Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C643C433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 18:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbhLUSLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbhLUSLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 13:11:45 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81094C061401
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 10:11:45 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p65so18887974iof.3
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lt8ASTna6/s7WYoDE2q4K1j06mGDiK7CFlaZHGUVnN4=;
        b=QIPZdV8/IZuwUvSRMxzUzfq3Je1Vzt6PNE/OaTo+RoG/sCO95c6Oj97RPqqCzgREYf
         363WOX8RCtYiKhhJg5ULf+T8kTh3Hr9VXvHsFG4uMl0DCMGMFbc/g2VTgo8q7aD/jaZm
         zf9G0a2eHj4Lsz4RDSpA43k3+9OfIEAD1uqkES9WiivawdBqR8SLgiJxgH/rjL7IEwzi
         bprnWMywrj3bHoEAjQZ7HzzKsJUFx0OYuCvgROCYi4ZyU2VDof8n7HIWMJkfP5W8JaUA
         hMMwk1V63+P7j35xCXoROoeF5UH5TKe9C5CXiArzr1O960tdEN+WFGhZ32dnN7xyh1S7
         E0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lt8ASTna6/s7WYoDE2q4K1j06mGDiK7CFlaZHGUVnN4=;
        b=wuj2m34j933gekNjTKPq8goQJSbhvhOUGHxTBRg2KIgByXjTMNnSuHObHiNQKwUCvc
         vPqkm17+06UdwsyhvCRaJ55UqyIVpIpk/qhDnhM7kNavqHctnqprETPGQTlWePU70y5Q
         6hGuOTZmbgBP75H4GxQsqrwb3a/sXrGc6VZKW9TIIvj6n4VcPNYxoFv4hminPQVhKxcl
         F7eLrIuh1lVzqEdQ0GqtzZHNBxqb7ov/k5uBuykvwjfJmrST1zZWesM0pUTL7RCl+Yit
         yY/h1Sby/Q19hMLOUyPednWMFBI4lhWBhTkwCffI9GNrxSkEihqZY+RXowBDk0EbKYBn
         Y1Sg==
X-Gm-Message-State: AOAM5338aaqJZ8qFJ+IhcSM9fLPcp6myrFbc85RcdNaihk74K3XKponk
        /AOzBTaWBlfH9VR1G44WjOjcNcBoHrUsOw==
X-Google-Smtp-Source: ABdhPJwH4P02unPRRNdUsw9JBuM0NHNpwW1jTeWgQL1azkgmXKw8DCNp4dVwrFHGrSrdrfqGBK3zJA==
X-Received: by 2002:a02:c6ab:: with SMTP id o11mr2659947jan.303.1640110304536;
        Tue, 21 Dec 2021 10:11:44 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s3sm11278566ilv.69.2021.12.21.10.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:11:44 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.15 20/29] block: reduce
 kblockd_mod_delayed_work_on() CPU consumption
To:     Sasha Levin <sashal@kernel.org>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20211221015751.116328-1-sashal@kernel.org>
 <20211221015751.116328-20-sashal@kernel.org>
 <MWHPR21MB1593141494C76CF5A0BDDB11D77C9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <ad76826e-73b2-b2f0-3cd4-8481645a6568@kernel.dk> <YcIVqFOrxbG8sqXK@sashalap>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <554684c4-9131-5035-17e5-87dc01bc9ee3@kernel.dk>
Date:   Tue, 21 Dec 2021 11:11:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YcIVqFOrxbG8sqXK@sashalap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/21/21 10:58 AM, Sasha Levin wrote:
> On Tue, Dec 21, 2021 at 08:36:33AM -0700, Jens Axboe wrote:
>> On 12/21/21 8:35 AM, Michael Kelley (LINUX) wrote:
>>> From: Sasha Levin <sashal@kernel.org> Sent: Monday, December 20, 2021 5:58 PM
>>>>
>>>> From: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> [ Upstream commit cb2ac2912a9ca7d3d26291c511939a41361d2d83 ]
>>>>
>>>> Dexuan reports that he's seeing spikes of very heavy CPU utilization when
>>>> running 24 disks and using the 'none' scheduler. This happens off the
>>>> sched restart path, because SCSI requires the queue to be restarted async,
>>>> and hence we're hammering on mod_delayed_work_on() to ensure that the work
>>>> item gets run appropriately.
>>>>
>>>> Avoid hammering on the timer and just use queue_work_on() if no delay
>>>> has been specified.
>>>>
>>>> Reported-and-tested-by: Dexuan Cui <decui@microsoft.com>
>>>> Link: https://lore.kernel.org/linux-block/BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com/
>>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ---
>>>>  block/blk-core.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index c2d912d0c976c..a728434fcff87 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -1625,6 +1625,8 @@ EXPORT_SYMBOL(kblockd_schedule_work);
>>>>  int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
>>>>  				unsigned long delay)
>>>>  {
>>>> +	if (!delay)
>>>> +		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
>>>>  	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
>>>>  }
>>>>  EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
>>>> --
>>>> 2.34.1
>>>
>>> Sasha -- there are reports of this patch causing performance problems.
>>> See
>>> https://lore.kernel.org/lkml/1639853092.524jxfaem2.none@localhost/. I
>>> would suggest *not* backporting it to any of the stable branches until
>>> the issues are fully sorted out.
>>
>> Both this and the revert were backported. Which arguably doesn't make a
>> lot of sense, but at least it's consistent and won't cause any issues...
> 
> The logic behind it is that it makes it easy for both us as well as
> everyone else to annotate why a certain patch might be "missing" from
> the trees - in this case because it was reverted.
> 
> It looks dumb now, but it saves a lot of time as well as mitigates the
> risk of it being picked up again at some point in the future.

It's fine with me, when I saw the first patch yesterday I did get
worried, but then I saw the revert was picked too. As I said, as long
as the end result is sane, then there's no harm in doing it this way.

-- 
Jens Axboe

