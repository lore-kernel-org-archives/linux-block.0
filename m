Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9855BEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjF3Odq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjF3Odp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 10:33:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F313FF
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 07:33:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3141140f51bso2289462f8f.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688135621; x=1690727621;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsEa83LElgV+AQL5e6o9aSSV0H6S/EdnOsnoqxBROhA=;
        b=H+Os4B7hYlGqCKP3ZBTL1CfbmQZAnDdA1Ma95DpqUEcPbitEtWpwDZroRvTY/Yd+Qj
         55yAJTSAzluveA0lcf4cot1uAHJTD5IxVpP3U33+/25vUo2yQRW28xqYUacd7JpKTaQh
         0VxMG0rwaI0ypKW1awW+rOqc8asLoLz7ciVrdelUHf6oWeLftc1sAUrqENr429lDxrzf
         FfsT0Dj5SON37+8P+ZGLYBM6o+r9QWBX7Y3/1j5+d5tP1FCetdVBNlx+x/+BbPCyx84n
         ZquXktVmxqaGYy6LVAUF+PgYVyVwYTx+dhsV6xlnBXXBCPycrfu4P2TfQWio0GPm0uTR
         DKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688135621; x=1690727621;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jsEa83LElgV+AQL5e6o9aSSV0H6S/EdnOsnoqxBROhA=;
        b=LJStY3qSpDfiHTOorX3ln3hcXzVQ7VUWh2DXCD/zDknnP00x9AQLj9SlnK9BHbVf3B
         NMPIr0cPwDBG5QLTv8myaynr7vJ3jyilwlTY/tyZuAw/bK6FgeLB/WKuMnNjSTJfvR46
         5JkrAWhf0flPcv1aWXxWUk0Zv3AY1E3y7Tg66nk4BGc9RakI5xuosA8Ge4MncUDgp2Bx
         J1s1vR84NOijTgwCdpdVWk0qi0F5qYuivs3zlQvjOqnruwuxAgwYrAHIYhkeukRQYvgF
         3gT+iA4Iocf0rbYaKRldDORxQiQevqAtFyQ7IfAzXEjfh9Xy3N7Lsf1zmrL5mlgOyKda
         MVoA==
X-Gm-Message-State: ABy/qLahpLgeioudJkvSk7sN2dcL/IhXDATmO/j5jh0QAqCdPsj+W6bK
        guFGio+3anWZ20i2dbhvUjXH5u+Bq8TZFfyudw0=
X-Google-Smtp-Source: APBJJlEARPMz2iDUCKng8lbKud0V7d0IOK5so+Rb4Rp4FIFyLs2G3PYHzo7Q0PG2iYHKhBDbiuYT0A==
X-Received: by 2002:a05:6000:1cb:b0:314:13a6:af20 with SMTP id t11-20020a05600001cb00b0031413a6af20mr2161017wrx.31.1688135621090;
        Fri, 30 Jun 2023 07:33:41 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d6986000000b0031130b9b173sm18354949wru.34.2023.06.30.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:33:40 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <5F597343-EC91-4698-ACBE-9111B52FC3FC@wdc.com>
 <b29f01c287c7469f47fb4b689a3cba68@opensource.wdc.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     aravind.ramesh@opensource.wdc.com
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 0/4] ublk: add zoned storage support
Date:   Fri, 30 Jun 2023 16:26:28 +0200
In-reply-to: <b29f01c287c7469f47fb4b689a3cba68@opensource.wdc.com>
Message-ID: <87edltdnp8.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


aravind.ramesh@opensource.wdc.com writes:

>> =EF=BB=BFOn 29/06/23, 12:37 AM, "Andreas Hindborg" <nmi@metaspace.dk
>> <mailto:nmi@metaspace.dk>> wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com
>> <mailto:a.hindborg@samsung.com>>
>> Hi All,
>> This patch set adds zoned storage support to `ublk`. The first two patch=
es
>> does
>> some house cleaning in preparation for the last two patches. The third p=
atch
>> adds support for report_zones and the following operations:
>>=20
>
> Just to clarify, we do need you ublk user space patches
> to create a ublk device node (with these patches in kernel), right ?

I provide an example implementation. I put a link in the cover letter,
but I think the sentence referring to the link got lost, thanks for
pointing out.

https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952dd88=
bf5e668b

This implementation is based on Ming's ubdsrv code. You do not need to
use this one, you can write your own. I am also working on an
implementation in Rust, but that is still very early. I think Ming is
also writing a Rust library for user space ublk devices.

But currently my patched ubdsrv is the only user space implementation
supporting zoned ublk devices (with the loop and null targets).

>
>> - REQ_OP_ZONE_OPEN
>> - REQ_OP_ZONE_CLOSE
>> - REQ_OP_ZONE_FINISH
>> - REQ_OP_ZONE_RES
>
> REQ_OP_ZONE_RESET

Thanks!

>
>> The last patch adds support for REQ_OP_ZONE_APPEND.
>> v3 [2] -> v4 changes:
>> - Split up v3 patches
>> - Add zone append support
>> - Change order of variables in `ublk_report_zones`
>> Read/write and zone operations are tested with zenfs [3].
>> The zone append path is tested with fio -> zonefs -> ublk -> null_blk.
>> The implementation of zone append requires ublk user copy feature, and
>> therefore
>> the series is based on branch for-next (6afa337a3789) of [4].
>> [1]
>> https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952d=
d88bf5e668b
>> <https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952=
dd88bf5e668b>
>> [2]
>> https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspac=
e.dk
>> <mailto:20230316145539.300523-1-nmi@metaspace.dk>/
>> [3] https://github.com/westerndigitalcorporation/zenfs
>> <https://github.com/westerndigitalcorporation/zenfs>
>> [4] https://git.kernel.dk/linux.git <https://git.kernel.dk/linux.git>
>> Andreas Hindborg (4):
>> ublk: change ublk IO command defines to enum
>> ublk: move types to shared header file
>> ublk: enable zoned storage support
>> ublk: add zone append
>> MAINTAINERS | 2 +
>> drivers/block/Kconfig | 4 +
>> drivers/block/Makefile | 4 +-
>> drivers/block/ublk_drv-zoned.c | 155 +++++++++++++++++++++++++++++++++
>> drivers/block/ublk_drv.c | 150 +++++++++++++++++++------------
>> drivers/block/ublk_drv.h | 71 +++++++++++++++
>> include/uapi/linux/ublk_cmd.h | 38 ++++++--
>> 7 files changed, 363 insertions(+), 61 deletions(-)
>> create mode 100644 drivers/block/ublk_drv-zoned.c
>> create mode 100644 drivers/block/ublk_drv.h
>> base-commit: 3261ea42710e9665c9151006049411bd23b5411f
>
> Regards,
> Aravind

