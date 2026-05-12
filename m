Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4494A3402
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578241; cv=none; b=VJM4W/4KW8mC9wiiKUsPFVLRX0yEAgTmXi/qROyhQ5idcwyJxUC5D8ovGJWX7AlnbOF1F6ED7BMfOSl9J2kjtukidw6/BNeCjODuJ/HAl54Be89YetiRFYpKj+CEjht5AvQUW9vbQaDwYIsFje8HMgzzpThRFMNzicw3cTcwvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578241; c=relaxed/simple;
	bh=AmxHQti+Cn5C3pCrdSnBlqV6BaHV+iBm0oydG8MleKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+oBMdgL953teDw9ggAoir6fPDh9We10M9+y3N+spHlOv8PxpwPmdc/nxdzxplcYsWf9sYYWlY8QGzQ/uGEXjF9bARf2GLkZNp6IWToe+BkipGNofSYH+VSFiqX0jF8ShZkppAqILLj757yNxB4lVdB8bx8mR/5S5a03lUnX8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHcEIjXa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHcEIjXa"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd0209f25c1so286543666b.2
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578238; x=1779183038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
        b=WHcEIjXadNkPFUtxZjibbIycxST9iPZAoiAmYMM+LukrN41+AEMZMMUijkA9iID3PE
         xg4pwXQf1Jf28htElNpnJC22niTXyfKF2ymcgg/R2KWT8wuJf7+q2BzapkmyoHtiZ9yp
         ZeXZ3dQBvv9XhLemLk6KoEUkaMeUy6581GgCbmz5Bl7y6+kbR3Wnh6/jD6M/cDn9kMfZ
         8AT9zIXP9OC7N3eldFmoe4xsIW/dvKGuw497uGm9lfr9q33CRajDdp+P2QckaO8WZZWu
         SK3l7wPIIMsdE2Ht4/8hyulcplC4t6peIu+13WnT+be/vVykhbBCd5Kgo5tQ7Kxl6IsG
         JtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578238; x=1779183038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
        b=kWuOP/3aPw49DKqlp6O5e6f+9YIvx23Kbn+9fVOtuZNChKWzlXDd4LMUsxqPFqlZJ7
         eSTxBABsXOewFG+RhhqSBNL2QSVLqBcgGUUAfjWlh4Mr+FhyWgKAFbKlJllLzFFyn73A
         lwENzDxkiU2wlyql6aZD5Ysnc0v46swSbdVYy+SM1pO2fvB/ksr1itKaEZQHqgSiH1Lg
         rTXkgiLYLmYP8r42GlCr7eKpKS4FGg0/Lh3PLQtQiJagXZA84ti6dlqeod71jo5Cd++x
         UCdvGzeilmhh7MdI5oxl4T0WyGS6UyBi/9eWpIH81WFppjYU2n8mY8JaE1U7ySdWzZfm
         1nnw==
X-Forwarded-Encrypted: i=1; AFNElJ9zQKTuCy1Fvy0D6Zy07CtV7RtT1xYGzZhJH4zAvpilCrTfFOvBq7SjCu1LvHTyoIY7tuuRx6i6d2eY4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BQfVQgWwFKMJnLLbe5X6p4Q2lwUPDM9HKDpBdaVr55MCPlyW
	Jz7YCpQYrBVdViFCeXRzM1fgqVF/UGrirXFrwjPCobgh1s1tah8Nv0y2
X-Gm-Gg: Acq92OHJxBrvnQ15xpDIOYVeOfzZi0WFDvloQjHM+EwxpQlFQ61U8gP7j5jD/uI1fYP
	RLqgU0STMEYjx4MkQA4x9TonytrwDPKqz3I/YwRsHZ70/8R12Fk7dykPFbI5amAWwSGqspE7ZMT
	fmKErkaujwIyJY1y29H9N09Ap85sRrjtvBHr9uDjfpb/Xkr+mPVW7a3b3578/+q5HLReI6ENRC9
	BWtMv+2r0dIA+scs+ILClOb0eoSd/ZIhzEM0ZZSMKEAe0bZIS/EjkOXaCOlanC3GbxJAMtzrUWl
	FMBjpjSxEp0KEOS8i+36sLYtOn2KtrGPtD2jeojwm1khmv2RHNyxIWAq+BLb/1Lnfyuky0adFVv
	mE6JOTlR02AVtFHIZZgmS0gTL8erUv5V/+Q72r2PAu0fXtDwjmzSi9tqlkXjBgEBQPGcq/xKOmy
	2yqGGy4DlIp6cXdhNh6Rqh8WWbgJzoyIDVIdHj77kU3Y3XOKtMEke5igKBwZKDN+u98fDVU3b/1
	NpnsP8kDhHbYjK/+oQAY361mTWFHQYiMLoT8VFQYeyF7THbbg==
X-Received: by 2002:a17:907:97d0:b0:bc2:1dab:3ea0 with SMTP id a640c23a62f3a-bd28de036d4mr114881866b.8.1778578237873;
        Tue, 12 May 2026 02:30:37 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:30:37 -0700 (PDT)
Message-ID: <24cc68b2-c432-4623-92eb-b56b76850c35@gmail.com>
Date: Tue, 12 May 2026 10:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <afi7c-VUJWOLlC1m@fedora> <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
 <afxgc4hizusnAA26@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <afxgc4hizusnAA26@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 10:50, Ming Lei wrote:
...
>>> BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
>>> which can maintain long-term vfio dma mapping over registered user-place aligned buffer.
>>
>> Interesting, just too a glance, and it looks like what David Wei
>> was thinking to add to fuse, but IIUC he gave up exactly because the
>> client will need to cooperate and that could be troublesome.
> 
> Here the cooperation is minimized, maybe one shmem/hugetlb path, or memfd,
> and it is one optimization and opt-in, and fallback to normal path
> if application doesn't cooperate.

My point is that with widely enough adopted interface the user will be
able to opportunistically use it without knowledge about the file, i.e.
not knowing whether it's ublk or something else. But as you mentioned
below, it'd be cooperative interface in either case.
>> Should we try to push everything under the same interface instead of
>> keeping a ublk specific one? Again to the point that it requires
> 
> If generic interface can be figured out, it shouldn't be a big deal for
> ublk to switch to it, and the usage is simple actually.

Sure, you'd just need to maintain both as there is a mismatch between
interfaces.

> So far, ublk supports both FS and nvme block device.
> 
> And cooperation can't be avoided for this usage no matter if generic or
> driver specific implementation is taken, for both fuse & ublk.
-- 
Pavel Begunkov

