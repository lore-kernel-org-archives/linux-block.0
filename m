Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA6C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5147520720
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 05:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgF3FKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:10:06 -0400
Received: from verein.lst.de ([213.95.11.211]:34431 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgF3FKG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:10:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 880A56736F; Tue, 30 Jun 2020 07:10:01 +0200 (CEST)
Date:   Tue, 30 Jun 2020 07:10:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        rostedt@goodmis.org, snitzer@redhat.com, agk@redhat.com,
        axboe@kernel.dk, paolo.valente@linaro.org, ming.lei@redhat.com,
        bvanassche@acm.org, fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 01/11] block: blktrace framework cleanup
Message-ID: <20200630051001.GA27033@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629234314.10509-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 04:43:04PM -0700, Chaitanya Kulkarni wrote:
> This patch removes the extra variables from the trace events and
> overall kernel blktrace framework. The removed members can easily be
> extracted from the remaining argument which reduces the code
> significantly and allows us to optimize the several tracepoints like
> the next patch in the series.      

The subject sounds a litle strange, I'd rather say:

"block: remove superflous arguments from tracepoints"

The actual changes look good to me.

> +		trace_block_rq_insert(rq);
>  	}
>  
>  	spin_lock(&ctx->lock);
> @@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		goto queue_exit;
>  	}
>  
> -	trace_block_getrq(q, bio, bio->bi_opf);
> +	trace_block_getrq(bio, bio->bi_opf);

But now that you remove more than the q argument in some spots you
might remove the op one here as well.  Or limit the first patch to
just the queue argument..

