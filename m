Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E65024B
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl66V9XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A92DC433F1;
	Thu, 11 Jan 2024 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990522;
	bh=vrSY0lJI/3iwMOgPxKGdrd6HKo2kTPfGF5G8IccHOwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gl66V9XJuoZEYt7GeSJohD6A3QvZhP2xhqVqNrIJF7MGOvjG4l7hg/8rE0DO2b5PB
	 fk745KURJ1MoziodLnbwLrPC+08h1PiRqC5I0ku8g+zDQ9F4vRjZHdKfH1eYaXLoKN
	 Kj7QDJ8+eyEFNQ/kgLiwOc7KH9mNKcONhRoQ3D3xeVu7tgxgMSgkjCCdGv8ix3MFCU
	 aOE3bZGsMPhMse9VJP0Q2LC/BTpFeEeAU4x3oX+esO9VqaKAJe589DbVsYjseIeSFy
	 JJez/otVunauGVRCSq5ahP5GwlnklzPE1PmzgGjCS7MSf2+DbBkS1Akh4wKG3h8Ouh
	 Hr0XiGbpzuKig==
Date: Thu, 11 Jan 2024 09:28:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 3/3] block: only call bio_integrity_prep() if necessary
Message-ID: <ZaAXN7MI5WPkdAvC@kbusch-mbp.dhcp.thefacebook.com>
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111160226.1936351-4-axboe@kernel.dk>

On Thu, Jan 11, 2024 at 09:00:21AM -0700, Jens Axboe wrote:
> Now that the queue is flag as having an actual profile or not, avoid
> calling into the integrity code unless we have one. This removes some
> overhead from blk_mq_submit_bio() if BLK_DEV_INTEGRITY is enabled and
> we don't have any profiles attached, which is the default and expected
> case.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 37268656aae9..965e42a1bbde 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2961,7 +2961,8 @@ bool blk_mq_submit_bio(struct bio *bio)
>  
>  	bio_set_ioprio(bio);
>  
> -	if (!bio_integrity_prep(bio))
> +	if (test_bit(QUEUE_FLAG_INTG_PROFILE, &q->queue_flags) &&
> +	    !bio_integrity_prep(bio))
>  		return false;

I'm confused. The bio_integrity_prep() allocates the metadata buffer.
Drivers that were previoulsy using the 'nop' profile for odd formats
don't get a metadata buffer anymore?
