Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9956C0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B82B2171F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CQqhWLI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbfHHNhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:37:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43467 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbfHHNhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:37:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so36560581pld.10
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f6C9KV9j+sL4/xH9R5I+DwXY8i4rM+vp2A30pHRGL78=;
        b=CQqhWLI3bbv/IzA52hkpRfGe5CWLRoEeF/tmUktp6vVIUwdnid8o6CHYXu8zIMl6gb
         YAeHCngjD8pgfF2p/rmAeSHjYXOp7eaWm0YCYM5rgNmCVqyBdD86D57jFx5H8dNDt2Qu
         MIIaf9HEsYNSKkbMjlEDi/Ibyh3ZGS3plDbgz9TRTu3M2m+d6yIqk72dP8y8mwXD6MDb
         aXElrXtcbS1M+zY7yGqcTnzSrf1IM0BaaaGizDRXrQKQ1AsrLcGVAjB9i0TS2upWM7xn
         R0CRBrAHv87foNLGHWDQkGCTDMHlRqndagLlONtG1dEYEsUbhfLGUB0SDfqurfGropYG
         SXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6C9KV9j+sL4/xH9R5I+DwXY8i4rM+vp2A30pHRGL78=;
        b=ipsEIssrmw8H1Cz0iuru4O+xawdKvUav/U08r+PpvZ7ioVjcEPixr4aoPFehIx/ML4
         j+AX43VmUmirvRW8H4A64iCT1OeHnHxAnfMs8Tetp5e9/eq9LZ1WXw+fqkqoc3chP+z/
         kgl4iffl8Hmj/t4Ghrk9fjMqo16foqVcMZcVtDE/eEHmC3atWpCRIAuhbhwNn+VBBVlu
         E59ogH3rmbMLz8aODhDm8wp8xkWjHreJMiiOi/z2jlmuzp2kR81TD1kUp27E+sP6a3en
         4tPbP0J1P2UaLvJyaemy0ENmQFoasqCZcBuykmBKqRGvmDT4U3LnGxS0k9Awv1N/HTWJ
         1ZZw==
X-Gm-Message-State: APjAAAUo8A11dWHWSpjcDOUs237ML+TIPCXrYQ2HrZ4NXcKIlOxgCfOo
        tnhqS8qNagjJFoEXNXrXgDF5Hw==
X-Google-Smtp-Source: APXvYqwMv1Zib2rOBZtQP7V4T0SixC03YEbTHFtqifzaHKtE0h3XbaIpSr8v3KE39fZcsagfJC7PPg==
X-Received: by 2002:a17:902:449:: with SMTP id 67mr14133427ple.105.1565271453972;
        Thu, 08 Aug 2019 06:37:33 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id w4sm118574237pfn.144.2019.08.08.06.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:37:32 -0700 (PDT)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>
Cc:     John Lenton <john.lenton@canonical.com>,
        Kai-Heng Feng <kaihengfeng@me.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
 <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
 <20190807094520.GB14658@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8935c19-8003-d9ee-a78d-2b305527da68@kernel.dk>
Date:   Thu, 8 Aug 2019 06:37:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807094520.GB14658@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 2:45 AM, Jan Kara wrote:
> On Mon 05-08-19 09:41:39, Bart Van Assche wrote:
>> On 7/30/19 6:36 AM, Jan Kara wrote:
>>> On Tue 30-07-19 12:16:46, Jan Kara wrote:
>>>> On Tue 30-07-19 10:36:59, John Lenton wrote:
>>>>> On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
>>>>>>
>>>>>> Thanks for the notice and the references. What's your version of
>>>>>> util-linux? What your test script does is indeed racy. You have there:
>>>>>>
>>>>>> echo Running:
>>>>>> for i in {a..z}{a..z}; do
>>>>>>       mount $i.squash /mnt/$i &
>>>>>> done
>>>>>>
>>>>>> So all mount(8) commands will run in parallel and race to setup loop
>>>>>> devices with LOOP_SET_FD and mount them. However util-linux (at least in
>>>>>> the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
>>>>>> retries with the new loop device. So at this point I don't see why the patch
>>>>>> makes difference... I guess I'll need to reproduce and see what's going on
>>>>>> in detail.
>>>>>
>>>>> We've observed this in arch with util-linux 2.34, and ubuntu 19.10
>>>>> (eoan ermine) with util-linux 2.33.
>>>>>
>>>>> just to be clear, the initial reports didn't involve a zany loop of
>>>>> mounts, but were triggered by effectively the same thing as systemd
>>>>> booted a system with a lot of snaps. The reroducer tries to makes
>>>>> things simpler to reproduce :-). FWIW,  systemd versions were 244 and
>>>>> 242 for those systems, respectively.
>>>>
>>>> Thanks for info! So I think I see what's going on. The two mounts race
>>>> like:
>>>>
>>>> MOUNT1					MOUNT2
>>>> num = ioctl(LOOP_CTL_GET_FREE)
>>>> 					num = ioctl(LOOP_CTL_GET_FREE)
>>>> ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>>>>    - returns OK
>>>> 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>>>> 					  - acquires exclusine loop$num
>>>> 					    reference
>>>> mount("/dev/loop$num", ...)
>>>>    - sees exclusive reference from MOUNT2 and fails
>>>> 					  - sees loop device is already
>>>> 					    bound and fails
>>>>
>>>> It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
>>>> perfectly valid mount. I'll think how to fix this...
>>>
>>> So how about attached patch? It fixes the regression for me.
>   
> Hi Bart,
> 
>> A new kernel warning is triggered by blktests block/001 that did not happen
>> without this patch. Reverting commit 89e524c04fa9 ("loop: Fix mount(2)
>> failure due to race with LOOP_SET_FD") makes that kernel warning disappear.
>> Is this reproducible on your setup?
> 
> Thanks for report! Hum, no, it seems the warning doesn't trigger in my test
> VM. But reviewing the mentioned commit with fresh head, I can see where I
> did a mistake during my conversion of blkdev_get(). Does attached patch fix
> the warning for you?

I've queued this up, Jan. Thanks for taking a look at it.

-- 
Jens Axboe

