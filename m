Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C27C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiFUIbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiFUIbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 04:31:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB8113D5D
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655800275; x=1687336275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qucA03qSP9PIA2chxP6Oz8ivk3NeMPXmaIPgisWiU7w=;
  b=SpFqvXUewMM1bzebiBr2QwQqiRVZYsfPl55a9aEEDzWspdL+vpqu1hCz
   NgpInHGrHt+MHbcNwqONa+8bqzhbuKVDUeagCtmqAZ+dJpmpRAV82L5Qg
   PKZ91zmYUQWVUMyJarNQjX+U8ZNnlS3cpOkn8lhoerqAD2lh0wNOX6mI7
   WDVylD+GlJNIi/hMFxD7rt+7Mto6WMO5gR3TW/QJWi1oN6y6zhuIvv9fM
   Mg9dn6IMxL/QqGQT6OGy6S17dsVl+Hf2xnWAK3xTt7FVOwzm0axTDQA0Z
   YpVhB/T67aJqcrwK7fBann7cipW0RgaDO3j68Nz3uJPTYczx38Ltrbnqo
   A==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="208558354"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 16:31:14 +0800
IronPort-SDR: 0Gie5iEv1gitsBIhnGGvpLiu1xXRf/LPDc4kQYdnKs/kKblQVw/crLELDBzezaQ4kq978wbZKf
 R6cw8xJBMi0tcd6zvyBvMrVXWrUqX1YYuMHhlCpUHiV5yU5m56GfEgxxbcNmt5J6AmvnMo8otd
 R1Jzut1iiSlfUjn8odvnyG6zupof0i3WKtJgTlfXRysPZXuElXW8GZ/xgYyWg/hpQaJICy7ZaT
 O4vOk4GVp3fkfXL7WkUw5PVRe+/wEe6Z56BgN0X5FJgzDlvFDyOr1YTqQ8FTidG9g3m5Jc3+pV
 H6uqyhQ0ci+2BtEgxjvlNzqM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 00:49:22 -0700
IronPort-SDR: tVvUKrZcqLI41iTtZjW7la+fFKtXsCF+M7oUycayq0OtAwKEPnvlKfkxUEXhZzrk92DB356Pgb
 QnKmEZiYoyB57dl1M//Jd7NsmoY511OlaSdEk3zQDpUbtYyJeQJxL0pabFDvZX8CdI6hc0qGHv
 +43KJyhXe6oovF8KEgUzIBltDbMp3C71iTt1aiMEtejyWTsMSO5CItuN6hY+Vl6ikzW3GDhuUr
 CsPylneiwoTz//Kjs10YaIPcF+QO2KnVEQ0/snH4cN3z690/2IZQ1UuB5Pt6l9wyhMnIdnU+c1
 V6I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 01:31:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LS08y6SN5z1Rwnm
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 01:31:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655800274; x=1658392275; bh=qucA03qSP9PIA2chxP6Oz8ivk3NeMPXmaIP
        gisWiU7w=; b=NVZt5ARKisL9yVfBWbErDlEI/ga4e0S8++8Xy1hDVxFjQ7lEAlT
        Oop8a2j64KESg7Frc3j/n/39VMSwyNxs3GeVvqIHQc3i5VRQDgNSuj/sH1RbDh1i
        v7DAbndz2dTXyDg6ebv7Gh8YTpFjyno0ZHhK+IZ4RdTYnz0A/jx+PKtaAvtFYIG3
        GL7MHfZtB4ITNbgNkD4YlADW0x7zHmgA4frfQ7WFQxJJIQCjAe3CxfKcmK5xE15y
        p/1x0l/fzqIy5wceIZV+U7HxR9+A9YywACFT2n00fLRpwn9mPLspDwX0ddK6BO6N
        Nmr1dMI1MalecYN4gUsNFzTbhrV2BLg+mMQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0B9Jvt-EE7nB for <linux-block@vger.kernel.org>;
        Tue, 21 Jun 2022 01:31:14 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LS08x101Rz1RtVk;
        Tue, 21 Jun 2022 01:31:13 -0700 (PDT)
Message-ID: <3f6cdc79-8cc4-aa56-cb4c-23b94b686396@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 17:31:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/8] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-4-jack@suse.cz>
 <7124bdba-e295-83d4-6346-9e9420062a0f@opensource.wdc.com>
 <20220621081558.6pzyqb67hgjncomm@quack3.lan>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220621081558.6pzyqb67hgjncomm@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 17:15, Jan Kara wrote:
> On Tue 21-06-22 08:57:29, Damien Le Moal wrote:
>> On 6/21/22 01:11, Jan Kara wrote:
>>> ioprio_get(2) can be asked to return the best IO priority from several
>>> tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
>>> tasks without set IO priority as having priority
>>> IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
>>> IO priority the task will get (which depends on task's nice value).
>>>
>>> Fix the code to use the real IO priority task's IO will use. For this we
>>> do some factoring out to share the code converting task's CPU priority
>>> to IO priority and we also have to modify code for
>>> ioprio_get(IOPRIO_WHO_PROCESS) to keep returning IOPRIO_CLASS_NONE
>>> priority for tasks without set IO priority as a special case to maintain
>>> userspace visible API.
>>>
>>> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> ...
> 
>>> +/*
>>> + * Return raw IO priority value as set by userspace. We use this for
>>> + * ioprio_get(pid, IOPRIO_WHO_PROCESS) so that we keep historical behavior and
>>> + * also so that userspace can distinguish unset IO priority (which just gets
>>> + * overriden based on task's nice value) from IO priority set to some value.
>>> + */
>>> +static int get_task_raw_ioprio(struct task_struct *p) { int ret;
>>
>> The "int ret;" declaration is on the wrong line, so is the curly bracket.
> 
> Huh, don't know how that got messed up. Anyway fixed. Thanks for noticing.
> 
>>> +
>>> +	ret = security_task_getioprio(p);
>>> +	if (ret)
>>> +		goto out;
>>>  	task_lock(p);
>>>  	if (p->io_context)
>>>  		ret = p->io_context->ioprio;
>>> +	else
>>> +		ret = IOPRIO_DEFAULT;
>>>  	task_unlock(p);
>>>  out:
>>>  	return ret;
>>> @@ -156,11 +196,6 @@ static int get_task_ioprio(struct task_struct *p)
>>>  
>>>  static int ioprio_best(unsigned short aprio, unsigned short bprio)
>>>  {
>>> -	if (!ioprio_valid(aprio))
>>> -		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
>>> -	if (!ioprio_valid(bprio))
>>> -		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
>>> -
>>>  	return min(aprio, bprio);
>>>  }
>>
>> This function could be declared as inline now...
> 
> Yeah, but compilers inline (or not inline!) static functions as they see
> fit anyway. So 'inline' keyword for static functions is generally a noise
> which is why I just avoid it. But please let me know if you feel strongly
> about that.

Not at all. Fine as-is !

> 
>>>  static inline int get_current_ioprio(void)
>>>  {
>>> -	struct io_context *ioc = current->io_context;
>>> -	int prio;
>>> -
>>> -	if (ioc)
>>> -		prio = ioc->ioprio;
>>> -	else
>>> -		prio = IOPRIO_DEFAULT;
>>> -
>>> -	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>>> -		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
>>> -					 task_nice_ioprio(current));
>>> -	return prio;
>>> +	return __get_task_ioprio(current);
>>
>> The build bot complained about this one, but I do not understand why.
>> Could it be because you do not have declared __get_task_ioprio() as "extern" ?
> 
> No, likely it is because !CONFIG_BLOCK kernel does not have ioprio support
> but something uses the get_current_ioprio() anyway. I'll fix it up.
> 
>> Also, to reduce refactoring changes in this patch, you could introduce
>> __get_task_ioprio() and make the above change in patch 2. No ?
> 
> OK, I will move some refactoring.
> 
> 								Honza


-- 
Damien Le Moal
Western Digital Research
