Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09512B89
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723195; cv=none; b=W5WKKqlwF3E+Sr03l21nn9FhlkWp6eZPHVUvk/4f80VQsmt1WHK5qhTmzMx4SEc2blOm1eYWk1/iIIiErzL3ahN0Oiasuya+7MiYEOYWWTGCIx7d2MI1te+f547/nD9uc8XSXcACllKkXcGqmgMZZ+jeN+ry3hpkHXAbYNfUxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723195; c=relaxed/simple;
	bh=L1iDuclfPlzUe9phzEjoL8oef5jE5ZPehMnRq3fx+eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH4TCztb8iWiOEFj8UX+BjumzIxWP42xp+4fzwlrovnEFv6vVv22vFAzas0oAQdXLln95D0+97YbEdqDjwmjSFt3uG/Pn2q12gSP/VQzxNnMPzojjlJOxllkXkAI8iW3m7QvTMbu77KBopPByQYtooKzqFslsOJRXcIhIzKTKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4190c2ec557so6114335e9.0
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 00:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714723192; x=1715327992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzYmbhpRbl8QiRO48tGkM6UvfO30LUVMTm33iagZ46k=;
        b=X/assQj2KEzA7oEqoeaI/0PvMzsAGj2sXyQJSKmvA8DHfnHV+aI2/SrwUowXj7uFH6
         u5MTzF2pUzTJQyJcaqJGtQ8D4IuImSmXDLsDMRUY2fTQKWm0E8c8yEKs0dspejIgQNda
         o+zyvf/8j/D+3ELrXH9Kf8dvZK7aAaO4heu80/rIOV5MBPkw1CgDZBuClxXEPgCdpOcB
         NJWo/tXGDYRWTpM8XC/aNGF1sNidgyJ3nA46tLSKa29P0Fj7uAOI/XGZG182IhLuWMLx
         B0zsMWmIhVKJiMcgFRqY0GBuyava8OO+EbiLxvh+c+p9wZPh6Lto1IjmqK3dZPqkxrFh
         sCVw==
X-Forwarded-Encrypted: i=1; AJvYcCWt4scpECp8WLWeRALfyXcXvFIjqHEsvMnvIpXNRKeiY98stN2jzUhXTm3HRSB2MV6HcxiFzsNbIISlJo2D/sjRLKSVZXrix+H8v4A=
X-Gm-Message-State: AOJu0Yz/ei1Z+19BFhjgAy7oQq3iw2YYPq71RozB3+p9XwjAle1Uo+vc
	xwTMGP2dXGWB20mb3jZ7JxAHEqmJs078NRU9J1NrTo1hi/awJTQK
X-Google-Smtp-Source: AGHT+IEx8ztqNh3d+bvC/lJPjNz2UsSvUo822Jks9MB10ZCj9tUirEjrifZ1NC+7rP/e2rF1SUTyoQ==
X-Received: by 2002:a5d:6586:0:b0:346:7f4d:e80f with SMTP id q6-20020a5d6586000000b003467f4de80fmr1514381wru.1.1714723192514;
        Fri, 03 May 2024 00:59:52 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b0034a710b6360sm3141726wrw.6.2024.05.03.00.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:59:52 -0700 (PDT)
Message-ID: <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me>
Date: Fri, 3 May 2024 10:59:50 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Yi Zhang <yi.zhang@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com>
 <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
 <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/30/24 17:17, Yi Zhang wrote:
> On Tue, Apr 30, 2024 at 2:17 PM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
>> On 30.04.24 00:18, Chaitanya Kulkarni wrote:
>>> On 4/29/24 07:35, Johannes Thumshirn wrote:
>>>> On 23.04.24 15:18, Yi Zhang wrote:
>>>>> Hi
>>>>> I found this issue on the latest linux-block/for-next by blktests
>>>>> nvme/tcp nvme/012, please help check it and let me know if you need
>>>>> any info/testing for it, thanks.
>>>>>
>>>>> [ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
>>>>> [ 1873.761900] loop0: detected capacity change from 0 to 2097152
>>>>> [ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>> [ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>> [ 1874.208883] nvmet: creating nvm controller 1 for subsystem
>>>>> blktests-subsystem-1 for NQN
>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>> [ 1874.243423] nvme nvme0: creating 48 I/O queues.
>>>>> [ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
>>>>> [ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>>>>> 127.0.0.1:4420, hostnqn:
>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
>>> [...]
>>>
>>>>> [  326.827260] run blktests nvme/012 at 2024-04-29 16:28:31
>>>>> [  327.475957] loop0: detected capacity change from 0 to 2097152
>>>>> [  327.538987] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>>
>>>>> [  327.603405] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>>>>>
>>>>>
>>>>> [  327.872343] nvmet: creating nvm controller 1 for subsystem
>>>>> blktests-subsystem-1 for NQN
>>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>>
>>>>> [  327.877120] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full
>>>>> support of multi-port devices.
>>> seems like you don't have multipath enabled that is one difference
>>> I can see in above log posted by Yi, and your log.
>>
>> Yup, but even with multipath enabled I can't get the bug to trigger :(
> It's not one 100% reproduced issue, I tried on my another server and
> it cannot be reproduced.

Looking at the trace, I think I can see the issue here. In the test 
case, nvme-mpath fails
the request upon submission as the queue is not live, and because it is 
a mpath request, it
is failed over using nvme_failover_request, which steals the bios from 
the request to its private
requeue list.

The bisected patch, introduces req->bio dereference to a flush request 
that has no bios (stolen
by the failover sequence). The reproduction seems to be related to in 
where in the flush sequence
the request completion is called.

I am unsure if simply making the dereference is the correct fix or 
not... Damien?
--
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 2f58ae018464..c17cf8ed8113 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -130,7 +130,8 @@ static void blk_flush_restore_request(struct request 
*rq)
          * original @rq->bio.  Restore it.
          */
         rq->bio = rq->biotail;
-       rq->__sector = rq->bio->bi_iter.bi_sector;
+       if (rq->bio)
+               rq->__sector = rq->bio->bi_iter.bi_sector;

         /* make @rq a normal request */
         rq->rq_flags &= ~RQF_FLUSH_SEQ;
--
