Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709B2747B
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545892; cv=none; b=mFHzY/up3f2W9Zu1AaI3QqOdePjJDWt6Q05QqM3yw6XkAwEuWRPGjkfMBNN91yp3SJ0+er3BxxUrtJLe1CJEPOyVWyxFZtYR4MbMSd+TcXK1jQ3OKwUN3orsW3xCKrvktGouPzsL7RJ2nulNfBvQBQcol9nJFd9/cfiGbkUcmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545892; c=relaxed/simple;
	bh=Ujx6oMY1Orybyc0a7iWF5SmNsDwUv4ExnNvazvghVCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo+FXVPZ109Mw0cwmCVle/ZEF0mMXhjx28p7HPM5z+1u2kDEuVFMwPn5SM6tiTaLEnoKiB6ByxfetFJmk3AfBK9PncLk74e75zz58ZnW+4pCfTIoDR/WuikWWZXzzDG2TsE8aliXMpF4lAfbx5oedYxffYhi4+Eqks/AbJgR6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5X3Jpgb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5X3Jpgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63108C4CEED;
	Tue, 15 Jul 2025 02:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752545892;
	bh=Ujx6oMY1Orybyc0a7iWF5SmNsDwUv4ExnNvazvghVCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5X3Jpgb0trnXW7OiOwoptkr5FgwTOxonWDXUjBXa+MaNuKjzTttsKmc+S8O7D2vT
	 Bjz9+SL26YyFSvcnKxW+M54HNcGXEJX2JcIlw7piBTzB/f2zN6DcUV4gDyTnuSGMlF
	 VvNT/kbtv//e+adHIBBEurd1cvc5McUacmHOeA0Tz/ZzOBFIokxlgkcrgqnc/UC2Bf
	 MsX/j4H/K7LZV6lOAHb9qAIq4Vv/R0Y7ZMeq360PefneK+TmsCtGZHfp1DtoSq/mCg
	 EuujzYgrfcVYj9akUR+zo4Ua4lGUteMm/5doAU8T7P51AD6MaA1ilGt2d6/rYtthpC
	 stsNoSheQDDPQ==
Date: Tue, 15 Jul 2025 02:18:10 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] block: Rework splitting of encrypted bios
Message-ID: <20250715021810.GA426229@google.com>
References: <20250711171853.68596-1-bvanassche@acm.org>
 <20250711171853.68596-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711171853.68596-3-bvanassche@acm.org>

On Fri, Jul 11, 2025 at 10:18:52AM -0700, Bart Van Assche wrote:
> @@ -124,9 +125,13 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>  		trace_block_split(split, bio->bi_iter.bi_sector);
>  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
>  		submit_bio_noacct(bio);
> -		return split;
> +
> +		bio = split;
>  	}
>  
> +	if (unlikely(!blk_crypto_bio_prep(&bio)))
> +		return NULL;

Is this reached for every bio for every block device?  If not, then this
patch causes data to sometimes be left unencrypted when the submitter of
the bio provided an encryption context, which isn't okay.

- Eric
