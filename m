Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB9EC0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 17:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D99A2089E
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfG3R71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:59:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45954 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfG3R70 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 13:59:26 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hsWPE-0005F5-T0
        for linux-block@vger.kernel.org; Tue, 30 Jul 2019 17:59:25 +0000
Received: by mail-pf1-f200.google.com with SMTP id j22so41268767pfe.11
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 10:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rStdt81f8tuOpW8xQfJL2o59lCgPCTZV6A0fkffTtIU=;
        b=Am/IZDWgupQWLF5AbudjDJ11GgC7Cp+tHUt2Tt83H/Z7vpkJmbnQFjFpaB+Q8HOJML
         dl+MV1DKhXGOLBVWtfZMru6nk5MHk5vPstHo9rHRn2T5SQ7DaoMAD4+kD72JLFEfnmC3
         fO9q/nzbefXxEP7utuV1xxLWOroPgulJ3DNt4TepxS0ia3ipqEFg+b9htxlJQ2t0JeFE
         znkZEvfF0HDONKJl1QspxJDqqFj3n/U651vap7mwCm4onIv7m3qc/ogIE0aDKeS+E7GU
         mC3JGBEamOHTjYyEN3duoEdDlgYJbUxKC4ullFykx/YzLPyMuA/bJ7SumRtr6RUYCszq
         g1Kg==
X-Gm-Message-State: APjAAAX+jnJlG4v9wEXo1Xe+y0m1nlS+cL2ysBHckcP25QQ8ZJE6EHZe
        jHlaAEEuznXxmaNcWDRPS5ZIgxDj3f4RNrm0D5MffaTrvqWMKenT/SXCbCk5U/n3WfGib3KP7OD
        FMxwf7T+inEqps76DwcqWwsrjpFlu1iyHD7+Q3lW0
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr117732489pjl.78.1564509563592;
        Tue, 30 Jul 2019 10:59:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzeRBIKEFOlxgxMxM0hd7uN6RigG82Hmvugzh5aQit2iVArjjX+ZWjPILzbTMFMQBMAhtl3A==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr117732473pjl.78.1564509563305;
        Tue, 30 Jul 2019 10:59:23 -0700 (PDT)
Received: from 2001-b011-380f-37d3-91ca-5fad-3233-fb26.dynamic-ip6.hinet.net (2001-b011-380f-37d3-91ca-5fad-3233-fb26.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:91ca:5fad:3233:fb26])
        by smtp.gmail.com with ESMTPSA id h9sm78797928pgk.10.2019.07.30.10.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:59:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190730133607.GD28829@quack2.suse.cz>
Date:   Wed, 31 Jul 2019 01:59:20 +0800
Cc:     John Lenton <john.lenton@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
Content-Transfer-Encoding: 7bit
Message-Id: <A5D409B1-A8D2-4C06-ACA3-775594759FDE@canonical.com>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

at 21:36, Jan Kara <jack@suse.cz> wrote:

> On Tue 30-07-19 12:16:46, Jan Kara wrote:
>> On Tue 30-07-19 10:36:59, John Lenton wrote:
>>> On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
>>>> Thanks for the notice and the references. What's your version of
>>>> util-linux? What your test script does is indeed racy. You have there:
>>>>
>>>> echo Running:
>>>> for i in {a..z}{a..z}; do
>>>>     mount $i.squash /mnt/$i &
>>>> done
>>>>
>>>> So all mount(8) commands will run in parallel and race to setup loop
>>>> devices with LOOP_SET_FD and mount them. However util-linux (at least in
>>>> the current version) seems to handle EBUSY from LOOP_SET_FD just fine  
>>>> and
>>>> retries with the new loop device. So at this point I don't see why the  
>>>> patch
>>>> makes difference... I guess I'll need to reproduce and see what's  
>>>> going on
>>>> in detail.
>>>
>>> We've observed this in arch with util-linux 2.34, and ubuntu 19.10
>>> (eoan ermine) with util-linux 2.33.
>>>
>>> just to be clear, the initial reports didn't involve a zany loop of
>>> mounts, but were triggered by effectively the same thing as systemd
>>> booted a system with a lot of snaps. The reroducer tries to makes
>>> things simpler to reproduce :-). FWIW,  systemd versions were 244 and
>>> 242 for those systems, respectively.
>>
>> Thanks for info! So I think I see what's going on. The two mounts race
>> like:
>>
>> MOUNT1					MOUNT2
>> num = ioctl(LOOP_CTL_GET_FREE)
>> 					num = ioctl(LOOP_CTL_GET_FREE)
>> ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>>  - returns OK
>> 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>> 					  - acquires exclusine loop$num
>> 					    reference
>> mount("/dev/loop$num", ...)
>>  - sees exclusive reference from MOUNT2 and fails
>> 					  - sees loop device is already
>> 					    bound and fails
>>
>> It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
>> perfectly valid mount. I'll think how to fix this...
>
> So how about attached patch? It fixes the regression for me.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> <0001-loop-Fix-mount-2-failure-due-to-race-with-LOOP_SET_F.patch>


