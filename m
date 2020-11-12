Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BD2C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 06:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7767221534
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 06:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="EWhVHCWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKLGyG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 01:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgKLGyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 01:54:06 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0ECC0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 22:54:04 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y16so4874732ljh.0
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 22:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jyRvIdgyGAjWDq5W0K1ksXVJK+gQp1v4Z+e6lQNh9W4=;
        b=EWhVHCWXmLiHsu0sT9VgjKIQLetXybwhvIk+GYPJAi46dOA5q9cfswM727cThj0AHk
         +GjNmz/3sKj1D4AWB66dZa9ZjchhO+5U7Viy3G93v6VznQ5UHOhOMZogLFZvjAfZQZCk
         gmGmKsfNlOO0H8hX6u0UETqwxi65Yvh+PcFKUblekKaKHTxIqn8li8wVOCJKjjQ7nbt5
         AAHi70MWJApfJ4Pxodg7rrHSwQrk7PLTHZ+kiKTfhn4XCdv+ca8YyKP6I99dJjh9Sn39
         mW3sAC+fmWksUt2AWrKDKm2e1n3q/MXRU4d8jdhPwPFDH6DOabDieUg8plUZx+XkSodP
         e+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jyRvIdgyGAjWDq5W0K1ksXVJK+gQp1v4Z+e6lQNh9W4=;
        b=H3brg0QL3sggTq9YY+AY7CFewfB8dTjSuI9X0lp94yxhPpOMo7oDJ9KmmRBcMe1ZxO
         Q6NxlzNAw38KGC8IRIf73wzMh/w/1OqFJEdfYvnVBY5fam2gJU9saldCYVZUO3qR/FfA
         kyc+YzTDizzfz5VLVTqmHIp/P58g32ihsCYDD1HZGi4HDaj5eH9lBHYE+qym1Z+9pKs8
         nKDhhmwW3LlY0MjO26DTgn/4Llx0QBRs+S2KymeBP8/YCd2ZAxZ1hSsHWBTtKPdP+m2h
         0sMx1EMsJopV6I+Eu1t9bIjs3WGw24B1FFVE8y8PTkh2rE3xsip66HEwULQelc1W94eu
         q0Cw==
X-Gm-Message-State: AOAM530HKhD5HS2Kp45aWm39EemcJuIafMaFkAdie1Cv5BpzYo4Hr4p2
        9b0KuWWyFZoEsDXJ31tSGpSdkI3W7xkyH7Q+
X-Google-Smtp-Source: ABdhPJxoE/WpHD4Hd69MvP0MpCUmik3AYwC2Pxu73yIXTy36mashD+1FV3Q3+u84EgwB606+fRcLhw==
X-Received: by 2002:a2e:9988:: with SMTP id w8mr11162295lji.107.1605164042855;
        Wed, 11 Nov 2020 22:54:02 -0800 (PST)
Received: from ?IPv6:2a02:aa7:4008:7a47:dd24:ebba:eb9c:4d77? ([2a02:aa7:4008:7a47:dd24:ebba:eb9c:4d77])
        by smtp.gmail.com with ESMTPSA id v1sm454368lfp.305.2020.11.11.22.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 22:54:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme: remove unnecessary return values
Date:   Thu, 12 Nov 2020 07:54:01 +0100
Message-Id: <5F62C483-424C-47D8-AFC9-B6B28B2C4D54@javigon.com>
References: <BYAPR04MB4965213DB3D1F07B7B75B92586E70@BYAPR04MB4965.namprd04.prod.outlook.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
In-Reply-To: <BYAPR04MB4965213DB3D1F07B7B75B92586E70@BYAPR04MB4965.namprd04.prod.outlook.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 12 Nov 2020, at 05.11, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> w=
rote:
>=20
> =EF=BB=BFOn 11/11/20 12:10, javier@javigon.com wrote:
>> From: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
>>=20
>> Cleanup unnecessary ret values that are not checked or used in
>> nvme_alloc_ns()
>>=20
>> Signed-off-by: Javier Gonz=C3=A1lez <javier
>=20
> The ret value pattern is used to avoid the calls in the if () which is
>=20
> not clean based on the comments I had in the past.

Thanks for the comment Chaitanya. I was working around this function and TBH=
 I have never thought about it this way.=20

Will add it to the toolbelt then.=20
