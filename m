Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD1C43612
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CB521871
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4NhPEvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeLRSFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:05:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37338 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeLRSFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:05:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so3748756wmd.2
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6lEfEC1lHx7ice2Le/HKQJGJ1GtmYuRqhVayCgxWRhY=;
        b=X4NhPEvvQIRX7udARiL0IrXceTbHRgn4yeGsIf0NAv5+fanbfYkF8e72S+/3RrMvY1
         Zt5O1SOYcocxeEBMtuaPV6i58TpJToRHnelhtLHhbSUcRsxSg71MWH5QLC6xaZwQDH03
         yZsnvi7qBhnpRX2CWL3N4I0JyVHGMVCCXgGbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6lEfEC1lHx7ice2Le/HKQJGJ1GtmYuRqhVayCgxWRhY=;
        b=DxgurHKcI8THvIpVYnwequHVa/nBeFIgCl6ozrQN8pzLk1/y4Qzkkad1HOY7ji8O6h
         WMuGXxoN+7J0MZXvq9H4bFxr3+9yfnHSLizLPvRflTTavpJ4B7Zws0QBR7wVVRBoTQ92
         CPjaULQCuDMTzOX/DqxiF7HCf4q7TXjm8uuAM+hTY4usoGiPusm+fFPH1zDttF1V6uAo
         c1GIwcM+rYdzu/Ndr48RXX2BrwFfdMy/9SPcSp/4iJ9bNJlr+EQr4WDiUIahzM7HmgaD
         Ae4xlh4tpjXcb/4iZRBx4X27Tpz0pzMzDRuFtuHA6+mSP/dHJd1WvTSx1i3RNnqUEaeI
         6Thw==
X-Gm-Message-State: AA+aEWZUT9pv6Ed7PrF7mVkcYrPAI2dWIjU9nsSUkd9Ytn3Qfd4L7DaG
        2UK2Fxk57l+v4zURK+M/RGfJ8g==
X-Google-Smtp-Source: AFSGD/VjRiKTxDSQVTm80qu8/gLvMTgqv6imP+pKKhsM+8csuBJ4iBUxZbVnRPVQBg3rdMGI47yBjg==
X-Received: by 2002:a1c:1741:: with SMTP id 62mr3954903wmx.25.1545156344847;
        Tue, 18 Dec 2018 10:05:44 -0800 (PST)
Received: from [192.168.0.100] ([84.33.66.6])
        by smtp.gmail.com with ESMTPSA id y185sm1943751wmg.34.2018.12.18.10.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:05:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <EC4F9B54-2352-4D85-B56C-5800CFEBCCB8@linaro.org>
Date:   Tue, 18 Dec 2018 19:05:42 +0100
Cc:     Tejun Heo <tj@kernel.org>,
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
Message-Id: <E6C76EEB-122B-4FE5-A670-FA066F813C1D@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
 <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
 <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
 <20181218164126.GX2509588@devbig004.ftw2.facebook.com>
 <EC4F9B54-2352-4D85-B56C-5800CFEBCCB8@linaro.org>
To:     bfq-iosched@googlegroups.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 dic 2018, alle ore 18:22, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 18 dic 2018, alle ore 17:41, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello, Paolo.
>>=20
>> On Tue, Dec 18, 2018 at 08:48:10AM +0100, Paolo Valente wrote:
>>> If Tejun cannot see any solution to his concern, then can we just
>>> switch to this extension, considering that
>>> - for non-shared names the interface is *identical* to the current
>>> one;
>>> - by using this new interface, and getting feedback we could
>>> understand how to better handle Tejun's concern?
>>> A lot of systems do use weights, and people don't even know that =
these
>>> systems don't work correctly in blk-mq.  And they won't work =
correctly
>>> in any available configuration from 4.21, if we don't fix this =
problem.
>>=20
>> So, when seen from userland, how it should behave isn't vague or
>> complicated.  For a given device and policy type, there can be only
>> one implementation active.
>=20
> Yes, but the problem is the opposite. You may have
> - two different policies, with the same interface parameter,=20
> - one active on one device
> - the other one active on another device
>=20
> In that case, statistics from one policy necessarily differ from
> statistics from the other policy.
>=20
> In this respect, in a system with more than one drive it already
> happens that the same policy is active on different devices.  When
> printing a statistics interface file for the policy, the output will
> be a list of separate statistics, with a bunch of statistics *for
> each* drive (plus a grand total in some cases).
>=20
> So, our proposal simply extends this scheme in the most natural way:
> if, now, also two or more policies share the same statistics file,
> then the output will be a list of separate statistics, one for each
> policy.  The statistics for each policy will be tagged with the policy
> name, and will have the same identical form as above.  It seems the
> most natural hierarchical extension of the same scheme.
>=20
> At any rate, if you don't like it, just tell us how you prefer it
> done.  Do you prefer the sharing of statistics file to be simply
> forbidden?  (If this can be done.) I think such an incomplete solution
> would preserve part of the current mess; but, if this allows us to
> exit from this impasse, then it is ok for me.
>=20
> *Any* feasible option is ok for me. Just pick one.
>=20
>> It doesn't make sense to have two weight
>> mechanisms active on one device, right?
>=20
> (Un)fortunately, the problem are not weights.  There won't be two
> weights for two policies expiring a weight parameter.  The problems

s/expiring/sharing sorry

