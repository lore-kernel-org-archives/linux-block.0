Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA86C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F99C20879
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F99C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLERtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:49:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29457 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLERtq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 12:49:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49A6713AB3;
        Wed,  5 Dec 2018 17:49:46 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72DF160565;
        Wed,  5 Dec 2018 17:49:43 +0000 (UTC)
Date:   Wed, 5 Dec 2018 12:49:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
Message-ID: <20181205174942.GA9838@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
 <20181130222226.77216-5-snitzer@redhat.com>
 <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 17:49:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05 2018 at 12:30pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 11/30/18 3:22 PM, Mike Snitzer wrote:
> > diff --git a/block/genhd.c b/block/genhd.c
> > index cdf174d7d329..d4c9dd65def6 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -45,53 +45,76 @@ static void disk_add_events(struct gendisk *disk);
> >  static void disk_del_events(struct gendisk *disk);
> >  static void disk_release_events(struct gendisk *disk);
> >  
> > -void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
> > +void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
> >  {
> >  	if (queue_is_mq(q))
> >  		return;
> >  
> > -	atomic_inc(&part->in_flight[rw]);
> > +	local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
> 
> I mentioned this in a previous email, but why isn't this just using
> this_cpu_inc?

I responded to your earlier question on this point but, Mikulas just
extended the existing percpu struct disk_stats and he is using local_t
for reasons detailed in this patch's header:

    We use the local-atomic type local_t, so that if part_inc_in_flight or
    part_dec_in_flight is reentrantly called from an interrupt, the value will
    be correct.

    The other counters could be corrupted due to reentrant interrupt, but the
    corruption only results in slight counter skew - the in_flight counter
    must be exact, so it needs local_t.

> There's also no need to pass in the cpu, if we're not running with
> preempt disabled already we have a problem. 

Why should this be any different than the part_stat_* interfaces?
__part_stat_add(), part_stat_read(), etc also use
per_cpu_ptr((part)->dkstats, (cpu) accessors.
