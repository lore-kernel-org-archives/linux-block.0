Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5216FC4320A
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3721561357
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhHXMwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhHXMwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 08:52:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279EC061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:51:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so44196702ejz.1
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3N5N1pL9l1Nd9FtRSCryRrWbfA4JEwfbr4ZSZbB62rY=;
        b=LanEZp11YjG5tA5E7i5vbAFGEEe0FMTAVPvJ0V5MH+frTIZhz029MuFXMSGh4fCDy/
         PaT6n+/EiNW9v3X30JjE6qihfC0ku+CrIbXjWER9z7E/aU8TPKJs0HH49Exr02CGNKAZ
         8EfG3E2203L0AqX6Y1zl5Yq+Vmg79VsaigsgsRYpTAHEceQcf34KsUio1lOGbGjF86dr
         MRe6SfPLzEgufV44aqpM3q0TTctw3I0KjoqApMEBx74M0wpN6Hhe7rsR47xKTUxLXt2F
         po+XkNz1nflA0WI+08shZokmxRZ+3t7sywy3kkd7kQfsYwPvrgX24d8w4yHp7VCkPsiQ
         LxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3N5N1pL9l1Nd9FtRSCryRrWbfA4JEwfbr4ZSZbB62rY=;
        b=ZakLNM+Srj/MXJYTit63HOZknLBZLmlY1ZJJkhTwPzScRjo5LrTcwgYmXzz3EzM65K
         jATnLy4T9N7IXng1fFEer2NsWlttuH9CQCXz9HvxJq9CS2bOVH0FnYmNHjrLIBhSyxDo
         RA9ZCKUZ4HhMimZess70YVLWOFZSs2y5NiMiefC8rXxr383vpOpkkFX+2YKHSWePjAMM
         84esAYHWhS4koPwLEfBe3XpTcejIHybUvb71yxIkFI0zjAqZBFa5dFyePDIvgW1S47vQ
         3khYXw4FOwF951jGHvuNMTj1QB+bRHu8os4ANj5L0m+23zndMPTdxfWEEpYtAEcF54wW
         feNQ==
X-Gm-Message-State: AOAM532k0Lw97DaOwVv0hMHIzmUdsAINUfPc19rKp4LPHlU3oM/XgtYS
        mI1yOzgK22vs6pMFibMLfDaw0g==
X-Google-Smtp-Source: ABdhPJyqOKi7ldq/YQP/xGJ/+MEH/MacItQp38lS3qa4BfJxoJdGaOEAHcthSPt/W2qPVB+igGuWZw==
X-Received: by 2002:a17:906:a14b:: with SMTP id bu11mr41053184ejb.260.1629809509104;
        Tue, 24 Aug 2021 05:51:49 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id d19sm9094628ejj.122.2021.08.24.05.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 05:51:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: BFQ cgroup weights range
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210824105626.GA11367@blackbody.suse.cz>
Date:   Tue, 24 Aug 2021 14:51:47 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC36D67F-D7CC-4059-8D3B-E0E64DFC3ADB@linaro.org>
References: <20210824105626.GA11367@blackbody.suse.cz>
To:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 24 ago 2021, alle ore 12:56, Michal Koutn=C3=BD =
<mkoutny@suse.com> ha scritto:
>=20
> Hello.
>=20
> The default weight for proportional IO control associated with a =
cgroup
> is 100 [1]. The minimum allowed weight is 1 [2] and the maximum weight
> 1000 [3].  This is a bit inconsistent with general cgroup weight
> semantic where def/min =3D=3D max/def (i.e. symmetric adjustments to =
both
> sides) [4].
>=20
> 1) Is there a reason why the maximum allowed weight is (only) 1000?
>   (E.g. it won't be possible to ensure 10^4 ratio of proportional
>   control but 10^3 is achievable.)
> 2) Is the default value 100 special or absolute in a sense? (I suspect
>   it is, the unchangeable weight of root cgroup members. Therefore two
>   siblings with equal ratios 10:100 and 100:1000 would behave same =
only
>   when there's no interfering IO from the root.)
>=20

Hi,
BFQ inherited these constants when we forked it from CFQ.  I'm ok with
increasing max weight to 10000.  I only wonder whether this would
break some configuration, as the currently maximum weight would not be
the maximum weight any longer.
=14
Thanks,
Paolo

> Thanks,
> Michal
>=20
> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/bl=
ock/bfq-cgroup.c?h=3Dv5.14-rc7#n513
> [2] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/bl=
ock/bfq-iosched.h?h=3Dv5.14-rc7#n18
> [3] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/bl=
ock/bfq-iosched.h?h=3Dv5.14-rc7#n19
> [4] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/admin-guide/cgroup-v2.rst?h=3Dv5.14-rc7#n602

