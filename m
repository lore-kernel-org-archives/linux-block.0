Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFSG0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 02:26:18 -0400
Date: Sun, 18 Jun 2017 23:26:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 01/11] fs: add support for an inode to carry write hint
 related data
Message-ID: <20170619062617.GB2311@infradead.org>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497729594-4707-2-git-send-email-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +/*
> + * Write life time hint values.
> + */
> +enum rw_hint {
> +	WRITE_LIFE_NONE = 0,
> +	WRITE_LIFE_SHORT,
> +	WRITE_LIFE_MEDIUM,
> +	WRITE_LIFE_LONG,
> +	WRITE_LIFE_EXTREME,
> +};
> +
> +#define RW_HINT_MASK		0x7	/* 3 bits */

FYI, exposing enums in a uapi is always a bit problematic, due to
different ABI rules.  It might be better to make these explicit defines
at least for the uapi.

Btw, I think it might make sense to merge this with patch 5.
