Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39398C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63D206DB
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pAOLKtsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgAHNol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:44:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgAHNol (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 08:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AR71W0pYKeg7a5lHYhxMyZIhsRDG+feadyyIkqvPVE4=; b=pAOLKtsi7bpcHnA73zW+Uq7FZ
        271UaMi5L/N+++qozrMG9czU5C15j05d58Wa4Gz0nAHETHowSYn2DnOe5CoKZchgij8e60jmu9QKP
        I0TlbSI3WI71zcLzyayAMgm6fVJ6GWXm2CvweaIVefRhUBDEGkNlvmA7zGAqQnKTMUjo2eO6P0sWg
        Xu9n/pWQfHXsRLfMPKlqqZuoGSAbAaKGWJS/O4TjFeGDvoUfbZGlx9fpS638rkSI59xPY271v1Rr6
        Yd7d3APRHqDD76Pe/QA7jyEQADGG2JWW6RmeAiSBYwnbodJ9TsxthvZrblBHiAcmhHshsiNdOnoiF
        BROF7cycQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBdV-0006wc-PJ; Wed, 08 Jan 2020 13:44:37 +0000
Date:   Wed, 8 Jan 2020 05:44:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] block: streamline merge possibility checks
Message-ID: <20200108134437.GF4455@infradead.org>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
 <df9c90e7-9aa7-4f77-7161-1bc38de6f8ba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9c90e7-9aa7-4f77-7161-1bc38de6f8ba@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 20, 2019 at 02:50:05PM +0800, Bob Liu wrote:
> On 12/19/19 3:41 AM, Dmitry Fomichev wrote:
> > Checks for data direction in attempt_merge() and blk_rq_merge_ok()
> 
> Speak about these two functions, do you think attempt_merge() can be built on blk_rq_merge_ok()?
> Things like..
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 48e6725..2a00c4c 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -724,28 +724,7 @@ static enum elv_merge blk_try_req_merge(struct request *req,
>  static struct request *attempt_merge(struct request_queue *q,
>                                      struct request *req, struct request *next)
>  {
> -       if (!rq_mergeable(req) || !rq_mergeable(next))
> -               return NULL;
> -
> -       if (req_op(req) != req_op(next))
> -               return NULL;
> -
> -       if (rq_data_dir(req) != rq_data_dir(next)
> -           || req->rq_disk != next->rq_disk)
> -               return NULL;
> -
> -       if (req_op(req) == REQ_OP_WRITE_SAME &&
> -           !blk_write_same_mergeable(req->bio, next->bio))
> -               return NULL;
> -
> -       /*
> -        * Don't allow merge of different write hints, or for a hint with
> -        * non-hint IO.
> -        */
> -       if (req->write_hint != next->write_hint)
> -               return NULL;
> -
> -       if (req->ioprio != next->ioprio)
> +       if (!blk_rq_merge_ok(req, next->bio))
>                 return NULL;

This looks sensible, but we might have to be a bit more careful.
rq_mergeable checks for RQF_NOMERGE_FLAGS and various ops, while
bio_mergeable is missing those.  So I think you need to go through
carefully if we need to keep any extra checks, but otherwise using
blk_rq_merge_ok looks sensible.
