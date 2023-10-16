Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CCC41513
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 21:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPVL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVL6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 17:11:58 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD7A2
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 14:11:56 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57f137dffa5so750457eaf.1
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697490715; x=1698095515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BRwuGLjLQCMOd5XxHaQqQETzEG0/pm9dc6qnNSBr58=;
        b=cD2SuoFgHrlnzeWPq73b3qJqNPJE4ZryuIuE5IB6aUU17hvtoCuzVNDLJTD8XXTXur
         qspN0f6GQH1WKkEJYSpUQfhpZjlDO4GBzkaWiN8yQ3XxYrI6XWpZWfLvZRcm4GY5GQcQ
         pgdcVeOkZp5rAiyr6PnNeqv+qVEQVNsNNBMAV3tw0neOdq62rame13/vmon0p5ul0Bw4
         YBi/xZJ+QSIEAbc7ws9COcc8jdzHNnML9wKhDNj8E8P75ujSenKLzDSRc70oHeHmKZaY
         Hk7SVv16x8VTTcCB0o0mGuBQ0Fu+CXazJNRe98sG5YfUgAjFddMwGQCL1MDGrptFwl6o
         GrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490715; x=1698095515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BRwuGLjLQCMOd5XxHaQqQETzEG0/pm9dc6qnNSBr58=;
        b=a3/2jn0K5kKxiMC/GDiLOrRE+2yprKKhVhsZO97ZZ6HwyIJCHVOGPvR8ZxdkiDy90w
         Dg1t7gtqUoGSgAAO4ac3Cl5fiuPdqYCwWkviDjykoIVo1DdEDr19fzl1kpC7rpnKCpvU
         vmbaWdeGxJVkOlSapndNtAHazxS31z/6LWQ3j0qOQBtryJYkaP6JWVGA1OaqtrKZL2ec
         UPgRK+NmYY0WlGvJu951/vVMY/0yfLXL7iHjGb48BXu+fXYYCNnAIVfE6d4mrlcveNnN
         GwjYZuiCKxTElQy0yEmUUTJkr+YX6nrqsHCU5lkShm+2zSPyHQ5s8sKEuWUVpmzLuVy4
         O+nA==
X-Gm-Message-State: AOJu0YzVycHcZmVy6PLM32r5vbWLXWOvM1f3AaXnnIGtIA2D0Y8Mg0It
        RV0OLr86bmznvZJvlR3FT+iruGkuxiPXwCa+/EAH1Q==
X-Google-Smtp-Source: AGHT+IEVsCPmZyGaaPY3tXBJ/DpyKL2KmozDoKJe2ntgMvGpD7yWUVp7uBkIQOvsd8ucbqnvSDwavA==
X-Received: by 2002:a05:6359:1b8f:b0:166:d9b8:4de6 with SMTP id ur15-20020a0563591b8f00b00166d9b84de6mr390148rwb.1.1697490715159;
        Mon, 16 Oct 2023 14:11:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b00687fcb1e609sm16008pfb.116.2023.10.16.14.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:11:54 -0700 (PDT)
Message-ID: <df197ee9-9a06-42c8-9633-896685b56328@kernel.dk>
Date:   Mon, 16 Oct 2023 15:11:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cdrom: Add missing blank lines after declarations
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
References: <20231016204741.1014-1-phil@philpotter.co.uk>
 <20231016204741.1014-2-phil@philpotter.co.uk>
 <68a2a403-ab2c-4932-a12f-1751ff6ccd77@kernel.dk> <ZS2l/R2cBqhdVNkR@equinox>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZS2l/R2cBqhdVNkR@equinox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/23 3:07 PM, Phillip Potter wrote:
> On Mon, Oct 16, 2023 at 02:53:06PM -0600, Jens Axboe wrote:
>> On 10/16/23 2:47 PM, Phillip Potter wrote:
>>> From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
>>>
>>> Add missing blank lines after declarations to fix warning found by
>>> checkpatch.pl script.
>>
>> Let's please not do this. It's fine to run checkpatch on new patches to
>> ensure that you don't make mistakes, but this is just useless churn.
>> Even worse:
>>
> Hi Jens,
> 
> So to be clear, I should not accept patches that do cleanup like this
> in future unless there are other substantive changes? I also build
> tested the patch as per normal.

Right. May be fine if actual fixes are being made, then do it as a prep
patch or something. That sometimes happens, you fix something and notice
that some styling is off and then fix that too.

>>> @@ -1202,6 +1204,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>>>  {
>>>          int ret;
>>>  	tracktype tracks;
>>> +
>>>  	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
>>>  	if (!(cdi->options & CDO_CHECK_TYPE))
>>>  		return 0;
>>
>> This int ret is using spaces and not a tab, why even make a newline
>> change and not sort that out too?
>>
> 
> Yes, good point. Given the patch only consisted of new lines though, I
> didn't think it a bad one. If this is the policy though, I will be
> stricter in future of course.

It's just pointless churn, which is the objection. Now granted for cdrom
the risk of conflict isn't that large, as it doesn't really see any
changes. But in general this is the kind of stuff that prevents stable
backports from just applying automatically. I view it similarly to
spelling fixes, and that kind of stuff. Is the style wrong? It is. But
it's not worth fixing seperately.

-- 
Jens Axboe

