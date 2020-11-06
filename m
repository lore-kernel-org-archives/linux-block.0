Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C520BC2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F7E2087E
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="rzD1v0/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFOWF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFOWF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 09:22:05 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C0C0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 06:22:03 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id a25so1564583ljn.0
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2020 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jqG0hrKmGlo514JQJQCOny84aPmId67veaaqw3tzZUw=;
        b=rzD1v0/dkvhBfGd3GzlELnU/N4vWkcjupZ9gCbarCgeBRc7dT1B9kcpJRrsuAViLkw
         9+iDEim8U5tst8yqUmzyRtGFMJ7D2sx9CwKN10RXhx/V1WGv4wWCNB1BiYXZQ5JK3zo2
         1Sajd8jYYJnHdDMTSeMPt+pdcw9Yk+Mhi3Au2mwgsdyCB7x2TA8yOXFTg7nSkwFPk0jD
         P0Mb1LswL9e4Cdf+M304lLMO9SPX4tsB0VGYYlU4VcMZZQrZoqOFDEDjJubLmyxzuAc5
         h1z06OHN5SFGgQzje89AsuudNJwYNcs+ojh+/hG0HXvNB3FtduBBodyKWxsCTK6/5Uft
         AqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jqG0hrKmGlo514JQJQCOny84aPmId67veaaqw3tzZUw=;
        b=o2JnD5BeMJGvNbJvkRpIhVfn4XMpxuWxAlAv9L6e2jf/1tOgYZ9I3siD85OTxy3a4L
         KXeu1EQdfZcdXpeN0PYtHwEN70JKcmzBR4jpe7ujH6+jW4LWfh/KdA3DsNU/WgHIO/Um
         KeJ9rkDOUcbWEfF6o5dSKH7Dtfbt/EltER+H7oI2s8eFnRs4zksd/JfxcHw3AHxfEu9p
         HTTE7yiSfIwSUABIAfLj/T8x0CgLRUeCZgWxMKf5NDXX4StKak6M4JypSuvNlsl2rJD9
         UmROsbqZQMr2VhwwKvXmW8ykC53rtCeQVqIhxjTSvK1xUSfAX+yTVnOxD5ffzRWitO4O
         sldg==
X-Gm-Message-State: AOAM533qaehmCFUeIlo94NkSPaT9t27HNm7BnRIXLE+KIt46J+64h5AX
        bHQJbYymSc/0K6WPi/n+nq4LDA==
X-Google-Smtp-Source: ABdhPJyjuuBNSG4p3jDrXJ8X24jmGIbior8qmhO4xpP7Z8t6C/zyHt+VZKAQIM6sN+xyGCyN3ZRtdg==
X-Received: by 2002:a2e:874a:: with SMTP id q10mr917611ljj.446.1604672521925;
        Fri, 06 Nov 2020 06:22:01 -0800 (PST)
Received: from ?IPv6:2a02:aa7:460f:ff9e:4554:dd33:6596:f69f? ([2a02:aa7:460f:ff9e:4554:dd33:6596:f69f])
        by smtp.gmail.com with ESMTPSA id l8sm184843lfc.50.2020.11.06.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 06:22:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme: enable ro namespace for ZNS without append
Date:   Fri, 6 Nov 2020 15:22:00 +0100
Message-Id: <36113018-83A0-4804-A077-F8C25FF3E913@javigon.com>
References: <20201106141428.GA23884@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        joshi.k@samsung.com, k.jensen@samsung.com, niklas.cassel@wdc.com,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
In-Reply-To: <20201106141428.GA23884@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 6 Nov 2020, at 15.14, Christoph Hellwig <hch@lst.de> wrote:
>=20
> =EF=BB=BF
>>=20
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +    if (blk_queue_is_zoned(disk->queue) && !ns->zoned_ns_supp)
>> +        set_disk_ro(disk, true);
>> +#endif
>=20
> I think we can simplify this at bit.  Add a new NVME_NS_FORCE_RO flag
> to ns->flags, set it in nvme_update_zone_info, and just query it here
> without any ifdefs.
>=20
>>    struct request_queue *q =3D disk->queue;
>>    struct nvme_command c =3D { };
>>    struct nvme_id_ns_zns *id;
>> +    bool zoned_ns_supp =3D true;
>>    int status;
>>=20
>>    /* Driver requires zone append support */
>>    if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>>            NVME_CMD_EFFECTS_CSUPP)) {
>> +        zoned_ns_supp =3D false;
>>        dev_warn(ns->ctrl->device,
>>            "append not supported for zoned namespace:%d\n",
>>            ns->head->ns_id);
>> +    } else {
>> +        /* Lazily query controller append limit for the first
>> +         * zoned namespace
>> +         */
>> +        if (!ns->ctrl->max_zone_append) {
>> +            status =3D nvme_set_max_append(ns->ctrl);
>> +            if (status)
>> +                return status;
>> +        }
>=20
> While you're at it:  my inverse the polarity of the if check as that reads=
 just
> a little more natural, and maybe mention in the warning that the namespace=
 is
> forced to read-only mode?
>=20
> Otherwise this looks good.

Thanks. I=E2=80=99ll send a V2.=20=
