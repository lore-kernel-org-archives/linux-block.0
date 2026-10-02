Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149046F4A6
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933050; cv=none; b=pS8lbayVXkZ9A4G71VZH7rzD1lV5ch5edT0NqHMGgPNw5N7pycnIERhhmozOrwquqS1M2tAKXDrG84JR0MDjZwliO6oIk+zPGWl6XTiinQ1hLLYtN6lU6u1VRBzUoURJiXQBrbFn0QGkECdkO86ApgBTd6w9fO5EAengLgtdg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933050; c=relaxed/simple;
	bh=TeAW1a6RQCXCKf7Eio6ms5S8qheL7kZWqi963AqXvR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOxLB6uv/uIH7NtjCeC5DBmDMgCo+LfHjb6Or4O20LV1ufTtT2VBrBrQydaxML+ukxw2D1BGzq454RnAU8QIWJ0NiACWMXhWRZeR6v2tTgmZsJ6xlm5P0u844poTuvQj/p86xwpODh4SPm+fOHhLls0RJFyuUnTaaLpFvrbHIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XyWD4JcE; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XyWD4JcE"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-887ba76d5afso1331570b3a.2
        for <linux-block@vger.kernel.org>; Fri, 02 Oct 2026 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790933048; x=1791537848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e4aOyrFzh7gdGZ8/kq9sOV0yCHBHbrdKcYYOkMYs0fA=;
        b=XyWD4JcEDqXhMkro787C6+7c6H2MG9RLH4o33V3Ka7TTw7+y0Pj/IJ4RYhOjoEvWy4
         hwIV9Nbs0QGxdp2S511/yKmuYiFhUzOeuUqwxlvWoMFpPGnBgZk4gyxt8fQ4MIE47Xhy
         /f+0YXdlAf9kL9gJTboMkzPW3kXtEs8STKZH8M70cBo+8pTA2yAO9LrQngvQKTCjW9dU
         6th5q+GvyyPsFUe7vErmACYwFvrc3M76vuC89mYWyRyR++bPtEiPdUftAL9VaOR4KAu4
         eGYkejDGdAcjPys/ppCDn2QzU5eYSWULW6SLYWOizv8rBGuRkEVQt/TZisLaH0DeCM9I
         8sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933048; x=1791537848;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4aOyrFzh7gdGZ8/kq9sOV0yCHBHbrdKcYYOkMYs0fA=;
        b=y5utxBGpGr3A0ilvXhIrPFNZcYGckFAyWdgpxQy8nPnRx1ApF8tatGX6m1BuU7kuch
         8NUW+oPukzweGZh9mz3bNZ0mF2m70FJw/vbRauocpBnP4WNpG0mJd+1hkKpM5+gnL5mI
         C/FgnWHQjpj0n/BeONf+DGeRigy2R8OAXmfWCS+YG1LUaBxxLt7ewQAIRV1BqixHgNDd
         S+0GPYJ3pUZaTlOb4wLcWV8mG7ZZefChFqaiUd/bGpT48ti4MK1lFak4fg6N8eDD1z2h
         EtDr8QGq2adfl4ggpvtNx2izC2rqJuiGyXizCeZMncq2UHbRR98prgneolTpcF4SCu84
         KwBA==
X-Gm-Message-State: AFuF++kT9sl0Gyq5Z0Ak0QNcw/ttRYEUPqd5Oh8IgR1HLn43EuxDP6q8
	8fZlfXvuPQldbXA/R1vXaLV0YoK5JfsM2LXVJJ0/FPrDc6Yl2gZE2tpFcxd6qFyHB1k=
X-Gm-Gg: AYBFou0WYnQWTNQgRa9uP1Lp+d+dsknWeIWPfNhftK4O3fzNUElXBuVBaNwZv2e1ko5
	VD3m8s/ya7pHCR7DpJ4RvvPhLm7rxi02I1HeFRPs/ETOHFrTx9ZMZk3fDU6yi0U//ReurPFBEZ2
	N7QOhDfI/i03FepBtgD9ID5/KG9VST4ZNgn3aQfqyZS/v7u8QlWWqiwR6jVRq8h9W/5ZXqTN/SQ
	Zg9jbkQAY3c1EDEJAfo4NoeWJG5VCY8qqO6DzvgATlxHf5EduRlVzXgZoegQ4CWOBj75cgM1P4q
	9EooMWrl3wQss8h0TZxFIlIPVDQIu9xV5M/B4KlZyCcBCxpl8ha6br2m+eCxowrVJlHe4XR/HSP
	VWYzj1kGwTsetc0UTWaty41dUJEP2dadt8VIOvMx8nMC2EvjTGMXFaSQGaR7SgEbmcorIzYrjBF
	T2gRWrSXukffsGwWepjhi+tXshqej72Jn8Y9BkPwO/smxyNS8kgIX8zGOGIkMJ59wSQCkXU7F8B
	WNLrLDgubsptAAkMeXT
X-Received: by 2002:a05:6a00:428b:b0:878:3538:8f7f with SMTP id d2e1a72fcca58-88af6658113mr1963422b3a.45.1790933048460;
        Fri, 02 Oct 2026 02:24:08 -0700 (PDT)
Received: from [10.254.198.23] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c78c7bfsm659640b3a.36.2026.10.02.02.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 02:24:07 -0700 (PDT)
Message-ID: <903dd25b-7af3-44cc-9425-9499f50d5750@bytedance.com>
Date: Fri, 2 Oct 2026 17:23:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] block: introduce bdev_flush_by_dev()
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, willy@infradead.org, tj@kernel.org,
 akpm@linux-foundation.org, Boris Burkov <boris@bur.io>
References: <20260925064444.3944820-1-sunjunchao@bytedance.com>
 <20260925064444.3944820-2-sunjunchao@bytedance.com>
 <arYaMbJUh6unvz_t@infradead.org>
 <3w6vfwfkojmfqy2qs5j4q2s2366ajqiwmqf624lyn3odrv42v2@va2r7a6ngfz6>
 <aroIAqoCNDBPlB2A@infradead.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <aroIAqoCNDBPlB2A@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/26 2:24 PM, Christoph Hellwig wrote:
> On Fri, Sep 25, 2026 at 12:34:52PM +0200, Jan Kara wrote:
>> On Thu 24-09-26 23:52:33, Christoph Hellwig wrote:
>>> On Fri, Sep 25, 2026 at 02:44:42PM +0800, Julian Sun wrote:
>>>> Add bdev_flush_by_dev() to submit page-cache writeback for a device
>>>> identified by dev_t without requiring callers to hold a persistent
>>>> device reference.
>>>
>>> This isn't really a flush is it?  This is writeback.
>>
>> So bdev_writeback_by_dev()? Fine by me.
> 
> Yes.
> 
>> Well, Julian is explaining that in the cover letter. We don't want memcgs
>> to hold bdev references just for foreign flush tracking. There's no easy
>> way to get rid of them so they could pin bdevs for a long time leading to
>> strange artifacts.
> 
> I have to admit I didn't get it when flying over the cover letter.
> But this also really belongs into the patch where it is more obvious,
> or even better into code comments.
> 
>>
>> As you write, we could just hold a reference to the bdev inode. Those get
>> unhashed when the device dies (__del_gendisk()) so memcgs would be just
>> wasting some memory by holding these inodes alive. But still, transitioning
>> from inode to proper bdev reference verifying bdev is still alive will add
>> a bit of hairy code (essentially what blkdev_get_no_open() does plus
>> verification inode is still hashed). Plus when replacing foreign flush
>> entries you're under irqsafe xa_lock so doing iput() from there is kind of
>> a nogo.
>>
>> So I think tracking devices by dev_t is a good way of dealing with these
>> problems. But then when flushing you have to transition from dev_t to
>> struct block_device and blkdev_get_no_open() is the canonical way of doing
>> that (and note this use is just internal to block/bdev.c).
> 
> I'd really prefer not to grow more blkdev_get_no_open users.

Hi Christoph,

Could you elaborate on your concern about adding another
blkdev_get_no_open() user here? Is it specific to this helper, or to
submitting writeback with a temporary bdev reference without opening
the device?

We only retain an identifier while tracking, and acquire a reference
when performing writeback. Looking up the device through another path
would still require handling the same lifetime constraints. Is there
any cleanup or rework we could do first to address your concerns?

> 
> But the more I look at this I wonder why we even bother.  Trying to
> attribute individual bits of dirty metadata to cgroups is pretty much
> insane.  Why don't we bypass memcg accounting for buffer_heads like we
> always did for the XFS buffer cache, and what btrfs switched to last
> year? See commit b55102826d7d ("btrfs: set AS_KERNEL_FILE on the
> btree_inode") for the btrfs side.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
