Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4ECC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B70B20791
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 16:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="fo9I1T9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgFZQZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgFZQZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 12:25:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBEC03E979
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 09:25:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so7374846edr.9
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=JmQ1A0vGh7Xxt46gow4Vy8pp18yVO8i7HKAvWSMhmBk=;
        b=fo9I1T9uGN5+4oNHkuOJ7sTyIW12MmMPzQeYW0gUtg+XfqwkgRXBDE7XKbsJn2TMCT
         PnXdSvbPiqFcOUF0RtAI9HSNXGOIt0bgB5d/t7fBBARbJTH2tA8iCxFxqOELGm3vtZC1
         EUoZtT3tohebDXXlAysvvFbXVjrDRPtEMoDRerqhtg5MpG/Lin+52/tRA4YtHT6y9aF7
         j390lVVZ6Rk2c87ul62gYhHP8hOPdOZDPl9jKnPGOnBDNT4mehGTEwY1oJMQCa1D5FEK
         iLksPKy81v8AZr9oC+imn6IT0fFszpWVuwNwiPYk+02U+3Ttz57rpwslcln7uHcuCK8C
         xpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=JmQ1A0vGh7Xxt46gow4Vy8pp18yVO8i7HKAvWSMhmBk=;
        b=fggieE2q+fEot+PNEc3W9IcFVFO1RXB/rFaYro7ESTN0+Md4IBZiuXLkYwHQ9ti8GD
         eHi0ASwePSdr0XCMbBEkBUSeYmyQIhmTHS3uPe7f+BM4xSo20d6jNC4ttIQ+4/SvR4Z7
         54J5XSwkTFjPQwyBcZ5vGiwNYNn/+wROnM9j9XoQjWXw7YsinfWRRoRh7I2ZXTyxut5j
         6BM5FltbsaY9GrDlXYMZbT4TyZ6nCwi77Hyh1jdDXhm/ZUkvpmYR/arKn8w38bjhxOqg
         4r8FEBjhXWN/Tl9tJzewMDXNJXRLf4HTY6LG0GPmccjsPqM8nKsM4g7rhEmhlgmaMSzD
         Ac5g==
X-Gm-Message-State: AOAM5309gYmHGkH0f8ifAoYsR6wMzckRNvGEkju2hfpgUxTNL/vEtoDD
        CNPFn2VOl4GaW1/olKNxFvIzPg==
X-Google-Smtp-Source: ABdhPJxOEtUI8X/VPkdyKqw3YxFUm77242GA2tpY1LE/AGyLDwTVZDpZaZjuU3yr83xqTCR4wojHvA==
X-Received: by 2002:a05:6402:1217:: with SMTP id c23mr4169817edw.270.1593188707993;
        Fri, 26 Jun 2020 09:25:07 -0700 (PDT)
Received: from [192.168.2.16] (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id lv17sm9073093ejb.56.2020.06.26.09.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 09:25:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Date:   Fri, 26 Jun 2020 18:25:06 +0200
Message-Id: <E5BC0C5B-C99F-40E2-9C17-0AFEFCE2446A@javigon.com>
References: <20200626155225.GA1774486@dhcp-10-100-145-180.wdl.wdc.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <20200626155225.GA1774486@dhcp-10-100-145-180.wdl.wdc.com>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 26 Jun 2020, at 17.52, Keith Busch <kbusch@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, Jun 26, 2020 at 08:28:28AM +0200, Javier Gonz=C3=A1lez wr=
ote:
>>> On 26.06.2020 05:25, Keith Busch wrote:
>>> On Thu, Jun 25, 2020 at 09:42:48PM +0200, Javier Gonz=C3=A1lez wrote:
>>>> We can use nvme passthru, but this bypasses the zoned block abstraction=
.
>>>> Why not representing ZNS features in the standard zoned block API?
>>>=20
>>> This looks too nvme zns specific to want the block layer in the middle.
>>> Just use the driver's passthrough interface.
>>=20
>> Ok. Is it OK with you to expose them in sysfs as Damien suggested?
>=20
> sysfs sounds fine to me for some attributes (ex: mar/mor), but I don't
> think every zns property warrants exposing through this interface. I
> just don't want to corner driver maintenance into chasing every spec
> field. If applications really want every last detail, they can get it
> directly from the device without any kernel dependencies.

Ok. Think Niklas sent a patch with mar/mor already. Will check which ones we=
 depend on in user space.=20=
