Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67805C433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Feb 2022 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245360AbiBUAGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Feb 2022 19:06:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbiBUAG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Feb 2022 19:06:29 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F272517DB
        for <linux-block@vger.kernel.org>; Sun, 20 Feb 2022 16:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645401963; x=1676937963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qq4qpDosp6DxyH08XdA7K6jKs4urmOKuJ45lIhnK/EA=;
  b=J/AT66FJbo837HuyosmsqadgoWtfyYOE3tDl5KDxobg6pSjYTKr3ubBH
   Wr1lGdyrR3q/TwQYuqeRjkoKd4qX4411TesIcozeb8ltF5/URZabUsYRf
   dD0tn9Cn19vdIll0suA8oXQwV0TL5tLDMvg02MdmOKGCtrRPQv3IjozD9
   IX0WonTzflj9e1997xPlLqgS6WaizO1yHRRr/YAgc0f2MHSK6ILrnMqTI
   BgbMiTzq+tFvS6oMHR6H7/U4mU5rOc95lrROO6gNkUiXg8gpfrtGJeiIk
   QMVqdEq5GpN5Ypah5go10RLm8gKLhcDmneLeGeBCl81fzwXofQxi+fNtB
   g==;
X-IronPort-AV: E=Sophos;i="5.88,384,1635177600"; 
   d="scan'208";a="194453434"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2022 08:06:02 +0800
IronPort-SDR: kbO0BXkojCaDax4AcGRpK/6jSU14exhSKLT6l1WIDV49/XGdehn4Ly69PyCXOwSPzCZd8YZPXf
 u+yRG0xaI5L/Ji4CgebKBUHSxGO3xum950rlqIv1rRZ/M4Du6XzDpWP1E76cHgIVIUoMG1QyOE
 IFBABejIcRxWMmwuOCfkqwvtLjroi/P/fb7KdbZMx638dfLVxqi6DqwqMUQybKW9OqrSSatnAC
 dxvOsYawaDTQDpBdIin3sgjwpkm3vAULqMmhYynfiIsqxyNXu2Sb29dtoc4h+/xObMpzqHWH/7
 hirSjWbD8orepWHigt3NQ2bK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:37:36 -0800
IronPort-SDR: dwcKuGbQ98C+A8WErSQbAWw1O5fkxlj/QKYrJAiW+OYAd27XyPCYCBS/2SvQS0XUlSu6XUoTfx
 TOxLFGtX4YNFAAGXyEiXwR4r+6vuT6UxlLduwQuSSKTmWTbSLRyhNgtlCfyS39nLtbZOPGRxqL
 RY6eaIoWLX5f6q+CtXGTD9dzuroeF9ujOiQQOmCw5CPEJACAZvrvWVc4bIKxki07lciHpAlZg0
 QFuvsby9Qep5uQQGmr4j/g+utZKBqBOtnO4JhQyYvMMyirW9yacTZcQGxvc0XDD2pbpjqTxjqQ
 PIc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 16:06:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K22dP3Q0sz1Rwrw
        for <linux-block@vger.kernel.org>; Sun, 20 Feb 2022 16:06:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645401960; x=1647993961; bh=qq4qpDosp6DxyH08XdA7K6jKs4urmOKuJ45
        lIhnK/EA=; b=r6trkfg+h84wdZZMN3Yj54xs/5Xjvh94bt9D0qh3sewQfWEgfB4
        m7E6z9GEa0tZndIdUDlKRCpGsWsI4bKryYxCRiojc9xnvcpKcS/NKzdsccbZOzIH
        tVz+h4jEW4gH9ClXw79YCPAItdpKQ7jK+ObK++64nrEo0gooLVqc4Ll7l6zv+JXg
        15xjxK9kOx/zmDX1+zcLYQBbgpiS3JJV1RyJ/uil+emANKZFUXr6eKGXgq9go6OS
        53dqzMnuYmH/CG+iYY9pMsF64r0aJSiIB7Yqn9Re/m99RE2p0psrk+izVfKgjBsX
        mkOXIUqI68AASKJiZC5an41Ca2//eYAN5ww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BIIq67PZNmwc for <linux-block@vger.kernel.org>;
        Sun, 20 Feb 2022 16:06:00 -0800 (PST)
Received: from [10.89.87.236] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.87.236])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K22dM57Tpz1Rvlx;
        Sun, 20 Feb 2022 16:05:59 -0800 (PST)
Message-ID: <ecdcc86e-433e-8592-bb7a-51aa1f83ae25@opensource.wdc.com>
Date:   Mon, 21 Feb 2022 09:05:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] pata_parport: second preview
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220220224909.8032-1-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220220224909.8032-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/02/21 7:49, Ondrej Zary wrote:
> Hello,
> here's a second version of pata_parport. Now a complete patch with protocol
> drivers (cleaned up coding style).
> 
> The device model is complete now (pata_parport bus, protocol drivers and
> manually created devices). Devices can also be deleted:
> # echo pata_parport.0 > /sys/bus/pata_parport/delete_device 
> 
> Protocol registration could be improved - I don't like protocols[] and
> protocol numbers, devices should probably be created by protocol name.
> Also the LPT port base addresses should probably be replaced by port names
> (like parport0).
> 
> The bpck driver seems to need to know if a CD drive is attached (weird) but
> I doubt that I can get such info from libata.
> 
> I haven't tested other devices yet, only the Imation SuperDisk drive:
> 
> [ 4297.947270] paride: epat registered as protocol 0
> [ 4302.019782] pata_parport pata_parport.0: 0x378 is parport0
> [ 4302.030573] pata_parport pata_parport.0: epat: port 0x378, mode 0, ccr 0, test=(0,256,0)
> [ 4302.030587] pata_parport pata_parport.0: Sharing parport0 at 0x378
> [ 4302.030719] pata_parport pata_parport.0: epat, Shuttle EPAT chip c6 at 0x378, mode 0 (4-bit), delay 0
> [ 4302.062891] scsi host4: pata_parport-epat
> [ 4302.063036] ata6: PATA max PIO0 port parport0 protocol epat
> [ 4302.277720] ata6.00: ATAPI: LS-120 COSM   04              UHD Floppy, 0270M09T, max PIO2
> [ 4302.358986] scsi 4:0:0:0: Direct-Access     MATSHITA LS-120 COSM   04 0270 PQ: 0 ANSI: 5
> [ 4302.394406] sd 4:0:0:0: Attached scsi generic sg1 type 0
> [ 4302.429152] sd 4:0:0:0: [sdb] Media removed, stopped polling
> [ 4302.461007] sd 4:0:0:0: [sdb] Attached SCSI removable disk
> 
> 
> ---
>  drivers/ata/Kconfig                     |  25 +
>  drivers/ata/Makefile                    |   2 +
>  drivers/ata/pata_parport/Kconfig        | 189 ++++++
>  drivers/ata/pata_parport/Makefile       |  24 +
>  drivers/ata/pata_parport/aten.c         | 139 +++++
>  drivers/ata/pata_parport/bpck.c         | 481 +++++++++++++++
>  drivers/ata/pata_parport/bpck6.c        | 164 +++++
>  drivers/ata/pata_parport/comm.c         | 198 ++++++
>  drivers/ata/pata_parport/dstr.c         | 226 +++++++
>  drivers/ata/pata_parport/epat.c         | 320 ++++++++++
>  drivers/ata/pata_parport/epia.c         | 308 ++++++++++
>  drivers/ata/pata_parport/fit2.c         | 135 +++++
>  drivers/ata/pata_parport/fit3.c         | 195 ++++++
>  drivers/ata/pata_parport/friq.c         | 263 ++++++++
>  drivers/ata/pata_parport/frpw.c         | 292 +++++++++
>  drivers/ata/pata_parport/kbic.c         | 292 +++++++++
>  drivers/ata/pata_parport/ktti.c         | 112 ++++
>  drivers/ata/pata_parport/on20.c         | 136 +++++
>  drivers/ata/pata_parport/on26.c         | 302 +++++++++
>  drivers/ata/pata_parport/pata_parport.c | 773 ++++++++++++++++++++++++
>  drivers/ata/pata_parport/pata_parport.h | 114 ++++

This is a very large patch... Could you split this into multiple patches ?
1) The first patch adds the generic pata_parport & Kconfig
2) Following patches add pata_parport drivers, one patch per driver.

That will make reviewing easier.



-- 
Damien Le Moal
Western Digital Research
