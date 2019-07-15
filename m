Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353FAC7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F9620651
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1XL/B9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfGOKSZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:18:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55864 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKSZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 06:18:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so14546645wmj.5
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=urzPv1yMPw9Qg3AXvPw/AJi+oPL/4Y0mn6dd+LWj1q4=;
        b=w1XL/B9jGJYylB6dF1FsjRNdaxpDSx/LA8xun/cxNj61kjNdn1u/fpdqwqWfCYtmrt
         MfBrL1yZF8qnHHWPfeu9w7nXCIwsHaXtIW58Dya0QASvBSrvMRuEp0O45sf6ty5Jz2a+
         GGJROUYqcx6bsLpy/qTWjwqOnlEKIr2Blj+S12CJNKk1OBEwBrTL4bgieZBspyk8uyln
         5LgX7Y3oDVwwS+5gmB8FJzbPoSFZbkK1mmx0BGwsVcZMLQmS/dTJZqHe2O0ejmy0sLMk
         P04pfx6RiZVcRkc1X3cqfPVAyk7UlXTQhrJTbkZE/BIeCRz8+oMwiyYIDbzXF/1rNEE9
         CqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=urzPv1yMPw9Qg3AXvPw/AJi+oPL/4Y0mn6dd+LWj1q4=;
        b=t6HgJIYK15Q2Wdw49y6muTPG1CuxugRVq17EflOwiU2f0dJeQZ/yAS020Her8jmGcM
         7qB7Q19boE6q0VdtdE/7jG2GOawvrVqfTOeT0c8xF1DBRcRnWkLy1CaBQdVVggpv+263
         na4cV1f3R54oQForfN1+uV2DOzZdgHsAylab0QDM4ILOcPKyY060vkDdx374BAZvfzHJ
         1qywQRQcx/tEANvOPnCingzpaHXQBhx+FkY+5nRl+zdtXDKDml37vVx5dZL3cw+6a0R+
         FgIqE96mEcfXHCGwcfi4BlqPl0pcpq2dEi0lqnxAnn9iYnY2RrTAFK5tZmHSrxyN14XZ
         8tmw==
X-Gm-Message-State: APjAAAUcw8s1kbsvAm4U3opnu11nILrh+cjnnNB5/I5e2O5Sh4UrF3YD
        ++A5OBsUYbb9BTrnsc5JtK0L0YDsxI8=
X-Google-Smtp-Source: APXvYqy9VE1CfNCcv7OD026I3XymK5MADFBaEDefeaFXTPt897j7Tljep5dn8kS9sEvmEgbhzjYW7Q==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr24968046wml.175.1563185903155;
        Mon, 15 Jul 2019 03:18:23 -0700 (PDT)
Received: from [192.168.0.101] (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id k63sm21710600wmb.2.2019.07.15.03.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 03:18:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT 1/1] block, bfq: check also in-flight
 I/O in dispatch plugging
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <88e3c1e1-224f-a9a8-0875-848ba23b6fbf@applied-asynchrony.com>
Date:   Mon, 15 Jul 2019 12:18:20 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0406DB0-1003-4610-8A75-F3D7614C616E@linaro.org>
References: <20190715093153.19821-1-paolo.valente@linaro.org>
 <20190715093153.19821-2-paolo.valente@linaro.org>
 <88e3c1e1-224f-a9a8-0875-848ba23b6fbf@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Didn't I simply move it forward in that commit?

> Il giorno 15 lug 2019, alle ore 12:16, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
>=20
> Paolo,
>=20
> The function idling_needed_for_service_guarantees() was just removed =
in 5.3-commit
> 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve =
I/O plugging").
> See [1].
>=20
> cheers
> Holger
>=20
> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
block/bfq-iosched.c?id=3D3726112ec7316068625a1adefa101b9522c588ba

