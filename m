Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1591E32AB
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699533; cv=none; b=GvUz5+0ZzxsqTZb86+P4u4Pn9lqquI8rcOmFY7uq8/YY+ev3Q3Ap1kDqfOwLBvDO1SexqR4+9a/FlsU83CpJ5TdrDJ7GP+3UHUoTaV3FGvoJQhXaBHJURMOJ3iPIm+Km2tKkV3m7JfnVuNAiSveuCHiwj84gUN1AH2kIz9si5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699533; c=relaxed/simple;
	bh=CrlGy8AEgKdIqFUxKj6w9vMdT6QAp+On53FXLY7r4t8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DVsNSlBPB4h0cYxGiWpYUxvs8FFN/rHYKXstG9/z9SDLVDBTzFMk5iHwtlZE5y78waSThnPaBH3hSLq5mOTG0T8D7FHyiO5wzqWGcMhEWWtd1KnR3QYZ+Qa69uOS835WyReNusjR0t7fj1o2QD2C03RGEmEl0rzXa/HZJ14XnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZclBSoOf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZclBSoOf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so13809385ad.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731699529; x=1732304329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=;
        b=ZclBSoOflPRoGzs8Je5oyrneZbmJ0Dwu0fZMaZeY2BZfxuhdWR80Hv4jl5Qpu/FnjX
         LMUKZSdQBrycdzQ6Nxwunfx8z07io7QBPXzuvKjiEIjhrRkApvwG2Pn3CE1dhRaYAmJA
         +YE32yviKeq14UTvFbamZlZp5lGmDdKlJjBhzfDewuBxaUDJud1Yzi2HvCPFNcvxNqy+
         i7nUKeOUCiSFcfE9RgQSwkpKrxs1IFHVKqSOl4MsE4giy0+pWSGugY6q7as43fzMOxwk
         IOU73JbhG9eBYF1OcNXsPvl8bV5shD0hi3ocTWqSsptC/0fC3I3rDf54oYD4mfu1M6eV
         orGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699529; x=1732304329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=;
        b=mHkJGjZMBU30xYw1pvD97LQfBDbbGRXGpHAYjb8MxI1+rDyv5HMiPKtWtslQ2gb14f
         FZm+z+LjZ6ASrTBhZDQr0OKOlMN6qOVkj/AX+lAjL9PqzdHO+/rHB3lIgRle4vzk3A/4
         JNfD2LuWWNE9NkWQUZCEYgjJbvYshQESMMbBTFsbB9awreQTARv5HVTf7q8JprXw7ey+
         Nxzc9I0mC+FmwRGnIBtzDCz4TAxSoC0bIfBRCMdpt+lcUGiCx7fLTGGHEHPVm0JGL4Ns
         4xJcj1Ed2ZR2ODzCAkScFi7rm/EiVcjLBxpdJxV/0L1fnWrio4nrHj5pOmjDS5NMHU/w
         f2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXiRz3+yvjtPR50EYArhEuRqJB3L1oUcSn2JwDk+Em3T6KGj7Q8Qv5KdhJAmphuieXNnnOz5nLeVaS+3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOu5YOaDAon42VwFSoL/1rC/AEH2a83ob5v+X342dax8BYJmqN
	LhUZp+OT2nos9vH8LMYzf8I8xvrnzT1z0UYSGXB8xOFVKws2AcEFrLgcAugrm+U=
X-Google-Smtp-Source: AGHT+IES54wrZ5hHWz7YLdSu6vOgOr+rIrH779oUdaufOW3TN+xRLH1Q3Md1D//toQnJHNLrz6k4hw==
X-Received: by 2002:a17:903:1248:b0:20b:831f:e8f7 with SMTP id d9443c01a7336-211c0f21d06mr109893485ad.11.1731699528961;
        Fri, 15 Nov 2024 11:38:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c04e3sm1791549b3a.102.2024.11.15.11.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:38:48 -0800 (PST)
Message-ID: <be0d06e4-a61a-47e3-8d50-f37f9b6fc719@kernel.dk>
Date: Fri, 15 Nov 2024 12:38:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: add a rq_list type
From: Jens Axboe <axboe@kernel.dk>
To: Nathan Chancellor <nathan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
 <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Content-Language: en-US
In-Reply-To: <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 5:49 AM, Jens Axboe wrote:
> On 11/14/24 1:11 PM, Nathan Chancellor wrote:
>> Hi Christoph,
>>
>> On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 65f37ae70712..ce8b65503ff0 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>>>  void blk_mark_disk_dead(struct gendisk *disk);
>>>  
>>>  #ifdef CONFIG_BLOCK
>>> +struct rq_list {
>>> +	struct request *head;
>>> +	struct request *tail;
>>> +};
>>> +
>>>  /*
>>>   * blk_plug permits building a queue of related requests by holding the I/O
>>>   * fragments for a short period. This allows merging of sequential requests
>>> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>>>   * blk_flush_plug() is called.
>>>   */
>>>  struct blk_plug {
>>> -	struct request *mq_list; /* blk-mq requests */
>>> +	struct rq_list mq_list; /* blk-mq requests */
>>>  
>>>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>>> -	struct request *cached_rq;
>>> +	struct rq_list cached_rqs;
>>>  	u64 cur_ktime;
>>>  	unsigned short nr_ios;
>>>  
>>> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>>>  void bdev_fput(struct file *bdev_file);
>>>  
>>>  struct io_comp_batch {
>>> -	struct request *req_list;
>>> +	struct rq_list req_list;
>>
>> This change as commit a3396b99990d ("block: add a rq_list type") in
>> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
>> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
>> out?
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 00212e96261a..a1fd0ddce5cf 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
>>  
>>  void blk_mark_disk_dead(struct gendisk *disk);
>>  
>> -#ifdef CONFIG_BLOCK
>>  struct rq_list {
>>  	struct request *head;
>>  	struct request *tail;
>>  };
>>  
>> +#ifdef CONFIG_BLOCK
>>  /*
>>   * blk_plug permits building a queue of related requests by holding the I/O
>>   * fragments for a short period. This allows merging of sequential requests
>>
> 
> Fix looks fine, but I can't apply a patch that hasn't been signed off.
> Please send one, or I'll just have to sort it out manually as we're
> really close to this code shipping.

I fixed it up myself, it's too close to me sending out 6.13 changes
to let it linger:

https://git.kernel.dk/cgit/linux/commit/?h=for-6.13/block&id=957860cbc1dc89f79f2acc193470224e350dfd03

-- 
Jens Axboe

