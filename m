Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhL2RlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:41:13 -0500
Received: from verein.lst.de ([213.95.11.211]:38326 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhL2RlN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:41:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E8A968AFE; Wed, 29 Dec 2021 18:41:09 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:41:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 2/3] block: introduce rq_list_move
Message-ID: <20211229174109.GB28058@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org> <20211227164138.2488066-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 27, 2021 at 08:41:37AM -0800, Keith Busch wrote:
> +/**
> + * rq_list_move() - move a struct request from one list to another
> + * @src: The source list @rq is currently in
> + * @dst: The destination list that @rq will be appended to
> + * @rq: The request to move
> + * @prv: The request preceding @rq in @src (NULL if @rq is the head)
> + * @nxt: The request following @rq in @src (NULL if @rq is the tail)
> + */
> +static void inline rq_list_move(struct request **src, struct request **dst,
> +				struct request *rq, struct request *prv,
> +				struct request *nxt)
> +{
> +	if (prv)
> +		prv->rq_next = nxt;
> +	else
> +		*src = nxt;
> +	rq_list_add(dst, rq);
> +}

Do we even need the nxt argument?  I think it should always be
rq->rq_next?

Also I'd spell out prev and next for a little more readability.
