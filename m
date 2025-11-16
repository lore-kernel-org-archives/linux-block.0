Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65F2309BE
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274403; cv=none; b=N+FpcRtitJQVEDn2D5ClKL9xiB9D19txsnrA3+lS+y8FJOe+91JqjEH2+Io6VVZSjkKioKhcUCUk0RlyQvHNyVAc4a0MMdQ4x1lQUJGoe+KHM84RiffuIMltHjPtMpDtWBiOXE2ME7nJ+pLtJhcFnrGbpnPw30d+sRZBgShubbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274403; c=relaxed/simple;
	bh=kTOmeXyG3GLjPvLj3ifFGBqn2tDM6iOlfDK/JsEG51g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ9rG9HTmnREddS7iY322aBDuOkStSGrMuRZHCgsm/F5fXOjq33alR11t1x/IcLFH3vMvWSjPcBGG4stt8H8qtiwIS+/MQErEYeHx2ht6rr/WxV0twKXOjOhY7Phq05kkRqUrIuok1BcTl1yzlBb5qaIfVJHZoW9BDh0jnj/umM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ74USJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ74USJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0AFC4CEF5;
	Sun, 16 Nov 2025 06:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763274403;
	bh=kTOmeXyG3GLjPvLj3ifFGBqn2tDM6iOlfDK/JsEG51g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZ74USJ+r4v+8jRCzZtH1UDwCodj68r75TW1b0GU8dO2pN/u07++yh+Q5FTZobX2t
	 kVtp8n1LAStkft86xI6RDVITFurGCEKPc8fuawbcSayDH1Vj5SaCh37dR/WkbEWeyI
	 E4KnhIxj/KB9t09AXgw7lPBOEzS+5gBVT3DMPatoW0i3DhPCBEGq25x1jRgfb5ZsNH
	 MBiVXNIJdSP4pfJ6u5sWsJ3qYxpTbih3gumhqTOQrTp9SaKIvyG+h7kbA7wfaBhFsz
	 DcBJA2z7YmxIKmllYrxfWiaNWB0Pwh+jsNRdhbjKbjtIoaJMVNt7OAXg3wjhjeHN6B
	 gX8j4oHpUNfcg==
Message-ID: <bb672149-fb81-489e-8afb-8ffdd8eb7702@kernel.org>
Date: Sun, 16 Nov 2025 15:26:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
 <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
 <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 14:43, Chaitanya Kulkarni wrote:
> On 11/15/25 19:50, Damien Le Moal wrote:
>> On 11/16/25 11:52, Chaitanya Kulkarni wrote:
>>>    6. Loop driver:
>>>     loop_queue_rq()
>>>      lo_rw_aio()
>>>       kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)
>>>        -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT
>> Same comment as for zloop. Re-read the code and see that loop_queue_rq() calls
>> loop_queue_work(). That function has a memory allocation that is already marked
>> with GFP_NOWAIT, and that this function does not directly execute lo_rw_aio() as
>> that is done from loop_workfn(), in the work item context.
>> So again, no blocking violation that I can see here.
>> As far as I can tell, this patch is not needed.
>>
> Thanks for pointing that out. Since REQ_NOWAIT is not valid in the
> workqueue, then REQ_NOWAIT flag needs to be cleared before
> handing it over to workqueue ? is that the right interpretation?

No. the queue_rq context does not block, so REQ_NOWAIT is being respected. I do
not see any issue with it. REQ_NOWAIT simply means that ->queue_rq() should not
block. It does not mean that the IO should/will be completed instantaneously...

Did you by any chance trigger a warning or something ? If yes, waht is the
reproducer ?

> 
> e.g.
> 
> loop_queue_rq()
>   loop_queue_work()
>     ...
>     ...
>     rq->cmd_flags &= ~REQ_NOWAIT; <---
>     
>     list_add_tail(&cmd->list_entry, cmd_list);
>     queue_work(lo->workqueue, work);
>     spin_unlock_irq(&lo->lo_work_lock);
> 
> I have read the code [1] and the commit that added the flag [2] as well.
> I could not find any mention of how switching to a workqueue context
> affects the interpretation of REQ_NOWAIT, or whether its scope is
> strictly limited to XXX_queue_rq() in the request lifecycle.
> 
> -ck
> 
> [1]
> 
> fio context =============>>
> 
> loop_queue_rq()
>   loop_queue_work()
>     queue_work(lo->workqueue, work);
> 
> fio ===> workqueue context
> 
> Work queue context =====>>>
> 
> loop_workfn
>   loop_process_work
>    loop_handle_cmd
>     do_req_filebacked()
> 
>      struct request *rq = blk_mq_rq_from_pdu(cmd);
> 
> [2]
> 
>  From 03a07c92a9ed9938d828ca7f1d11b8bc63a7bb89 Mon Sep 17 00:00:00 2001
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Date: Tue, 20 Jun 2017 07:05:46 -0500
> Subject: [PATCH] block: return on congested block device
> 
> A new bio operation flag REQ_NOWAIT is introduced to identify bio's
> orignating from iocb with IOCB_NOWAIT. This flag indicates
> to return immediately if a request cannot be made instead
> of retrying.
> 
> Stacked devices such as md (the ones with make_request_fn hooks)
> currently are not supported because it may block for housekeeping.
> For example, an md can have a part of the device suspended.
> For this reason, only request based devices are supported.
> In the future, this feature will be expanded to stacked devices
> by teaching them how to handle the REQ_NOWAIT flags.
> 


-- 
Damien Le Moal
Western Digital Research
