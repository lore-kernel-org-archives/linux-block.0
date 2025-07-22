Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DF2D5437
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175928; cv=none; b=D3B1fGGDNV9G1+xPgxJVPZ2BFErAukXt4OFdQ9QjYyopfN1Mt1b+3UdKlKA4mJbH3Tp8Vpm/7Zlhclfm5ir6Pd1l6hYi7vcrbNE0kUb7D58rsAp51mAc0LDifohXQL4rWdsjN++HuwH7maIF6n3LQvdoXaUYMphugnpUXC4nRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175928; c=relaxed/simple;
	bh=7vNBjXDs/CNlWCWPSsFEVEqn2KSb2D2ogstPdpeDV68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBLMHAsR+P1krA7jRQoYIVjPWcHofuUaLQyRhCyIIIAz3pCJ178jV+xuNGbFou4Rb31Xkgz49+x03NQ75jz3tVSMuakSQ9VQgYSSgW4UB40xphlKhBO/7bP5P+mrVGroJPNe7EM9jtMQWXGnR5WerO+aLyr4vAFwIcI6Gvc+sRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqTGgb+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqTGgb+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D585C4CEEB;
	Tue, 22 Jul 2025 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753175927;
	bh=7vNBjXDs/CNlWCWPSsFEVEqn2KSb2D2ogstPdpeDV68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DqTGgb+NOBqN2VjNlkb6IWyrZxUWq6b7a0Tfgz3H28RsW5ymSevZK1Gvppj4JRx6H
	 wsdUaz3sFf6Wvk3wlN0Xq04Fb2n0YTuSfK/jCCVCwvPSn4/VQcME1z/sldz/vGcJCp
	 yscWQA5n83rTqA/LDlnMVuFD0JLD+aDabNQcoBmShRes0txCCYIE2VOkkicZHkMSRh
	 qFPpCWK7vy3xe5zkCtdva71btYRjm0+KXHoZG/0FTDvUGrnvP3t0obY7vfn5fToxtw
	 6EwbkPpWZGGQfXwm0Rx/ofZlbhXZ3wbf8QYfppvCv9gqFZY1uZ4ALx3zP+Ckn3PAjg
	 E7kjTIArD+thw==
Message-ID: <9af6ea8f-3e21-40a9-a72b-e2a3da3a378a@kernel.org>
Date: Tue, 22 Jul 2025 18:16:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
 <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/25 5:30 PM, Nilay Shroff wrote:
> 
> 
> On 7/22/25 6:37 AM, Damien Le Moal wrote:
>> On 7/21/25 11:04 PM, Nilay Shroff wrote:
>>> When setting up a null block device, we initialize a tagset that
>>> includes a driver_data field—typically used by block drivers to
>>> store a pointer to driver-specific data. In the case of null_blk,
>>> this should point to the struct nullb instance.
>>>
>>> However, due to recent tagset refactoring in the null_blk driver, we
>>> missed initializing driver_data when creating a shared tagset. As a
>>> result, software queues (ctx) fail to map correctly to new hardware
>>> queues (hctx). For example, increasing the number of submit queues
>>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>>> remap queues. Since set->driver_data is unset, null_map_queues()
>>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>>> effectively making the hardware queues unusable for I/O.
>>>
>>> This patch fixes the issue by ensuring that set->driver_data is properly
>>> initialized to point to the struct nullb during tagset setup.
>>>
>>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>  drivers/block/null_blk/main.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index aa163ae9b2aa..fbae0427263d 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>>>  {
>>>  	if (nullb->dev->shared_tags) {
>>>  		nullb->tag_set = &tag_set;
>>> +		nullb->tag_set->driver_data = nullb;
>>
>> This looks better, but in the end, why is this even needed ? Since this is a
>> shared tagset, multiple nullb devices can use that same tagset, so setting the
>> driver_data pointer to this device only seems incorrect.
>>
>> Checking the code, the only function that makes use of this pointer is
>> null_map_queues(), which correctly test for private_data being NULL.
>>
>> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
>>
> I think you were right — the first patch alone is sufficient to prevent the crash.
> Initially, I thought the second patch might also be necessary, especially for the
> scenario where the user increases the number of submit_queues for a null_blk device.
> While the block layer does create a new hardware queue (hctx) in response to such
> an update, null_blk (null_map_queues()) does not map any software queue (ctx) to it. 
> As a result, the newly added hctx remains unused for I/O.
> 
> Given this behavior, I believe we should not allow users to update submit_queues 
> on a null_blk device if it is using a shared tagset. Currently, the code allows
> this update, but it’s misleading since the change has no actual effect.
> 
> Would it make sense to explicitly prevent updating submit_queues in this case?
> That would align the interface with the actual behavior and avoid potential
> confusion and also saves us allocating memory for hctx which remains unused.
> Maybe we should have this check, in nullb_update_nr_hw_queues():
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index fbae0427263d..aed2a6904db1 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>         if (!submit_queues)
>                 return -EINVAL;
>  
> +       /*
> +        * Cannot update queues with shared tagset.
> +        */
> +       if (dev->shared_tags)
> +               return -EINVAL;
> +

I think that is fine since null_init_global_tag_set() uses g_submit_queues
(module parameter).

>         /*
>          * Make sure that null_init_hctx() does not access nullb->queues[] past
>          * the end of that array.
> 
> If the above change looks good, maybe I can update second patch with
> the above change.
> 
> Thanks,
> --Nilay
> 


-- 
Damien Le Moal
Western Digital Research
