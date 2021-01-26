Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADEC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570532311B
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391793AbhAZMp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:45:56 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46613 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391811AbhAZJ77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 04:59:59 -0500
Received: by mail-lj1-f179.google.com with SMTP id u11so18747283ljo.13;
        Tue, 26 Jan 2021 01:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xmi28xkvyUxUdMMISjflxCIU4Qrn8nItoYK8w0cV+yo=;
        b=bRY/0HP03LiNPTEXh22HhrXTz0OC2a/vwjixT3b5LyjDcGESWgWt7vXW9CSOx5rDN5
         P9MqYeW/1m9iCwbFHJbMWQ6P+lzNcWqEMXpGSwoWePUBC35cr4+5d8raMUVp827uv1NN
         bUdic2wN7R563Y3Afzh0GjsPX1lFt+k2nOMkMK2nYjJ9LiSAeFoG1Nczuoz4xkYzkKTU
         AoDfPXsxBPBB8/dzylMkj9z1s2ioQ4oPy6BDOS+E6f0O/QTudiDhKdvHOIO0PH1FH5ym
         EGZJKy8D8/6ZMFFnS/46C0vQmO0gTbUk2ypjzfByXqwReaiilygAwyhuxVpklVO/OpqV
         NDBw==
X-Gm-Message-State: AOAM530+PG0CX3Su6fWIif/fvM5EE/65ybbwDhpcNdRCtcQC0ospU/7s
        K2rts4UxtKCl617gAM0KanbFBEo1WQg=
X-Google-Smtp-Source: ABdhPJyLbthDt9qZuqRBd6OcRqpdtZTjkEa/7t5StwY1UpUD0WLMlYqsFA9p+pmJOsXRvHZwDvkehA==
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr2540175ljo.161.1611655150121;
        Tue, 26 Jan 2021 01:59:10 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id r9sm779650lfm.69.2021.01.26.01.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:59:09 -0800 (PST)
Subject: Re: [PATCH] floppy: reintroduce O_NDELAY fix
To:     Kurt Garloff <kurt@garloff.de>, Jiri Kosina <jikos@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Wim Osterholt <wim@djo.tudelft.nl>
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
 <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
 <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
 <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm>
 <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
 <nycvar.YFH.7.76.2101211603590.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101221209060.5622@cbobk.fhfr.pm>
 <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
 <f822ebde-89d6-dbbf-ae4e-b06a4aadedf5@garloff.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <baf2391f-be61-90b3-9f01-db769d288576@linux.com>
Date:   Tue, 26 Jan 2021 12:59:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f822ebde-89d6-dbbf-ae4e-b06a4aadedf5@garloff.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/26/21 12:31 PM, Kurt Garloff wrote:
> Hi Denis, Jiri, Jens,
> 
> Am 26.01.21 um 09:21 schrieb Denis Efremov:
>> On 1/22/21 2:13 PM, Jiri Kosina wrote:
>>> From: Jiri Kosina <jkosina@suse.cz>
>>>
>>> This issue was originally fixed in 09954bad4 ("floppy: refactor open() 
>>> flags handling").
>>>
>>> The fix as a side-effect, however, introduce issue for open(O_ACCMODE) 
>>> that is being used for ioctl-only open. I wrote a fix for that, but 
>>> instead of it being merged, full revert of 09954bad4 was performed, 
>>> re-introducing the O_NDELAY / O_NONBLOCK issue, and it strikes again.
>>>
>>> This is a forward-port of the original fix to current codebase; the 
>>> original submission had the changelog below:
>>>
>>> ====
>>> Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
>>> side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
>>> this is being used setfdprm userspace for ioctl-only open().
>>>
>>> Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE) 
>>> modes, while still keeping the original O_NDELAY bug fixed.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
>>> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
>>> Reported-and-tested-by: Kurt Garloff <kurt@garloff.de>
>>> Fixes: 09954bad4 ("floppy: refactor open() flags handling")
>>> Fixes: f2791e7ead ("Revert "floppy: refactor open() flags handling"")
>>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>> Applied. I'll send it to Jens soon with a couple of cleanup patches.
>>
>> https://github.com/evdenis/linux-floppy/commit/e32f6163c47efbdbad06258560aa00d1c7e5b699
> 
> Great, thanks.
> 
> Due to libblkid (rightfully) using O_NONBLOCK these days when probing
> devices, the floppy driver does spit loads of
> [    9.533513] floppy0: disk absent or changed during operation
> [    9.534989] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    9.537206] Buffer I/O error on dev fd0, logical block 0, async page read
> [    9.546837] floppy0: disk absent or changed during operation
> [    9.548389] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1
> and fails a mount prior to being opened without O_NONBLOCK at least once.
> (Reproduction is easy with qemu-kvm.)
> 
> The patch addresses it and I would suggest it to also be backported and
> applied to the active stable kernel trees.

Yes, it will be backported to all stable trees including v4.4

Thanks,
Denis
