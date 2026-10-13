Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9560545DA2
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921771; cv=none; b=ilXCEzOGTjabkSmUAcQvPEYqkndf/Y9wIRQZCKAr1bRzo0+BNRuBcEin52vTVVU1A6DhZvHRDNe2YQUF3YrXT/f3F1zAH+ucNNbdwEySior9QxKLU6EaOUV63l5HQYMBznkLxFF1UWnmY2May8ZG1S9flZ/sSkqoaebFCcgCYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921771; c=relaxed/simple;
	bh=5OmzUIP8dmoGXLqtWjV2SDzvrm+zBkTDLpjN5AcCB6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYjxtGjF0+JdIGUBuxey9YhuiP0PYuM5UZewm2joOABlQwHD1VcgffBNyyPtWRHmvztdwEISHS0OFALq+omTd0xSxoDaWi7EPnvsT3icKBpCttFYhCd24mflLMQALJUe/Q37i/M28YsZr+nTgcHrAqZhISqE0DVqZcevtyb6CSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJf3PxDN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJf3PxDN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so28093355e9.2
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791921768; x=1792526568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=;
        b=hJf3PxDN4i6ZpsKL2RdjcwzOTsxpJNzzmvONtwiGent2HSuMTbvCA/ErZzO6rsrI4o
         fDJFZhbpOZehvFgsi6t+o1TCN3mTCJLCRM/gI/fd0Rep5AhyMflANAxrT89Vtn4NYrR2
         GZok6c3wcIMdliMvyGLNyJbo9XAcsFwmJMPruDMBB9q1uRaozVCLvb+722hn4fGUQ/xJ
         lhivSigzIf16XS8SAFInn5e2TgMYXDgEFWNjS5PXDqsxiqbyKl0FYl6WPvD9rL1zBvUY
         pIfJVNz7f4RkYuT0Et8lCvOsX2ZIx5S4s2VJWHrWadTEo2JcTjFz0Ko2MR3X7/OWcS7S
         h/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921768; x=1792526568;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=;
        b=ctrZNkQvbMFz0+Qc8nEMRu/CgpHTkMcrh9o/qwPdVRZ4uwkerXaBF/0mxARewMdUqS
         W/E7Y5FPeHy7+g8Dv9tQxSZPiN7RjxlLSs67YGXpbHbA3xzG94kxAr451VXM2t8DOL14
         DtaishWLk/noCqz74ZUKCqKk5dk4AwzYVvJ1q04Fx5emta7xEqqf4gu/VPIi44z+ax0+
         nd72CWX8jDTs5SsWgzoEKl3cCAg3NT8l48nqhXiSmIJ+H5GSaQr5AoL4PDkUGCb78j7t
         CRY0K2JBmmTh3bUQh1rTOMIpdM6NO0B0oTkPq30/z/a/NCibpAf0YDE5woFRtfAJ6uSu
         Pqig==
X-Gm-Message-State: AFq9FYI6XxiAh3FbjDETJ6SNMZP1nIte+JwAPgwRf8L+b5Stn2+zVMDP
	A/KnQnrIYMARZ0oVXbxC0gIZNEzIVlASjSIqdUdehUEZjHTu1akpJAt0
X-Gm-Gg: AYBFou37WFRQq0QjhOKjODJNdXCeJdsNY0VeRIYc4QLrXQ/g6KsTQc2frm6DfC/DoHV
	60phVkU7Q84OglnoCzDkbb+yJpysw5W4hYy7Ak0j5qb/7Wo7P7Wew+CTqBbiAJli0ZaiAKWlcW4
	S5mwb30kzBXI1kXIxoltgGBoXeGWpEUKeiWK3bWSWwKXO7UIsfp30JDlk1/5ZLwTTdysaLMWSGY
	Y139QZypaT0oox91JcbJCrgHJqsSBmgk162BKh8NeAauNrZVurk3ytvQvOo+cKWLHr0n9+S8Asn
	JQWhjvsWs+5tgoEl73qGQLQjCLY3a6xb3mG9S7LUQQYU7nLidIq79OjAilqWNSnDDJVI/WWdA6x
	GmJ5RzC5NPdwIMbI2vU23umf9aDee92aeB+tq8QGAWFwWBQ59xxYNBlbP2/bMoMvR64AQM6aEOA
	Kp948neMK1gFDLCaSHWwR8g6kOBU/zs9GW0K7l7hWLPM0LuoIKS3oAt/y3Hk7CU4woGR15fSwDv
	0ek9NLvN1Pq9MtDbTRmyUlqY6I/ucKF44IFSpr7kywSeLtpIutSUDbzn5Axg4Zu/TwwS7//ZxGN
	H4SKbbwem+s3pRz5cZOXT939lfiLOJLPp38sbQwZj7PeoELBGLMh3MqqgQQ=
X-Received: by 2002:a05:600c:46cc:b0:4a0:8b1:f5c with SMTP id 5b1f17b1804b1-4a18e4b583fmr268480065e9.22.1791921767928;
        Tue, 13 Oct 2026 13:02:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm384426465e9.13.2026.10.13.13.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:02:47 -0700 (PDT)
Message-ID: <63fa3e64-44a8-4539-960c-946cebc8fce5@gmail.com>
Date: Tue, 13 Oct 2026 21:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/13] dma-buf: introduce initial file I/O
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
 William Power <william.power@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <b44df9fed6e346110c504ee312bb0083c7e75574.1791336930.git.asml.silence@gmail.com>
 <aszbv7TgDOPHBEem@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aszbv7TgDOPHBEem@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 14:08, Matthew Brost wrote:
> On Wed, Oct 07, 2026 at 02:42:44AM +0100, Pavel Begunkov wrote:
>> The goal is to be able to natively use dma-buf in the read-write / IO
>> path. This patch adds basic building blocks serving as a glue and API
>> between drivers and upper layer subsystems providing the uAPI. Later
>> patches implement it for NVMe raw block devices and expose it to the
>> user space via io_uring.
>>
>> There are two main objects. struct dma_buf_io_ctx and struct
>> dma_buf_io_map. The ctx is used during initial registration and serves
>> as an interface between the upper layer user like io_uring and to the
>> importer subsystem / driver. The map represents the actual dma map
>> established for the target device[s] with dma_buf_map_attachment() and
>> stored in a device specific format. The context is created via a new
>> file operation ->init_dma_buf_io_ctx.
>>
>> The ctx-map separation exists to facilitate map invalidation (see
>> dma_buf_io_invalidate_mappings()). A ctx can create
>> multiple maps during its lifetime, but there can only be no more than
>> one (active) map attached to it. Invalidation drops the active map
>> if present, and any new I/O request will try to create a new one.
>>
>> The primary task of dma_buf_io_map is to count requests using it
>> and wait for their completion when we want to destroy the DMA map.
>>
>> [un]mapping and any work with dma addresses is delegated to the
>> importer driver via an ops table stored in the ctx, see struct
>> dma_buf_io_ops. Only the target driver / subsystem knows about devices
>> it wants to use the dma-buf with, especially in case of multi-device
>> filesystems or stacking in the future.
>>
> 
> Full disclosure Pavel incorporated some of my ideas wrt to locking
> cleanup which I shared off the list.
> 
> So I can't in fairness give an RB but:
> Acked-by: Matthew Brost <matthew.brost@intel.com>
> 
> For the series - I can give this and I have pulled to code + have Xe
> nvme + IGT setup showing this working:
> 
> Tested-by: Matthew Brost <matthew.brost@intel.com>

Thanks for the suggestions and testing!

-- 
Pavel Begunkov

