Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5662CC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244B82148E
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcxr0LBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfDHPOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:14:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52029 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfDHPOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:14:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so14810211wmf.1
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0Pg/PPOhnVEHU5+v9TN+1h+o1cyHfmj4yiNKzFut/NM=;
        b=gcxr0LBkwUedpN1uWMk5UjYOOqRw/bI4NluLcuhe0ZJN4RFyMwGUQAex+jpA9d7gyJ
         qy96cJwTsdDLagkZxj4ueGRkDqSUI9yeV3WW3WDtEZ8gK6QFFXUN2+LZKXsE9y+2yoxe
         nYFpgMoi7EDi97xu3INgW1NGRtFlAQ7hVS4jyvDd68MPFEDDbD5C5eRbYB/MPpqLdYEq
         ArUzSUVegGWhYBND4Slp2Sjs7ieYkOKuB03m9cxpWYRZq1JR4p72YQwV8vJq9kpLVWRB
         ON6gIlMg6sqW+EeW0LLIPG7UT4d9t1Jqor6MpTCvA1+n6jGQCWHcSL/LTgrI/47/sIYg
         kqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0Pg/PPOhnVEHU5+v9TN+1h+o1cyHfmj4yiNKzFut/NM=;
        b=QG3/Yzl0GO7JhdLSXQZoLNxa8gcFfn7AXNr/4uZHp0NKoUDFAuxNdo75rtDXVb9/zq
         gvLzYYD78rHjHoFbjjY18e6ibVYfZDDLZ7IWkLiTYT//kcZ/gNVdZV64EnW35QbOyxFm
         t6q3MyBpVIEWbICMaiqXk85x2ku8TZ25rp+wWyKosz627JLucYqESyXQM1kIMOQaAXmw
         sTvIOKmrM16vdOqe7DJeSwbXQYR6bNAVdhnKq16tKXwBydVuEbnhfPzRBqpdhigIBul7
         y9/cpSQv5vnmwX3mNTEVIhJa1kinKFTCsbZ7/ruHUA5W0C3OkUu9atq92nDL6AoPv4Ie
         MyEQ==
X-Gm-Message-State: APjAAAU2XF5UB6AR7SMbyZLS5gCTN0i3WQdFxe+60PBAtsT5iDLHc+I8
        Mxc59YqtKN0JxW/XwBWGtanbFQ==
X-Google-Smtp-Source: APXvYqx+S8Z4kvY0NQ2cuKE1qG39KukdnqgvPb+He9wdxp+NcPmwwAVvkdRXG1p4HS0xYR4SJxT4GA==
X-Received: by 2002:a1c:6783:: with SMTP id b125mr17728924wmc.79.1554736484636;
        Mon, 08 Apr 2019 08:14:44 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id z1sm25372163wrs.52.2019.04.08.08.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:14:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190408150828.GC23021@linux-x5ow.site>
Date:   Mon, 8 Apr 2019 17:14:42 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
Content-Transfer-Encoding: quoted-printable
Message-Id: <5283A08F-FD6F-4A9C-841D-B49CE9B4CF1F@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
 <20190408150828.GC23021@linux-x5ow.site>
To:     Johannes Thumshirn <jthumshirn@suse.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 17:08, Johannes Thumshirn =
<jthumshirn@suse.de> ha scritto:
>=20
> On Mon, Apr 08, 2019 at 09:05:19AM -0600, Jens Axboe wrote:
>> I did consider that, and that would be doable. But honestly, I'm =
having a
>> hard time seeing what issue we are attempting to fix by doing this.
>=20
> Yeah, I guess the real fix would be to update the documentation and =
the
> expectations user-space has. Including eventual re-write of some udev =
rules or
> whatever is facing these files. But to me that sounds more like a =
systemd or
> even distro thing than a kernel thing.
>=20

Unfortunately the user-space people I have interacted with find crazy
to have to change their software to call bfq.weight the weight of a
group.  And are not willing to do it [1].

Thanks,
Paolo

[1] https://github.com/systemd/systemd/issues/7057

> Byte,
> 	Johannes
> --=20
> Johannes Thumshirn                            SUSE Labs Filesystems
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

