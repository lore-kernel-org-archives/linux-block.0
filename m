Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3736C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjC2IVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjC2IVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 04:21:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C805FCA
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680078010; x=1711614010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wj1lP/+wUwSzWlSJRPb4INL+mjheKwhJzgjuShBdobw=;
  b=eyoaCziUE49uEnO1aLCNpYvV63EJ4Guo1J7Rx7FvBl+nPNkqimwAXNnd
   FjXm/it48iJbANecHO8azm/olIRgtfkKe6FbyL3xPtEnNsIpDriPN/CT6
   sI5WK2cfyG4icKH8ZcT7wpSNXOPfxFB6l0jgxpYIIE6g8h52q8oZetfLp
   cWAdq1Vdb+sRXWFRzu/JTMS/V5wvuATs8vzcwHOo/dIHDhtXJxRy0RAJi
   7XVKs8/suzhmUkhnxR9BhCkzfQCD40aXG/WQFqYQ/qAW5lx2+glkR4Gc3
   q68TxmVxbCIdROFrVSbz3G7lxEH0z8m1Pqmwc1nSnLfY46DuajXksT1yA
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="331212189"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:20:09 +0800
IronPort-SDR: 6j47PNrJLWaJ3viy8dj1yk/xdjNAKrlSYc524bCySonY/tcSOp9vPpZwgEKOVmoQcMYEfuZZ0/
 3BqAZtcaLU1+dt7dJz/kj6NH54x4T71CuOFunh89qDKFOwUoZJpb5TyupuMIw03DqmawhpnJEx
 EBYFtahV9fGsaSj0z+7aYaDS07n9mq3PURAeoEYBNpXLyJvvUjM2OZycPfiQUzb24ZGoyZ/wrL
 +JNT+lsPqydaFqz5dfNDJKc7YK5DwHiFjWiSgE3XLBwr/GxIp1N5ngaGacdX4qrk8BqrWn6Vgf
 zJo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 00:30:38 -0700
IronPort-SDR: ZAtHlZvDzZQtbCvxt97Bo4/PgmFBS0VnawT2ixxIidHiCZnhZVxDKgp8jyFpb6vH+mJBmDDt+y
 UcSAlFVyRflAbx1SIKLATe9Eip3DORMHTsb9PcwnDA82xgRsq1wi1C3Dk2v/z+SNYFIlOCvhRM
 ACHuhFXUR9vYP4a4G6GzCJ2pfNtgqXFW/XIz4SX8U5YPdc5Tr8dnVOz5d7c2/zCC+viGMjZWDo
 NR3B4bp4g1vpHaVGJv6izaApwN0n/3zJA5QsyPAeEJrSV8Y2EtPHPJEx2ZNByRXD5Oo/1dcFgS
 9Y8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:20:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmfcT2XrYz1RtVv
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 01:20:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680078008; x=1682670009; bh=wj1lP/+wUwSzWlSJRPb4INL+mjheKwhJzgj
        uShBdobw=; b=DJp/nSWD9r454hOJLxOObPQPdK7fHluAEhgRT2uyJpzhHo3lAaa
        z4iPfYXQJIa2k70LtgHgs/1L1ZbE+KMCcJmf2U1xoUTuc8pVIMFiULKe1DTCXUNu
        2IF1rbuo6Ya3ocZkgWZ6epAYdJKDqWP3H1EInLuGKQ6pINemUDb+dcNSIlHwcbZ5
        898ulOIAAQJbcN94RkZoy2FT8ZifLeRPa7ZTuZ9YOGOWx8E0g0VK+JkdxQlv1X8A
        YHxTx4KzNlg/NsYRjqCKnIXpzA+AmAMn722uXbaf7O/rRZrGzWSSXiVYY5u0kkP/
        JDGKNVPLl7YT2T9rxow47fmU0IlbTQxOjkg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rRi3ZY1Nx3lN for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 01:20:08 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmfcR1FjLz1RtVm;
        Wed, 29 Mar 2023 01:20:06 -0700 (PDT)
Message-ID: <f10dc56d-8114-d6b3-6426-cd943c6aea9b@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 17:20:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] virtio-blk: fix ZBD probe in kernels without ZBD
 support
Content-Language: en-US
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/23 11:29, Dmitry Fomichev wrote:
> When the kernel is built without support for zoned block devices,
> virtio-blk probe needs to error out any host-managed device scans
> to prevent such devices from appearing in the system as non-zoned.
> The current virtio-blk code simply bypasses all ZBD checks if
> CONFIG_BLK_DEV_ZONED is not defined and this leads to host-managed
> block devices being presented as non-zoned in the OS. This is one of
> the main problems this patch series is aimed to fix.
> 
> In this patch, make VIRTIO_BLK_F_ZONED feature defined even when
> CONFIG_BLK_DEV_ZONED is not. This change makes the code compliant with
> the voted revision of virtio-blk ZBD spec. Modify the probe code to
> look at the situation when VIRTIO_BLK_F_ZONED is negotiated in a kernel
> that is built without ZBD support. In this case, the code checks
> the zoned model of the device and fails the probe is the device
> is host-managed.
> 
> The patch also adds the comment to clarify that the call to perform
> the zoned device probe is correctly placed after virtio_device ready().
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

One nit below, but otherwise looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> -static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> -{
> -	return false;
> +	u8 model;
> +
> +	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
> +	if (model == VIRTIO_BLK_Z_HM) {
> +		dev_err(&vdev->dev,
> +			"zoned devices are not supported by the kernel");

May be simply: "Zoned devices are not supported"
Or: "Support for zoned devices is disabled"


-- 
Damien Le Moal
Western Digital Research

