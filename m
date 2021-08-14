Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566AC4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CBC60EB5
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 20:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhHNUm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHNUm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 16:42:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BDC061764
        for <linux-block@vger.kernel.org>; Sat, 14 Aug 2021 13:42:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n12so20471422edx.8
        for <linux-block@vger.kernel.org>; Sat, 14 Aug 2021 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=yNzjxSfnVSUDSGUY1rHTEQ9gqqafkCS75FpW05fDG6g=;
        b=aIQFsNMKSxQ5tem4VTSQs7xseHym013YLoVCgIvyc/0xD8c3vpYQOOZa6ywj5kZIQt
         XSMqx+JQIPMhXQP0gy7ykQ42Q6plgPccIH+cHoyHiC3YBvlTQhQrDTmPAfST7YArRwQs
         0AqUuS8PmgU0UL3BIZSW1Woro5wA3BSL7vZ4TK+InRkh8npiDNO8P2GQLUiIyYx7srAN
         Gol6t6s2pp78wEOfHaE+KWmrk0i3IdMkJNDjkZW5qywhkWO0v41dcyRYuHA26ubwBYk3
         g3lY8TIAZYUAmNb/x0as1Sb435dG8TeQPPFh2iVWlBO7/1vYsLZjGoc74FjTMJdUnYY4
         hh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=yNzjxSfnVSUDSGUY1rHTEQ9gqqafkCS75FpW05fDG6g=;
        b=LB9fr/hkv10t/EZJSwgN/Ejh3FnkVAheuJkz45AYEeDyS0so4b3fpxGU8YQhFMycfJ
         38EUzB/6jJqLy4bIse8/kSlY1GFFsXGHdX5bivASg1xS+kXV/XkfdiJmuOZiIp+ClFy3
         2q0FvI8FjzfFSZ+HxRxUq8MTfecnivAs+3tkY0p/wdezhDj1PSpuEbDL0V0ttEvyLNC4
         drtsclQ5Jx7evVTjnQnjfj+CVMj94CVGelcEOFilAYdu+fWXeW/275SA6NNdixd04F7g
         vPJDDJAFbBZJjBvwsauIHY9FmN1Gs200iAaFIetXoGrG5wxrvHyxpl9d3UaDgS224fem
         eUBQ==
X-Gm-Message-State: AOAM531KMQxg2FquUWjluslTAPlqI5vbmd6OPTKGDlQlFa9p4p0dh9fA
        5to+qa3m0pE8fECXzXuyn/Pl7zpPNxsiU8yZ
X-Google-Smtp-Source: ABdhPJzTvddzsELNhz8McEhEGjR1s3BDpCyEOiQEwyuJ81VGNo1ZP2Hk/arY/AgqQHIc51yajHpm6A==
X-Received: by 2002:a05:6402:27d1:: with SMTP id c17mr10762249ede.178.1628973746133;
        Sat, 14 Aug 2021 13:42:26 -0700 (PDT)
Received: from smtpclient.apple (5.186.124.144.cgn.fibianet.dk. [5.186.124.144])
        by smtp.gmail.com with ESMTPSA id v1sm2123489ejd.31.2021.08.14.13.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 13:42:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] remove the lightnvm subsystem
Date:   Sat, 14 Aug 2021 22:42:25 +0200
Message-Id: <52C4BBAD-21CE-4CD2-8B21-90ACEB4E4B01@javigon.com>
References: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
In-Reply-To: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (18G82)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 14 Aug 2021, at 21.30, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> =EF=BB=BFOn 8/14/21 1:01 PM, Matias Bj=C3=B8rling wrote:
>> Thanks, Christoph.
>>=20
>> Reviewed-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>=20
>> Javier, if you agree to the removal of the subsystem, would you like to=20=

>> provide your reviewed-by as well? Thanks!
>=20
> Side bar - please don't quote 400k of text, this reply really didn't
> need any of it.
>=20
> Pet peeve of mine, and it happens way too often on reviews as well.
> Don't quote the whole email just to add Reviewed/Acked-by, it's just
> wasteful.
>=20
> --=20
> Jens Axboe

Looks good to me.=20

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>=
