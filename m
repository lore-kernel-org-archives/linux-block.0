Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392B3815F3
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119062; cv=none; b=kZlU+eQoQ+DaipCSlkY2vAbIPDOe78HWK/fhDIqX+FF2WmLUbrf47znD/W1iCqCaksRCp8NsCSz29b9CPpVeWrCkqAsno4TBcffiFPEXBk2k+OIOh0jNjeTuw43gNkiZYGm9Odysxvgilw3fUHD665B4/HSqR+ACFVxFI3vk54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119062; c=relaxed/simple;
	bh=OzhKQ0zjdHqPgB7S+Ikgz64g07wCTq53XVCI+H2FpN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHzKMxQO5Z/ExYjf/Wsby0BtvdbdlX/oGQAZwfsbxGktf7UiOKxlWQS+Rw6X3tTV5H6I03AOUIf1D8Lp6UVxE3B6z4+0uLCOUG0nxjIcoBB1GptxnwIr8Pz+Pc208kNJKB2CDCEj+4jErvF8qsImx8idoiGOt60Bct4Y2/Mpcvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kqT2McTD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kqT2McTD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-884062f3296so3590398b3a.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792119061; x=1792723861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=te0aRe2cAvi4B71/ALfBS1DPp0JoXviSgYqxKkN67ro=;
        b=kqT2McTDjVGEe4vsEDUEnE21LbEsyHigEO2pK0ihU47yud3o+uv3WmqK1khacT1qRi
         IGtpASV6dK+Y/XCDSB3btoOVWuxsBfRIGp77SwOuM/pF18VcZl6QKzcR7NcxeQXTM5MC
         8W51peLLI96FI3Yqueo4zZopnkg21/FonIihI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119061; x=1792723861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=te0aRe2cAvi4B71/ALfBS1DPp0JoXviSgYqxKkN67ro=;
        b=pzIp5mY/n1KYs4l32qQ/T518n/BRn6RKIw/+lCl+xccQPfKYjH02vL8R/t9nuSGaBG
         jqN+kphNNcbUhEdqNha16kbOWXfqXMEOcfnQYmqUc27yzttV11YpvmpVFCF40DdrJ9lw
         L3741DDehZhO8qY12GyU+LHApLbZhn7GVMGMAGjzO2Bm5x9vZS1MYL09zNPejiUJYX1A
         egMoPo4DiiPDHHqemy7c2r/AwsyNhiWu4xqSdgL6+8AtBe2W7KP2EfqXZfwCUk+V8gMh
         eTFx1l6+2nHQePn1MMRQjVqf7ue7+KQXyXlsJXDg+UOYU271TLCJ1hwkYTh45yv05kpk
         Fh0w==
X-Forwarded-Encrypted: i=1; AKwUvBzwM//fwzvNNmG36f7TAS3JuA/MzXIZ3FHP/49lnUbbneoViOYjRJqWyeLkCCZu6ZmGWVw1aDXOlBq8ow==@vger.kernel.org
X-Gm-Message-State: AFq9FYKX62RAx1C0kM3+eG6o36/KWHzaYe+j0aI64Od0UynIt90rDlBh
	jbyf3fg8spjW/JeVVxgBW4p/M0XGGjBQN10QJRraU3BjOql/l2RzZy7Apr/XmSrcyg==
X-Gm-Gg: AYBFou08B9fvE+9fCXIm0c5dFErnmqyuonzqkFAM4QpKH7CzK5D7qyhG8LUFY6H1zzl
	KJ8dDmS6LZbt7awK7MYBCp4Y9gNcfUaTYWmozWTJ3pGCKdOE9u6Fmfr3PzyXCUu6C1kX8KO6IyQ
	Im4V5DASd7+rpnUenyvzTNAi18DjA31i6URBP5A/x2BcRsRmZk38MVPm2p8z0qhuWXszNcRZ8Fj
	iZVP8RgyIqPbiC9JpH7QTZVNc6OoXAErdkUPCPxOoKNg89DlN2yiQ1SsDoEtwoPVh+L2VxtPZc0
	EW+xqR6lVIjYzwG0t42lhLdG7temxAk0lxmaMA9VKie5kf1Xe4RDJ6FE5wjLcKWbDvURvQFupE1
	R0C+nEYxtyN7BLH8jifio/c2nJatf2kh2mWhvS0fObu2UYqwIF5RMeKvjjQx2ilrQnLIkeTAmkc
	ukJ1uL+CvEC0/MUMb0kUJLZSOixCcieJkWLC5e60WuW+xuN//VSQsPQ9aIEpjaHrepUAYEtkbKq
	1FdD6EAdlwAvELkcLOAOi+WI01Qmi/l3XCCqyvhF/lyylzHGB6OzybIdtHVYzWVHFCb43q+Sx1y
	HIHQUEcYCEwnwN492Cvq
X-Received: by 2002:a05:6a00:189b:b0:88b:7278:ebf4 with SMTP id d2e1a72fcca58-897c70104e6mr21100989b3a.18.1792119060609;
        Thu, 15 Oct 2026 19:51:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f56c87e66sm390668b3a.13.2026.10.15.19.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:50:59 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:50:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, baohua@kernel.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atGPwJL6XzlRaMva@google.com>
References: <atBh9xfpOji_A7A_@google.com>
 <20261015112440.1491168-1-zhangbo56@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015112440.1491168-1-zhangbo56@xiaomi.com>

On (26/10/15 19:24), Bo Zhang wrote:
> On Thu, 15 Oct 2026 12:19:49 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > Or perhaps we can avoid vm_map/unmap.  A slightly different approach.
> > kmalloc on fast path + memcpy (zsmalloc objects are strictly less than
> > PAGE_SIZE bytes)
> 
> I applied the kmalloc+memcpy variant on-device and re-ran the same
> Android A/B. It removes the exclusive path entirely in our workload.
> 
>                       9+10       9+10 + kmalloc fastpath
>   read contended      ~1,959     0
>   read wait_ns total  ~12 s      0
>   read wait_ns max    72-96 ms   0
>   shared              76.7%      100%
>   exclusive           23.3%      0%
>   dpin_contended      0          0
> 
> Every decompression now takes the shared (down_read) path, including the
> cross-page objects that previously had to go exclusive. The ~1,959
> residual contentions on the exclusive path are gone, and pin contention
> stays at zero, so the full read side runs concurrently with no stream
> contention.
> 
> Read-side contention end to end:
> 
>                  baseline   9+10      9+10 + kmalloc
>   read contended 24,749     ~1,959    0
>   shared         0%         76.7%     100%

Thank you.  I'll include kmalloc patch to v4 of the series.

> This is a stateless-backend result (lzo-rle). zstd/deflate have
> create_dctx and stay exclusive, so they don't benefit from shared reads
> at all - which, as you noted, is the sad part about zstd on that list.
> 
> For those backends the serialization is unavoidable, but the actual
> root cause of the long waits is still the holder being preempted or
> migrated while holding the stream. So on top of 9+10+kmalloc I tried
> a quick-and-dirty preempt-disable for synchronous backends. Allocation
> can no longer sleep under the stream, so a two-stage zram_zs_malloc()
> does a non-sleeping attempt first and, on failure, bounces into a kmalloc()
> buffer, drops the stream and retries with a sleeping GFP_NOIO.
> 
> zstd backend, same A/B workload, on top of 9+10+kmalloc:
> 
>                        9+10+kmalloc   + preempt-disable
>   cwrite_contended     14,880         48          (-99.7%)
>   cwrite_wait_ns_total 137 s          0.32 s      (-99.8%)
>   cwrite_wait_ns_max   243 ms         43 ms       (-82%)
>   dexcl_contended      15,919         54          (-99.7%)
>   dexcl_wait_ns_total  109.6 s        0.68 s      (-99.4%)
>   dexcl_wait_ns_max    145 ms         34.6 ms     (-76%)
> 
> zstd stays 100% exclusive either way; the win comes purely from the
> holder no longer being preempted/migrated, so the hold time stays short.
> It's the same mechanism that took lzo-rle read contention from 24,749 to
> 406 earlier. So the two are complementary: shared reads remove
> reader-vs-reader queuing for stateless backends, and preempt-disable
> covers the exclusive/write serialization that stateful backends can't
> avoid.
> 
> Quick and dirty, for discussion only - Patch below.

Yeah... I need to think about it, before I can join discussions
in a meaningful way.
