Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72977C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5E36117A
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTG17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTG16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:27:58 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C645C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B2HLaIOcuoo0cHKqyPZF2TPdwoAyW1EdKeXgbaaKi+w=; b=dfcAEa+nitBmEsCLWC+ziMBDfG
        8c0uZvxggQpEzA+LRsd2ToNQsUfZaMaY22d/ZcTbjNON+bZEc2hLH2Te4k1eZmCAr8+mmYKDJk9Fo
        v0Jo9wCPYd6eDpSiMiw3deXDI/mn1KXQ0LwgaqaNlbCW2TZzxnZZfM0lsZMH9W/1MOhdik0Y3q3y1
        jpZBtdcl+q7roO2fwJqhc/upFCEa4UbTp+OoGbXQ++6Wp+IDfiE/mltkrqBXOcNyqZxPJWuWclNPM
        3PAY6Nnp4pFB0FphrJEpFFPo5G1GQ9O89EJeSu3wBQxogMOZao3fNxCiPsl4cO/M0CNXNyBPYVG/l
        iV5KfB5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md52m-003TgL-48; Wed, 20 Oct 2021 06:25:44 +0000
Date:   Tue, 19 Oct 2021 23:25:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 15/16] block: optimise blk_may_split for normal rw
Message-ID: <YW+2aLXepTC3uMW7@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <9ded7cf6a3af7e6e577d12a835a385657da4a69e.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ded7cf6a3af7e6e577d12a835a385657da4a69e.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:24PM +0100, Pavel Begunkov wrote:
> +	unsigned int op = bio_op(bio);
> +
> +	if (op != REQ_OP_READ && op != REQ_OP_WRITE && op != REQ_OP_FLUSH) {
> +		switch (op) {
> +		case REQ_OP_DISCARD:
> +		case REQ_OP_SECURE_ERASE:
> +		case REQ_OP_WRITE_ZEROES:
> +		case REQ_OP_WRITE_SAME:
> +			return true; /* non-trivial splitting decisions */
> +		default:
> +			break;
> +		}

Nesting the if and the switch is too ugly to live.  If you want ifs do
just them.  But I'd really like to see numbers for this, also compared
to epxlicitly checking for REQ_OP_READ and REQ_OP_WRITE and maybe using
__builtin_expect for those values.
