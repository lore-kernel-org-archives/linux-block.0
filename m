Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CBC433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 13:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiCJNP5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiCJNP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 08:15:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40ECD5FE
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 05:14:55 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gb39so11974104ejc.1
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=vBffCw7yxR08203yqk5YHoqQ7XS/o1T3z5vSH1C4j+o=;
        b=NSnsv/YlVRnmwl5NUdxZb3e0Y7KZN25nTRQpW6Eb46hTerOHq2gdD5i+oW7TuvdyMe
         5eAX4iybzViIwtwWYCAg6tiyMKEct/4oEVSw9jqMvdp4RbFJrESldMSUsozmsINp5dfj
         xCEHcalG528i/dXvOFvDdYX3bAlZkdaPH9Ae8POz2WhQwTe1l94CE9ofsXBj7JA4PwGE
         Ur8pAbRMPKqzrcRAXOxhWTdPYhHnkAxingagXm4pqawvBdOkuFAjAsG50AzGtPzQ+wYD
         R+F5rxNSqY8x6DIfZI+I2T8DaCEejIvX5w9jaio20Yk7zwA47V0CMkEmxkU+CkQgg6UU
         w9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vBffCw7yxR08203yqk5YHoqQ7XS/o1T3z5vSH1C4j+o=;
        b=JQjqhtjodlLUDVRA/awXEJaqZQQmC+vGWqaEx2JTv81i0TQk8pz39NbQSQynGz/MSH
         IXPSOEVNvET7c8eR85Fc5Ij8TfalgkOxIT5K1iW0+AP0dWxKJn2vryyhQ5tfXYgNEB+I
         yji4GETAjuzeBovOuI8Xq797rdOjF/QvomrDMxN1E1clR7xhjhsQ2w2XL/YeU++hvAJF
         S0ew28qILfSedBlpGvToH2pawYaGBInkor3oOSyVMvNV5+OZZD8unEZjsGQFezdFsJPc
         VFswm/tYZ5eS48Cg8ktQOV/UkTtb8+50n4sdj844lNFdsqqw64N6cEJnOOnh9SLGhwNn
         6EbQ==
X-Gm-Message-State: AOAM530UyYtQDp9DzNzDCcFnSv3ViFD/9IzB9JPf+E6Xtrh+JcmU5Iwb
        +Z0pS7odHDd9CF1aLfhHPbL06g==
X-Google-Smtp-Source: ABdhPJys3+fb3FNd4PHh5hvmjjJTkorU7UTjdX+OLN9i22AxgvCT0Aec6WaiKyDdI1X7RWcunfDAaw==
X-Received: by 2002:a17:906:bcec:b0:6da:9ded:2f7 with SMTP id op12-20020a170906bcec00b006da9ded02f7mr4097629ejb.113.1646918094002;
        Thu, 10 Mar 2022 05:14:54 -0800 (PST)
Received: from smtpclient.apple ([2a02:aa7:4007:6673:70d2:2604:fb1b:500e])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906739600b006db726290dcsm1576050ejl.217.2022.03.10.05.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:14:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Date:   Thu, 10 Mar 2022 14:14:52 +0100
Message-Id: <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
X-Mailer: iPhone Mail (19D52)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On 10 Mar 2022, at 14.07, Matias Bj=C3=B8rling <matias.bjorling@wdc.com> w=
rote:
>=20
> =EF=BB=BF
>>=20
>> Yes, these drives are intended for Linux users that would use the zoned
>> block device. Append is supported but holes in the LBA space (due to diff=
 in
>> zone cap and zone size) is still a problem for these users.
>=20
> With respect to the specific users, what does it break specifically? What a=
re key features are they missing when there's holes?=20

What we hear is that it breaks existing mapping in applications, where the a=
ddress space is seen as contiguous; with holes it needs to account for the u=
nmapped space. This affects performance and and CPU due to unnecessary split=
s. This is for both reads and writes.=20

For more details, I guess they will have to jump in and share the parts that=
 they consider is proper to share in the mailing list.=20

I guess we will have more conversations around this as we push the block lay=
er changes after this series.=20=
