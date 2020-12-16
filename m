Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68F7C0018C
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 08:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6843723357
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 08:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgLPICe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgLPICe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 03:02:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E9C0613D6
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 00:01:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b9so6442364ejy.0
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 00:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qexlGjtoIwVVGu2gcy5iyB4/p0MInWb8FNAdG7CIFz0=;
        b=FzkVg7SEmZikOJZtEsNiU20maUGGW2yTUOOj/aFpWOkD6GNOtu1goDT3usVIbO2cah
         kFPjA0xXUf3Aw91n9DgZ5qRQuV1gRQ7vLdzLc6y7NCu0GUx3/xj/5PXRtZ8s7+7bFewn
         TO0dhXw0JnFndleQruE4ElNQxgtym5O8oTXxEWDnPjxvR0pyYRxrF6lndpmmv5wcBrZj
         12nkme1rPqieVgAFlTdwIkHDka3eFylY1MrKq17k/UkLgG3Tsd64mY4IfatDL6gWkrIz
         wjLSqC1rBi5cMUIVNNWfgjg23yl0NB9SPXWQ6g4gC3pZHPzswvqe3NPdziHH4dCC8sdf
         RG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qexlGjtoIwVVGu2gcy5iyB4/p0MInWb8FNAdG7CIFz0=;
        b=MBHysx00onX5kb7bpV96A++zRML1O48JaP+X8dCnAc4AkSDoS2/hD2Mie2gkL/P6uO
         GX4wLocnir3tB7yGQx9Atw5wTkXw3by5OEZZK0eGHXk72dKQb8qlvurU1vUVVo+RcgE+
         VQf5k+XekBEIz6QylyQdzn3Hpf4LTOCAEy1crvdicWtTEELDmJAPD9zVNPRfzZK3ELkj
         dRZt9j566Vd8wMvf/vNtkdeNLAlJLgtfuDiY2G78hAcKf5ipyRSZQ+i1pXWGg9F9FgRe
         MnyvJMnTM4zy0TpMBZ5KehQtPWy1T7RBWOolk2DL5Iir6YrWsfO9Fp1/w3KWcWsYVcut
         HjDA==
X-Gm-Message-State: AOAM530un3Z+xyfk66t3MiTqoOdu+WhhLpsUYSYfVe+/orEp56J4afnt
        GO5oOAVWR8Q/s0HBLPV71+IBeg==
X-Google-Smtp-Source: ABdhPJy1RUHmsf1ghVRpsNs591H1tav5u9Qn+KoHyglJ5hqAyGstsoI2/tmACf65vTzmXKZ+PhalZg==
X-Received: by 2002:a17:906:7243:: with SMTP id n3mr29031051ejk.246.1608105712954;
        Wed, 16 Dec 2020 00:01:52 -0800 (PST)
Received: from [192.168.10.21] (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id v18sm798630ejw.18.2020.12.16.00.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 00:01:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Date:   Wed, 16 Dec 2020 09:01:51 +0100
Message-Id: <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
In-Reply-To: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 15 Dec 2020, at 23.46, Keith Busch <kbusch@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrot=
e:
>> +static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *=
ns)
>> +{
>> +    char cdisk_name[DISK_NAME_LEN];
>> +    int ret;
>> +
>> +    device_initialize(&ns->cdev_device);
>> +    ns->cdev_device.devt =3D MKDEV(MAJOR(nvme_ns_base_chr_devt),
>> +                     ns->head->instance);
>=20
> Ah, I see now. We are making these generic handles for each path, but
> the ns->head->instance is the same for all paths to a namespace, so it's
> not unique for that. Further, that head->instance is allocated per
> subsystem, so it's not unique from namespace heads seen in other
> subsystems.
>=20
> So, I think you need to allocate a new dev_t for each subsystem rather
> than the global nvme_ns_base_chr_devt, and I guess we also need a new
> nvme_ns instance field assigned from yet another ida?

Ok. I=E2=80=99ll look into it.=20

Thanks!=
