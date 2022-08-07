Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F758C19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 07:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiHGHhs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 03:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHGHhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 03:37:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E01E0A1
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 00:37:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so11623627ejc.1
        for <linux-block@vger.kernel.org>; Sun, 07 Aug 2022 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2tTk7KPbk5a0ODn5yTstWIPgCZZT6VooBB34NjkKZvU=;
        b=TSErcheVsZMoCtJ/UDqsaizGph0ZxzfhHZj/xOBIJhMtd1SuuIOCzVJWwLtBIL+QDL
         0qVyKRgcNlIVJiQ3dK39TrCzqkAc1l3icYnIictrlF8tY3Crb4IjmlERjxAwXhAhtAuL
         ghQxsbmDHc5ac5barajEVhzdrF08YyshTyoyJ2kRS5QYam4136aEUgKGYZDzMEuSeE9Z
         jWbHUI6oj4Iafws5vpX62GhgvaMlztbwOelN7MLe/FYlZrYN3ithxKOxoxkxA0dJ0JyN
         wAnw2ico2YJ/x4vyKOXCjQdZ3erLkzlFwTNi6cm41VfnmvgVvx3HrRpzt6oWFzixCslI
         0VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2tTk7KPbk5a0ODn5yTstWIPgCZZT6VooBB34NjkKZvU=;
        b=LJicAcHUIJhyYGnlsuKJmyZgYOB5lmOhWJ5hlMBQ/2ULJQdejnh6b3GGmrM3Y2SVag
         D3bnmaWmsiqTmeondcR4DU1w4y6HHPxFE0XBxzSUJjRH2B+COJLYDLzrGaeZv2+/Cip9
         OgsmIi063MWldnqaJs/zD4XmnnhpVmsSulxQuqzwtyMztn8AANJ5rJf4RH11MsPw2zgo
         m8Rx0xebzSisCPfj2noiZd4tLxnALbbGZiznZ9M6B8dCg4leBK0d5f9lgcPlfZym+JZD
         xkwQRESoIipFiuZFuA8awd+kkNbjjDrz7CCBp0YR9Deaj/womja4ckO/7+gGrvDc0YTI
         KepA==
X-Gm-Message-State: ACgBeo0Hi+bIFa7SGZwZs4Yql0XZjdsswq9OzTz/MPv+3ZmUeGguCqiD
        obHHTtMfVT+qSQ7sHe+G0Vw=
X-Google-Smtp-Source: AA6agR7on5CPYQbc2HorCagWm2setsQfuFUI6wus9ckKp/+QbDT092Q0Svm/NqfU3mjpB6xyImE0dQ==
X-Received: by 2002:a17:906:6a02:b0:730:9f44:2bff with SMTP id qw2-20020a1709066a0200b007309f442bffmr10154177ejc.209.1659857861898;
        Sun, 07 Aug 2022 00:37:41 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0072f9e7ce354sm3530089ejc.139.2022.08.07.00.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 00:37:41 -0700 (PDT)
Message-ID: <99e17678-8801-ac41-de20-a5f6f60da524@gmail.com>
Date:   Sun, 7 Aug 2022 09:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [git pull] Additional device mapper changes for 6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com> <Yu1rOopN++GWylUi@redhat.com>
 <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
 <Yu6zXVPLmwjqGg4V@redhat.com>
 <CAHk-=wj+ywtyBEp7pmEKxgwRE+iJBct6iih=ssGk2EWqaYL_yg@mail.gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <CAHk-=wj+ywtyBEp7pmEKxgwRE+iJBct6iih=ssGk2EWqaYL_yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Just a few notes on why we use target versions in libcryptsetup,
as I am perhaps one user of this field there.

TL;DR: it is *only* for hinting to users what is possibly wrong
after activation fails because there is *no* proper error reporting
from the device-mapper.

On 06/08/2022 20:36, Linus Torvalds wrote:
> On Sat, Aug 6, 2022 at 11:30 AM Mike Snitzer <snitzer@kernel.org> wrote:
...
>> Yes, I know you mentioned this before and I said I'd look to switch to
>> feature bitmasks. Yet here we are. Sorry about that, but I will take
>> a serious look at fixing this over the next development cycle(s).

Please don't just replace it with bitmaps.

It will not bring any better interface while adding more magic with
handling compatibility, as we need to use both... see below.

> Well, right now we're in the situation where there are certain kernels
> that say that they implement "version 1.9" of the thing, but they
> don't actually implement the "version 1.8.1" extensions.

I cannot speak for the others, but for veritysetup (libcryptsetup),
the worst that can happen is that the user will get a wrong error message
(or just a generic message "something failed, bye").
(All the crypto options are tricky, I would like to keep at least basic
usability and better errors like "seems tasklets are not supported,
retrying without tasklets flags.")

In principle, we use activation flags/options as Linus describes - try
to set it, then deal with the failure.

And *this* is the real problem that needs to be solved - there is no proper
userspace interface that says what went wrong.

The userspace sees only -EINVAL from ioctl() and a generic message.

Perhaps in the syslog is more info, but usually only at debug level
(that is often not visible), and parsing syslog is not the option for us either.

What is even more problematic is that the error string in DM target is
often set (e.g. ti->error = "Integrity profile tag size mismatch.";) but later
discarded, and it never reaches neither log nor userspace calling the failing
ioctl().

If the device-mapper can fix this, we can easily thrash the magic that
consults the target version and determines what went wrong.

Then you can forget the version and feature bitmaps and send
us a proper (ideally structured) error message in ioctl() reply.

Milan
