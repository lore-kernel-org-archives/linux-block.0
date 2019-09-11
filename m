Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61401C49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3887720838
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 16:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiplzaXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfIKQoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:44:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50578 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfIKQoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 12:44:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id c10so4285221wmc.0
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2019 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CIzlo4K5/PjwxwRPJcn0L8E28gxLYoETPgMFHBnxBGM=;
        b=RiplzaXsZoN/l8/1QB2+PKmfBVYwqpeO8FjSnlnUnzxJBUYAaqG8Zm1oboRrHXiUgK
         shFRnhEZ9eAh5ONRTyBJDmTxG56+hxS9st+TCG401AIBpGfhNFuCfPkL/dcJCWBB0VQD
         X760P9SJ0S3MpF0ZGewpEpp8cHqbAFGYiZffb1lKQ6ej5txVcZzNhSZqqlBLsjymKFgD
         S1tQjzpdK8PA1rlsT7cr9AOOK94cRX5NGAP1ZHEviIDK+Q89HaLqqsdpqxy2M0ctDDbq
         KAzP+tv0EsEdBVkVUh5M6A6MLsCnd3jTrRLqj/6zi4SuSH/7MmYIU0IMTDMjeaznIdVu
         hAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CIzlo4K5/PjwxwRPJcn0L8E28gxLYoETPgMFHBnxBGM=;
        b=fJKb7mxdTVYjGPDgHjMP2Cit8OnusKX8ovvRN8ksGHvJqSPKZhtGdUJWf1v3OMIYO2
         shy1vWfDPLMcvLRxuqyUkThEkyN+w3bu1LqN7FmrjyatV9UEv7lHA2Q2NQYa9m6z8yOI
         4eBieOjqUQRKbVsQgSTLHB1ro3VCDndEAqd+YuZBnptqZnE0X+Sjta7P8hTZ8tPbHtZP
         OLAQHs9wweN+CkfCWtpeiPmQU8jNPoKCRsPWhUeTzUQdpJCrAwWqK/O+FUywnZPkyb2Q
         Oro/8q5bFGba+gVOD+VyuKYnKFuq+CWzz4GBjusTQQjOUPx9YvAN+1FTsupzJyogSF0z
         0fgg==
X-Gm-Message-State: APjAAAUOwFF8UyUp3wjihkR8xqS/N+7VOb97gDSrXACKX3UAErrjX8qa
        v1L1b8x4l5JgOq5f4N2OS7RUgg==
X-Google-Smtp-Source: APXvYqxHBemyp1FBv7D6CS0N0RcxK4MROGEnSaZVxrdDnq4ihO2G7EZFt4VzOaMlrSi5x9kUIGNK2Q==
X-Received: by 2002:a7b:cd12:: with SMTP id f18mr4926073wmj.111.1568220273954;
        Wed, 11 Sep 2019 09:44:33 -0700 (PDT)
Received: from [192.168.0.103] (146-241-81-247.dyn.eolo.it. [146.241.81.247])
        by smtp.gmail.com with ESMTPSA id w125sm7064842wmg.32.2019.09.11.09.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:44:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190911141630.GV2263813@devbig004.ftw2.facebook.com>
Date:   Wed, 11 Sep 2019 18:44:31 +0200
Cc:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, clm@fb.com,
        dennisz@fb.com, newella@fb.com, Li Zefan <lizefan@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37CB2690-F1B9-4159-B6A9-77BDB0FF906D@linaro.org>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <A69EF8D0-8156-46DB-A4DA-C5334764116E@linaro.org>
 <20190911141630.GV2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 11 set 2019, alle ore 16:16, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Wed, Sep 11, 2019 at 10:18:53AM +0200, Paolo Valente wrote:
>>> The two being enabled at the same time doesn't make sense, so we can
>>> just switch over to bfq when bfq is selected as the iosched.  I =
asked
>>> what Paolo wanted to do in terms of interface a couple times now but
>>> didn't get an answer and he posted a patch which makes the two
>>> controllers conflict, so....  Paolo, so it looks like you want to
>>> rename all bfq files to drop the bfq prefix, right?
>>=20
>> Yep, mainly because ... this is the solution you voted and you
>> yourself proposed [1] :)
>>=20
>> [1] https://patchwork.kernel.org/patch/10988261/
>=20
> So, that was then.  Since then the interface change has been published
> and userspace, at least some of them, already had to adjust.  Now, I
> don't have any opinion on the matter and flipping again will cause
> inconveniences to some subset of users.  It's your call.
>=20

Ok, then let's go for removing bfq prefix, as expected, e.g., by
systemd community [1].  A few days ago I reposted a patch removing the
prefix from all involved parameters [2], it should make all legacy
software work again.

[1] https://github.com/systemd/systemd/issues/7057
[2] https://lkml.org/lkml/2019/9/9/47

>>> I can implement
>>> the switching if so.
>>=20
>> That would be perfect.
>=20
> Whichever way it gets decided, this is easy enough.  I'll prep a
> patch.
>=20

Thank you for that too,
Paolo

> Thanks.
>=20
> --=20
> tejun

