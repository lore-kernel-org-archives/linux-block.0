Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4685C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 08:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAA360F92
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 08:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhH0Idx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhH0Idw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 04:33:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA18C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 01:33:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u16so9190728wrn.5
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VtoCWVqLTV/heRDzLkHFfB6NsN56tLaUOwMyBzk6DsQ=;
        b=p/XqSfnZUooWAr8lgDeoBRdn3K1+CVOMlLcHv640+uENvSRHmZHL/Jgt4NXBeRRIQU
         9S6RPb4u0xmPpipOcWiNh7NacH3f3BaGFhl8BBDRVL2cylmQ205R5dzp4/iEci705arm
         eeXKeDNPCjU/T0lcP0GWvReSEMchHGSqNrjwY3Q5vpumbt1rClmdOUI4ZSdtFPX2aZm1
         mQdRkS3hP+lKNWwYmOJTM7wLs/I1e1Q3EgJVBWBxRqOIIDDkkKGQsaE5YYf8lSOs9i4a
         LOSebZMZ+Yylt+8h7WM1IMps85gmmCfO5RAcc2gh3nnfpdPWCNuAGvkDAIBujwTDFrq/
         38Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VtoCWVqLTV/heRDzLkHFfB6NsN56tLaUOwMyBzk6DsQ=;
        b=PrpvfbJpKrE+sGtS+nYBK2kqH8qk1+C+o84KV9NbSQxfGCVRL7dxZTmk0YwFYwZQ1x
         Xkw60j9bCU3ppuM53KpOaS+3NJVIBNY6IIYoYoEkbseFMLb47cH3gcUqkRVx1XNpxMqf
         +PAnyRDxevnLbiHQdyzsGNHgx65UYUdkie2kvO+4zO6ISAJhVZqaAxW1Qn8FmQjXCTn6
         SW7mRmUTTciW57dz+GzG4HLv3zFz+tCKYVZ/pzWZmn/NrQ6QfqP5YVNznDim/SZ7JI6y
         A9aDFGs9s3Yq9fo1S6Tq98HFeEPNvH0Ztiy9s9vGMmbGK41TLj4fkmjGVT12dJ6DxG/H
         Z8WA==
X-Gm-Message-State: AOAM531h7OkLFpC2T9S4BeVTkjWAHEPAI1aVSdQEqKC6ZlA2qA5Vp3qS
        FZOWaL3UBAFzSQ88LkfBxVuDSg==
X-Google-Smtp-Source: ABdhPJxVx6afc47YInNnteHGfK0p5HZ4m/TugBVCsf93N3hJ3wlglrcgrmLCRpLOttrbzg2VTuJiIA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr8969546wrh.148.1630053182963;
        Fri, 27 Aug 2021 01:33:02 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h11sm12269724wmc.23.2021.08.27.01.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 01:33:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: BFQ cgroup weights range
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <YSfOhM9+uJ5/FzY2@mtj.duckdns.org>
Date:   Fri, 27 Aug 2021 10:33:01 +0200
Cc:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <72DB38C2-196C-4F55-B1A1-B8EA55667057@linaro.org>
References: <20210824105626.GA11367@blackbody.suse.cz>
 <EC36D67F-D7CC-4059-8D3B-E0E64DFC3ADB@linaro.org>
 <20210826131212.GE4520@blackbody.suse.cz> <YSfOhM9+uJ5/FzY2@mtj.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 26 ago 2021, alle ore 19:25, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Thu, Aug 26, 2021 at 03:12:12PM +0200, Michal Koutn=C3=BD wrote:
>> On Tue, Aug 24, 2021 at 02:51:47PM +0200, Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>> BFQ inherited these constants when we forked it from CFQ.  I'm ok =
with
>>> increasing max weight to 10000.  I only wonder whether this would
>>> break some configuration, as the currently maximum weight would not =
be
>>> the maximum weight any longer.
>>=20
>> Thanks for the reply. Let me form the idea as a patch (and commit
>> message) and discuss based on that if needed (+ccrosspost into =
cgroups
>> ML).
>>=20
>> -- >8 --
>> From: Michal Koutn=C3=BD <mkoutny@suse.com>
>> Subject: [PATCH] block, bfq: Accept symmetric weight adjustments
>>=20
>> The allowed range for BFQ weights is currently 1..1000 with 100 being
>> the default. There is no apparent reason to not accept weight
>> adjustments of same ratio on both sides of the default. This change
>> makes the attribute domain consistent with other cgroup (v2) knobs =
with
>> the weight semantics.
>>=20
>> This extension of the range does not restrict existing configurations
>> (quite the opposite). This may affect setups where weights >1000 were
>> attempted to be set but failed with the default 100. Such cgroups =
would
>> attain their intended weight now. This is a changed behavior but it
>> rectifies the situation (similar intention to the commit 69d7fde5909b
>> ("blkcg: use CGROUP_WEIGHT_* scale for io.weight on the unified
>> hierarchy") for CFQ formerly (and v2 only)).
>>=20
>> Additionally, the changed range does not imply all IO workloads can =
be
>> really controlled to achieve the widest possible ratio 1:10^4.
>>=20
>> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
>=20
> Looks fine to me.
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks for this improvement,
Paolo

> Thanks.
>=20
> --=20
> tejun

