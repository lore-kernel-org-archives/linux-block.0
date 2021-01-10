Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2C2C433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A8D23B08
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbhAJJYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbhAJJYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:24:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C428C06179F
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:23:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g185so12167451wmf.3
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+sEfYXmXjJwM3bkWoryOChmoDQfx+t0d4+2es3SsFiE=;
        b=IcqlE3IZFPlNeok9bmULJsnVxEgNLVpIb/htaUiZAVW6CaEvz956H918W94HKc5PGy
         fEbBz+5oGnvDZjUZTbuDOKOlw7dKXoMFbvsDKucCCWHIpwiOvwtCTsBepP7o4Eih3VOh
         KI7DH7yhAU8yoGmy4HMLjDeAq1j7DYO80HrzTXX6Yj/oQe5WtdzY0fSJ3xvnGu7iTTG4
         chllB2qMgFhZGzTudhnsp2OCnu5ss5WvUi1YR+mxOFXN+keOQlMt98i2S/yHlyt7JnvJ
         m/syPbz65YWUcLfXHml2nmo47FYoj4WCSHaDJ7Z3a+Zl5Z1crsUPGs0l1490JeJyAcA5
         bI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+sEfYXmXjJwM3bkWoryOChmoDQfx+t0d4+2es3SsFiE=;
        b=nR/+RSq9wCKEkaTf4BglNZYN1QePuYoTJjIdiRb7OY3CuKQV8QMZHe9QKZv82BG+Eb
         XFT3260zguVyjyYQ/W5hgvJHuzo4ZPjz058Opvbqb5mRQa5xJNPEeH/kfExFfaazHpGy
         U7RR/AtZWFp7UkhBP6s+EtPbqk1fLZdB7rfUYVezkvBUTFaGCQE8o8FndjbcG+Y2sQ/8
         bJrSHLGZgA+K1ImbQdya3oEHiav7JbXT/BnNUwE/kYI13W5K4WW6zoZtntcrpjn+Sjag
         KujZznmzytbnJ/wTRtZHncOT6qrfPHSt7AjjHu4mCs4K1goKXgYTSnvEuJgbfIqtumBF
         8NeQ==
X-Gm-Message-State: AOAM53099BWUCDobg88143lygPdCNeHNQdftjyRnV4rz4AC+7Dr0GiLi
        5QU78C/N7CMgloJpCljQ9TdjE5tW0LlAML0F
X-Google-Smtp-Source: ABdhPJyNrD+PEC91Xw378+kSVDJ7725PdYvtenSGeFLWQC/G+g/R1VU78qRZPzlsyNDVmbnMlnGoeA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr10107623wmj.52.1610270629013;
        Sun, 10 Jan 2021 01:23:49 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id u66sm18359292wmg.30.2021.01.10.01.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 01:23:48 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] bfq: Use only idle IO periods for think time
 calculations
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200902151717.GA4736@quack2.suse.cz>
Date:   Sun, 10 Jan 2021 10:23:47 +0100
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB611C75-B2D5-4B0B-AA05-8F38E5AA96D7@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-3-jack@suse.cz>
 <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
 <20200611143912.GC19132@quack2.suse.cz>
 <7BE4BFD7-F8C1-49DE-A318-9E038B9A19BC@linaro.org>
 <20200727073515.GA23179@quack2.suse.cz>
 <20200826135419.GF15126@quack2.suse.cz>
 <20200902151717.GA4736@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 2 set 2020, alle ore 17:17, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Wed 26-08-20 15:54:19, Jan Kara wrote:
>> On Mon 27-07-20 09:35:15, Jan Kara wrote:
>>> On Wed 22-07-20 11:13:28, Paolo Valente wrote:
>>>>> a) I don't think adding these samples to statistics helps in any =
way (you
>>>>> cannot improve the prediction power of the statistics by including =
in it
>>>>> some samples that are not directly related to the thing you try to
>>>>> predict). And think time is used to predict the answer to the =
question: If
>>>>> bfq queue becomes idle, how long will it take for new request to =
arrive? So
>>>>> second and further requests are simply irrelevant.
>>>>>=20
>>>>=20
>>>> Yes, you are super right in theory.
>>>>=20
>>>> Unfortunately this may not mean that your patch will do only good, =
for
>>>> the concerns in my previous email.=20
>>>>=20
>>>> So, here is a proposal to move forward:
>>>> 1) I test your patch on my typical set of
>>>>   latency/guaranteed-bandwidth/total-throughput benchmarks
>>>> 2) You test your patch on a significant set of benchmarks in =
mmtests
>>>>=20
>>>> What do you think?
>>>=20
>>> Sure, I will queue runs for the patches with mmtests :).
>>=20
>> Sorry it took so long but I've hit a couple of technical snags when =
running
>> these tests (plus I was on vacation). So I've run the tests on 4 =
machines.
>> 2 with rotational disks with NCQ, 2 with SATA SSD. Results are mostly
>> neutral, details are below.
>>=20
>> For dbench, it seems to be generally neutral but the patches do fix
>> occasional weird outlier which are IMO caused exactly by bugs in the
>> heuristics I'm fixing. Things like (see the outlier for 4 clients
>> with vanilla kernel):
>>=20
>> 		vanilla			bfq-waker-fixes
>> Amean 	1 	32.57	( 0.00%)	32.10	( 1.46%)
>> Amean 	2 	34.73	( 0.00%)	34.68	( 0.15%)
>> Amean 	4 	199.74	( 0.00%)	45.76	( 77.09%)
>> Amean 	8 	65.41	( 0.00%)	65.47	( -0.10%)
>> Amean 	16	95.46	( 0.00%)	96.61	( -1.21%)
>> Amean 	32	148.07	( 0.00%)	147.66	( 0.27%)
>> Amean	64	291.17	( 0.00%)	289.44	( 0.59%)
>>=20
>> For pgbench and bonnie, patches are neutral for all the machines.
>>=20
>> For reaim disk workload, patches are mostly neutral, just on one =
machine
>> with SSD they seem to improve XFS results and worsen ext4 results. =
But
>> results look rather noisy on that machine so it may be just a =
noise...
>>=20
>> For parallel dd(1) processes reading from multiple files, results are =
also
>> neutral all machines.
>>=20
>> For parallel dd(1) processes reading from a common file, results are =
also
>> neutral except for one machine with SSD on XFS (ext4 was fine) where =
there
>> seems to be consistent regression for 4 and more processes:
>>=20
>> 		vanilla			bfq-waker-fixes
>> Amean 	1 	393.30	( 0.00%)	391.02	( 0.58%)
>> Amean 	4 	443.88	( 0.00%)	517.16	( -16.51%)
>> Amean 	7 	599.60	( 0.00%)	748.68	( -24.86%)
>> Amean 	12	1134.26	( 0.00%)	1255.62	( -10.70%)
>> Amean 	21	1940.50	( 0.00%)	2206.29	( -13.70%)
>> Amean 	30	2381.08	( 0.00%)	2735.69	( -14.89%)
>> Amean 	48	2754.36	( 0.00%)	3258.93	( -18.32%)
>>=20
>> I'll try to reproduce this regression and check what's happening...
>>=20
>> So what do you think, are you fine with merging my patches now?
>=20
> Paolo, any results from running your tests for these patches? I'd like =
to
> get these mostly obvious things merged so that we can move on...
>=20

Hi,
sorry again for my delay. Tested this too, at last. No regression. So =
gladly

Acked-by: Paolo Valente <paolo.valente@linaro.org>

And thank you very much for your contributions and patience,
Paolo

> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

