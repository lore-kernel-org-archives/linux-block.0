Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED438C43217
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 07:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJMHMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJMHLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 03:11:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA41FFF93
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665645100; x=1697181100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s9hcQcdAlAzyhKMWI+wdGejeFtAk0WjChyhpIcsu+pQ=;
  b=lxiBc3E/QsN+x2U0R0QfhExGvxn6IqEjLXWrE/HhAFWMQ03YS/0diCm+
   a+aNhSkGcrpgkuwKTrxJX55HVVp6/jo0Phf4zwIDgi0DgsPXm+2ZuSQwz
   UxIsvHNl+BCHZIHYNdjfK3rCgaX+kZcA0TZamUe0zisuYl83E1xn8JFk9
   PdONYMOE/UdhJbVPCkYEA+KiGR4F95Sv6TBMsIKTGZd9WTqbttLxTM2yd
   wJiIH+LvPcxe7XPKaGlscwFZRJ3lUOVKBd/ZPEeWJ//6ywLZfil4UuAAd
   CEBTXHv3uCUK1UOo0LvpObJgbSrvRxFx8mmdaW6VbrcomHbcQ4nlc64mB
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="214073745"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 15:11:34 +0800
IronPort-SDR: bUjl/o2rIcC5gjXrGRugWfhhoJp1lp5eH6Pqslv27nkdEJhQAUgnQBkXt5eKxuZ4EpNVffoTDL
 DzFw3ZdYYqIq1mlNznTgSTqYkbIKCLSuXG4ENzZiwSsKpXYfdyOgXG2ajGeWoWWYCi69GoqXfv
 Bc8AZbpB7wLVe9ivqEQznpEes3OHcmvbPFQIerQoZYXySwf4RhpDI0ATdQPR4xOp04cUOZWVpe
 k35+bnryfFJptlXVRU4Y/M5/vsdsyBqtC3t69HowZDTIOuFI4eSzvEaYU0pip5APIEurdjfOCY
 P4xgo+6HdGSQgPmUwp30opOt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 23:31:13 -0700
IronPort-SDR: IqDDYJ4ZIt5Pg4TcbbZgif3qdadVaODyr/xto1B7wSBAWJSrOM+fjQ3iO6zWiUgX5275W4Izf0
 FfmTSPmMV70T9KumLRo7qHNPbi0DZ9krtpJyhP9ysg+Sww53uUzrzYRBbO99yhXowBV1LomB+A
 avWdtRmCN9vVb6XttiGE5lUnOWFmGsfzK/WgRFtlanR3QQHriiJ7UUjQhaopz89+CnefrI3fAt
 EO+3y5wILnVD56gMecAX/l/UvLdFU36ORvsQSyu/Cx7PcvGKAXlWAaZ8tdi9trTezvS3E7T0dk
 i3E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 00:11:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mp10P6Y6qz1Rwt8
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 00:11:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665645092; x=1668237093; bh=s9hcQcdAlAzyhKMWI+wdGejeFtAk0WjChyh
        pIcsu+pQ=; b=E2qH8RgJd3gtBWYAORPFpgQaSWrC9PBc2Az25CwFOjOp7LLwl6k
        jvPcf8DEeRTKatzK97j5Z7Nd+h8tZefe47khQ5qrcJwCV9ICM2gLmslL34WENuqK
        d5FPrWZLObqk0R5O8Oac8mAl5oGW21cp0tICCtp+wHRRZ2aVCiGse1C7DH+KM86M
        bD0pIuFXhNNtDKFod35yzP0p5j9GOnEPNLk7RKi+/kPBh0RkMZ5xZTsWGFmyCTJr
        4jZ6poKF3w5HHS9HaYf4DOTMPRXGh1gXNbLPgItU2S+M3GgVUhH55cuMhTipeyqd
        E9S/6AfN2/JPDNgqLHEMQy1MYC5RujDpOaw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BdIilEQTNPNT for <linux-block@vger.kernel.org>;
        Thu, 13 Oct 2022 00:11:32 -0700 (PDT)
Received: from [10.89.85.169] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.169])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mp10L5vWSz1RvLy;
        Thu, 13 Oct 2022 00:11:30 -0700 (PDT)
Message-ID: <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 16:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/12 16:24, Naresh Kamboju wrote:
> On TI beagle board x15 the connected SSD is not detected on linux next
> 20221006 tag.
> 
> + export STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> + STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> + test -n /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> + echo y
> + mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> mke2fs 1.46.5 (30-Dec-2021)
> The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does
> not exist and no size was specified.
> + lava-test-raise 'mkfs.ext4
> /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
> exit'
> 
> Test log:
>  - https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 7da9fed0474b4cd46055dd92d55c42faf32c19ac
>   git_describe: next-20221006
>   kernel_version: 6.0.0
>   kernel-config: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/659754170
>   artifact-location: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F
>   toolchain: gcc-10

The kernel messages that are shown in the links above do not show any "libata
version 3.00 loaded." message nor any ata/ahci message that I can see. So I
think the eSATA adapter is not even being detected and libata/ahci driver not used.

Was this working before ? If yes, can you try with the following patches reverted ?

d3243965f24a ("ata: make PATA_PLATFORM selectable only for suitable architectures")
3ebe59a54111 ("ata: clean up how architectures enable PATA_PLATFORM and
PATA_OF_PLATFORM")

If reverting these patches restores the eSATA port on this board, then you need
to fix the defconfig for that board.

-- 
Damien Le Moal
Western Digital Research

