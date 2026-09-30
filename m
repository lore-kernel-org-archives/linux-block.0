Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2B3C109A
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762897; cv=none; b=rqjxZY/Rjf3Oc2k5KNwRPir1rrR3zQd5BIA0X8NzTi7pPbvnnOsgCy4f7GUAvOqCDELeXu+px20R3rgc4k8s5hNHoY3upTfH4PnKdRqrRHXq1rRryNwrt1tk1v75nU3kHth/nGvMZv7VPJywkizWHAMR/tZXJ0Ep8YxPJFng0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762897; c=relaxed/simple;
	bh=yFJZlb+iGZsfhNjOANXyz0l3Z8bjj8XhD2cNkl79VuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf9R9m6grso+MTbvEHP/v09yPSSEDcsMrVzwTkxPUd40ISUGwWjxGec5WYEhZZkDUW/IqvGNNNJgfBxxN2lBLitiBPb3HalIkmzIe+YcshKtBS6jbBNNq4U0CLj1ZWN7/ajY/J0rF0p/zp7THxvMGz/VuZzzLqtAINkdujXkeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pv6qrUQZ; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv6qrUQZ"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae1f2cedfso6717549a12.3
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762892; x=1791367692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=;
        b=pv6qrUQZvjpTIGQr7ilzmWajqAelw6/EDANTOn30ksWuTe9TVmd0SVMbuFmVe+LUpB
         sjqXVYJ+H/oWfl3Y0Pi5vnmGW4u/osYljg3ocJ96gNhBhNL8gL2eTRZ9fpw4WI2e8xsV
         pzVKjTjrCN0fRNp+OVV5Okam8ZftHFHo7+kpoMT/T9A4Q+uSVdHo7vPVWry1KoN72Uzq
         xKzjWcRnQGOldYZU2H1jo9mNGTGqmhtwbY0zwWdvc7Y6i2g21Vx1vFhMG+t/FSSm24Ws
         VWpD6LSaSZCqrTqdpcusezC49DCBWv/stolPeavtdUlPV+EVSLUoKgG8vVpJ/6FC5e07
         DrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762892; x=1791367692;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=;
        b=qLrDi4VRTC/TKo0pRaOSDanBn4S9s9lNhK4MDjckA+tHdbdqJ/Cu0PrRD4CrqNeD+u
         Zf4dkJUj9Rkw72jOKHP3hteJ2pHj830YpLgsSFhPdcQgg0ljGJHft6dTN/jbBlBNMEeV
         dGH0ifWssFw3MLUvaEwXaqr5gMYgktZAllFCx+HbYVadgGuEOFIXSicLwp56aYJbODRL
         0JQYmavWks4K2SJAM2gIWml9i8i3L7y2azXDWRUzS/z9rvUxGWUVpXf1dn/tCDrhpg4W
         0rgjtIx7bDGi857xDK+jGcdQfmQAFjqX7Xrsg8ty5D3CdBqBtSw9rcIsYjxBx/TrmWSt
         x5ng==
X-Gm-Message-State: AFq9FYKLnTimo/fZlfpCPWQpcHhXRflp0dyX0PrkaG7O/d7pcEAVUhyG
	iU1anxJbJikuQknPRO62mV+/QDYCMp09/l3GzWNOtVQNnsubwVUFPL7V
X-Gm-Gg: AYBFou3reH2Uaapokq9Kd1L/WGx++CIZApzleOV/2deDApIba9oEks2+4LizvLE9axI
	y6ghvdyvHDHA3V36PU5HhehkI30hDqd0pDXUkx5P4LMR1AziGDS/DnvnBGTg+C7Q210JmW7nIzT
	KeGTm96xMtWlExBAw4dy8lm+uldxIuiEtbaAEe5NbetBuDVeOw9UTijoUvlAv8ohMgE8KCGQq8N
	Klb/g35dFiJojZyN5kjQYwtY1qw+O6WsMvA+1dlrJfwDqtbpRG5lvp1UGqjKTVMwXhCfkQ/u7PO
	eMjHws8oQzGVyglHGizefrcjr2DpTmZ6FTTmfj/qW95JTRKrZY3AGHkmf5XeqpHVCpJi23lix5k
	sDiXb3ew0riKl8iYu0sgluPHoMLmhBeTxvEE4A3zcpe6s0Y3Ja4R5ge3XomdqWnvISwwxJvds8C
	MSflsBcG0E7nzG43+RIlC83QhWcjQZngetC9HLmqx6ylNl+k3qtdFl49U7DGx3a17BRTn+jtg5W
	iT+dx4CXKC8Rwj/4o9gBKOfmCL9ANCS+gp5Rp1m+gzYJBwXHfP4oODCl98z20oJBAK29enqp8wp
	UWAMl0jtA1xuUThtafE8dqzpSFhmKKLzAzJ9o+sl3JAcVxhl
X-Received: by 2002:a05:6402:42c4:b0:6a9:a362:4646 with SMTP id 4fb4d7f45d1cf-6ae198f0fbfmr582772a12.14.1790762892209;
        Wed, 30 Sep 2026 03:08:12 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae156adf4fsm527943a12.32.2026.09.30.03.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:08:11 -0700 (PDT)
Message-ID: <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Date: Wed, 30 Sep 2026 11:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/26 04:00, Matthew Brost wrote:
> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +	struct dma_buf_io_map *map;
>> +	long ret;
>> +
>> +	guard(mutex)(&ctx->map_create_mutex);
>> +
>> +	scoped_guard(mutex, &ctx->map_mutex) {
>> +		if (ctx->maps_killed)
>> +			return ERR_PTR(-ENOENT);
>> +		/* recheck under the lock in case it has already been re-created */
>> +		map = __dma_buf_io_get_map(ctx);
>> +		if (map)
>> +			return map;
>> +	}
>> +
>> +	dma_buf_io_wait_active_maps(ctx);
>> +
>> +	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>> +				    true, MAX_SCHEDULE_TIMEOUT);
>> +	if (ret <= 0) {
>> +		if (!ret)
>> +			ret = -EAGAIN;
>> +		dma_resv_unlock(dmabuf->resv);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	map = ctx->dev_ops->map(ctx);
> 
> I'm playing around this code now.
> 
> I think you need the dma_resv_wait_timeout after the 'map'?
> 
> If a device doesn't support p2p ->map() will typically trigger an async
> migrate to system memory and data will be moving but the map is valid -
> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
> async behavior.

There is a wait right before because I read somewhere in dma-buf
comments that I need to do that, sounds a bit odd if I need to
wait on fences before and after. I can add it, just curious how
come that other dma_buf_map_attachment() callers don't need to do
that. Or maybe they wait somewhere else?

-- 
Pavel Begunkov

