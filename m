Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F56C43444
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F302086D
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eCasF6U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfANN0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:26:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfANN0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 08:26:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so10344721pfk.10
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aubFD5Gq1gq/mvCOyz5wzJwe55pl3rSMUOZl6C6NQGM=;
        b=eCasF6U/w30uMpy2O/9TVNs2Z2uMsSytK69FvPCCe+fff4Bfd/9JNBRAb6ai7/rs7K
         4KOxMHQpmUtRoL9SmXNg+zE1mkMsegycBiCYl7DAYKumgoU4xl/v1buw44bosj1U0G18
         PS2avHyCcLzCCWeqTPYDwFQBES9BpzGZS/pou5A/sDovRbXJNJlpc4k7aDb5Bn76EXuL
         Hlg3LiL4er0eax7ftcJEmPu9FXrJwnN+eIfBJMOsLly2cOQPGZKpc8JEJ8L29yh4IUJO
         SU+WVrj56wrwUCCR5exeKFke6sd0OuSgst/K4KWq2oJE8m9oAN13MbZg3AYBEHCgVzU4
         j0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aubFD5Gq1gq/mvCOyz5wzJwe55pl3rSMUOZl6C6NQGM=;
        b=URBwxdqLmZm5xSZtaFCRE8KCsQdhE78YknhMPVxc8DVhWqJ48OaPXwTpKEbdIw9NRH
         9bxORvrU0qPKB8gxrcxokGdwRZ7dsfOTYqaeP1Ehk+Sx3boo4xDsiIg14qYcW4jgUqVR
         BO7lvNZUhLuM/Rbvc+umoeVRWzvMQOpWEPGkDJ/aUhOsCgOUPZo4UXBpifTmvbxYfm7X
         Bfv7XUgOCSQ4ieF/bHy2oSECmWcogRvWrg8LsH4LgTi814iuBw6pk5VwPRQsko1oeqHB
         eITVczuRm4KaphdcR1MvBNZ4aZos0nl3X3A+CiR35r6YoFddnb35eSepGbpW889VmVED
         dQ9w==
X-Gm-Message-State: AJcUukcQE8fYPzvUb77lSpjEsjGvQuM+E2ILrmtLNztco5XQLsjPFVKF
        TbhIqUj8B6AujuH/QiP0lqE6lQ==
X-Google-Smtp-Source: ALg8bN6spBFlTlaRU8DbIwhfRmuBtRDRr2lxpsmxwpLglDOfooxOj4I7osPpgRQC+NCiF3vAedPirA==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr21434916pgv.368.1547472373273;
        Mon, 14 Jan 2019 05:26:13 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m19sm1024468pgn.35.2019.01.14.05.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:26:12 -0800 (PST)
Subject: Re: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of
 throughput
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it
References: <20181206181819.11148-1-paolo.valente@linaro.org>
 <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
 <8753C347-2BFD-40D4-A97E-DA955BC0207C@linaro.org>
 <16d4065e-c0d1-7a85-3d9a-242bfd92923e@kernel.dk>
 <F7FF3405-74FF-40C3-8C0E-12108170CEF0@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cfe7c5d1-040a-33a7-bb63-ac591c6eec14@kernel.dk>
Date:   Mon, 14 Jan 2019 06:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <F7FF3405-74FF-40C3-8C0E-12108170CEF0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 2:09 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 7 dic 2018, alle ore 15:40, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 12/7/18 3:01 AM, Paolo Valente wrote:
>>>
>>>
>>>> Il giorno 7 dic 2018, alle ore 03:23, Jens Axboe <axboe@kernel.dk> ha scritto:
>>>>
>>>> On 12/6/18 11:18 AM, Paolo Valente wrote:
>>>>> Hi Jens,
>>>>> the first patch in this series fixes an error in the decrementing of
>>>>> the counter of the number of groups with pending I/O. This wrong
>>>>> decrement caused loss of throughput or, less likely, of control on
>>>>> I/O. The second patch is a fix of some wrong comments, which somehow
>>>>> contributed to making the above bug more difficult to find.
>>>>
>>>> Are you fine with this going into 4.21? I can't quite tell what your
>>>> intent is. The first patch has a Fixes for something
>>>
>>> yep, that fixes a serious error.
>>>
>>>> that went into
>>>> this series, but then patch 2 is a comment update that would not
>>>> normally be something to be applied at this stage.
>>>>
>>>
>>> and yes, only comments changed by the second one
>>>
>>> May it make sense to apply them in two steps, one in the 4.20 and the other one in the 4.21?
>>
>> I think so, I'll do that.
> 
> Hi Jens,
> is the second patch still queued?

That got dropped for some reason, I've applied it now.

-- 
Jens Axboe

