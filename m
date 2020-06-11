Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B18BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606EE206C3
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 14:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgFKOjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:39:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:53996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgFKOjO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 10:39:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8DD9CAC53;
        Thu, 11 Jun 2020 14:39:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62ECF1E0B00; Thu, 11 Jun 2020 16:39:12 +0200 (CEST)
Date:   Thu, 11 Jun 2020 16:39:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] bfq: Use only idle IO periods for think time
 calculations
Message-ID: <20200611143912.GC19132@quack2.suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-3-jack@suse.cz>
 <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 11-06-20 16:11:10, Paolo Valente wrote:
> 
> 
> > Il giorno 5 giu 2020, alle ore 16:16, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > Currently whenever bfq queue has a request queued we add now -
> > last_completion_time to the think time statistics. This is however
> > misleading in case the process is able to submit several requests in
> > parallel because e.g. if the queue has request completed at time T0 and
> > then queues new requests at times T1, T2, then we will add T1-T0 and
> > T2-T0 to think time statistics which just doesn't make any sence (the
> > queue's think time is penalized by the queue being able to submit more
> > IO).
> 
> I've thought about this issue several times.  My concern is that, by
> updating the think time only when strictly meaningful, we reduce the
> number of samples.  In some cases, we may reduce it to a very low
> value.  For this reason, so far I have desisted from changing the
> current scheme.  IOW, I opted for dirtier statistics to avoid the risk
> of too scarse statistics.  Any feedback is very welcome.

I understand the concern. But:

a) I don't think adding these samples to statistics helps in any way (you
cannot improve the prediction power of the statistics by including in it
some samples that are not directly related to the thing you try to
predict). And think time is used to predict the answer to the question: If
bfq queue becomes idle, how long will it take for new request to arrive? So
second and further requests are simply irrelevant.

b) From my testing with 4 fio sequential readers (the workload mentioned in
the previous patch) this patch caused a noticeable change in computed think
time and that allowed fio processes to be reliably marked as having short
think time (without this patch they were oscilating between short ttime and
not short ttime) and consequently achieving better throughput because we
were idling for new requests from these bfq queues. Note that this was with
somewhat aggressive slice_idle setting (2ms). Having slice_idle >= 4ms was
enough hide the ttime computation issue but still this demonstrates that
these bogus samples noticeably raise computed average.

								Honza

> > So add to think time statistics only time intervals when the queue
> > had no IO pending.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > block/bfq-iosched.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index c66c3eaa9e26..4b1c9c5f57b6 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -5192,8 +5192,16 @@ static void bfq_update_io_thinktime(struct bfq_data *bfqd,
> > 				    struct bfq_queue *bfqq)
> > {
> > 	struct bfq_ttime *ttime = &bfqq->ttime;
> > -	u64 elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
> > -
> > +	u64 elapsed;
> > +	
> > +	/*
> > +	 * We are really interested in how long it takes for the queue to
> > +	 * become busy when there is no outstanding IO for this queue. So
> > +	 * ignore cases when the bfq queue has already IO queued.
> > +	 */
> > +	if (bfqq->dispatched || bfq_bfqq_busy(bfqq))
> > +		return;
> > +	elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
> > 	elapsed = min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
> > 
> > 	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
> > -- 
> > 2.16.4
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
