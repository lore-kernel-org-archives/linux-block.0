Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAF38C438
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401028; cv=none; b=Xi2Qv9aNsP8R96S0QCA082e+4DqkLQSk/ajYBSfbatJAcq8Hjh4xZC4E/plkHencTWNYXS18lIZH0pGqppxL6uB2anw85hMNMyRI65IbBQsh6zI5gg63POxK9dsv3F+yaHNwZNteZgdEtGsnjN1kfNhZHOoUNOnqG6nGdzG2QOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401028; c=relaxed/simple;
	bh=auCBgk0v7+8BpvMxpnoaacS+mT+SxVCkPa6wybn3nTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TknrsbcUtabEZWJ49K3iukvSFVJnJCteYilKZpt36E7nL1egDY27oODK2LM8M39EReUgPlmSG1KCsdcpuIZ3PB6xhblJ8QfPFmssPBA1juxLB/Cmh3DXAWK7Zk1sABegBLMsStYu8z+mhnn8NawIPc+HZmBPCDfKogadIlkHEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2D2ozxz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2D2ozxz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954d29264cso8435485e9.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785401025; x=1786005825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2aUYlvSnFQyHqLqh6TDTs9lMuK0bX5eXRwDs/M2T8c=;
        b=b2D2ozxzcEPwu9ZNorupQKEA0vV99qD7WKMmjcl3tQ3IydPccPWRa+YYqr84Taj9BX
         PmeukBL61br8J7J1kLsN6wvu0FA2cxVPUXlqjtZgijnaMgCKJTz3cpOFy7cZ3uYjuYPD
         2K73PvxqZhI5idC/iLA3p2XwtLwCEp/5F9iGb3cMbmAf/nM2B1VSRL5INUTKml58R3e8
         7QbFRB1+H81MHWaI8AP6ehMWNGKXNgEIVlyCQi1I49d1izNTL8StsgB3y5YHoUH0t32Q
         LQT123KKDiU4QVr4BYaLVjhqkpqlgkSEgtcE95+lF2uCQ7vUzQ27pHBHs2KkLNhOH/SO
         WuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401025; x=1786005825;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2aUYlvSnFQyHqLqh6TDTs9lMuK0bX5eXRwDs/M2T8c=;
        b=ARKyyM1nfCwIKzAKq3txlNPlymHMOjNpzXJuUOrdU03Fu2SPvPg8eX3PJ9o7VEfH+u
         A/mkzSY1zWNYKltgfXv/DXn3IzJh9Nm3crNphSyqval7QqJ2fMkjXb5ppC2FDgLRTegB
         Wqd8+oxYsy09y4q93nXjp9Hh1vWL9HLWk8p9tPT1tM3kOWpFlUUk4VF4Lzow9PPROqdL
         76VcC4+A5+j26uH8ScN2tSsH7b+YFyYm04r1kaXszcKLaXi8CeNSXISHYq8Usdixi+2a
         kRfrhhWQaDVm/DqEvu6O39lJtpzd9GTOHl6M3q5edr6oC/TJndQTQHVUoYBdGEQgp7pF
         iQng==
X-Forwarded-Encrypted: i=1; AHgh+RqhhZGck+clJznI33CFF04bhPB62lcblBfqwv1jYZvjLU8/0QZXFbAfZNLAcRYcF/I6ns5Z09JMn50dXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEC3y2yefHnw9qp72WzovBMVjTxc/G0x5t0CW1X3k6xMIkMY7
	+lchmryOwEaeDCYx+lgp7L8RmucGFxnsuwtoFYPKjrkJ5MwS7b5N6D+y84yP5/h3sg==
X-Gm-Gg: AR+sD12kMCnHm3xwSnf6YrXU5aYrEguyLVTTguml2rdhgaNST145c4u/3sq9GokH2UG
	XgyfvGjBz/7liCeYO0Pbb7Q848AUyv0EeSv5qAeCR4WUFmgj4kynH3pGVSrgjE2Hs+KFwhhUm17
	16kw5hpc5+VOn7eEAd9n25T7hvgtjMDQP1+0T7WdlRNKJoXbE7UhVKXPPvR11n7F7UZG2eDX3b9
	wgceM6fSl3E9QRGH1YNGRw8CRlpLDGhrRYHdsg5zP+VfPqQfbHSYyH0hvU9GHoA/hDiHNgBvlPg
	cA5Tv3O2Mk3alw1DaOamsh3iOLqpD+O9mwDpBjS60P2KEHAB1pu42gwrDeuDZsy8gM8lBYW2Gqd
	rQnX80XkIi9lfUQeaeTjf4Kl5z0whLnEWHsnwm4sTML8bEFNPfkuidTH1JVa1YW9coqPZnmyenC
	Us5V/Z21U8AHnNWSqpRjz2A2j+8E/MlwBIoYmVhc6CPhYaBCmmMBgphS7yWycQQvKT9kbjE3dXL
	DNq8kJEyztO9iB/5ena165gZ9b6rSXpduO42PZO9ox5G3N43dvD+w==
X-Received: by 2002:a05:600c:b95:b0:495:3b8a:bf11 with SMTP id 5b1f17b1804b1-49800ebb830mr23188915e9.26.1785401025320;
        Thu, 30 Jul 2026 01:43:45 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d6d0f8sm114474435e9.2.2026.07.30.01.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:43:45 -0700 (PDT)
Message-ID: <66fc571d-4e6e-4d2e-973c-2de4789df432@suse.com>
Date: Thu, 30 Jul 2026 10:43:43 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/blkback: Prevent missed completion when draining I/O
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, roger@xenproject.org,
 xen-devel@lists.xenproject.org
References: <20260730084000.3305702-1-hanguidong02@gmail.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20260730084000.3305702-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.07.2026 10:40, Gui-Dong Han wrote:
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -1021,6 +1021,13 @@ static void xen_blk_drain_io(struct xen_blkif_ring *ring)
>  	struct xen_blkif *blkif = ring->blkif;
>  
>  	atomic_set(&blkif->drain, 1);
> +	/*
> +	 * Publish drain before checking inflight. Otherwise,
> +	 * xen_blkbk_unmap_and_respond_callback() can decrement inflight with
> +	 * atomic_dec_and_test() and still see drain == 0 after this path saw
> +	 * inflight > 0, missing the completion.
> +	 */
> +	smp_mb();
>  	do {
>  		if (atomic_read(&ring->inflight) == 0)
>  			break;

Yet then don't we also need a barrier in xen_blkbk_unmap_and_respond_callback()'s
check? Barriers almost always come in pairs, after all.

Jan
