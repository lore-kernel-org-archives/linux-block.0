Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393A1D543
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474590; cv=none; b=ogFu/iziJD/fi4+4SHLoiD+dOaiRUAilqYcB8n/2crcv1ORuJ3cHdLRgtIdd7QesagVjhnS6Pel6/zFI7IWNAhnTHB3vL7OGUEpcQQL6Yz4HxQS/i7rVO+OEGDDrnwgner+q2U5kZyE+MK26xlQbXk/rxl3ESnL6ZWgS5AMU1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474590; c=relaxed/simple;
	bh=2wJydGbdJPmoGCNHuHFvPcCvxgjL6LEvnOTJwiZsw/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIjk6sR7RyAic0/mJNu7Kn5+/57AXvOdE77hZ+wRQVn6/Fd83qHLnp+WO4/iCB2AOp91ousnOONwCmSHJ1K5L30KvXh+7ZebwBdlswvAzUpYJ4erL8hYCXzWemZ5pRa/Pw/EngHv0cVmUreZmzXp9ilciT2fBND82Yi7e0EaZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6b22af648so36803b3a.0
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474588; x=1712079388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEI4OL9/S8ZxxANaxzhWy9+bIcaWumABieLLj1vBxOs=;
        b=TU9jXZU+Sy32/CalV7V18h4++0tRtR+i9H5x9MFvRPz2RVK7YH1iKu2kMpLRnWbyiY
         OAuNUvxcpLchYcRlxp2KuAIpf8XMGjOp3/lMnMYDzxFofRZbu4rW570bxJVN/DINWbmi
         cGYo55tZpoFmivOtS/C/FtJoj61GeKM6vHgZf7/7MfT5Hxirg6cjbh7tcCvW0b6kqg4T
         ju2C8NfIKwoDydubrWR6YyKT12FM6jAUpsAju6Cry4n4xSHAu1L95KvXH7GDyN4mOZqT
         8KNJjFootA+UquV3cZa0Scz5vN+CLbljGzBaBjgyC3FYFoQrgNcZ6iB4GuvXONMzfN+w
         jSpw==
X-Forwarded-Encrypted: i=1; AJvYcCUDRZFM7TvW13UFSkZT+AZi76NftS09WC3SPCjcyPQI80ArzYK1EY3U+frL48RUORLiXarAJX/1rSLOAu5fRS9dpUYbgT6kLCK+BXk=
X-Gm-Message-State: AOJu0Yz6Xne+n9K1m/zheIBKgMeJzkAOA68oZPFJ+8538WpAhl+TVNou
	Dp0bChnI3bd5glez9H8BlcOo+24PQ/vnZIPmuhhGtKUNwA8hmjF6yFGTh5UN
X-Google-Smtp-Source: AGHT+IGBN7djwvXndfRL3EhkK/FJIa/DXu0KhH6LjjIoa9mvvmjprr0UzOMeC/G3/ImaHrSjxw7VBA==
X-Received: by 2002:a05:6a20:4325:b0:1a3:c6aa:ec7d with SMTP id h37-20020a056a20432500b001a3c6aaec7dmr3190685pzk.16.1711474588416;
        Tue, 26 Mar 2024 10:36:28 -0700 (PDT)
Received: from ?IPV6:2620:0:1000:8411:262:e41e:a4dd:81c6? ([2620:0:1000:8411:262:e41e:a4dd:81c6])
        by smtp.gmail.com with ESMTPSA id x21-20020a056a000bd500b006ea7fbd484csm6239190pfu.192.2024.03.26.10.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:36:26 -0700 (PDT)
Message-ID: <30519ebe-d370-4dbf-8f08-c28fa960b794@acm.org>
Date: Tue, 26 Mar 2024 10:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Improve IOPS by removing the fairness code
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240325221420.1468801-1-bvanassche@acm.org>
 <20240326062229.GA7554@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240326062229.GA7554@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 23:22, Christoph Hellwig wrote:
> On Mon, Mar 25, 2024 at 03:14:19PM -0700, Bart Van Assche wrote:
>> On my test setup (x86 VM with 72 CPU cores) this patch results in 2.9% more
>> IOPS. IOPS have been measured as follows:
>>
>> $ modprobe null_blk nr_devices=1 completion_nsec=0
>> $ fio --bs=4096 --disable_clat=1 --disable_slat=1 --group_reporting=1 \
>>        --gtod_reduce=1 --invalidate=1 --ioengine=psync --ioscheduler=none \
>>        --norandommap --runtime=60 --rw=randread --thread --time_based=1 \
>>        --buffered=0 --numjobs=64 --name=/dev/nullb0 --filename=/dev/nullb0
> 
> And how does it behave when you have multiple request_queues sharing
> a tag_set with very unevent use that could cause one to starve all
> the tags?  Because that is what this code exists for.

Hi Christoph,

The proposed test case block/035 includes the following test:
* Create a first request queue with completion time 1 ms and queue
   depth 64.
* Create a second request queue with completion time 100 ms and that
   shares the tag set of the first request queue.
* Submit I/O to both request queues.

If I run that test I see a queue depth of about 60 for the second
request queue and a queue depth of about 4 for the first request queue.
This shows that both request queues make sufficient progress. This is
because of the fairness algorithms in the sbitmap code.

Given the performance impact of the request queue fairness algorithm, I
propose that users who need better fairness than what can be realized
with the sbitmap algorithms enable a cgroup policy of their preference.

See also 
https://github.com/osandov/blktests/compare/master...bvanassche:blktests:master.

Thanks,

Bart.


