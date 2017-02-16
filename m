Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753530AbdBPMgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 07:36:00 -0500
Subject: Re: [PATCH 13/17] md: raid1: use bio_segments_all()
To: Ming Lei <tom.leiming@gmail.com>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
References: <1487245547-24384-1-git-send-email-tom.leiming@gmail.com>
 <1487245547-24384-14-git-send-email-tom.leiming@gmail.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <4a700de4-8540-d5d8-8c58-3465c0a7a55a@suse.de>
Date: Thu, 16 Feb 2017 13:35:58 +0100
MIME-Version: 1.0
In-Reply-To: <1487245547-24384-14-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/16/2017 12:45 PM, Ming Lei wrote:
> @@ -998,7 +998,8 @@ static void alloc_behind_pages(struct bio *bio, struct r1bio *r1_bio)
>  {
>  	int i;
>  	struct bio_vec *bvec;
> -	struct bio_vec *bvecs = kzalloc(bio->bi_vcnt * sizeof(struct bio_vec),
> +	unsigned vcnt = bio_segments_all(bio);
> +	struct bio_vec *bvecs = kzalloc(vcnt * sizeof(struct bio_vec),
>  					GFP_NOIO);

Maybe use kcalloc() instead of kzalloc() with a multiplication.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
