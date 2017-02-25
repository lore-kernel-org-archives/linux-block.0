Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdBYSWT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2017 13:22:19 -0500
Date: Sat, 25 Feb 2017 10:22:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 01/14] block: introduce bio_segments_all()
Message-ID: <20170225182216.GB26447@infradead.org>
References: <1487950971-1131-1-git-send-email-tom.leiming@gmail.com>
 <1487950971-1131-2-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487950971-1131-2-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +static inline unsigned bio_segments_all(struct bio *bio)
> +{
> +	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
> +
> +	return bio->bi_vcnt;
> +}

I don't think this helpers really adds any benefit.
