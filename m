Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDF1C84AB
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750819487; cv=none; b=BZbVN8nlnj6jjksc4pRcCwDtTgcNvzqNF7SX6ZRFqnnhuskn6ynI5UqBPsus8j7BwdfsfxfGAr07sDyJQrTfeJ1pKI2NkZ53DcDMFI4QseSW0C3ihdnsvXkNXUb+9W8Ol+y2fe6M4FGvHBwFfWehy1kuHe8E4aKWgWbXKS9I+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750819487; c=relaxed/simple;
	bh=rLajZTmMJEgAxVeJ/wCF7h7cfrMsLq2/SiKbV3siYw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQv31IC4S9Bm2gtbYrkj7K8WOXP8JBPrT1hlNkgUD7ZLPCcdSC5osQSTK57YG8yM4ofgHiCHFZ9u7HwC+g9nFB9PCFy0UEAFP90iNt6ymk1Yxusro9zuubmFUXiEVOayp+XitnItwYRDL2ubVpXYFfOMS+3dPwlYYXoLbo9ZtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aWbM/oYg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aWbM/oYg"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748da522e79so2935227b3a.1
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750819480; x=1751424280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krnaXgCt7FGwFNgUY8fBOpyKd6sWF6OHxZmIJdnQpY0=;
        b=aWbM/oYgipB3MnAnG6w25HXkw7Keuh7ewZKrJFsJqUPo/eC3OsO4gdBRWsECFHuk/E
         osBO6CcPRkrluCVnRoMlOnIcOu1JGU9We7uPRaD9HIFVR/X2abbClJ9UrOLh2/6cyiVQ
         TrLszUgDJwWrQod2rMkAR2ATL9nSdzLwqquZ/zKsxRHSRhFI8Ee9r/zj0zi3bdxLYHxh
         QQ1k9vgUiUhf6/bY0uOBe3kJnXZ0wyxCxOgoNaPZeqcdDko05ajMkfNal5scN3FWx1B3
         H+Ev3qfQwmDX+o2o6lLhnT4eR7W6+ObqTOUtNixJoF5UjJFack2d6qfRH8aAZcIxQc/H
         4UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750819480; x=1751424280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krnaXgCt7FGwFNgUY8fBOpyKd6sWF6OHxZmIJdnQpY0=;
        b=rqOSow+IeC897mtcAHDBoBszDAnaQqSwcRTD57Ekm/4cfWpf8DkcFNPZxrNinzWMlr
         FURL7ggivNidyQDOTzjEh95MD07f3EB7Tc5iM07Qkvk361ARqsJlRStI8hfrNuWh+9FW
         uaPOzYo7re9ht3N4QEYM2Z/YsC0caP0X/oqqg5S9VS476hwSR/NsB9vzkBz7Y5MyXyY/
         aISyrKJqbNHV6H7L+yu51TXjce/A/fLhDa23Z1AHjoSny2x06DhELjgCNmGvf0RjDC0R
         RNt6LSPpqEkpZCcnXIrXyFuSN1jXJ4OiNpho6PhcGSJxfpC7h3AxJLitF7jHrIVPhi5N
         n7tw==
X-Gm-Message-State: AOJu0Yy7Sdxmd24CRCCFELaxLwDV4ZziNZTZaOVT4UpivcsBia1U5sUk
	Ce+lt9To2JIp0W/JK9ISBvzbWf3jrlxkqYnNDHa1xuUORwu9f0EYY8z3SLg4ffka0Uw=
X-Gm-Gg: ASbGncs2UKb2I2ry9Mx5gIrBsoeQWav7hxOmluk1V3fk1lNFJlZD9Az1RTc9zRLaou8
	KyRn6tC2083eF/eFNYmDeUsQxCSGM2v26jHUBkmIjFKb5T29Dl3M8dbPtx8f6DqaiGjRr+KCWsp
	mE7ovDtgqUShbrsWA5OSw7VKvNBoMxm4H6Ko6wpMK5jQdo7QvFrkpA0yNCdXVEVGieUo7Ggne+j
	R2ztZFfRvbTD/fjvIwY2JapxyDTsB1cD/MsV1F78c9/UQ0mUNKmQTmo9ASEXm1wbXNqVB+AiK7T
	UyB+NF9AB7MTAFccT1K/4QPSw2XxgEVTf0PbG+dTQLmsJ6CtBfK917tvfg==
X-Google-Smtp-Source: AGHT+IGYrK7nJVX4i3aYN3s2EV/3JJzxO1iou1zLbA+BU4UenhWgSqWcgEosHGY+7YyOEGnh2ZWGyQ==
X-Received: by 2002:a05:6a00:464f:b0:732:2923:b70f with SMTP id d2e1a72fcca58-74ad45645f4mr2076345b3a.11.1750819480004;
        Tue, 24 Jun 2025 19:44:40 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e21472sm3069937b3a.48.2025.06.24.19.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 19:44:38 -0700 (PDT)
Message-ID: <895556ee-43d5-4bfa-adc5-20c35f4e3e84@kernel.dk>
Date: Tue, 24 Jun 2025 20:44:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ublk: build per-io-ring-ctx batch list
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
References: <20250623011934.741788-1-ming.lei@redhat.com>
 <20250623011934.741788-2-ming.lei@redhat.com>
 <CADUfDZp=69+ZpJ5vc7c9qGmA3zLU+eYdYd2PfeiDwFvxYQ+0nQ@mail.gmail.com>
 <aFn-RNJxWFl5Vz-G@fedora>
 <CADUfDZq3CN+i2d9sX+79n-Si4UWad-2n2_9E+-vkj0vfb7pVGg@mail.gmail.com>
 <aFtPShUlUwGLWvqF@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aFtPShUlUwGLWvqF@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/24/25 7:22 PM, Ming Lei wrote:
> On Tue, Jun 24, 2025 at 08:26:51AM -0700, Caleb Sander Mateos wrote:
>> On Mon, Jun 23, 2025 at 6:24 PM Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>> On Mon, Jun 23, 2025 at 10:51:00AM -0700, Caleb Sander Mateos wrote:
>>>> On Sun, Jun 22, 2025 at 6:19 PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>
>>>>> ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
>>>>> work via the tail request's io_uring_cmd, this way is fine even though
>>>>> more than one io_ring_ctx are involved for this batch since it is just
>>>>> one running context.
>>>>>
>>>>> However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
>>>>> of tail uring_cmd's io_ring_ctx for completing all commands. This way is
>>>>> wrong if any uring_cmd is issued from different io_ring_ctx.
>>>>>
>>>>> Fixes it by always building per-io-ring-ctx batch list.
>>>>>
>>>>> For typical per-queue or per-io daemon implementation, this way shouldn't
>>>>> make difference from performance viewpoint, because single io_ring_ctx is
>>>>> often taken in each daemon.
>>>>>
>>>>> Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
>>>>> Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  drivers/block/ublk_drv.c | 17 +++++++++--------
>>>>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>>> index c637ea010d34..e79b04e61047 100644
>>>>> --- a/drivers/block/ublk_drv.c
>>>>> +++ b/drivers/block/ublk_drv.c
>>>>> @@ -1336,9 +1336,8 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
>>>>>         } while (rq);
>>>>>  }
>>>>>
>>>>> -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
>>>>> +static void ublk_queue_cmd_list(struct io_uring_cmd *cmd, struct rq_list *l)
>>>>>  {
>>>>> -       struct io_uring_cmd *cmd = io->cmd;
>>>>>         struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>>>>>
>>>>>         pdu->req_list = rq_list_peek(l);
>>>>> @@ -1420,16 +1419,18 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
>>>>>  {
>>>>>         struct rq_list requeue_list = { };
>>>>>         struct rq_list submit_list = { };
>>>>> -       struct ublk_io *io = NULL;
>>>>> +       struct io_uring_cmd *cmd = NULL;
>>>>>         struct request *req;
>>>>>
>>>>>         while ((req = rq_list_pop(rqlist))) {
>>>>>                 struct ublk_queue *this_q = req->mq_hctx->driver_data;
>>>>> -               struct ublk_io *this_io = &this_q->ios[req->tag];
>>>>> +               struct io_uring_cmd *this_cmd = this_q->ios[req->tag].cmd;
>>>>>
>>>>> -               if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
>>>>> -                       ublk_queue_cmd_list(io, &submit_list);
>>>>> -               io = this_io;
>>>>> +               if (cmd && io_uring_cmd_ctx_handle(cmd) !=
>>>>> +                               io_uring_cmd_ctx_handle(this_cmd) &&
>>>>> +                               !rq_list_empty(&submit_list))
>>>>> +                       ublk_queue_cmd_list(cmd, &submit_list);
>>>>
>>>> I don't think we can assume that ublk commands submitted to the same
>>>> io_uring have the same daemon task. It's possible for multiple tasks
>>>> to submit to the same io_uring, even though that's not a common or
>>>> performant way to use io_uring. Probably we need to check that both
>>>> the task and io_ring_ctx match.
>>>
>>> Here the problem is in 'issue_flags' passed from io_uring, especially for
>>> grabbing io_ring_ctx lock.
>>>
>>> If two uring_cmd are issued via same io_ring_ctx from two tasks, it is
>>> fine to share 'issue_flags' from one of tasks, what matters is that the
>>> io_ring_ctx lock is handled correctly when calling io_uring_cmd_done().
>>
>> Right, I understand the issue you are trying to solve. I agree it's a
>> problem for submit_list to contain commands from multiple
>> io_ring_ctxs. But it's also a problem if it contains commands with
>> different daemon tasks, because ublk_queue_cmd_list() will schedule
>> ublk_cmd_list_tw_cb() to be called in the *last command's task*. But
>> ublk_cmd_list_tw_cb() will call ublk_dispatch_req() for all the
>> commands in the list. So if submit_list contains commands with
>> multiple daemon tasks, ublk_dispatch_req() will fail on the current !=
>> io->task check. So I still feel we need to call
>> ublk_queue_cmd_list(io, &submit_list) if io->task != this_io->task (as
>> well as if the io_ring_ctxs differ).
> 
> Indeed, I will send a V2 for covering different task case.
> 
> Jens, can you drop this patch?

Done

-- 
Jens Axboe

