Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4693EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Apr 2022 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbiDZOcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiDZOcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Apr 2022 10:32:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D337CDF3
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 07:29:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i19so4778726eja.11
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UtxKEl/jdAqxBbZkRmwFZRoJTQTnJz7V1g2tHc7h6gA=;
        b=UeuWDB3lygmDq9VaXuxbUAj9p7032s/4d7MGrlpWMDufmnizE5SL3kzclmt5qrUYAF
         IjN17FrgjPFMK4Y90alyXIW44IpZGglJFeuFhwHaMxJHAtwxNeWJyxH7vetHF1zCS96P
         JLpN5k7YOQ7owSoigr6acMM96PVLvz0IDJ5l/WUvHG1FKxOx1vUkes5qOSb9SFVw353E
         ZmouDY7pwWdAGCN/MWgCFyU9Tl23e2MptT1J5MWRyBy/iIjAGGkHP9aWgT663dwqS9A/
         UqgvPS8T4hifvUmZYJRw5nbifvpV5iV7hNxwXTepI8i8trUxm6DOwT3eXVN0mZzrI4d/
         cQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UtxKEl/jdAqxBbZkRmwFZRoJTQTnJz7V1g2tHc7h6gA=;
        b=y9KOjMsN1gK2kkxNfKvpdVpon8TKYu5BmiYH8bWi9tBwnsMvC9ddQNaSWPYKjHyeeq
         pszWXGG+5SWYLBtVE8ZDPoqIGRevUIgP+2f/N27g92h2eOIrjvYlJ5XYQxMGqZN9naiZ
         jSccL6MhAH9eKI/rvGUyb4Kz3kd8AhbeHMQoWu4W99phLmh/gprp21MjQtc043J95I2k
         +M/Z5zp/wgC24c+ZHb488ypS4Ko9FkPv848CueEOGXnyTwItoKOFTXsAmVP03EUIFGZy
         hfkSR8+ngiCHzwg42TLmLRUaFj3DCFhRnrY1ogIe2FK+h6kwZ1T+tf+njs1aFvQrqpPw
         dJgQ==
X-Gm-Message-State: AOAM531t9uUSAi//NGN+sGAGYXe2KWUwMUYz+fBaAG2dZjv34bWUDdWX
        YDxuRL9+nia1aH+Wl5phlSvY0g==
X-Google-Smtp-Source: ABdhPJyGRkMWyD1aO9GmIcxVeO8yS27LDvWOAzBdjHRNEiJzJ9oW7wiURCskEcybfdd/ay9ohfux1g==
X-Received: by 2002:a17:906:4c93:b0:6f0:2de:f42d with SMTP id q19-20020a1709064c9300b006f002def42dmr22046784eju.648.1650983373165;
        Tue, 26 Apr 2022 07:29:33 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709067e5300b006f39880d8e5sm2342868ejr.78.2022.04.26.07.29.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2022 07:29:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9 v7] bfq: Avoid use-after-free when moving processes
 between cgroups
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220401102325.17617-1-jack@suse.cz>
Date:   Tue, 26 Apr 2022 16:29:31 +0200
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C6715AF-82B4-4CBE-949B-83E4420C8340@linaro.org>
References: <20220401102325.17617-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 1 apr 2022, alle ore 12:27, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Hello,
>=20
> here is the seventh version of my patches to fix use-after-free issues =
in BFQ
> when processes with merged queues get moved to different cgroups. Kuai =
has
> confirmed that patches now fix all the issues his reproducer was able =
to
> trigger so I've just added some tags, codewise this is the same as v6. =
Paolo,
> can you please check whether the patches look good to you so that Jens =
can
> merge them?

I think this is not needed any longer :) At any rate, your patches do =
fix
an evident problem, in a correct way.

Thank you,
Paolo

> Thanks!
>=20
> Changes since v6:
> * Added some Tested-by, Fixes, and CC tags
>=20
> Changes since v5:
> * Added handling of situation when bio is submitted for a cgroup that =
has
>  already went through bfq_pd_offline()
> * Convert bfq to avoid using deprecated __bio_blkcg() and thus fix =
possible
>  races when returned cgroup can change while bfq is working with a =
request
>=20
> Changes since v4:
> * Even more aggressive splitting of merged bfq queues to avoid =
problems with
>  long merge chains.
>=20
> Changes since v3:
> * Changed handling of bfq group move to handle the case when target of =
the
>  merge has moved.
>=20
> Changes since v2:
> * Improved handling of bfq queue splitting on move between cgroups
> * Removed broken change to bfq_put_cooperator()
>=20
> Changes since v1:
> * Added fix for bfq_put_cooperator()
> * Added fix to handle move between cgroups in bfq_merge_bio()
>=20
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # =
v2
> Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
> Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # =
v4
> Link: http://lore.kernel.org/r/20220121105503.14069-1-jack@suse.cz # =
v5
> Link: http://lore.kernel.org/r/20220330123438.32719-1-jack@suse.cz # =
v6

