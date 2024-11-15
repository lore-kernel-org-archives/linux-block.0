Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790291B85E2
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674976; cv=none; b=ulSEU8xXi0OcA0I8L1ZD4DM67qjXNYPmUN+ivkMD5Qiup0uusT9YR8+/DVgLFRAZ3uUq3EhOo79iS7yn7CqLY5NSNj2vghkohnhQkckFLlLryqndFyzxONMdt8hjEH+4JVCOuIj6/8B9sjl/VxVqU6SsYok1xeZs8zYssM9oij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674976; c=relaxed/simple;
	bh=+UYApFnT9UM37KTNXTpn2LxWwTjTgga79QdwKc3PiHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9pXX7JD19PZYLeOE9WrefPquSykLSijJC6zs7cnKbMJLqFxHgx39QHpMJZ1nOR1+g7U9NHosUp0uaCPbsSOa09OWDMmmn5AuNNR2ksgagVmEvWFmqVvwdXCA9WaqP85Q3au39JUge53Vxv6bRKU4a2RJi7YerX2iIL0bUvQ8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TqiUZMdU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TqiUZMdU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cd76c513cso16101995ad.3
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731674971; x=1732279771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=;
        b=TqiUZMdU4ZCtD+Rg1MV3fYw7A7G/8hDEubDD97mUD8VFIMvJpydHoc1OqQaVck50Ti
         CIiMbK+SDUVDVj2SwkSWFtjoDKCAgJpg8uBMlU5BU3xZN6FMrudyvBNCWsN4obfPGnq/
         TOOeogimHm5AqC3mtEGY5u0/v3sFvXFhoQafjtYPlLgtHMT3kxzIvrbcFRwoRAp1waq5
         x9sfzXGq/cRH331GYb9ImrvO4Nf3jfx4+n2Di5vpTP6M/ziQ/GZbQpUPPcDnwAPlL4Gs
         MsajxHhYC643k55cu0f46zcQuL/GjIhJ7Goes03JVpB//MPXvfBq+oI3B7GSeKwH/7jk
         W3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731674971; x=1732279771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=;
        b=MQW1JbTB1BweVO4BpozRMh2ZpevuLJ7WxNuIVve+Am4alXlwQz4jBTsCZtvALw9Ojj
         jMXRhjUz9ND1RouquxSucUwDqE1I7FiSIubzO//XIRRGP/7w81oAQRWJ634hVofB8q6O
         p1xtRF93/fYUctKFnKe1ueozl9IztS6APWpsHGg1lMo0F5ZWUokJIzaOJ/eRQ7RNuMsh
         cwc+r+gpZ9krvZw03aMh48JAWns0IdqnZL7KtGSS8J1qzzXYA2dvpVcXOvzMLceWPAio
         +ptii2RjstFWMKnLJCLx7mPD2pXxjL1I9McPFSn20jca6Uz0AfmrczElVVpYtD+nT6JV
         HCMg==
X-Forwarded-Encrypted: i=1; AJvYcCWYRhCgut+TOfcGcj+GQKkGFwOggYPKq/bwYhfkEZ/Hj2E3FGuhaaYKcqIqT9B6Xc+akQwYmVz9tbJmlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzASGo+b1Ho232GIQgdDbd1f9oc1rd2v6Qj1EomnyhTVDSBWfH
	pRh6b17FdODD1MPOvngV8RuKjhTwGEzKXJKnkgWrbPJNFwJ+Tmzv2FhcJXk5leM=
X-Google-Smtp-Source: AGHT+IHLsm4F8XGgt+dNqMlncEMHZaB6TNbve2F3AL5DPq8Q+6a6Bwd0d1gK0LzJt/GKxZcrS9AoKQ==
X-Received: by 2002:a17:902:e74c:b0:20f:b5d1:8805 with SMTP id d9443c01a7336-211d0ca73admr34323225ad.0.1731674971420;
        Fri, 15 Nov 2024 04:49:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34609sm11080105ad.121.2024.11.15.04.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 04:49:30 -0800 (PST)
Message-ID: <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Date: Fri, 15 Nov 2024 05:49:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: add a rq_list type
To: Nathan Chancellor <nathan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241114201103.GA2036469@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 1:11 PM, Nathan Chancellor wrote:
> Hi Christoph,
> 
> On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 65f37ae70712..ce8b65503ff0 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>>  void blk_mark_disk_dead(struct gendisk *disk);
>>  
>>  #ifdef CONFIG_BLOCK
>> +struct rq_list {
>> +	struct request *head;
>> +	struct request *tail;
>> +};
>> +
>>  /*
>>   * blk_plug permits building a queue of related requests by holding the I/O
>>   * fragments for a short period. This allows merging of sequential requests
>> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>>   * blk_flush_plug() is called.
>>   */
>>  struct blk_plug {
>> -	struct request *mq_list; /* blk-mq requests */
>> +	struct rq_list mq_list; /* blk-mq requests */
>>  
>>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>> -	struct request *cached_rq;
>> +	struct rq_list cached_rqs;
>>  	u64 cur_ktime;
>>  	unsigned short nr_ios;
>>  
>> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>>  void bdev_fput(struct file *bdev_file);
>>  
>>  struct io_comp_batch {
>> -	struct request *req_list;
>> +	struct rq_list req_list;
> 
> This change as commit a3396b99990d ("block: add a rq_list type") in
> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
> out?
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 00212e96261a..a1fd0ddce5cf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
>  
>  void blk_mark_disk_dead(struct gendisk *disk);
>  
> -#ifdef CONFIG_BLOCK
>  struct rq_list {
>  	struct request *head;
>  	struct request *tail;
>  };
>  
> +#ifdef CONFIG_BLOCK
>  /*
>   * blk_plug permits building a queue of related requests by holding the I/O
>   * fragments for a short period. This allows merging of sequential requests
> 

Fix looks fine, but I can't apply a patch that hasn't been signed off.
Please send one, or I'll just have to sort it out manually as we're
really close to this code shipping.


-- 
Jens Axboe

