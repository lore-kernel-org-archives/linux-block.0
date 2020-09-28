Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC6C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CD921D7F
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F70VgFIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1Ngu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1Ngu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 09:36:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE898C061755;
        Mon, 28 Sep 2020 06:36:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so1410758wrn.0;
        Mon, 28 Sep 2020 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vy4kzQyF2IDjqBaHr91Kux6zbP14BgENrqcc/gCSvtU=;
        b=F70VgFIeZnxmC7YhnypgTCceCkjK/weqIX8EuHz4pUzDKCdTY/AMS2Zy9esi7dMN4n
         KUiUt2Kl6y6lB1Urttr2xAfQvB3WRAHd5sEEl7XvZTid5M8KNAN0iJvao9TeuofQ4HKE
         UrpTSC7fT8aOyq6E0a2gQl1it9hi7mfoV9PnxbYyF2db33MSNcKiK1JRlLco2AbsBBUo
         smO3mP6HZKjZgWtABxV04mJ58D50DxdeU8GbCvNvXZ6wXbIVajx8TolTxk0jiB7+Qvdy
         71ZyPZauU3UesKs3HpoT9QHzyBdMHYn/aaueJg3xaN+ZQaPokBPCV0/UXT9y1hHoHSTS
         XMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vy4kzQyF2IDjqBaHr91Kux6zbP14BgENrqcc/gCSvtU=;
        b=Zy6IZIu4x8k1SF+paOxWqFfW9rYIozxBA/PoEyZe6Vdw3fp5XwHxoFRn6TIsPEFKx9
         RgT488pvFlRAIEReREMvF0bEjLRT2qYuO1OKAvMEgODX0y9beGA2YzxJm3qKTb0XAlbB
         5DF5XJtAKI+6Vp6wZ64QezRPlfXLLr9d+vdXtDncX6PiM8zliJHsraCRa1Tpw+kqaYiE
         Ou/RBkGQXLNVZ65ZKL4rkBbH38kQ44P4oldfcrgmJRC6Ws3HotLpJd86uNlNWsSyM5te
         iaMRbiTjsVe4GkTNByBUbm6BNiRdgfy1Bnf4IPPQ5Mmy/mM9ActyHcGF2fL8BkpSS54o
         2c4w==
X-Gm-Message-State: AOAM531dzMYEcA+z3bX4oAPlLrOjAy0bQN5WfCvBRNXcW7IKHJiyLmdR
        D8uyGVfD6aWjvMaprE6CVJ4=
X-Google-Smtp-Source: ABdhPJxXUsKq6vGViYR/BdWe4EnU5l/DPOLaiuqTZOfuzeXXujV7aoWwEqc2tWUm0BQCR7YD85b3yg==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr1765699wrs.48.1601300208373;
        Mon, 28 Sep 2020 06:36:48 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y6sm1508341wrn.41.2020.09.28.06.36.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 06:36:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Deadlock under load with Linux 5.9 and other recent kernels
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <c05ae5ee-535d-ad2a-ce7e-137c428eb83b@gmail.com>
Date:   Mon, 28 Sep 2020 17:36:44 +0400
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        furkan@fkardame.com, Brad Harper <bjharper@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE8CADEC-593D-4712-A422-97AF44D95210@gmail.com>
References: <5878AC01-8A1B-4F39-B4BD-BDDEFAECFAA2@gmail.com>
 <4a51f6d8-486b-73ee-0585-f2154aa90a83@kernel.dk>
 <EE8C801E-0AD8-43E2-9C65-92CD512904BE@gmail.com>
 <c431ae48-6913-acc0-dc0a-b52065e9eaed@kernel.dk>
 <91886A80-8164-4699-8662-E7D3444A4F12@gmail.com>
 <BA41AA25-8647-474E-87E6-64D4F030E590@gmail.com>
 <c05ae5ee-535d-ad2a-ce7e-137c428eb83b@gmail.com>
To:     Patrik Nilsson <nipatriknilsson@gmail.com>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 28 Sep 2020, at 3:06 pm, Patrik Nilsson <nipatriknilsson@gmail.com> =
wrote:
>=20
> Hi!
>=20
> To me this bug description is very similar to what I'm struggling with =
on an amd64-platform.
>=20
> When I get too much data sent via usb, it seems as the usb controlmsg =
is delayed so it times out and unmounts the block device.
>=20
> I have been working on my related bug for long to get it easily =
reproducible, but failed. It is there all the time. New hardware is on =
its way so I can continue my testing.
>=20
> Maybe you can test the patch I'm using to see if it works better for =
you?
>=20
> In the meanwhile here is my description of my bug:
>=20
>> I have stress tested the usb system. To the USB is now seven =
mechanical hard disks and two ssd disks connected. Six processes are at =
the same time writing random data to the disks. One of them is to the =
ssd disk I couldn't write data to before without it failed. Also the =
other usb-ssd disk is my root partition.
>>=20
>> Before I applied the patch, my root partition sometimes failed to be =
kept mounted. Now I have not had any crashes.
>>=20
>> This is a quick fix for hard disks, but working. It continued to work =
when I started three virtualbox guests and let them also do work. The =
guests' hard disks is on my usb-root partition.
>>=20
>> It doesn't work if I also use my usb2ethernet adapter (ID 2001:4a00 =
D-Link Corp.), although my root partition and two randomize tests =
survived. Maybe a much larger timeout in this case will help? But this I =
don't find as a good solution.
>>=20
>> The behavior is the same on the other (much slower) computer with a =
different usb hub. I have also tested it with exactly the same setup as =
earlier, with no mechanical hard disks, and it works with the patch and =
not without it.
>=20
> Best regards,
> Patrik
>=20
> ---start of diff---
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 5b768b80d1ee..3c550934815c 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -105,7 +105,7 @@ MODULE_PARM_DESC(use_both_schemes,
>  DECLARE_RWSEM(ehci_cf_port_reset_rwsem);
>  EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
>=20
> -#define HUB_DEBOUNCE_TIMEOUT    2000
> +#define HUB_DEBOUNCE_TIMEOUT    10000
>  #define HUB_DEBOUNCE_STEP      25
>  #define HUB_DEBOUNCE_STABLE     100
>=20
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 20c555db4621..e64d441bb78f 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1841,8 +1841,8 @@ extern int usb_set_configuration(struct =
usb_device *dev, int configuration);
>   * USB identifies 5 second timeouts, maybe more in a few cases, and a =
few
>   * slow devices (like some MGE Ellipse UPSes) actually push that =
limit.
>   */
> -#define USB_CTRL_GET_TIMEOUT    5000
> -#define USB_CTRL_SET_TIMEOUT    5000
> +#define USB_CTRL_GET_TIMEOUT    10000
> +#define USB_CTRL_SET_TIMEOUT    10000
>=20
>=20
>  /**
> ---end of diff---

No obvious changes with this patch applied. Here=E2=80=99s output =
https://pastebin.com/raw/ZMgwNqgm

Christian=
