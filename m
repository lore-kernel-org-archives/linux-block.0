Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB647C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 06:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJSGpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 02:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJSGpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 02:45:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16E30569
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666161898; x=1697697898;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=C2ZawkswtA9tKNGbaMZeZVQwX2HF+f3Zy0Yc5BjuaLU=;
  b=KpRzeaJmZl/UBm1FdaMaQ0KMFEF3jkdj0lEc0FR8+Qq0uAF13iEUSRY3
   XjfE2pFTMRiQIMu2Nd0JqazIHR2VSXxaISmKWB/cQgBo3NggezxTzymWV
   abL9Dg2EpQE7QOFgg4/7akYZSIFsYZO6PNxzJMCTCXxsAy/IrUOMC9mHR
   1ZLL/95OWVsdgbD9115JJA+ES9ghaRs1tVfhzFcCBchDNat2w53C9RKVe
   EhXgCrspOFcSvW2dQC5rW+0xOwyNSHrGjQJYOVoQ29FZgdKmI1ZPZerks
   gSGR/VfgmHVLRQLcWjbFPfmIKSOGc4lQsmXLVAzzREVmxQea8JLJdEt+9
   w==;
X-IronPort-AV: E=Sophos;i="5.95,195,1661788800"; 
   d="scan'208";a="219357400"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2022 14:44:56 +0800
IronPort-SDR: GT9IaKcTDd4Yjj1C2g7L60xK+iZh1CRm8egR85PybVyDC8owulXCRNhYoBwXaLjo28bjz981qE
 e4pYpWsSVWssX6PhzrsZqH+qbcQyWClOXBtxAXZkitArzi2epop/Ub8J4Bj5boUXjo4Gk50Hvi
 Ba61mW5+YisfBZzDe+p35vSBG+C5tEmasakUNYKZfhyDejHrP8MGB+R33SE0X0fRSXLSM66C1o
 mXRp7lohHjOFURbzsxPp+AncfUHaSyZJORlu/cCB17KGmwCGYdZzPgcMSaZCpplTwVB6UYUMOs
 vZT4R+gB/mIYg0qGEu0DE7kA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 22:58:47 -0700
IronPort-SDR: DXOpmOCm4n6HlCNywKSqU5FJwRWrNFyPjbLXNEF2dB5ofriCAy3DHNlDnd9QkoB4lnOzTO/pqw
 uAdQeNHRX3qjOiimnuxPmoL1CPYIgjeBVMaO4RnNuW+SGJRUgzp6so6tvcDqDZwJYBNmXIS45e
 nhiz8lh9ac5z6NIZo12LKEXQBt7i+SjbAa04GNSMS1Nvl3Ubc7m98DUo716m54KrJQ8thho66r
 T2WzWU2rmNrCDvT32VpbNhgjkEFQqwsPVNM5L5JR6HS2YvhnxiKljJJtt7Kzz+JTuccwrIt5yE
 nrg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 23:44:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Msh6w3mQSz1RvTp
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:44:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666161896; x=1668753897; bh=C2ZawkswtA9tKNGbaMZeZVQwX2HF+f3Zy0Y
        c5BjuaLU=; b=rP+wRixH6tOLBFaGfBirb2atB+s6qmFIoIDmNqXVlYRWhwOTe0R
        S8w3Ng0+uo5/wpVmud3bUier3X69mAOXUMMTcHJZpfn/Q+/hkQ2BTK0u/6H42Apk
        e4LOR+oOjcgGQjMMjI9Ttu1tKInhqEJNiBhTDqYVJLrpDZVZCU3c68BhsHIaPIYN
        yLMsK2edRzVizMxrNsOAkY2S/yftawcBIZH1jC39Z6HZfe5ycbJIxzJnoTXT39Pg
        8Rt3al9wwsF3YehQFaxtOKi1WYj3DCVn6HqrWGFwKvmLFRGPnON0dwi0maqXk4g+
        afBC/DTQZWgIEEcF89sPNHKq9j4fbTHpQPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eVzYHSQQskke for <linux-block@vger.kernel.org>;
        Tue, 18 Oct 2022 23:44:56 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Msh6v4wNdz1RvLy;
        Tue, 18 Oct 2022 23:44:55 -0700 (PDT)
Message-ID: <35800544-675a-a849-bd8a-7f780affac60@opensource.wdc.com>
Date:   Wed, 19 Oct 2022 15:44:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
References: <20221006050514.5564-1-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221006050514.5564-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/22 14:05, Chaitanya Kulkarni wrote:
> For a Zoned Block Device zone reset all is emulated if underlaying
> device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
> Zoned mode there is no way to test zone reset all emulation present in
> the block layer since we enable it by default :-
>=20
> blkdev_zone_mgmt()
>  blkdev_zone_reset_all_emulation() <---
>  blkdev_zone_reset_all()
>=20
> Add a module parameter zone_reset_all to enable or disable
> REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
> behaviour.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
> # git log -1=20
> commit 8ca0bd53a9c9e2f58c4fc9e38e3f5f82d26d3851 (HEAD -> for-next)
> Author: Chaitanya Kulkarni <kch@nvidia.com>
> Date:   Wed Oct 5 21:57:00 2022 -0700
>=20
>     null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
>    =20
>     For a Zoned Block Device zone reset all is emulated if underlaying
>     device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
>     Zoned mode there is no way to test zone reset all emulation present=
 in
>     the block layer since we enable it by default :-
>    =20
>     blkdev_zone_mgmt()
>      blkdev_zone_reset_all_emulation() <---
>      blkdev_zone_reset_all()
>    =20
>     Add a module parameter zone_reset_all to enable or disable
>     REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
>     behaviour.
>    =20
>     Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> # ./compile_nullb.sh=20
> + umount /mnt/nullb0
> umount: /mnt/nullb0: not mounted.
> + rmdir 'config/nullb/nullb*'
> rmdir: failed to remove 'config/nullb/nullb*': No such file or director=
y
> + dmesg -c
> + modprobe -r null_blk
> + lsmod
> + grep null_blk
> ++ nproc
> + make -j 48 M=3Ddrivers/block modules
> + HOST=3Ddrivers/block/null_blk/
> ++ uname -r
> + HOST_DEST=3D/lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk/
> + cp drivers/block/null_blk//null_blk.ko /lib/modules/6.0.0-rc7blk+/ker=
nel/drivers/block/null_blk//
> + ls -lrth /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//nu=
ll_blk.ko
> -rw-r--r--. 1 root root 1.2M Oct  5 21:57 /lib/modules/6.0.0-rc7blk+/ke=
rnel/drivers/block/null_blk//null_blk.ko
> + sleep 1
> + dmesg -c
> # modprobe null_blk gb=3D1 zoned=3D1 zone_size=3D128 <---
> # lsblk
> NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> sda       8:0    0   50G  0 disk=20
> =E2=94=9C=E2=94=80sda1    8:1    0    1G  0 part /boot
> =E2=94=94=E2=94=80sda2    8:2    0   49G  0 part /home
> sdb       8:16   0  100G  0 disk /mnt/data
> sr0      11:0    1 1024M  0 rom =20
> nullb0  250:0    0    1G  0 disk=20
> zram0   251:0    0    8G  0 disk [SWAP]
> vda     252:0    0  512M  0 disk=20
> nvme0n1 259:0    0    1G  0 disk=20
> # blkzone reset /dev/nullb0
> # dmesg  -c
> [  397.079221] null_blk: disk nullb0 created
> [  397.079226] null_blk: module loaded
> [  406.626500] blkdev_zone_reset_all 237 <---
> # modprobe -r null_blk
> #=20
> #=20
> #=20
> # modprobe null_blk gb=3D1 zoned=3D1 zone_size=3D128 zone_reset_all=3D0=
 <---
> # lsblk
> NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> sda       8:0    0   50G  0 disk=20
> =E2=94=9C=E2=94=80sda1    8:1    0    1G  0 part /boot
> =E2=94=94=E2=94=80sda2    8:2    0   49G  0 part /home
> sdb       8:16   0  100G  0 disk /mnt/data
> sr0      11:0    1 1024M  0 rom =20
> nullb0  250:0    0    1G  0 disk=20
> zram0   251:0    0    8G  0 disk [SWAP]
> vda     252:0    0  512M  0 disk=20
> nvme0n1 259:0    0    1G  0 disk=20
> # blkzone reset /dev/nullb0
> # dmesg  -c
> [  425.456187] null_blk: disk nullb0 created
> [  425.456192] null_blk: module loaded
> [  438.419529] blkdev_zone_reset_all_emulated 197 <---
> # modprobe -r null_blk
> #=20
> ---
>  drivers/block/null_blk/main.c     | 5 +++++
>  drivers/block/null_blk/null_blk.h | 1 +
>  drivers/block/null_blk/zoned.c    | 3 ++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> index 8b7f42024f14..a0572e6c28ce 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -260,6 +260,10 @@ static unsigned int g_zone_max_active;
>  module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
>  MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when=
 block device is zoned. Default: 0 (no limit)");
> =20
> +static bool g_zone_reset_all =3D true;
> +module_param_named(zone_reset_all, g_zone_reset_all, bool, 0444);
> +MODULE_PARM_DESC(zone_reset_all, "Allow REQ_OP_ZONE_RESET_ALL. Default=
: true");
> +
>  static struct nullb_device *null_alloc_dev(void);
>  static void null_free_dev(struct nullb_device *dev);
>  static void null_del_dev(struct nullb *nullb);
> @@ -715,6 +719,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->zone_nr_conv =3D g_zone_nr_conv;
>  	dev->zone_max_open =3D g_zone_max_open;
>  	dev->zone_max_active =3D g_zone_max_active;
> +	dev->zone_reset_all =3D g_zone_reset_all;
>  	dev->virt_boundary =3D g_virt_boundary;
>  	dev->no_sched =3D g_no_sched;
>  	dev->shared_tag_bitmap =3D g_shared_tag_bitmap;
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk=
/null_blk.h
> index e692c2a7369e..e7efe8de4ebf 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -115,6 +115,7 @@ struct nullb_device {
>  	bool discard; /* if support discard */
>  	bool write_zeroes; /* if support write_zeroes */
>  	bool zoned; /* if device is zoned */
> +	bool zone_reset_all; /* if support REQ_OP_ZONE_RESET_ALL */
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  	bool no_sched; /* no IO scheduler for the device */
>  	bool shared_tag_bitmap; /* use hostwide shared tags */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zo=
ned.c
> index 55a69e48ef8b..7310d1c3f9ec 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -160,7 +160,8 @@ int null_register_zoned_dev(struct nullb *nullb)
>  	struct request_queue *q =3D nullb->q;
> =20
>  	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
> -	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> +	if (dev->zone_reset_all)
> +		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
> =20
>  	if (queue_is_mq(q)) {

--=20
Damien Le Moal
Western Digital Research

