Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAF32C8B
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064120; cv=none; b=GszBJc2UIgm/xA3Yub+5tOrzNPT+YLnjj4ZSurccaM+b3gQSd/MNsXDSXVYYxi8q5rCI6M/IOhKPE6wjrN510Y+vNGaXYSOcDMwPF0fqBRkQc/S7OIDDKDjW/P2iH/ltRbdb/iA4PbAQ5IX74N0Fy5u7CqTiW8GeZmAhVV2lV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064120; c=relaxed/simple;
	bh=DsY/SFW24sC0wmI81ASDC6V+e+HKYw5jdUmk01QezMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9jDSbEaOf0uWTrP0KThBybLRyYSMIAdkA2Oeo2BSLjVISR05PHwJStCpVFuORHrl42JF2CNvvuNjaQkb1PE6BUgTDY23M7bGG+uCFLSAis9+hlakuZcg0zyOzM4eHCrTfXBt8u6xR7SEJZ7xLLYQFToxIoe3A9cIJJLx8FWeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ElyqBId2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ElyqBId2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d75312379so492017f8f.1
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778064117; x=1778668917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcF8GD17NRlKZjIVYFwP6ujBkxC9SfM3ir1MBqAtF6E=;
        b=ElyqBId2NgbgVecq4foesAPMYH/MeTUG76BFt1ZVC7GsWuypifll1/KvwWLvvtGeKU
         dA6PSX4FLcddVI88d1iI1FXdx//bSAxRlYnp5Agjd16C3GU2sabWuAkSjo6QYcg96Hl+
         B7k8YukO17wdAKSCt0x9cHGl1cVGtbivvidIRk1JXS1LH+iLoAhPmerQLiq6R+8CtuAJ
         t/oGtBeuipz4vawVLEulX8rO6RTiyLh7sTrYz/wFPzMaPeqb+cKLbVhjbROqus80cxm9
         aW9UqMleqslPel2CCdUUA2PITMyGs2kHYs/auCvzOSGNCrPCQm/HtPQbwHKwixsGjuB7
         t2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064117; x=1778668917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcF8GD17NRlKZjIVYFwP6ujBkxC9SfM3ir1MBqAtF6E=;
        b=Ih5v0QDarOop177eeaaL/eetwgU+d39ThoSYKqlJNjCSoa5e0N7GOPkJPFuWPzsgCU
         i+PGDVpMBAhsJ6CMGhBN3eVd2o50OxAGZTQVq65ZaHOBxPKC78HJ7WgFv3pLV047Styv
         PV0vqX2bMURKSpLlqVJzWu0YA2PFl82a19OMGn84wCCGlE60QRf6TgJ8YEGClTKhMQwz
         ms+pOimDNulD1FUAxMg2gV/52/9LXcPf/h4JXACccQMb8wu7d+54L38yGrnYfWv26PeI
         L7GVaV+2Z9z7FR13oW07RuuUjjDwi/HQhlGDKKhdnm+VlBOBy/3nVlAdAQFGPN+evqXK
         6OsA==
X-Gm-Message-State: AOJu0YwPqGga9LW3vU7srJIPAQrtHIDbFoVFEFsU8543noU+MuMoJPvU
	TZpxLXqTW/0E1grgqc/pMGSewN2fXd+o1/5XoMGMA7EPXT4dLFDRjiDH1QVqsptec1E=
X-Gm-Gg: AeBDiet+OQ0qYd7ONH8Nq2UwFoXayUgBIF8k64LW2/VdGNfyL97AU/b+Sp7e/pRMaI/
	VRoJU7KM94ZdC7lybOJ3QsBFPxPr+iWUjQyGyttDT02EMjjgcgryE/XfSGOJa7+/Qb2TYUKYtUl
	kJMXly8Nt024H72mjQJi1r/CDTqDqnrduf6d2bs2djWqCcdU4Smr4NOvBOF1RYUAtzjqkUOtdjZ
	3ZvPazK7zvREqt2gBDiliTxgGldjQeoAO5GCOwyIcOeGYmp6aKDaMzLxODQPywiq1VhJ7GmYGHn
	dn1Q09BKzL2Ks8AbslrzTdU9A2LnHZeC0BYznEaCM+8j+qti8e7PhhASfOtbeatXx//7lddtadM
	BvDxfPyw9VZTEPjSysDnXFMIGBYweQlI9eRF/rKc4+tQBvvkQskcfN39tlhnpUgCN+HnFYZKoCC
	s7AcYRE+YYfrPrXnD+H1hwxO7qWpKsgoHhHKitboLOcKwy+mHnFi7FqBXDJF1XjfuQjbQfz7HxS
	IewEO3pxz42HQz7DuwX2MEe7Crzejg=
X-Received: by 2002:a05:6000:1842:b0:44c:53dc:8cb2 with SMTP id ffacd0b85a97d-4516594c3f1mr4347575f8f.14.1778064116826;
        Wed, 06 May 2026 03:41:56 -0700 (PDT)
Received: from [10.211.9.173] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm11670232f8f.2.2026.05.06.03.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 03:41:56 -0700 (PDT)
Message-ID: <9face7b3-d4de-474f-8948-d8efde02bfc8@kernel.dk>
Date: Wed, 6 May 2026 04:41:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: add NULL checks for bic in bfq_bfqq_save_state
 function
To: yanlonglong <yanlonglong@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai@fnnas.com
References: <db3d516f-6ad2-469a-9bd8-1a9b61eb12a0@kernel.dk>
 <20260506090409.49648-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260506090409.49648-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 3:04 AM, yanlonglong wrote:
> When the `bic` variable is null, referencing `bfqq_data` through `bic` will
> cause the program to crash. Therefore, the null check for `bic` should be
> moved to the beginning of the function to prevent referencing a null pointer.

Cap at 72 char line length... And title should start with "block, bfq: ".
And should be "add NULL check", singular, see below.

> Fixed:fd571df0ac5b289af8?"block, bfq: turn bfqq_data into an array in bfq_io_cq"?

This tag is wrong, should be a shortened sha and the format is also
wrong (Fixed vs Fixes).

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 141c602d5e85..e952e4ea2dd4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3035,9 +3035,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
> -	unsigned int a_idx = bfqq->actuator_idx;
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
> -
> +	unsigned int a_idx = 0;
> +	struct bfq_iocq_bfqq_data *bfqq_data = NULL;

You're killing the empty line between variables and the comment. And why
is a_idx being moved? This is !bic being NULL, presumably?

-- 
Jens Axboe
