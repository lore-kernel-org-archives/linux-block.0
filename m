Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F2C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 04:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A26D2192D
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 04:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfBOEeq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:34:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfBOEeq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 23:34:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4C982FE547;
        Fri, 15 Feb 2019 04:34:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59926101960D;
        Fri, 15 Feb 2019 04:34:40 +0000 (UTC)
Date:   Fri, 15 Feb 2019 12:34:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
Subject: Re: [PATCH] blk-flush: fix inverted scheduler check
Message-ID: <20190215043433.GE21045@ming.t460p>
References: <d52cf5d9-07a0-b643-e775-48139a4b19b0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52cf5d9-07a0-b643-e775-48139a4b19b0@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 15 Feb 2019 04:34:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 11, 2019 at 04:11:40PM -0700, Jens Axboe wrote:
> 
> A previous commit inadvertently inverted a check for whether or not we
> have an IO scheduler attached. This is reported to cause a hang with
> particular LVM setups.
> 
> Fixup the condition.
> 
> Reported-by: Dragan Milenkovic <dragan.milenkovic@pantelija.rs>
> Fixes: 344e9ffcbd18 ("block: add queue_is_mq() helper")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 6e0f2d97fc6d..b56f4e5e6359 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -273,7 +273,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  	 * assigned to empty flushes, and we deadlock if we are expecting
>  	 * other requests to make progress. Don't defer for that case.
>  	 */
> -	if (!list_empty(&fq->flush_data_in_flight) && q->elevator &&
> +	if (!list_empty(&fq->flush_data_in_flight) && !q->elevator &&
>  	    time_before(jiffies,
>  			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
>  		return;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
