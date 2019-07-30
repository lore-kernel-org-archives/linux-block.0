Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D016C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 19:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD702064A
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OPWRgzjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfG3TRc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:17:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44855 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3TRc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 15:17:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so30308814pfe.11
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKRXaVDJSlU0T4/Xl0oCkA1iiCA/fnQS0EqE4w9u64k=;
        b=OPWRgzjsLGmbAteShLjmHurJDIYCUd941DBG145EV21g48qnQi+Bq9ieB9ly9vZ3yZ
         yuM1AObHKLlfObnby2F0av4p6G+1w1yJ23IPr8VobV5fhvz8REUSTh9Wm+E1Z7JKsbXJ
         DNi3QDvCLDAmrUk5sYTHzY5QzqkpzF6o5Q13K5Gy66Q9M+X49iAQqjBxd7H/BhDAqf/m
         HqSnhyXLW0YDfcHCznSfqXPJEW7ETcWNfazTtaslGJlOYnO3i6DF4ZU1JeG8VT3uQUMm
         X4tJ20TNIqjTJgK6gyFaeCokmdaBY3TG1iId+xqmM5dT2ZCFc5FaXUeln3uJNXNU+aXw
         ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKRXaVDJSlU0T4/Xl0oCkA1iiCA/fnQS0EqE4w9u64k=;
        b=bQc/K7NdA8a7Imc6UUsE99SO8ylX/f/gBxTnA2faJmJUHARpGrStSJWw3yQmti1Yln
         dhmHYneiEqXhAll5LPij1ovx3tuxvnlE/CzzkrqA6Z9b/DL8exEulnmP5D7sUSU4fNPo
         /323G7gwPxSA3ia0yLoNPwHWta9y/sBEb8a1Vfpkex07dOJA5wBC5jOgF5kq8hEI8I64
         qH3roQQuQ1MPesJxkpN1hUWjII6RxcROg9H3XIPwqcUhj8gJcITY9oRctDzb4fsdhoxQ
         jVouQNJUfLFBa61ASdqNWPMAMbyozBi3KiAE/ts/jvq1aOhijv/sYrch0T6fWrgaJ/NM
         u1AQ==
X-Gm-Message-State: APjAAAX1sesrWDt/pSq/JoamEZ59DsQlbnWM4zmxNlUlWPkRH5H9h6W5
        Psinl3dW6dCQ73MGcPEms5Y=
X-Google-Smtp-Source: APXvYqyR9Yl+gC2FiZHCRvN4GMa+r9UUsNkz4xdMawyq5rNKbXtlttCA36fNlTNlfDGr+rgco+SoOg==
X-Received: by 2002:aa7:8202:: with SMTP id k2mr44189502pfi.31.1564514251623;
        Tue, 30 Jul 2019 12:17:31 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g1sm106835922pgg.27.2019.07.30.12.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:17:30 -0700 (PDT)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>, John Lenton <john.lenton@canonical.com>
Cc:     Kai-Heng Feng <kaihengfeng@me.com>,
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <009a7a06-67c5-6b3c-5aa3-7d67ca35fc3a@kernel.dk>
Date:   Tue, 30 Jul 2019 13:17:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730133607.GD28829@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/19 7:36 AM, Jan Kara wrote:
> On Tue 30-07-19 12:16:46, Jan Kara wrote:
>> On Tue 30-07-19 10:36:59, John Lenton wrote:
>>> On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
>>>>
>>>> Thanks for the notice and the references. What's your version of
>>>> util-linux? What your test script does is indeed racy. You have there:
>>>>
>>>> echo Running:
>>>> for i in {a..z}{a..z}; do
>>>>      mount $i.squash /mnt/$i &
>>>> done
>>>>
>>>> So all mount(8) commands will run in parallel and race to setup loop
>>>> devices with LOOP_SET_FD and mount them. However util-linux (at least in
>>>> the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
>>>> retries with the new loop device. So at this point I don't see why the patch
>>>> makes difference... I guess I'll need to reproduce and see what's going on
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
>>   - returns OK
>> 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
>> 					  - acquires exclusine loop$num
>> 					    reference
>> mount("/dev/loop$num", ...)
>>   - sees exclusive reference from MOUNT2 and fails
>> 					  - sees loop device is already
>> 					    bound and fails
>>
>> It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
>> perfectly valid mount. I'll think how to fix this...
> 
> So how about attached patch? It fixes the regression for me.

Jan, I've applied this patch - and also marked it for stable, so it'll
end up in 5.2-stable. Thanks.

-- 
Jens Axboe

