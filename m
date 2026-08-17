Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA843D565F
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984654; cv=none; b=dfCRScG7nUE/l1HeeqRnVkidjgg6OHZd386n+oHfOz38nLf1haYxvakMhTU7s330tP09q5RKcFhv8nCAz8rM53QuK2Uz6cLMonPRWroQI50BjEeuH83OsF7FOBa5akNZd9/xwSpBDc41h+76NbFf3jdYAaui1k3H+wdEg5rhZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984654; c=relaxed/simple;
	bh=SSJqr2oJ4etd2lyFwgXlCwrGbNqvbSNHkKyBY4P2FoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTVWUMRDnPdSco3YtnLMvkhITgi7sqpJ5wF/8IYVhNGNUhkHK/tvFn0qQVpICuiKpHhScTjwd4Bo4CG7M7Imfeh6Itm4OrqVwxeilkH3vrjcx50v7qpsvdU78zwnafswvJ9l7bymkfCBoqCxdcC/EhSWb/Rt6oaz1vJIrAn7CgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOk35MjX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpWs9M9z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOk35MjX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpWs9M9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786984651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98pTz1wjWa3DC15z3yywDMfFCjc1xmvSAJlUL+hubU0=;
	b=DOk35MjXqdzIkwtv5J+KCBNvwi3wrvEoGQ9LJDLxB1+2NPFLgSiMrB56OtWVXl3pC9T+XT
	Z7nYTcMcOAeXCZaumRJx3bKZyPhavjPxeHo9H66Za1oGJ8rZbmiVPEiNTa2PSlSdkIWOou
	jJ+uj+Izc3OzBfPn0JtSyE3UWJrUEIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_yrsn3m-OsOR-d6k1HOYmA-1; Mon, 17 Aug 2026 12:37:29 -0400
X-MC-Unique: _yrsn3m-OsOR-d6k1HOYmA-1
X-Mimecast-MFC-AGG-ID: _yrsn3m-OsOR-d6k1HOYmA_1786984648
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482a2d55c4eso722462f8f.3
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786984648; x=1787589448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=98pTz1wjWa3DC15z3yywDMfFCjc1xmvSAJlUL+hubU0=;
        b=RpWs9M9znsxZAz5ecyM8Smhpw/NFWOAjhQ/GAuvXQ6crfmPJzMgkFZ2/w9wlxfQz3w
         Jzv+5IX1+07AmVmH35Grz62QHXv1kKmaRW+Pc4/PWEZvksfOT7gAafCMkBU4tUNmlMtT
         Arn0/OERJ3cmSzk3c7SEuLlSJ9CC2SywEdHdeiERUU2h+TSJc8+Womwz4gdyvArxwlIx
         sLQA75Fy8rQsuPzqjw1K5c0YJTR33YZfqd8wMZFlqMCjCdWbouw/IpD3+VmdB7Y+v+yy
         blW9LcagTe5FxyV48oio4HlEoo+dXD4bVUU1QAayy7+jO04xAnCg+tXq7+OabxT88aSk
         R7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984648; x=1787589448;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98pTz1wjWa3DC15z3yywDMfFCjc1xmvSAJlUL+hubU0=;
        b=asDi+HBty0skM7go42El0ZaA65swvbcG0/4TUyflGLbGsBpM7tBaQdSeOc4SmwxfHR
         fi3vue9xN/EIeJ/CqAeXb9RVAWrqzfrBx2+a3ZOqstrkUO8gLO7ZdsJKm0LuKPwM+Ody
         9kYXrkMYKrcTwLJ9TE1qoKxcKD6AeV9X6nyQkmrorClC7Jx3MrTZmpTlT31nCTEY+vej
         CA1smyBqxcvfQXjRaY6+7kPzYtf7AOsb4cDHIWfbbQ8AakbOHOb3OVVSKbypAadsGl8P
         lDiTd1EXqkFQWmtGirGu+HWR9YFWvVzVopdm7C+mNvwlOSNhgbmDuJP2nDx3r+8/VUO/
         ol/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpa1Acs4MOQA4RjiB0+0vPxnYP3s672MOS47y4KBlaYyYN+K7lwiCGwfuqq7iUS2Re1gaI/ooqtpZs5sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHj0X2DX33cg9Gwt2msoj6WyWfQONUYCp2orYoJWnXi/Lmmo6J
	rhl82SuhCAH0rXRnajLzia7Bj4hN1IBGd9XRDyUuPKoo2h99Oa/NJWJRLvFPR/0QRgjbm+qC02z
	aeBFz5IFPFW+qhEbu7rIL6CxNwgEC0lgQ7rUPMsbmRdTH9T+2TVTPELN+i2KE3GoF
X-Gm-Gg: AR+sD10T2rmDga2Zj0j0Z2ukwDlJLI1TMjB+zDZW0792W6EduPczva5fX5+MylbEM6u
	sYg9Pe2BeF3w2POqvk2J+6VB6UJ4CkzKQ/P4mh/fbM44ujg+Gt0E5GPQkw6g90PxNzlyIuGAxYW
	VDF4/rE8lAo8LWSApEw4/bDu8FWwSx7+sqGEc3p+vp+0qJF6ULtDMSUeMgkm4R0IpJM/8LEInB/
	5Li4uuShfeuycTp8x22aXDEY201FMEupO7DgpTHr14UNCsnq/frA2iRMvax3QT4UOq3WWDSTSkc
	3HeWrcFhUgTKiASHyprf7jvmDmc5AE+kzZAkfGfIgqYr34I8M4ivUXEFSUq/KHOmVxh+2gNSNb8
	ZyRa0G/R/VrmmVpZLfqFGP3wdikuvD8mqtlokXx8lufg=
X-Received: by 2002:a5d:5f56:0:b0:481:5167:a9a4 with SMTP id ffacd0b85a97d-4816071c181mr42522382f8f.7.1786984647876;
        Mon, 17 Aug 2026 09:37:27 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:481:5167:a9a4 with SMTP id ffacd0b85a97d-4816071c181mr42522299f8f.7.1786984647459;
        Mon, 17 Aug 2026 09:37:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b660sm5386882f8f.15.2026.08.17.09.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 09:37:26 -0700 (PDT)
Message-ID: <e2da7cc1-3ab8-408c-b561-345de5a33963@redhat.com>
Date: Mon, 17 Aug 2026 18:37:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
 <aoMi6y2qsnRVembg@kbusch-mbp>
 <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
 <aoMxLBmKfFo_-i1u@kbusch-mbp>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <aoMxLBmKfFo_-i1u@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Keith,
On 8/17/26 6:05 PM, Keith Busch wrote:
> ---
> diff --git a/block/bio.c b/block/bio.c
> index 4074a0496b93f..c343788e1f96e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -859,6 +859,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
>  	bio->bi_write_stream = bio_src->bi_write_stream;
> +	bio->bi_bvec_gap_bit = bio_src->bi_bvec_gap_bit;
>  	bio->bi_iter = bio_src->bi_iter;
>  
>  	if (bio->bi_bdev) {
> @@ -1969,6 +1970,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  		bio_integrity_trim(split);
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
> +	bio->bi_bvec_gap_bit = 0;
>  
>  	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>  		bio_set_flag(split, BIO_TRACE_COMPLETION);
> --
Many thanks for your quick investigations. With that patch I do not see
the IO errors anymore so it seems it fixes my issues.

Thanks

Eric

