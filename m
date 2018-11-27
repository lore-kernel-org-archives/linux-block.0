Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BAC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65659206B6
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="O6J/sBqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65659206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeK1Kyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:54:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35308 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1Kyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:54:38 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so1507548itp.0
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gm7yih4XqLQ08sDeAFaFgpkm6b4NxUvXde0q6OQRSc=;
        b=O6J/sBqK4FmeYNbZik/Z+mI14xy7OYiCBaLSFAESTeO/0ZR3lDz0hjgs2kXftvf9BW
         HkvvSQltfoKO0FMUM0V43rQp0mREczLstxObn3wTZHC1Z5VG4nuNI28yYV4+lxJhrRbv
         J3Vbg93Za+kw1R5uUDKJIUezbOHMp08tiTotjsh70rfB4bsKvimGPYJ8861Y4GuSmk6g
         QA+kDmOVEkqq+/lkeDLR/zXv22rSIz6Jd7FN0Ll9cjod6W4KgZopKRfSRpY19Xta+LSo
         Z+NibJYW9lwSdY5a1t2ZCAeyWqOZoMJu3DHCXhCcr/xghGbpbd3Phzi/RT7OMsSZss82
         Nbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gm7yih4XqLQ08sDeAFaFgpkm6b4NxUvXde0q6OQRSc=;
        b=ezXLIYvUaDVT+2qA/A8RG6TKDHKrOFPhTbxUQS3CmHWT1DTfgnye6vRgSY3ah4mSph
         RT/9tX+pOIcWEh7J7/tzpTjt53lPh1X8NzdNlCbjh64QTUx9sIqgw4++nZQCb7Qvfcjv
         tcEEOt0hTy+RZof6C3nY/8OiMISjdRJqjhyG8wmT4ocUFpKJzR4S/LNbmKcBQwzGfHDa
         BNQyURJ+I7cZQ3uw2tJaU1iP6i7kQkTG+GN97Jw8tSKQDijgx2p3LFXZJXV7FCih5Hpz
         EVyQ2vNiltOc8TU0XlH50LpjuJuqmEEK2Pm/Cyiu6QmBSe++kTsTyd3b4QjrNxiMzj2X
         lJ0w==
X-Gm-Message-State: AA+aEWafmJVSadGrLPeSqGcRMnkOonpHSc259dtLz9r3wbWuVnCkNAl0
        vhbF+O8UAKCY8IH3/TYNwQ77OQ==
X-Google-Smtp-Source: AFSGD/WPlwBzSGxEaL9EKpH8wODgiTce/kDaMfbRb1omZtDEdOeTx47zWaeV9y4p0Sqm9+cMPHhgFg==
X-Received: by 2002:a24:1d4a:: with SMTP id 71mr956950itj.62.1543362903510;
        Tue, 27 Nov 2018 15:55:03 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id t64sm307377itb.5.2018.11.27.15.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:55:03 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:55:01 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/8] block: improve logic around when to sort a plug list
Message-ID: <20181127235501.GG846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk>
 <20181127233142.GB846@vader>
 <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 04:49:27PM -0700, Jens Axboe wrote:
> On 11/27/18 4:31 PM, Omar Sandoval wrote:
> > On Mon, Nov 26, 2018 at 09:35:50AM -0700, Jens Axboe wrote:
> >> Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
> >> case if we have requests for multiple devices in the plug.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  block/blk-core.c       | 1 +
> >>  block/blk-mq.c         | 7 +++++--
> >>  include/linux/blkdev.h | 1 +
> >>  3 files changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/blk-core.c b/block/blk-core.c
> >> index be9233400314..c9758d185357 100644
> >> --- a/block/blk-core.c
> >> +++ b/block/blk-core.c
> >> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
> >>  	INIT_LIST_HEAD(&plug->mq_list);
> >>  	INIT_LIST_HEAD(&plug->cb_list);
> >>  	plug->rq_count = 0;
> >> +	plug->do_sort = false;
> >>  
> >>  	/*
> >>  	 * Store ordering should not be needed here, since a potential
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 99c66823d52f..6a249bf6ed00 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >>  	list_splice_init(&plug->mq_list, &list);
> >>  	plug->rq_count = 0;
> >>  
> >> -	list_sort(NULL, &list, plug_rq_cmp);
> >> +	if (plug->do_sort)
> >> +		list_sort(NULL, &list, plug_rq_cmp);
> >>  
> >>  	this_q = NULL;
> >>  	this_hctx = NULL;
> >> @@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >>  
> >>  		list_add_tail(&rq->queuelist, &plug->mq_list);
> >>  		plug->rq_count++;
> >> +		plug->do_sort = true;
> >>  	} else if (plug && !blk_queue_nomerges(q)) {
> >>  		blk_mq_bio_to_request(rq, bio);
> >>  
> >> @@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >>  			data.hctx = same_queue_rq->mq_hctx;
> >>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
> >>  					&cookie);
> >> -		}
> >> +		} else if (plug->rq_count > 1)
> >> +			plug->do_sort = true;
> > 
> > If plug->rq_count == 2, there's no benefit to sorting, either. The
> > nr_hw_queues == 1 case could also avoid sorting in that case. So maybe
> > this whole patch could just be replaced with:
> 
> Heh yes, good point, it should be 3 at least. But if you look at the
> later mq plug patch, we only sort for that one if we have multiple
> queues. So the logic should be something ala:
> 
> if (plug->rq_count > 2 && plug->has_multiple_queues)
> 
> since that's the only case we want to sort for.

Yeah, just got to that one. If you're going to respin this, I'll wait
for you to change that around before really looking at it.
