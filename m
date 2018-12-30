Return-Path: <SRS0=wt6W=PH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C7CC43387
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 10:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643EC21019
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 10:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2Gz+1F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeL3KZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:25:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35798 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeL3KZb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Dec 2018 05:25:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so10719845wmt.0
        for <linux-block@vger.kernel.org>; Sun, 30 Dec 2018 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RcIxiy51crz2BQyDtywt/mbWbWq0tfJAe0NkaqiG1IM=;
        b=J2Gz+1F1qZXyqxAPjwSRThTSJUptrgZUg6fKCtvgXhgC8HcoRmlPrhLmIwcxyF6xn+
         wbCktOKo6nps6P+AolCt1l1RLjoq9WdSMOwUXb/dz10JTbqZ9y+TOrrS6g4FyWrMhgfI
         gy1xRQH3ziJRyLLoBvajgBfamYoD0nXeNpCIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RcIxiy51crz2BQyDtywt/mbWbWq0tfJAe0NkaqiG1IM=;
        b=l/UXYBDgg8EXfShAh7uD6M6nzmNbqjBseUodrx5AlX4s+ZItHaPeLkPfVVq5uFZCCT
         l3xs2jaiA/rQv9wSM6UNCKpqoWM47J7uYVzqa1Az/mJS9RJZFhLrEgRkiAgh5u53CwXc
         x1XGQQC6pbNPlozLeIJxlT7yhJvx3qHn+VKKlX6l/i1MZ+DzOxdpsCGI0iNVbD8vOJ/n
         tMRVQQmsV9fI5BHfmTxRXV8HVETDWfFv4MZvLjE8Z46+l5gUs1B4CMsKdrfNs7jeB+o8
         +LgzQAu/LKc68teJzNh6NVlK57eSOehDPzW1JwlVjTA6L5SXaADIEDvFgIJjPIjbC96y
         KquQ==
X-Gm-Message-State: AJcUukewmnZqGdmk1PretoisGA8IAUtiuAFVf/oIaBCi2DjQ/yW+nBWf
        bxFTvffpL4vWToKfUWaRm9CLSQ==
X-Google-Smtp-Source: ALg8bN526XimT9K+w4VLwcsCWezIkvqZvSgRHDdQJ9tWiXJjZ+pgAgEhFYvyy530UENjshRziH1ByQ==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr30115242wmf.46.1546165529055;
        Sun, 30 Dec 2018 02:25:29 -0800 (PST)
Received: from [192.168.0.101] ([88.147.52.125])
        by smtp.gmail.com with ESMTPSA id z12sm33115243wrh.35.2018.12.30.02.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 02:25:28 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181227234144.GE2509588@devbig004.ftw2.facebook.com>
Date:   Sun, 30 Dec 2018 11:25:25 +0100
Cc:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
        Angelo Ruocco <angelo.ruocco.90@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2A4E669-8C79-46D7-8A97-2C561FF5346B@linaro.org>
References: <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
 <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
 <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
 <20181218164126.GX2509588@devbig004.ftw2.facebook.com>
 <EC4F9B54-2352-4D85-B56C-5800CFEBCCB8@linaro.org>
 <A360EBDC-B297-4754-AF5C-0A6C30D725B4@linaro.org>
 <20181227234144.GE2509588@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 28 dic 2018, alle ore 00:41, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Sun, Dec 23, 2018 at 12:00:14PM +0100, Paolo Valente wrote:
>> 4.21 is coming ...  and the legacy proportional share interface will
>> be gone with cfq.  This will break legacy code using the
>> proportional-share interface on top of bfq.  This code may just fail
>> when trying to use interface files that don't exist any longer.
>=20
> Sounds like inheriting .cfq namespace would be the easiest.  Would
> that work?
>=20

For bfq, yes, but what will, e.g., Josef do when he adds his new
proportional-share implementation?  Will he add a new set of names not
used by any legacy piece of code?

What's the benefit of throwing away months of work, on which we agreed
before starting it, and that solves a problem already acknowledged by
interested parties?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun

