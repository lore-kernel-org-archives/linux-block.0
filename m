Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C85C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA02C206BA
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbeLQBK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:10:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeLQBK1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 20:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65D60C0495BA;
        Mon, 17 Dec 2018 01:10:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782F4600D7;
        Mon, 17 Dec 2018 01:10:18 +0000 (UTC)
Date:   Mon, 17 Dec 2018 09:10:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 2/2] blk-wbt: export internal state via debugfs
Message-ID: <20181217011012.GD1223@ming.t460p>
References: <20181214113926.7451-1-ming.lei@redhat.com>
 <20181214113926.7451-3-ming.lei@redhat.com>
 <1544814903.185366.427.camel@acm.org>
 <35fd2388-21d2-3a15-cfe4-9564523aa0f1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fd2388-21d2-3a15-cfe4-9564523aa0f1@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 01:10:27 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 09:07:38AM -0700, Jens Axboe wrote:
> On 12/14/18 12:15 PM, Bart Van Assche wrote:
> > On Fri, 2018-12-14 at 19:39 +0800, Ming Lei wrote:
> >> This information is helpful to either investigate issues, or understand
> >> wbt's internal behaviour.
> >>
> >> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> >> Cc: Omar Sandoval <osandov@fb.com>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Cc: Josef Bacik <josef@toxicpanda.com>
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >>  block/blk-wbt.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 91 insertions(+)
> >>
> >> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> >> index 463e4eb80287..2684bf2d112f 100644
> >> --- a/block/blk-wbt.c
> >> +++ b/block/blk-wbt.c
> >> @@ -715,6 +715,94 @@ void wbt_disable_default(struct request_queue *q)
> >>  }
> >>  EXPORT_SYMBOL_GPL(wbt_disable_default);
> >>  
> >> +#ifdef CONFIG_BLK_DEBUG_FS
> >> +static int wbt_curr_window_show(void *data, struct seq_file *m)
> >> +{
> >> +	struct rq_qos *rqos = data;
> >> +	struct rq_wb *rwb = RQWB(rqos);
> >> +
> >> +	seq_printf(m, "%llu ns\n", rwb->cur_win_nsec);
> >> +	return 0;
> >> +}
> > 
> > Please consider to embed the unit ("ns") in the attribute name instead of
> > in the attribute value. That will make it easier to process this attribute
> > in developer debug scripts.
> > 
> >> +static int wbt_min_latency_show(void *data, struct seq_file *m)
> >> +{
> >> +	struct rq_qos *rqos = data;
> >> +	struct rq_wb *rwb = RQWB(rqos);
> >> +
> >> +	seq_printf(m, "%luns\n", rwb->min_lat_nsec);
> >> +	return 0;
> >> +}
> > 
> > Same comment here about the unit.
> > 
> >> +static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
> >> +	{"curr_window", 0400, wbt_curr_window_show},
> >> +	{"enable_state", 0400, wbt_enable_state_show},
> > 
> > How about using "enabled" instead of "enable_state"?
> 
> Agree on all of these. Ming, I had to amend so I dropped the previous
> commits, so I could also drop the compilation fixup for
> !CONFIG_BLK_DEBUG_FS. Can you resend with those fixed, and also apply
> this incremental?

OK.

Thanks,
Ming
