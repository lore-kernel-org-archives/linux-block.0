Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B71C2BBCA
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6395C2335A
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 08:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgLPIBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgLPIBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 03:01:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36483C0613D6
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 00:01:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm17so23833868edb.4
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 00:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TK2+rxKYqb9+AHBAgonGhFMhZ04YHGd5Yl1GOTZdM9o=;
        b=SYUUMPDPsVX0FpTrNk7+IQ5D0elUv6IeupWe1gij/Ndb8c/V9x/Kk1a/hMZ3DSrcya
         rTLueIbag23jVSh6DuCDci91vvwkbeVtdkzdyLBjX03sxAZSTUx326bT80TKiskoxwFf
         /nV2JVGwnoB0AMSw/wWg9+AdkZB2VummL91t4yvsfV57cAN7QnyG3hlfCGO0DAs6tKVr
         P2y/GLzf0n7xN3sNeLXhcm3tGn/VmVH0lwEZaP4FiDoUURwVOMaYSWBjCnX2fo2lK9PP
         fYk5wZx7a0lgwK7ek+FVbApRO8viQvM8ygAcl7QwDISMingTpiWejO3g9nEv3szuomgl
         dIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TK2+rxKYqb9+AHBAgonGhFMhZ04YHGd5Yl1GOTZdM9o=;
        b=iQwtx19xqVNmffk9tluYrQNWUctocmJrcZCINC6YSVet1aaX5iF3aZWcwTlm/bmVdz
         Qvpc4YKggYb1rqRcbbyoLcl6ucPxkRvC5Yub8H3h+Al6bhRmqyB2QIOYLuOODkAWGSHs
         T7DKb+5DzFAru6aUrGoQO77gBtaQ2j0Mq8dm7r+8qSnwJpiXyKN6JIpPExQ51+ko5Icf
         q8i885MXUONq7cEZ0ORy9W4Q4y0rQ3kkKBkkr6vTV9w2DJLUNx4SR1AzP4/leGMmn8iC
         dfeyqM0aAUcK55C3TvZ2VCgcD8l1Ait2fHMNgilHXGonfJ5ebVMR8eSL5DPF96+TE2WI
         cndQ==
X-Gm-Message-State: AOAM533lA7FOAT0e7/3c7lNb+dPjVK2mhYWktBhQj9OH+RPy/Psqb3kQ
        GrrKa9H573mmIXeLvshVKIHaDA==
X-Google-Smtp-Source: ABdhPJxH6A/gyCc15lrO0/OaDJzFkcSc/9sFJ1LDfOKXOwmTW6gxp6PK/MEYoX3U6VXHzJvCAUzF7Q==
X-Received: by 2002:aa7:d2c9:: with SMTP id k9mr5614173edr.74.1608105666959;
        Wed, 16 Dec 2020 00:01:06 -0800 (PST)
Received: from [192.168.10.21] (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id mb22sm801178ejb.35.2020.12.16.00.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 00:01:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Date:   Wed, 16 Dec 2020 09:01:05 +0100
Message-Id: <84685B9E-B4CB-4F30-AB58-DB88F117889D@javigon.com>
References: <20201215221254.GA3915989@dhcp-10-100-145-180.wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
In-Reply-To: <20201215221254.GA3915989@dhcp-10-100-145-180.wdc.com>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 15 Dec 2020, at 23.12, Keith Busch <kbusch@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrot=
e:
>> From: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
>>=20
>> Create a char device per NVMe namespace. This char device is always
>> initialized, independently of whether the features implemented by the
>> device are supported by the kernel. User-space can therefore always
>> issue IOCTLs to the NVMe driver using the char device.
>>=20
>> The char device is presented as /dev/generic-nvmeXcYnZ. This naming
>> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
>> for multipath will follow.
>>=20
>> Christoph, Keith: Is this going in the right direction?
>=20
> I think this is looking okay, though I'm getting some weird errors and
> warnings during boot. The first one looks like the following (I will
> look into it too, but I wanted to get a reply out sooner).
>=20
> [    4.734143] sysfs: cannot create duplicate filename '/dev/char/242:1'
> [    4.736359] CPU: 4 PID: 7 Comm: kworker/u16:0 Not tainted 5.10.0+ #172
> [    4.740836] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    4.744228] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [    4.745558] Call Trace:
> [    4.746122]  dump_stack+0x6d/0x88
> [    4.746834]  sysfs_warn_dup.cold+0x17/0x24
> [    4.747656]  sysfs_do_create_link_sd.isra.0+0xb0/0xc0
> [    4.747659]  device_add+0x604/0x7b0
> [    4.749298]  cdev_device_add+0x46/0x70
> [    4.753241]  ? cdev_init+0x51/0x60
> [    4.753246]  nvme_alloc_ns+0x670/0x8a0 [nvme_core]
> [    4.753249]  ? _cond_resched+0x15/0x30
> [    4.753253]  nvme_validate_or_alloc_ns+0x99/0x190 [nvme_core]
> [    4.753258]  nvme_scan_work+0x152/0x290 [nvme_core]
> [    4.753261]  process_one_work+0x1ac/0x330
> [    4.753262]  worker_thread+0x50/0x3a0
> [    4.753264]  ? process_one_work+0x330/0x330
> [    4.753265]  kthread+0xfb/0x130
> [    4.753266]  ? kthread_park+0x90/0x90
> [    4.753269]  ret_from_fork+0x1f/0x30
> [    4.753272] CPU: 5 PID: 88 Comm: kworker/u16:1 Not tainted 5.10.0+ #172=


Mmm. I=E2=80=99ll look into it. I don=E2=80=99t see this in the config I=E2=80=
=99m using.=20

>=20
>> Keith: Regarding nvme-cli support, what do you think about reporting the
>> char device as existing block devices? If this is OK with you, I will
>> submit patches for the filters.
>=20
> I'm not sure I understand what you mean about reporting these as
> "existing block devices". Are you talking about what's shown in the
> 'nvme list' output?

Exactly. Do we want the char device to be listed?=
