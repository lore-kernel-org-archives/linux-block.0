Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31D360EC5
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047014; cv=none; b=h/qA2RWW5MBjd8PMbKM7WX+egWlrkTxDn0gTVdiFssi73OSpHaQL1nqRns6jjSYjBfTQgG1ukZzwHEvwFSlDPOU8fvMDC1uq+DxM76NrwaIVdRG8AvBO+WMiZaTp2B9kWOl5b7NZVthCY5uqkLLMQk1HxJquAUWfvGwdzTGsa7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047014; c=relaxed/simple;
	bh=F+K/kEn3lNUPF9mFVphw/+S4yZYT6fYrW2k6zt1aC4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdMsYvPvsgq3GSBa0A2dT6GIlGRm0kUnuXQwBM56HRcQJMF3oAZft3alIbKXQYOQDFpDA7EWq00nt8VySkMJyjgBcR+G9t2Yq6NFSGW3Fqmr16HuXfMkjn9g3TN45Tz0C19dsj0xC+7vGnu+nthXb2WBjcjV9Gykj5EVxqc/lL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSijOEJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSijOEJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0842F1F000FF;
	Tue, 22 Sep 2026 03:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790047013;
	bh=8L3ydvWDptC6UxtbmvjqUGJw4ARsGvJc6y9u5fjzT6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TSijOEJk8PCysfNa66ldZTE7F4LEzXqiH6HazgsI0qQ+t644VVQ2ZW7rwFf2fYwNV
	 SQrXfjepsHnGwEpv1htejnNti/EkaNctF1q0UBIdoPyuh++hCQsIOjVdg7tMuRxWgr
	 pGNZSlsAfQN3B3XjzGs/Zac/YKw3faaWsPEb15KMlnJ4DsJ/4oovSHLJrNi6xPZ0Dt
	 nEBByM44RrXTGo7RJregFHo+OatrU6rKzWwvO3ca5l3g8Nrb9QM5RxPygNKl7OVks+
	 5IsgWQAV8g6vmLYKZr8NFVQPZwZoSw1O4bCLG9WjNUTxPvNFx7KaHJRBC1ozzRQqhx
	 QtfmV+9fNToBA==
Message-ID: <632cc6ac-94b9-4cb6-a589-0a81f62bc38a@kernel.org>
Date: Tue, 22 Sep 2026 12:16:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Merge branch 'for-next' of
 https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
To: Dan Carpenter <error27@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-block@vger.kernel.org, ZHOU Jiaxiang <me@fxti.xyz>
References: <arGDF5byCiew-pqQ@stanley.mountain>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <arGDF5byCiew-pqQ@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 04:18, Dan Carpenter wrote:
> Hello Mark Brown,
> 
> Commit a9ce2250a714 ("Merge branch 'for-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git")
> from Sep 18, 2026 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	block/blk-zoned.c:2200 disk_init_revalidate_args()
> 	warn: impossible condition '(args->nr_zones > (~0)) => (0-u32max > u32max)'
> 
> block/blk-zoned.c
>     2195 static int disk_init_revalidate_args(struct gendisk *disk,
>     2196                                      struct blk_revalidate_zone_args *args)
>     2197 {
>     2198         args->disk = disk;
>     2199         args->nr_zones = disk_get_nr_zones(disk, args->capacity);
> --> 2200         if (args->nr_zones > UINT_MAX)
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^

This was fixed with an improved conflict resolution yesterday. Today's
linux-next does not have this anymore, so this should now be all good.

-- 
Damien Le Moal
Western Digital Research
