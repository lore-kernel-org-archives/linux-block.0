Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB0C433FE
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 07:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205BB6126A
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 07:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhKEHsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:48:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5091 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhKEHsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Nov 2021 03:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636098358; x=1667634358;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4Mr6C2Q26HRBt5U9/UxcMoj0kfBczAtbDc8YvXZrep8=;
  b=XvWAcTY87jDWm8fyh5uc+G3hw4nmx2Ngcu+X3H7pMjDoWPf7W5DiE8Lp
   nSW6Ae6AOpjx/6x8/RR6sVzkijit1Kv3Ev+bDf14f8KIPMHpaU8mLEdrh
   +lbT7AlJO3exW3X4+sPdASWxnYlkuda4rkcbsUhDnr6HSzUug2UXXv4nY
   CMQlpUNxVSzCP2HDyTocVU+jV2bRs5UwLAEOaPQxpLkiK4MPz1FgTbSdt
   g6lKGspFbH5dHrpVGXOnhQCrRRQUbJGECqn5XFSlbqRve5eTMrEEZOzus
   8rGCjPC/T2OM2bD+DNu6GJ+B46nb/1JU+82cKyisZoepX8zwM+8l2dRrV
   A==;
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="184772919"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2021 15:45:57 +0800
IronPort-SDR: WOHKtZrGWnTsUZg8CZjiw4kyte/Og+eb9FtIzjBbCBBveUR6xhIqjUKRgedlMamFpO7VqW72WQ
 PC60Cundz7+/VQiJAnfEsmvsjfRk34KAPS+wqS+XhRNoKvxyBLNHARF+5t7gO8P50mx1/rnNXt
 bc6IiPrdHVmr45YekpZomhtWlDGb7HX9EZIgubtzoPvbniDonw9f1MQORAiaKIbso2+oG4oRUr
 xCpV0p+e/wuRTcXOyYUcixfHdKC3a6JMnH70Z2EqPXWv7dEYX4mb+3XQXOPap1fxhZWr3Bk706
 ga6dnmYc7ZZLkdXxCN0j0o9u
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 00:21:15 -0700
IronPort-SDR: zCePlzCLi3aOUNTHi/DzZL+fRPlNqhVAT8DTbC0l7LdHCqXwNoqKqmU6NJCaMK99oyLJ+SKMbv
 0YnXysOKUwc/cT77699VbMZx2kUCIkaTsZvvGe3jzHOljNplK1jSgsW7WdRQYb0uXb67crj7i9
 rGnWqw9+juG1OG037Bvf4apWqGfL/ltbX35AVcH1wGBsieTP9c6XGk7V8zOZzRvNpJ9aMvo97+
 pwEzJoZlNl4EKDhfpyP4QsEGTopjB4M8A7Dc4hdLrlREqium+ZnfsLA6dmns+VxJIAaORjCLwR
 Ijo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 00:45:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hlsxy1NKfz1RtVn
        for <linux-block@vger.kernel.org>; Fri,  5 Nov 2021 00:45:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636098357; x=1638690358; bh=4Mr6C2Q26HRBt5U9/UxcMoj0kfBczAtbDc8
        YvXZrep8=; b=Be6shJpvuB17YRdUvO3QXhwS4K12/Adc+bxGc37hrR/n8o6mRMM
        0x45ovjszb/67rQXuD/XuZPqR+PFW8IdMgN1QcESwuk+iECec79mF2cxCbeshGfN
        9XgnBa+Zu75+/mMNBXuI4r96mR922ZKOv6Ms397iAgwbMAz2b4FTO2Lf6z7A1uFN
        3DEAmqYzH1OOU2A5lK7nC3HDv2ateUZeDjeS8FwKqTNnXXDC3y1ol/KhDJEKyeWp
        OkyiU23qjepJ/j33XQG/f4YMbrqTUbjOVxNX/Mq7su/8/XKZq+2da5C1OlSZ33Yb
        cUD1ayAYG8qb8rSd9BRnCqLizxpyCLJ8OJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id paQMlwG39rFo for <linux-block@vger.kernel.org>;
        Fri,  5 Nov 2021 00:45:57 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hlsxx0nN9z1RtVl;
        Fri,  5 Nov 2021 00:45:56 -0700 (PDT)
Message-ID: <9c14628f-4d23-dedf-3cdc-4b4266d5a694@opensource.wdc.com>
Date:   Fri, 5 Nov 2021 16:45:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: Unreliable disk detection order in 5.x
Content-Language: en-US
To:     Simon Kirby <sim@hostway.ca>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20211105064623.GD32560@hostway.ca>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211105064623.GD32560@hostway.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/05 15:46, Simon Kirby wrote:
> I'm seeing disk detection order changing across reboots on 5.x kernels
> (5.4, 5.10, 5.14), but not 4.9, 4.14, 4.19, with megaraid_sas (Dell
> PERC_H700). With 13 disks and 5.14.14, the order changes almost always.
> 
> I did initially try to bisect this issue, but it seems to become more
> rare in earlier kernels, and there are some non-booting problems between
> 4.x and 5.x.
> 
> The most common effect is swapping of sda with sdb, or two neighboring
> devices in the list; for example:
> 
> # diff -u lsblk-S-5.10.0 lsblk-S-5.10.0-2
> --- lsblk-S-5.10.0      2021-11-04 15:23:23.767008360 -0400
> +++ lsblk-S-5.10.0-2    2021-11-04 17:34:37.748310196 -0400
> @@ -1,6 +1,6 @@
>  NAME HCTL       TYPE VENDOR   MODEL      REV TRAN
> -sda  0:2:0:0    disk DELL     PERC_H700 2.10
> -sdb  0:2:2:0    disk DELL     PERC_H700 2.10
> +sda  0:2:2:0    disk DELL     PERC_H700 2.10
> +sdb  0:2:0:0    disk DELL     PERC_H700 2.10
>  sdc  0:2:3:0    disk DELL     PERC_H700 2.10
>  sdd  0:2:4:0    disk DELL     PERC_H700 2.10
>  sde  0:2:5:0    disk DELL     PERC_H700 2.10
> 
> This is happening on vendor (Debian 5.10.0) and home-built kernels, and
> on a variety of hosts. On all kernels, the detection printks come up in
> an interesting order, but in older kernels, it always ends up with an
> sd-name that is ordered by SCSI ID ascending:
> 
> [    2.289776] sd 0:2:0:0: [sda] 999030784 512-byte logical blocks: (512 GB/476 GiB)
> [    2.289918] sd 0:2:4:0: [sdd] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.289947] sd 0:2:3:0: [sdc] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.290032] sd 0:2:6:0: [sdf] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.290210] sd 0:2:7:0: [sdg] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.290248] sd 0:2:9:0: [sdi] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.290323] sd 0:2:2:0: [sdb] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.290461] sd 0:2:5:0: [sde] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> [    2.290476] sd 0:2:8:0: [sdh] 11719933952 512-byte logical blocks: (6.00 TB/5.46 TiB)
> 
> Full "dmesg" is saved here: https://0x.ca/sim/ref/5.10.0/dmesg
> 
> Any ideas on suggestions on what I could use to track down what changed
> here, or ideas on what might have influenced it?

Most distro kernels are now compiled with asynchronous device scan enabled to
speedup the boot process. This potentially result in the device names changing
across reboots. Reliable device names are provided by udev under
/dev/disk/by-id, by-uuid etc.

You can turn off scsi asynchronous device scan using the scsi_mod.scan=sync
kernel boot argument, or disable the CONFIG_SCSI_SCAN_ASYNC option for your
kernel (device drivers -> scsi device support -> asynchronous scsi scanning).

But even with synchronous scanning, device names are not reliable and there are
no guarantees that one particular device will always have the same name.



-- 
Damien Le Moal
Western Digital Research
