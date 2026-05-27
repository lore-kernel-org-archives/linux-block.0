Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DC37BE9E
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910890; cv=none; b=Chk/TgUx6ipeZ1pf8y8T25gqOsp3aC22wveXWVdT1zNPR0QdLR6XAf2W4hJJtExqFikInU8UjOKFYECtDMr+wjo1M6M/hugIl4y/ka69fhg+XDLhRA95i2sFcMJgPwI6qVhQ2tDeDZnOyUhY0eFg0EPmKAywvnNDv3NZPZIFQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910890; c=relaxed/simple;
	bh=/qs1emDNd0jHRJcYj85K1YkIS2cdAv7UxiY2Hcmy84g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlDVE2uMbXi0+I5Q/0h6ih/Oj4LVSESuTzT8p7euauxfFkos1SV8Ar+mh6/zbvrLrvCy/b2EWvDwKCnnxMLPZM+/KSqV5yeO1PM9vXrNJK+8ivC/gnMpI2mXlENSoL541EvA75b8ygoxr85Y6x9hSO2xuA7qvPe6tXu5ae5Z4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD2NVcO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD2NVcO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960961F000E9;
	Wed, 27 May 2026 19:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779910889;
	bh=XKHKfcIO69c5iOB3FRAAGrPYyFZBPNaSoikQ3b6D/Dc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BD2NVcO/jIZ/1LbSli0J4gbwpg7E3nIzChgQgggUTOgFyW8N486rYVvi4ViuNM7xh
	 oWBwunpFWsi+TGAJ6c/vakm+zBb5QVOhE/CWsGSGDDrgtXe38AObBbEzLZLfrQ6bVg
	 VVAP5YdTl57TJUdy+gMEer7meDThsxXYaU8ox7O9C4PAy7L+mfh0e4kLwyQxIteQmS
	 vrrVbLq8hvn7m7u2/HYDHFjxF9URlAFd1iwDl2kgNJ/iOlzrTJGnuMO9N/tDB6Dz+P
	 czUG18qGdQxkJ3U+GipN8ZRf9Wx8oFJ03bncl842M48lxDvhjae8JbllrTqwzvc1le
	 eX4iHtrRoDYUA==
Message-ID: <8bf168de-6bf6-4486-85ad-b765c3948ab7@kernel.org>
Date: Thu, 28 May 2026 04:41:27 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add a bio_endio_status helper
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260527151247.2352145-1-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260527151247.2352145-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/28 0:12, Christoph Hellwig wrote:
> Add a helper that sets bi_status and call bio_endio() as that is a very
> common pattern and convert the core block code over to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, modulo one nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +/**
> + * bio_endio - end I/O on a bio with a specific status

This should be:
 * bio_endio_status - end I/O...

> + * @bio:	bio
> + * @status:	status to set
> + *
> + * Set @bio->bi_status to @status and call bio_endio().
> + **/
> +static inline void bio_endio_status(struct bio *bio, blk_status_t status)
>  {
> -	bio->bi_status = BLK_STS_IOERR;
> +	bio->bi_status = status;
>  	bio_endio(bio);
>  }
>  
> +static inline void bio_io_error(struct bio *bio)
> +{
> +	bio_endio_status(bio, BLK_STS_IOERR);
> +}
> +
>  static inline void bio_wouldblock_error(struct bio *bio)
>  {
> -	bio->bi_status = BLK_STS_AGAIN;
> -	bio_endio(bio);
> +	bio_endio_status(bio, BLK_STS_AGAIN);
>  }
>  
>  /*


-- 
Damien Le Moal
Western Digital Research
