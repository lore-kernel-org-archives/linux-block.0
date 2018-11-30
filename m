Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BACC04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF1A2081C
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 00:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF1A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeK3Lho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:37:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeK3Lho (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 06:37:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02EB3D7937;
        Fri, 30 Nov 2018 00:30:22 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 692A64388;
        Fri, 30 Nov 2018 00:30:19 +0000 (UTC)
Date:   Thu, 29 Nov 2018 19:30:18 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] block: return just one value from part_in_flight
Message-ID: <20181130003018.GB10015@redhat.com>
References: <20181128004251.504425345@debian.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128004251.504425345@debian.vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Nov 2018 00:30:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27 2018 at  7:42pm -0500,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> The previous patches deleted all the code that needed the second value
> returned from part_in_flight - now the kernel only uses the first value.
> 
> Consequently, part_in_flight (and blk_mq_in_flight) may be changed so that
> it only returns one value.
> 
> This patch just refactors the code, there's no functional change.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  block/blk-mq.c            |    6 ++++--
>  block/blk-mq.h            |    3 +--
>  block/genhd.c             |   32 +++++++++++---------------------
>  block/partition-generic.c |    6 +++---
>  include/linux/genhd.h     |    3 +--
>  5 files changed, 20 insertions(+), 30 deletions(-)
> 
> Index: linux-block/block/blk-mq.c
> ===================================================================
> --- linux-block.orig/block/blk-mq.c	2018-11-28 00:39:16.000000000 +0100
> +++ linux-block/block/blk-mq.c	2018-11-28 00:39:16.000000000 +0100
> @@ -113,13 +113,15 @@ static bool blk_mq_check_inflight(struct
>  	return true;
>  }
>  
> -void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
> -		      unsigned int inflight[2])
> +unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
>  {
> +	unsigned inflight[2];
>  	struct mq_inflight mi = { .part = part, .inflight = inflight, };
>  
>  	inflight[0] = inflight[1] = 0;
>  	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +
> +	return inflight[0];
>  }


I don't think this change goes deep enough.  You're leaving unnecessary
work (relative to mi->inflight[1]) in blk_mq_check_inflight().

Mike
