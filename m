Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F0C433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6125261361
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 17:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEKRJV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhEKRJU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 13:09:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E250BC061574
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 10:08:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s20so25334089ejr.9
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3zmcfRb1uJElYtXfgojT5h84reMoSiWpEZHR7ZUYa/c=;
        b=aQdSkiqvee4KkfS8RFWgm+rjiOvJ8hqk4bEkSRtJhSg9G0nBpcojSpWp+XnspGj7U8
         SQd4iHfBezijlAxbL41XGlOGs+LGBqpH0e2lFy0tHiJBe/oi+6bre5g99b0bpon3V/P/
         L580ulFSivOhekn2LAOTiDjTCKvehBzxffDAAgXMHPnS1TH1A38seuwdvJnIpFSyE3VC
         Z8Q3BJAN4ewSP5lJCs5BGKMeFEyCDsz2Mtm9bpqKIP95qNr0I65MnLYJEXyMCx0mZlTQ
         l7cp6icnFOGT34nlql0+taOzVoAZQMgERhoeAsFieUtiypJzAG/Pds0HHJzmhExi/Uiy
         yp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3zmcfRb1uJElYtXfgojT5h84reMoSiWpEZHR7ZUYa/c=;
        b=NwusldQ624p1o2EDAlHRpxQ/i1jlHYFAQRLkETA1dJog8MMANMkerf+b562jFFD4iW
         S6lv8Cy9KfTx3kw9XV30mV+uG/MZobFcrxqBnrUlNT2nMXiT9TqOvYfYHQUbs49gc8hR
         cpY5xpw7qViFWOcqq11JKsN/7JVYZqaCN7YwnaTiIO48XIm+ETnl7tXV9sdpbDqMHLZ/
         Jk6R2izD09tAT+WJJasm2hmWOQLqWFuRHM4/PVu/I7nFbCGmCgZ1CFezLjC9gUR8bJvX
         5d3p0ZkVhYCgW1r1Dmh9gvumZir5/+z8f1wOpF8Pp2sFaUOlucSdeqsyrLHJWHhfY3qe
         bLpw==
X-Gm-Message-State: AOAM5317VSnASwJ5+EYIL7/31E/qDFJXYM4ced+Y4u0WDMOkccIss2sB
        ikPIHySkaETdmSW1ZcRAkYRm/g==
X-Google-Smtp-Source: ABdhPJy2X07bo4kK8O0opXu6MjSuY5Vr09im773qYHP6tf0/nXW61EBtntCWjeVHK8l57/D5uzIYOQ==
X-Received: by 2002:a17:906:71d8:: with SMTP id i24mr32873908ejk.444.1620752892578;
        Tue, 11 May 2021 10:08:12 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v12sm15565125edb.81.2021.05.11.10.08.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 10:08:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAHj4cs_4jPzoZWcuio+jQig4GARVfMac9h=0TyYCiQYqXmXUyQ@mail.gmail.com>
Date:   Tue, 11 May 2021 19:10:22 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        Xiong Zhou <xzhou@redhat.com>, Li Wang <liwan@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE809A3F-9AAA-4289-BED4-74F67361B71F@linaro.org>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
 <4F41414B-05F8-4E7D-A312-8A47B8468C78@linaro.org>
 <c7d23258-0890-f79f-cc6a-9cb24bbaa437@redhat.com>
 <CAHj4cs9+q-vH9qar+MTP-aECb2whT7O8J5OmR240yss1y=kWKw@mail.gmail.com>
 <B657F0B6-E999-467B-98CB-56C29B04B8F3@linaro.org>
 <F22E9AB1-06EE-4A66-833A-16C3AD1FFF18@linaro.org>
 <CAHj4cs_4jPzoZWcuio+jQig4GARVfMac9h=0TyYCiQYqXmXUyQ@mail.gmail.com>
To:     Yi Zhang <yi.zhang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 7 mag 2021, alle ore 10:30, Yi Zhang <yi.zhang@redhat.com> =
ha scritto:
>=20
> On Mon, May 3, 2021 at 5:35 PM Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>=20
>>=20
>>=20
>>> Il giorno 20 apr 2021, alle ore 09:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>>=20
>>>=20
>>>> Il giorno 20 apr 2021, alle ore 04:00, Yi Zhang =
<yi.zhang@redhat.com> ha scritto:
>>>>=20
>>>>=20
>>>> On Wed, Apr 7, 2021 at 11:15 PM Yi Zhang <yi.zhang@redhat.com> =
wrote:
>>>>=20
>>>>=20
>>>> On 4/2/21 9:39 PM, Paolo Valente wrote:
>>>>>=20
>>>>>> Il giorno 1 apr 2021, alle ore 03:27, Yi Zhang =
<yi.zhang@redhat.com> ha scritto:
>>>>>>=20
>>>>>> Hi
>>>>> Hi
>>>>>=20
>>>>>> We reproduced this bfq regression[3] on ppc64le with blktests[2] =
on the latest linux-block/for-next branch, seems it was introduced with =
[1] from my bisecting, pls help check it. Let me know if you need any =
testing for it, thanks.
>>>>>>=20
>>>>> Thanks for reporting this bug and finding the candidate offending =
commit. Could you try this test with my dev kernel, which might provide =
more information? The kernel is here:
>>>>> https://github.com/Algodev-github/bfq-mq
>>>>>=20
>>>>> Alternatively, I could try to provide you with patches to =
instrument your kernel.
>>>> HI Paolo
>>>> I tried your dev kernel, but with no luck to reproduce it, could =
you
>>>> provide the debug patch based on latest linux-block/for-next?
>>>>=20
>>>> Hi Paolo
>>>> This issue has been consistently reproduced with =
LTP/fstests/blktests on recent linux-block/for-next, do you have a =
chance to check it?
>>>=20
>>> Hi Yi, all,
>>> I've been working hard to port my code-instrumentation layer to the =
kernel in for-next. I seem I finished the porting yesterday. I tested it =
but the system crashed. I'm going to analyze the oops. Maybe this freeze =
is caused by mistakes in this layer, maybe the instrumentation is =
already detecting a bug. In the first case, I'll fix the mistakes and =
try the tests suggested in this thread.
>>>=20
>>=20
>> Hi Yi, all,
>> I seem to have made it.  I've attached a patch series, which applies
>> on top of for-next, as it was when you reported this failure (i.e., =
on
>> top of 816e1d1c2f7d Merge branch 'for-5.13/io_uring' into for-next).
>> If patches are to be applied on top of a different HEAD, and they
>> don't apply cleanly, I'll take care of rebasing them.
>>=20
>> Of course I've tried your test myself, but with no failure at all.
>>=20
>> Looking forward to your feedback,
>> Paolo
>>=20
> Hi Paolo
>=20
> With the patch series, blktests nvme-tcp nvme/011 passed on
> linux-block/for-next, thanks.
>=20

Great!

That series contained only one fix.  I do hope that it has been that
fix to eliminate the failure.

So I'm about to propose such a fix as an individual patch for
mainline.  Please test it if you can.

Thanks,
Paolo

> Thanks
> Yi

