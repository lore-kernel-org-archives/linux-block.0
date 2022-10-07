Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB692C433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJGGIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJGGIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:08:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA9AE840
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665122887; x=1696658887;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4aS2jy2IpbxbQ+lHyDBQLDg9e44lRtAL+iT/DLjHSaE=;
  b=M2aWoKzlxZ7y2agTtFb3UOLJFMS5Lo6dqSEQl2ZSF/pzHlvOZAP37JS5
   Zf3IHiIxJXRbamc1q17VdOhQH9wqJ4vVuuvf6LYkVaUPqJHRZYdg8xq8P
   JThNzYynjF5ocT3L5QXg4abT9aAM74fsx1JRaS/OMq1eEZIiT9VvIXcyg
   8bsoCFAMeU7jYMJeNLyAsAeYbO0Isqtncc/eV3Krq831CIlMxy0vtS2NY
   V+t2daEW0MygehNAVLiyZUS6x2vpJZB49MeqMI0N8QEy0DHPcijyDXMbU
   9htmLEcBROJBxH/Rfdf8pjhCUpoF4b9T2LUGM5EGZpCKmow9T84in4/aM
   g==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661788800"; 
   d="scan'208";a="213212392"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 14:08:06 +0800
IronPort-SDR: BpAUgRFbWq5kQeiPl3gA2OGjPuXYQbB5SNcTunfaDyunkP6zcdjGirJJ8OIjjvolJFAvABt4yD
 LElAIV4WsjlA2wqDM+zJX5T+QXp5w4QToeqMA+LkZUs65hIi2ctFRM+JlQFCPvLbmZNrWhE/qM
 lf+mVJVN2EyajuwyjIMq3WrOKtEfJv15DQKSoJiH9gajNc5EYA0QnpL31d66y8wGQYm+HuNHvL
 17GUSGWZftj0BFh6X3/IEc077jmF44RpcW7oEOEz3EIxWEAlBGRt886p3XWLYzjrrbrVPWFcd/
 kyyBHxnDA9D1ZWjoMYwlhIzF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 22:22:16 -0700
IronPort-SDR: yWAewKka+3dWQ3k3u2/VLGgKtt4TJv5RrSpGb+SQABxqBCvk3NArzMaF4M+AWq2Zap+W4SQF1t
 PReDKNbtb7aNejxTpjQYUQzmYtLXyi4DroRK5eTxLwjL+hSOrMQjHG+d112wb1XfAr+8c9Vpn1
 kOVanywuB/3IQ2XD/bPVhV50TwYEZRo9WiyRFXVaEhPjleT7hhiuEoAZfmuzmXblqeswLAsBTe
 GlSJ9Nb5lMt2TIQqpz4oGs/YxdYtQhHD+Ap8WrSPs61ZLkt5CIGO+qQCWFmENZAcPUC8Ay3rl+
 eG8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 23:08:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MkHsx62n7z1RvTp
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:08:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665122885; x=1667714886; bh=4aS2jy2IpbxbQ+lHyDBQLDg9e44lRtAL+iT
        /DLjHSaE=; b=r+wqOanXQQn1HxSdVm02zNsot5ylrv+895QB4yU/1b4sWnr8IH0
        sFMMpyTz2hhikfu+aaecxNnozNUrgbYkZe7v5RQ6i4I1nwnuSMNxVRyqSYXv0H9S
        igR2z7DdoV+KCRBAY/YiF5YK8HjHPoZ64r9eT5hqRREVwbgPpkoTPZNRho8euuQ0
        MI1Fx4BwIMx7jKPvGpora8eJhUCP/QaaiiQcAiLi+jgOM4EOUorVW0nMAdpa9jpx
        7gZheGj6eeefl6rMwxpvk/xkXkxXUN93dbTcb8Ad5gqrkT/X0Ds7KFvb79c/YXpN
        PJlO3vxuHBeNX7iTMjjK1NdfuF914z39D4w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WPXJx2T0Qpj3 for <linux-block@vger.kernel.org>;
        Thu,  6 Oct 2022 23:08:05 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MkHsw6ksWz1RvLy;
        Thu,  6 Oct 2022 23:08:04 -0700 (PDT)
Message-ID: <a54a9c84-0dd6-4af6-6c6e-d67d9e5a8695@opensource.wdc.com>
Date:   Fri, 7 Oct 2022 15:08:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20221006050514.5564-1-kch@nvidia.com>
 <0ac14f65-d8ac-8d50-ccf1-010ec7bcaad9@opensource.wdc.com>
 <50136c06-498c-4058-731e-01938ad011de@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <50136c06-498c-4058-731e-01938ad011de@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/22 14:38, Chaitanya Kulkarni wrote:
> On 10/5/22 22:15, Damien Le Moal wrote:
>> On 10/6/22 14:05, Chaitanya Kulkarni wrote:
>>> For a Zoned Block Device zone reset all is emulated if underlaying
>>> device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
>>> Zoned mode there is no way to test zone reset all emulation present i=
n
>>> the block layer since we enable it by default :-
>>>
>>> blkdev_zone_mgmt()
>>>   blkdev_zone_reset_all_emulation() <---
>>>   blkdev_zone_reset_all()
>>>
>>> Add a module parameter zone_reset_all to enable or disable
>>> REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
>>> behaviour.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>> # git log -1
>>> commit 8ca0bd53a9c9e2f58c4fc9e38e3f5f82d26d3851 (HEAD -> for-next)
>>> Author: Chaitanya Kulkarni <kch@nvidia.com>
>>> Date:   Wed Oct 5 21:57:00 2022 -0700
>>>
>>>      null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
>>>     =20
>>>      For a Zoned Block Device zone reset all is emulated if underlayi=
ng
>>>      device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_=
blk
>>>      Zoned mode there is no way to test zone reset all emulation pres=
ent in
>>>      the block layer since we enable it by default :-
>>>     =20
>>>      blkdev_zone_mgmt()
>>>       blkdev_zone_reset_all_emulation() <---
>>>       blkdev_zone_reset_all()
>>>     =20
>>>      Add a module parameter zone_reset_all to enable or disable
>>>      REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existi=
ng
>>>      behaviour.
>>>     =20
>>>      Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> # ./compile_nullb.sh
>>> + umount /mnt/nullb0
>>> umount: /mnt/nullb0: not mounted.
>>> + rmdir 'config/nullb/nullb*'
>>> rmdir: failed to remove 'config/nullb/nullb*': No such file or direct=
ory
>>> + dmesg -c
>>> + modprobe -r null_blk
>>> + lsmod
>>> + grep null_blk
>>> ++ nproc
>>> + make -j 48 M=3Ddrivers/block modules
>>> + HOST=3Ddrivers/block/null_blk/
>>> ++ uname -r
>>> + HOST_DEST=3D/lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_bl=
k/
>>> + cp drivers/block/null_blk//null_blk.ko /lib/modules/6.0.0-rc7blk+/k=
ernel/drivers/block/null_blk//
>>> + ls -lrth /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//=
null_blk.ko
>>> -rw-r--r--. 1 root root 1.2M Oct  5 21:57 /lib/modules/6.0.0-rc7blk+/=
kernel/drivers/block/null_blk//null_blk.ko
>>> + sleep 1
>>> + dmesg -c
>>> # modprobe null_blk gb=3D1 zoned=3D1 zone_size=3D128 <---
>>> # lsblk
>>> NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>>> sda       8:0    0   50G  0 disk
>>> =E2=94=9C=E2=94=80sda1    8:1    0    1G  0 part /boot
>>> =E2=94=94=E2=94=80sda2    8:2    0   49G  0 part /home
>>> sdb       8:16   0  100G  0 disk /mnt/data
>>> sr0      11:0    1 1024M  0 rom
>>> nullb0  250:0    0    1G  0 disk
>>> zram0   251:0    0    8G  0 disk [SWAP]
>>> vda     252:0    0  512M  0 disk
>>> nvme0n1 259:0    0    1G  0 disk
>>> # blkzone reset /dev/nullb0
>>> # dmesg  -c
>>> [  397.079221] null_blk: disk nullb0 created
>>> [  397.079226] null_blk: module loaded
>>> [  406.626500] blkdev_zone_reset_all 237 <---
>>> # modprobe -r null_blk
>>> #
>>> #
>>> #
>>> # modprobe null_blk gb=3D1 zoned=3D1 zone_size=3D128 zone_reset_all=3D=
0 <---
>>> # lsblk
>>> NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>>> sda       8:0    0   50G  0 disk
>>> =E2=94=9C=E2=94=80sda1    8:1    0    1G  0 part /boot
>>> =E2=94=94=E2=94=80sda2    8:2    0   49G  0 part /home
>>> sdb       8:16   0  100G  0 disk /mnt/data
>>> sr0      11:0    1 1024M  0 rom
>>> nullb0  250:0    0    1G  0 disk
>>> zram0   251:0    0    8G  0 disk [SWAP]
>>> vda     252:0    0  512M  0 disk
>>> nvme0n1 259:0    0    1G  0 disk
>>> # blkzone reset /dev/nullb0
>>> # dmesg  -c
>>> [  425.456187] null_blk: disk nullb0 created
>>> [  425.456192] null_blk: module loaded
>>> [  438.419529] blkdev_zone_reset_all_emulated 197 <---
>>> # modprobe -r null_blk
>>> #
>>> ---
>>>   drivers/block/null_blk/main.c     | 5 +++++
>>>   drivers/block/null_blk/null_blk.h | 1 +
>>>   drivers/block/null_blk/zoned.c    | 3 ++-
>>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/m=
ain.c
>>> index 8b7f42024f14..a0572e6c28ce 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -260,6 +260,10 @@ static unsigned int g_zone_max_active;
>>>   module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
>>>   MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones w=
hen block device is zoned. Default: 0 (no limit)");
>>>  =20
>>> +static bool g_zone_reset_all =3D true;
>>> +module_param_named(zone_reset_all, g_zone_reset_all, bool, 0444);
>>
>> Nit: Why read-only ? You can make it writable without any issue, no ?
>>
>=20
> Sorry I didn't understand this comment. In case this comment is about=20
> new zone_reset_all modpram being readonly and not allowed to set via=20
> command line? The test log shows I was able to set it to 0 and trigger=20
> call to blkdev_zone_reset_all_emulated() and default behavior ends up=20
> calling blkdev_zone_reset_all().
>=20
> -ck
>=20

If you change the param mode to 644, one can do:

echo 0 >/sys/module/null_blk/parameters/zone_reset_all
or
echo 1 >/sys/module/null_blk/parameters/zone_reset_all

But given that all null_blk parameters are read-only, not a big deal.

--=20
Damien Le Moal
Western Digital Research

