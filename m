Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41F13BAE3
	for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751106250; cv=none; b=SYz72ayTskupTQIRdKe1mGno/rX0grKs8TrktKqKzFQAZKE0gtlXeAQAA+GuFcFwO7Iy8Pbx+BIPG7t/mvKapyO8HCxvantCZgNv/zPFi6llv43Vuy1hBLJdic4TB6/J9ZprqI+fP6SuQVz2+BJmblZfmZVYoe1mPWFh0khDI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751106250; c=relaxed/simple;
	bh=v3M/3XOFU2arxveYDUYQIJGCF0sz0482anXNEE6frTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioKhtFcuIr9MT2FN3Do1G2z3/tUyjVy4ZIJqiH1JRZxSyd0ZYGkGa7Tm9a7ghaqnTf40IH7M0GD9f76dIPpGWKUKTYsc1wqzSQpBk42c6uR3c/lPYiLhAwAmjBOFL4trDpn0aqXQdl5p7Uh1C6VPxdqvcVF+S/7fEhB/rQgZe8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a528243636so1788851f8f.3
        for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 03:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751106247; x=1751711047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LClUed192tILHo+/vwfpU9tbOrExqi15ULo3AzIBDm4=;
        b=eUhlnsSdzp3ZAwuFtatGGMlBNN9EUcgHDOI5JeMp9xkW4QYvMl/A4ZX2YLkxSEcpU2
         cjoVC45/4YyR2goP/zfzPevnb8L71xzGQbgmWkz6TIfnnNYYlcizGzDXlzuqXiRsLhZF
         W4CMgrQCwalhNUoSPpoN5B4bjEWkryTttNZLr1nCycRzKMNYahv7CixzEh2dvCsu8VPC
         94nhoEa7sdsK6l0/HGvg3QHcvjMcC/ZWSJU6QEbOO0BGwWp5sAncf0yWdf9180v3fh+X
         0kd76y9J4Os9Ep5uA+U2GVwq1tcH90/QflgxnUG0I1A4V0DRXd3M5bwGYNQLahNkulsn
         zDGA==
X-Forwarded-Encrypted: i=1; AJvYcCVmny1o7znb6NvrC0XVnKIHYZ2AhFLpqJ07Wu0fdOob+Eo0k5jHMQRavm43TjuwmWGB9Dh5k/hBeg6I2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KhKgPHB2aebePZDhodDQN1QGowDfFOYhH8fXvrQ4jOrhtvHf
	JaR7rijwo4d9CJDib9eiuTmmguD05l0BQyUTxurAwon3HXVwTWNZHhHc
X-Gm-Gg: ASbGncvS94BIh7pTnefQFSSq1ekc9gN7qqr+KfcrzZ6KSIPqY8kpi9A4DfEoHtO8ngg
	56rPttDitcuoGr0vuxI1f1S4SonCTM7bWz567eGjqUdh9bEFhXUoTwek+zCRNAFhxtBfIuMqoiu
	IZfwybMtIMdPsRT0om8qSjjvMhwrFqyUR5tDnqTs01+jVYrBy7vNv0WON6dRPpcBwSjYDmy/nPB
	7nIf7ko6H1r6VG4BOBjeiOgUwMKoP56KeJn4PbqYzz/t8tob7xQqkLqYPQmrKBvAy3EHhwNu0jp
	FkT8TnGfvnySR3mHS5GwkUoAf2e9nmLFCGMF/WUR1wPghVIscQeI/ksWy6QcJUoroXdfPvc4YMH
	fuvgrcNAPFXQobdqBVSiCB6PZL8ng3uz0
X-Google-Smtp-Source: AGHT+IF5bL19Bz2cqkIHP5r+d05dZkzyqX/hGKmsQU7T9lSjmrQTh5HCl5FyPu4JrS/fhx3Ws33kjA==
X-Received: by 2002:adf:ca92:0:b0:3a4:f722:f98d with SMTP id ffacd0b85a97d-3a9008557admr4519014f8f.51.1751106247302;
        Sat, 28 Jun 2025 03:24:07 -0700 (PDT)
Received: from [10.100.102.74] (89-138-75-164.bb.netvision.net.il. [89.138.75.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e71dfsm4901565f8f.7.2025.06.28.03.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 03:24:07 -0700 (PDT)
Message-ID: <c66548d0-1211-4176-b698-05a36320cf94@grimberg.me>
Date: Sat, 28 Jun 2025 13:24:05 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
To: Ming Lei <ming.lei@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>, Hannes Reinecke
 <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
 <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
 <aEuviL5O2kD70Sij@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aEuviL5O2kD70Sij@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/06/2025 7:56, Ming Lei wrote:
> On Wed, Jun 04, 2025 at 11:17:05AM +0000, Shinichiro Kawasaki wrote:
>> Cc+: Ming,
>>
>> Hi Sagi, thanks for the background explanation and the suggestion.
>>
>> On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
>> ...
>>>> This is a problem. We are flushing a work that is IO bound, which can
>>>> take a long time to complete.
>>>> Up until now, we have deliberately avoided introducing dependency
>>>> between reset forward progress
>>>> and scan work IO to completely finish.
>>>>
>>>> I would like to keep it this way.
>>>>
>>>> BTW, this is not TCP specific.
>> I see. The blktests test case nvme/063 is dedicated to tcp transport, so that's
>> why it was reported for the TCP transport.
>>
>>> blk_mq_unquiesce_queue is still very much safe to call as many times as we
>>> want.
>>> The only thing that comes in the way is this pesky WARN. How about we make
>>> it go away and have
>>> a debug print instead?
>>>
>>> My preference would be to allow nvme to unquiesce queues that were not
>>> previously quiesced (just
>>> like it historically was) instead of having to block a controller reset
>>> until the scan_work is completed (which
>>> is admin I/O dependent, and may get stuck until admin timeout, which can be
>>> changed by the user for 60
>>> minutes or something arbitrarily long btw).
>>>
>>> How about something like this patch instead:
>>> --
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index c2697db59109..74f3ad16e812 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>>          bool run_queue = false;
>>>
>>>          spin_lock_irqsave(&q->queue_lock, flags);
>>> -       if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
>>> -               ;
>>> +       if (q->quiesce_depth <= 0) {
>>> +               printk(KERN_DEBUG
>>> +                       "dev %s: unquiescing a non-quiesced queue,
>>> expected?\n",
>>> +                       q->disk ? q->disk->disk_name : "?", );
>>>          } else if (!--q->quiesce_depth) {
>>>                  blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>>>                  run_queue = true;
>>> --
>> The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
>> concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
>> ask your comment on the suggestion by Sagi?
> I think it is bad to use one standard block layer API in this unbalanced way,
> that is why WARN_ON_ONCE() is added. We shouldn't encourage driver to use
> APIs in this way.
>
> Question is why nvme have to unquiesce one non-quiesced queue?

It started before quiesce/unquiesce became an API that had to be balanced.

In this case, we are using the tagset quiesce/unquiesce interface. Which 
iterates
over the request queues from the tagset. The problem is that due to 
namespace
scanning, we may add new namespaces (and their request queues) after we
quiesced the tagset. Then when we call tagset unquiesce, we have a new 
request
queue that wasn't quiesced (added after the quiesce).

I don't mind having a BLK_FEAT_ALLOW_UNBALANCED_QUIESCE for the nvme request
queues if you don't want to blindly remove the WARN_ON.
