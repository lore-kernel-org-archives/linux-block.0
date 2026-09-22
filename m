Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDF44C64C
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070734; cv=none; b=gfvVfbPM8dAVugaPkMDd7oK+gDLAeounNZhc2F3Lh+OOZMhrMFFvXwUe1Ra9hsXm0X7yqeVqbuzicoANrYOifuroDJwyVyxRZ/rECBmtpUDyAuU2PovfiGwYZ36HVD+wDLwGIy3/S6XdHV1Ab0SHYo092Nqk0cZpqUsZUoDIx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070734; c=relaxed/simple;
	bh=MxiZCmJT9Dufw+rEGKKJYfTRtYNzmG5IdUw5ajtU6+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZLw/BQLnJbPNpVrFahZQ9LWLQHOFgpSjx4xlXBJ1CHda//3OfB71ZXmjkY6LZwhXV0x/yeR0IuIOwUl4V+YNRjKY7iwPfBi12dboI3IKj69ujcx4eCPmTlCxgXyvZbdKlZdPFXgoQ0bfdYYGXwNYVdCPKbGVzITJNtn6MjUuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ox6D3lGj; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ox6D3lGj"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so2669946a91.0
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790070725; x=1790675525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b8gnsOu8dUZ3aA1jMaDEM+zSBKGqHWilm/tfYcR3Kt8=;
        b=Ox6D3lGjOYbouL6YmtZ2Bbed+sZAv+o7BqGuPt7M3avbUQOLV7UlsIoldA9Jlfx7ph
         gER/m0w+6zdnASZ17EqWmXnlnp/RkfAhobSw3xPIyFKiDrmZTamnA/osWEDlHHdnmmsU
         eStwOIW0JYWrPEegx3odIRd/zpsioQXSMmZWEUwYTlNwkFgasTfBqBnDakcKfTiSphJu
         M97cvRxknPzyLn2ktMGXD80Xc4Z5h1N3HrTSLiHWbI+P0SNuzfsKy9zeMeNl+HCV4nG7
         c6Kq3Evl9EWnAFGdU4bil0SmWlggUIZTFXxvUbUCvsr2wa1THzmwqoRk9sHMc4buPll5
         56jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070725; x=1790675525;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8gnsOu8dUZ3aA1jMaDEM+zSBKGqHWilm/tfYcR3Kt8=;
        b=G+9731dL93joGoSEH9Nyh7BYcGLDfYZZQQvTAd8YtZO/ep1reQwvvuDGrPC9c3WXXX
         Mi0sSh8/YYPKHraZkcaDr2HUW5p7+5+AeDYEsk0wyEalJMwXZNWV0kvgDQ6PYm8c81+4
         1Cw2s2/bOJEXB8gV/e6/2qTPt9Y7ij0Y/go0Q8G/dr6n7yWp9vER37MKO9pI3y6faX9d
         Crb7Ganf0uvBl8xUVVzTu4YLJhTlQQqARk3Vd6uaoTvdXBukTNM8EntJ3M+IP89Zc5JJ
         7+WFIBdhEZ6FHbTN9H7eWGKZdwOoBy3lf73uXHjEaOOD1G/WGhMULuWpwNTYzQe7BaDa
         x/FA==
X-Gm-Message-State: AFuF++kuD6dkUXM55pRCCjxMau2p9aRlP9f0/Heehagx7H65276+9n4j
	sGW0jBg9B2Fh9FSAB0A5NHF9KoKUSUb8J4NwEPc/UBJtpB4oUI7tBwDx5yuEe62yqWw=
X-Gm-Gg: AYBFou0MQDqSe5B2OM/WxkddOQVwjgkDb+45jzJmZGHtY+jri9PoRerSlM+updMYODw
	ad3FTImXi5uDZkKHZFxbI6VRcqZ6oX5HcSVoEdG+xOT/B5cPAMZ9FUAD+1q7GB8kxmSFhj3B9v+
	30YzZAWEtU4ruzJeREN9vGp7Qxc/Kz9Wc+Kxhf46g/nsel2f07AhXSSoHLT3S4CmbSomdGQxbbx
	VkDnfgO2MwSN2uPm4JVcNFcoYKxoRh9O62z0O6A4r8zhxh4U0Mw7xNkDNs1seIK0Z+ntKCdxVP2
	7MNEgSL22XlfHSR4b0aOsSlznCbHQJbfRIzMbH2a6g9wfEDJuD9xEP/rfq2sbF0i8t+Kz7gkd16
	2EDmbOpepKi2i0uhkd7Z+2HzuRLCIzgnF+ey6FXMlWoB7tARBeVlkOJO8haQQJN2uN2OTbd7N7J
	ev3UxpVR40N1CuBi5t62ktZzPYmNj/9LXO/Nc5U6PRBsAUPUQ5nSKaWrDjH9HqJwAArkRmy1q6B
	L9oFRx8FZKg8BoCtruLjnl/QwavBm2VnQA3lNC/RNK4vef459w7
X-Received: by 2002:a17:90b:2fce:b0:39e:14db:4371 with SMTP id 98e67ed59e1d1-3a0730a1432mr716576a91.1.1790070724728;
        Tue, 22 Sep 2026 02:52:04 -0700 (PDT)
Received: from [100.81.13.24] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3905971a91.7.2026.09.22.02.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:52:04 -0700 (PDT)
Message-ID: <e9d4b9c8-1b0e-45fe-95b8-f999055357a9@bytedance.com>
Date: Tue, 22 Sep 2026 17:52:00 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] memcg,writeback: flush foreign bdev mappings
 separately from owner wbs
To: Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, willy@infradead.org, jack@suse.cz,
 akpm@linux-foundation.org
References: <20260921120658.1627992-1-sunjunchao@bytedance.com>
 <20260921120658.1627992-3-sunjunchao@bytedance.com>
 <b15c63490f9164bf46d68ff3ec5dfc02@kernel.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <b15c63490f9164bf46d68ff3ec5dfc02@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 1:55 AM, Tejun Heo wrote:

Hi, Tejun.

Thanks for your review.

> 
>> +static void bdev_frn_flush_work(struct work_struct *work)
>> +{
>> +	struct bdev_frn_flush_ctx *ctx =
>> +		container_of(work, struct bdev_frn_flush_ctx, work);
>> +
>> +	bdev_flush_by_dev(ctx->dev);
>> +
>> +	atomic_set(&ctx->inflight, 0);
>> +}
> 
> The in-flight window is now just the submission of the bdev mapping, and
> mem_cgroup_flush_foreign() runs on every throttle-loop iteration, so a
> memcg that keeps dirtying and throttling requeues the flush back to back.
> A folio the flush redirties, e.g. a buffer locked by a jbd2 checkpoint
> write, re-stamps the slot on its own. The old record stayed in flight for
> the whole owner-wb work. With a journal the write cadence of hot metadata
> is still bounded by the commit interval, but for nojournal ext4 and other
> buffer_head users it's bounded only by the throttle pause, for every
> tenant of the filesystem while any tenant throttles. Not measured. The
> description covers the target size but not the cadence.

The description, comment and tracepoint suggestions make sense;
I'll address those.

Dirtying or redirtying the same device during a flush can refresh its
recorded timestamp. This is expected. Another flush for the same
slot cannot be queued until bdev_flush_by_dev() returns and inflight
is cleared. A subsequent call to mem_cgroup_flush_foreign() can queue
the work again if the record is still valid and inflight has been cleared.> 
> Each pass also goes through wbc_attach_fdatawrite_inode() and
> wbc_detach_inode(), so it votes in the bdev inode's wb-switch detection
> like the owner-wb flush did, at the higher pass rate. Whether the bdev
> inode ends up switching wbs more often is an open question.
> 
>> +		if (memcg_bdev_frn_wq && time_after64(ctx->at, now - intv) &&
>> +		    atomic_cmpxchg(&ctx->inflight, 0, 1) == 0) {
> 
> Records are only created when the workqueue exists and @at stays 0
> otherwise, so the wq test can't be false with a live record. Fine as
> documentation, but the cover lists it as a fix.
> 
>> +		INIT_WORK(&ctx->work, bdev_frn_flush_work);
>> +		atomic_set(&ctx->inflight, 0);
> 
> memcg is zero-allocated, so the atomic_set() isn't needed.
> 
> On patch 1, the kerneldoc's "does not wait for all I/O to complete"
> understates it, the flush waits for nothing.
> 
> Thanks.
> 
> --
> tejun

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
