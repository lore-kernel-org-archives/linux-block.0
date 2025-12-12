Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED112FFF93
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570258; cv=none; b=kdzkFCdJhR7MB1397adtkDAMb9tsWtvmQxZDjIKCisXrs4Fx7x0H7hxmK7K0BkZ2ui6wETd+SdhJx/XIjUKjomdiGMnmcua1v9uUhjY+J0abOHFWQV9rwHXE1zKljgx0zQEgWmqxLu2jGudLogYBF0hVsLLawgyLL6F+n/TAdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570258; c=relaxed/simple;
	bh=4gfCtO9+aoCvqYEay1XZJUUI1s50LzgL381O6T7z7FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfW6hGVCImRjQE1D7f/HTaIhGJuvhVocIdSjnq5/mP6zMtf4erXfjIE+yNea6noOjotOPINvebTzjqD2fjZRLyajMnROOq53rmt0WKLoTiVqxkgm/J1R4CoGcnztHdDqgL3SRWPb/Gv1+5HckGiY7GTSfQALJOpn6Amih+UwLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kMcM4LWP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kMcM4LWP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29ba9249e9dso21977715ad.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765570255; x=1766175055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=;
        b=kMcM4LWPOOW5aofuFjI2DOpQEcNRY9pNxIjsXTaODIbDPKMC5FNcR7RvUO9eXo7mUq
         6BsGnJ80Xlb32jsfGAp+kCt1gImNMKb/QKdXHMJzk3bvdv8jJhbJphheaDpf4gyuL5OG
         HydGJQiIETyM9h3gNatOuE/XUa43fmZn6KP8wz9r5te3Ta0LYeDWaXyvX2hZGRTaXuXg
         /iNRw/JmobBVs/4eJJRU3EsIFK6gjThqYZOWcBvyjw/thYYPRJAIm93s1R1dBxjNosQg
         yLY2UQskQxlKMiLFwHf+C19An1ecALJSPCTKVzeWTZrQ5wRsmfgnj+Hjun9X4HRLWPjc
         cWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765570255; x=1766175055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsVed5WgXtZPXSfJ2PXjLRbNCmFwRAyF31OH8siBSJw=;
        b=q6qaPRGYbT/yU3obLaMmDfQQ3KuU2MJby+im4a0EHjpPz9M9+drOZ0xi8s5UlbC1YB
         ir64WvzimjkITRhaSGTvt0Bmd32W4CtmHN2GZWu5cdvZp8pctFWhf3R3LqAzRs/zhZGE
         855Q02maJTt618s1W1kharQXz9nsX49d+nKIedxr+saWeAPWPZO25hn2STWcWaMDTogO
         nvr3DJaO9+YoQxDMdblfuCDI/ZCxLWLoY9HkfNHCgr8DCt4k+e7YYYFgvgt7hNRndMfO
         lc0E2UKowTgWzj4fuy6R8VFzkCDnQWF6NzppA7wEeWc2Fy2282p2s/E4M3/hhrY5kZoV
         GlTA==
X-Gm-Message-State: AOJu0YztGNS8xCEIwo6lm3LElqHGqmeuWpIA12XZfIlDJtVYHq0BOCi/
	l8kBXvaGbkdjBpTkF2ml4h29s++sL3e6jL+90yD2gUBrR1YzYIygJ6PLy7c01Qh9r3E=
X-Gm-Gg: AY/fxX5kD4fB/GSritTXl4nG63ybOQRDj4mUYYEMuO08DFcE/5dj47iMSKLv7xL7Hpc
	g8hUgUqAoWyrb5dhPA5iotOtMZqlLKbB9lxdV4AFMoq3DD4yKSFVkYt7o7Zt73oW8Su4EuUV2n/
	VHZgPYylqQLGbFm2CDxrnbQDzy0HmnRGVDh5gcFdvX+2GEuSdzt6MUdVvtilkOAP6V8cP0J1RXn
	CHUqCtC42k8RTbHhr2kA+xQKMJBI5Y7SxRBpK4T9smap3vTtFrdeOlOJ/SU1jrsV5SLGY8s6JXl
	BBF0CnD3dBzCR0Uyjw/C9+9gBDO4FMrbFt0nn1748i4pVtz0KdJtWqZEEpWF/fSC4mmbi9RkpX7
	Lx+gPfEDmjTZDvhiHUD8hUhW+0bHKbuLoem46SpiqnzTHdlgJtuABN6DRNnGbCrTSC3sU5ibaJY
	iTf8gzQ/DqK0+HYMUNG/lMjcNxM/lVTps/EXknI3I2fwTv3liNng==
X-Google-Smtp-Source: AGHT+IH4YKlBbDeLqTy95z05gm75S6dqOblA2F2FrB859WtV1ZEekn7/gpBPyoL8TMFo+3JpfAzaQQ==
X-Received: by 2002:a17:902:f688:b0:29f:29a8:608b with SMTP id d9443c01a7336-29f29a861cemr19807075ad.13.1765570255065;
        Fri, 12 Dec 2025 12:10:55 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38c7fsm62825655ad.39.2025.12.12.12.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 12:10:54 -0800 (PST)
Message-ID: <2729b31b-ba58-4f32-b71a-75bd07524ac8@kernel.dk>
Date: Fri, 12 Dec 2025 13:10:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/11] block: move around bio flagging helpers
To: Pavel Begunkov <asml.silence@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 tushar.gohad@intel.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
 <aTFl290ou0_RIT6-@infradead.org>
 <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 6:08 PM, Pavel Begunkov wrote:
> On 12/4/25 10:43, Christoph Hellwig wrote:
>> On Sun, Nov 23, 2025 at 10:51:23PM +0000, Pavel Begunkov wrote:
>>> We'll need bio_flagged() earlier in bio.h in the next patch, move it
>>> together with all related helpers, and mark the bio_flagged()'s bio
>>> argument as const.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Maybe ask Jens to queue it up ASAP to get it out of the way?
> 
> I was away, so a bit late for that. I definitely wouldn't
> mind if Jens pulls it in, but for a separate patch I'd need
> to justify it, and I don't think it brings anything
> meaningful in itself.

I like getting prep stuff like that out of the way, and honestly the
patch makes sense on its own anyway as it's always nicer to have related
code closer together.

-- 
Jens Axboe
