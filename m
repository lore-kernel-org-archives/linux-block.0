Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC2370D63
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140285; cv=none; b=RcZC/52Ok5DUONZiAoITCYD81fu3tREryY78W/mNvZbfSXGNxMh9IwxWPYts0lV+NmKeDNoTf+mfwlndTeBpJPVzIQu8aC4Yf2l6nMAJOaO8GfOGzGWbEU1sQWDm5StQRKxmfs/SkyDnslJ1zBUkVn408cqDP7lR9I/J5fHXBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140285; c=relaxed/simple;
	bh=hXQbl8Cit4+T7yJRt5JdQu9NH39mDdQbqe+q74GCoO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX4iuwOkaybjVDceIX7JSNONtIDnmGuvpePKrwqfrdtEa/SyFnH7UsOY456XKUObR+7f89gwRj7kmYDIow2cBLPDLS6AALUOoVqEfTjSjJy05U/QllBOLlh3tWfWISuWx38mRR+9gMZV5z6kCkBqVh7Irb5H379YjAx7ZYw8y0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=KZ6I+6+l; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="KZ6I+6+l"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ee990e8597so929655eec.1
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778140281; x=1778745081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5O+SMVnZI3YBFvbhgSVs7bzkx3ZYwEGUQfzptmHoXU=;
        b=KZ6I+6+lwczseyjNIJZl4pBnDm0jGr/gk/aThc5B0UbdSKkCg4jGX+fi9cTHPUWAtu
         SEbDm7iFVXAYEJiKTYZzogHLbb6Q2+VviNncsj/ajX4svIBx6BMXX5mhNMjBwdV+egUG
         HiKDKtsRgsvHiBcVs5ULSQZJZ17mx/xqCEW/CWQyQPtBWm3srajLdrf84VXJ/fHblgO5
         FNjh9tmUVd1C/IMC21YNTU7GSW2d6ozwFIBSB5+bARGWBCA56gt2E7qTPD9aZlsWev0L
         mop2cbc0ex/mMYvw33aUH3wWDi3ly4mn0M6W94DSrG29xsnTwZP9mwybPBlLc7B81UBk
         P0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778140281; x=1778745081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5O+SMVnZI3YBFvbhgSVs7bzkx3ZYwEGUQfzptmHoXU=;
        b=p17o3YhUNg5ZYUYMacCkw6hZ9CKzLAr/9Uiti8dRvyLvorlpcTdbloDEZ/iv7cCBw8
         t/Q1Uva13OiQDl8jsoTabCYY7Rf9ubHBgocbmIYkDm50NTBerVZPhVqnUp6FIK4wfszI
         ++87MpCs51YAEsQsUtJTw6egVY1CB30TkTD5DeevFEtu5gtd7P48tbeKnqXiZDcL8h3G
         PMLyEJ9s+u5ItuDW30yX5TxP7Zz/gw/2LIH6NTMIACZPvTyQ3w9+rWnYFzRSsphoSAx1
         B/loSdmSd4sycN3lQeGYLSAKkgh6EPevE9f1Zrzt0RT46uKkEZ1RUIPKIMild9K/cURc
         0oZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YV49+8r71Tapo9xr0cxaAbx5S3Xu7XJcZ9DjFo1QenKHHjnMH3AHNJdzsZrkH7XJw5j2yn6pG6YG0PA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19ODvk++I7Tqkw/9iRi7pyNnGO5HrUF452FIVh9r6xmNx+Lm5
	YjzNRXk+z4yZGTiXdmS0lkesyxUvWFi3QdG/EUplg2iUggstfV4vPlXbZDsK3x3TE6k=
X-Gm-Gg: AeBDieuX7auVTh/2XV1+Ka2iDE6vZp9My4Zvt/6tKSFUqrS2bcSZoNuuv4160N0hZrG
	EByX6ELpKjbHhCOGMramqmXA7dnohId3tpqGmf8KpDHf8ZUdbRQlzQvRjOIFvYpKCmkobnOtuPh
	FpM5FsGEAYA9BuJ2/R4DvhHeWL9N8DOwJLjwXuca1YuOgrTO2AMpZfwJ58cGV5oQT50h6J8Aa2J
	5ga6xyZDjGwwNQ+PN5Gs5ejdCsPoKkSsmsafkPQcNv8SpXkmaZoiJPnfFikiEdxib1rssaiTIhl
	bLNuywG7jgmYMXm7qij62ZmEEQbl0PtFzAxSDPrOdLR248h+px2olpYqhaubxbdFXgNZOgZO6q0
	vTjZWjENlf0CApKbmz5AeGKc9CM2d54NoUkXLGDwq7gMd8iI54KNuk2zn/oZvMULUfxKKrRCOit
	0ByKQJmgJW5NSpIFLTeoD4TNMMu+A00blZzXAzZNIUhtEP3sOVfZCMijITHBhSDPYn0lpJUoxnT
	GKQtCZt/qVshl+I20bnXfu48cN4bPZp01miuLEhq3AzaFETTKB2ziJKCNZwZrmS82MN/MUDKq3A
	DIOPgNPJ
X-Received: by 2002:a05:693c:2c01:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2f54b265a7dmr3572827eec.23.1778140281108;
        Thu, 07 May 2026 00:51:21 -0700 (PDT)
Received: from ?IPV6:2600:380:4661:8001:1a06:add6:6891:16e? ([2600:380:4661:8001:1a06:add6:6891:16e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f89csm6750124eec.15.2026.05.07.00.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:51:20 -0700 (PDT)
Message-ID: <3f01f3b5-f57e-4e04-8a70-ac0722f243be@kernel.dk>
Date: Thu, 7 May 2026 01:51:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: bio-integrity: Fix null-ptr-deref in
 bio_integrity_map_user()
To: Sungwoo Kim <iam@sung-woo.kim>, Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
 Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427040926.987166-3-iam@sung-woo.kim>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260427040926.987166-3-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index e54c6e06e1cb..766cc2d1d51c 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -403,6 +403,23 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
>  	if (unlikely(ret < 0))
>  		goto free_bvec;
>  
> +	/* Handle partial pinning. This can happen when pin_user_pages_fast()
> +	 * returns fewer pages than requested
> +	 */

Please follow the multi-line comment style used in the code around you.

> +	if (user_backed_iter(iter) && unlikely(ret != bytes)) {
> +		if (0 < ret) {

And never do this, it's so much worse to read than if (ret > 0)

-- 
Jens Axboe
