Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B6C55199
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A2206D9
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rv9xl/0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgD0Pqy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgD0Pqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 11:46:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6973AC0610D5;
        Mon, 27 Apr 2020 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WJhX0gy4PLhLVzhkqKlPTRBI4F1++Yw2mgGmpA3PmDk=; b=Rv9xl/0yJAvArM66lMVoxSWEMQ
        3Qh/ze4bgZMsEwvC5UUATGsA9ndC2ScJuPNo9xuctTBXRJo5vw9hJsy620rzuA+6fG7N0rMSJ4Ldg
        57nntPN3w9G49xjrPcPPxzMKCxNlEAe5dlw5t04X/s4HsA/6UOTAAMAeik+Qz2XZPrxeEtp82fUtt
        Jr7x3NcjgEjOVQnZyTTB8P0XwdhKAspRZ7sD9Td1qDK8ZIHp/jaGQ8LcNHFsUPCbu+Gtxz6TKMbAK
        Awqyk3g/bsIaq4woSAzA3r6HJ5HmKsRwiyhFjY3dYtVOjI2t6CgFPy+oSNkQmF0hMXalSzMCMHzK4
        8GhNKZnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT5y1-0007q0-PV; Mon, 27 Apr 2020 15:46:45 +0000
Date:   Mon, 27 Apr 2020 08:46:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
Message-ID: <20200427154645.GA1201@infradead.org>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

extand in the subject really shpuld be 'extend'

On Sun, Apr 26, 2020 at 05:38:54PM +0800, Baolin Wang wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Now some SD/MMC host controllers can support packed command or packed request,
> that means we can package several requests to host controller at one time
> to improve performence.
> 
> But the blk-mq always takes one request from the scheduler and dispatch it to
> the device, regardless of the driver or the scheduler, so there should only
> ever be one request in the local list in blk_mq_dispatch_rq_list(), that means
> the bd.last is always true and the driver can not use bd.last to decide if
> there are requests are pending now in hardware queue to help to package
> requests.
> 
> Thus this patch introduces a new 'BLK_MQ_F_FORCE_COMMIT_RQS' flag to call
> .commit_rqs() to do batch processing if necessary.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Baolin Wang <baolin.wang7@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  block/blk-mq-sched.c   | 29 ++++++++++++++++++++---------
>  block/blk-mq.c         | 15 ++++++++++-----
>  include/linux/blk-mq.h |  1 +
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 74cedea56034..3429a71a7364 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>   * its queue by itself in its completion handler, so we don't need to
>   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
>   */
> -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)

This function already returns an int in the current for-5.8/block tree.

> +		if (!(hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)) {
> +			if (list_empty(list)) {
> +				bd.last = true;
> +			} else {
> +				nxt = list_first_entry(list, struct request,
> +						       queuelist);
> +				bd.last = !blk_mq_get_driver_tag(nxt);
> +			}
> +		} else {
> +			bd.last = false;
>  		}

This seems a little odd in terms of code flow.  Why not:

		if (hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS) {
			bd.last = false;
		} else if (list_empty(list)) {
			bd.last = true;
		} else {
			nxt = list_first_entry(list, struct request, queuelist);
			bd.last = !blk_mq_get_driver_tag(nxt);
		}

> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index f389d7c724bd..6a20f8e8eb85 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -391,6 +391,7 @@ struct blk_mq_ops {
>  enum {
>  	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
>  	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> +	BLK_MQ_F_FORCE_COMMIT_RQS = 1 << 3,

Maybe BLK_MQ_F_ALWAYS_COMMIT might be a better name?  Also this
flag (just like the existing ones..) could really use a comment
explaining it.
