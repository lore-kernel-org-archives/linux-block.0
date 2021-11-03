Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1EFC433F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC0E61106
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 23:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhKCXbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhKCXbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 19:31:05 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E7C06127A
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 16:28:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h2so4286748ili.11
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 16:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j1OGXGZmjG01NjS95dxUPckzXhBrb7o1XpBd0nMr2nc=;
        b=lbLk9or6fDHIDDPJUaFYf5ivCScDIniOG3xor6Stm+sQUFxAOaX7/AmUDcjO2x4qTp
         nyB8GA/AcSEc+jP5KhS0SWSzIXIIm2WLUVOa3lMpUkW8Y2MYBPJ4ok7XYxAXDaD/7Few
         w7kizo8lDGDAuDKW/0BKYbqbAhxw7S3IJLpmKbwS04H4DW1S7/CUqjB8YA4a5Bx20aMJ
         3mm/+wHlJUot+7yEir/SmMPNB72KsqscLMART4wWiIjeyjw9QUonJMxjEIGQS4T2AiBh
         L/yOVaX2ZbASxEI9ARBYPOnbGkl6aoazkiKwpJCcxRi+1Rm357KhsrE+09nHHGLfHXym
         v/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1OGXGZmjG01NjS95dxUPckzXhBrb7o1XpBd0nMr2nc=;
        b=0eiqpGe97Y4awAIe/CxHpnZfkSgd3crGvVtCmcKeuQmtexhnhTD0O84rY6nWoHmqat
         o2z3CrN6C5wJoi73cZpmLDlL1rsCxXgyjQIKhDvzjPcxKO7sas/7xq4nfdpjoPmPMPAl
         EYLy3YDwVYJWsCAEGg+u1Q5bVv+YCdFeRTnkVABfXgVPgmF0eT1m7wF5q6Z/gze57Bsj
         +iUlWzCAhe3NE7Js9pfYz1W9m8VyDm4cFoZmcjMkYakntRPLrbaonPjipCKCNhZF4+R5
         XTn7cNVoQ3h8I5TDnLTeoSOC+vt26oZkwDj9yYBYjVEQ8atbuOFsBX7gKf+0HUXmda5y
         Pj5A==
X-Gm-Message-State: AOAM531m9pZC+ePNrG5mE5OZ9TRRnC6I65FODGrFs8OYoSd6b+hY5m3X
        bXj0kP4xcrbYsR7BnNfL6E+mpA==
X-Google-Smtp-Source: ABdhPJw2vyG7lnHSAWSbIQijLL+N912mMUgH7PX4Oo6rPITk0Q1eL+1WBea9NSu51UX180Fhxk4ftg==
X-Received: by 2002:a05:6e02:1a0a:: with SMTP id s10mr3342501ild.161.1635982107352;
        Wed, 03 Nov 2021 16:28:27 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k8sm1797971iov.11.2021.11.03.16.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 16:28:26 -0700 (PDT)
Subject: Re: [nvme] f9c499bbbf: nvme nvme0: Identify Controller failed (16641)
To:     Keith Busch <kbusch@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, linux-block@vger.kernel.org, hch@lst.de
References: <20211103141454.GA30634@xsang-OptiPlex-9020>
 <e6f09b9b-386a-8a26-7c4b-c528791f7c9a@kernel.dk>
 <20211103213853.GA2654246@dhcp-10-100-145-180.wdc.com>
 <20211103214748.GA2654474@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf4c8341-591c-8207-98af-82bdfb2c1054@kernel.dk>
Date:   Wed, 3 Nov 2021 17:28:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103214748.GA2654474@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/21 3:47 PM, Keith Busch wrote:
> On Wed, Nov 03, 2021 at 02:38:53PM -0700, Keith Busch wrote:
>> On Wed, Nov 03, 2021 at 01:51:18PM -0600, Jens Axboe wrote:
>>> On 11/3/21 8:14 AM, kernel test robot wrote:
>>>>
>>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>
>>>> commit: f9c499bbbf603389abad60d1931c16b2f96dee06 ("[PATCH 1/2] nvme: move command clear into the various setup helpers")
>>>> url: https://github.com/0day-ci/linux/commits/Jens-Axboe/nvme-move-command-clear-into-the-various-setup-helpers/20211018-214956
>>>> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 519d81956ee277b4419c723adfb154603c2565ba
>>>> patch link: https://lore.kernel.org/linux-block/20211018124934.235658-2-axboe@kernel.dk
>>>>
>>>> in testcase: will-it-scale
>>>> version: will-it-scale-x86_64-a34a85c-1_20211029
>>>> with following parameters:
>>>>
>>>> 	nr_task: 50%
>>>> 	mode: process
>>>> 	test: readseek1
>>>> 	cpufreq_governor: performance
>>>> 	ucode: 0x700001e
>>>>
>>>> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
>>>> test-url: https://github.com/antonblanchard/will-it-scale
>>>>
>>>>
>>>> on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
>>>>
>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>>
>>>>
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>
>>>>
>>>> [   38.907274][  T868] nvme nvme0: pci function 0000:24:00.0
>>>> [   38.924627][ T1103] scsi host0: ahci
>>>> 0m.
>>>> [   38.948010][  T773] nvme nvme0: Identify Controller failed (16641)
>>>> [   38.951220][ T1103] scsi host1: ahci
>>>> [   38.954193][  T773] nvme nvme0: Removing after probe failure status: -5
>>>
>>> This is odd, looks like it's saying invalid opcode. Looking at the probe
>>> path, it's pretty standard and the command passed in is cleared already.
>>> So not quite sure why the patch would make a difference here. I'll
>>> poke at it.
>>
>> It's actually an Invalid Queue Identifier error (0x4101). That error
>> makes no sense for an Identify command, so it sounds like the controller
>> observed a different opcode than the driver intended to send, which
>> seems odd; I didn't observe any problems and I'm pretty sure I'm running
>> the same code. I'll take a second look as well.
> 
> The git url that was used in this test points to commit:
> 
>   https://github.com/0day-ci/linux/commit/f9c499bbbf603389abad60d1931c16b2f96dee06
> 
> And that commit has an extra memset in the REQ_OP_DRV_IN/OUT case, and
> it doesn't belong there. I don't see that memset in the upstream commit,
> Did the bot pick up the wrong patch?

Ah good catch, it's picking up a previous broken version. Good question on
why that might be, that's counter productive...

In any case, we can ignore it.

-- 
Jens Axboe

