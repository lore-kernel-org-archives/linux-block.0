Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3762C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 05:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjDZF6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZF6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 01:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB3AA3
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682488632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoGTtVAlJv4wCX1i2eDa2D1HcfBB0jcK5ZhiKj43bU8=;
        b=TL586CMP0xGVndnqPdnZc7R+7sSRbid8t4qOYgtZZgaw7MpvqeE168KVm9koJFKf5VmS6/
        ZBkhqFVCHkj7P1AjxTnCj72mFi9JWt6+kIkKVou2pc2hUyq7e9twmSu3aeG0uQkW/flHfc
        ou0aNOUaqHT6UapEPXJ1VRvbW2gHTG8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-sSHL-qQKPAuE1L4BBkjJpw-1; Wed, 26 Apr 2023 01:57:10 -0400
X-MC-Unique: sSHL-qQKPAuE1L4BBkjJpw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506991c6519so7456516a12.0
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 22:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682488627; x=1685080627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoGTtVAlJv4wCX1i2eDa2D1HcfBB0jcK5ZhiKj43bU8=;
        b=bDVH9OMVT8DyGSUTFlJlOy1gkRAhV7f41bKCCoEhd8pocOlRR6omCOwRbMSYEwY0ho
         lcYUQec/BNTYRlHXl4wlIrsZEvwNgEX5CA48bdVCuiItTSDa7If2i8pFHQRdT3ZgHyQk
         fjm2k2k3rueTFuQMoGdElLcf/PgGtEBzr/tsfbTjIB0uY3ASu/5CqwCqleAQC/xqYFov
         +TUnFwHWxmppsxvPEEqfschIXsfk00mO2Ysse1BNi8EeiAgCP47uRpCfPXmB6Z2Zk644
         Ljmb0Ot5spcXCW1gf8u5UeNaqHswOrn7VwSHFc0p0rn/o+QWvun4+sYiTFYY6BQKX6A8
         oM+Q==
X-Gm-Message-State: AAQBX9fA8OTmbSbSBtXc5+axQNIwanJFr/m0lsp1lrYfgiYul7DRES8n
        9By9BRzxLJ04J2mXEg9egU6U7jKBWrfbBN9FKJ5ElyzZUEVuqBQoqQ4Cz1GiVE2fbERbTkm6D96
        D2QSqRR1bWmGywZj7Ds9wawWGRIdv1WLsXjlnMsvsqP085TCqEyGfntU=
X-Received: by 2002:aa7:d90d:0:b0:506:77e5:d157 with SMTP id a13-20020aa7d90d000000b0050677e5d157mr18330563edr.19.1682488627696;
        Tue, 25 Apr 2023 22:57:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIE1D9VJsATahSU3taHEXfy/mDMvRO5BS4jbFnITHStPFmR9hZer5YMsohPjmQQZNfciNE+oBC61Kc9lBOmDw=
X-Received: by 2002:aa7:d90d:0:b0:506:77e5:d157 with SMTP id
 a13-20020aa7d90d000000b0050677e5d157mr18330549edr.19.1682488627278; Tue, 25
 Apr 2023 22:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
 <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com>
In-Reply-To: <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Wed, 26 Apr 2023 13:56:55 +0800
Message-ID: <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 00000000000000fc
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 25, 2023 at 11:27=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Tue, Apr 25, 2023 at 10:37:05AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > Below issue was triggered in my test,it caused system panic ,please
> > help check it.
> > branch: for-6.4/block
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >
> > mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> > sgdisk -n 0:0:+100MiB /dev/md0
> > cat /proc/partitions
> > mdadm -S /dev/md0
> > mdadm -A /dev/md0 /dev/sda /dev/sdb
> > cat /proc/partitions
> >
> >
> > [   34.219123] BUG: kernel NULL pointer dereference, address: 000000000=
00000fc
> > [   34.219507] #PF: supervisor read access in kernel mode
> > [   34.219784] #PF: error_code(0x0000) - not-present page
> > [   34.220039] PGD 0 P4D 0
> > [   34.220176] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   34.220374] CPU: 8 PID: 1956 Comm: systemd-udevd Kdump: loaded Not
> > tainted 6.3.0-rc2+ #1
> > [   34.220787] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
> > Gen9, BIOS P89 05/21/2018
> > [   34.221188] RIP: 0010:blk_mq_sched_bio_merge+0x6d/0xf0
>
> Hi Changhui,
>
> Please try the following fix:
>
> diff --git a/block/bdev.c b/block/bdev.c
> index 850852fe4b78..fa2838ca2e6d 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -419,7 +419,11 @@ struct block_device *bdev_alloc(struct gendisk *disk=
, u8 partno)
>         bdev->bd_inode =3D inode;
>         bdev->bd_queue =3D disk->queue;
>         bdev->bd_stats =3D alloc_percpu(struct disk_stats);
> -       bdev->bd_has_submit_bio =3D false;
> +
> +       if (partno)
> +               bdev->bd_has_submit_bio =3D disk->part0->bd_has_submit_bi=
o;
> +       else
> +               bdev->bd_has_submit_bio =3D false;
>         if (!bdev->bd_stats) {
>                 iput(inode);
>                 return NULL;
>
> Fixes: 9f4107b07b17 ("block: store bdev->bd_disk->fops->submit_bio state =
in bdev")
>

Hi,Ming

I retest the latest updated branch for-6.4/block
(https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/=
?h=3Dfor-6.4/block),
which contain your fix patch "block: sync part's ->bd_has_submit_bio
with disk's".
the kernel panic  no longer happen, but the test will failed, the
system will reread partition table on exclusively open device,

:: [ 01:50:05 ] :: [  BEGIN   ] :: Running 'mdadm -S /dev/md0'
mdadm: stopped /dev/md0
:: [ 01:50:06 ] :: [   PASS   ] :: Command 'mdadm -S /dev/md0'
(Expected 0, got 0)
:: [ 01:50:06 ] :: [  BEGIN   ] :: Running 'mdadm -A /dev/md0
/dev/"$dev0" /dev/"$dev1"'
mdadm: /dev/md0 has been started with 2 drives.
:: [ 01:50:06 ] :: [   PASS   ] :: Command 'mdadm -A /dev/md0
/dev/"$dev0" /dev/"$dev1"' (Expected 0, got 0)
:: [ 01:50:09 ] :: [  BEGIN   ] :: Running 'lsblk'
NAME                         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                            8:0    1 447.1G  0 disk
=E2=94=9C=E2=94=80sda1                         8:1    1     1G  0 part  /bo=
ot
=E2=94=94=E2=94=80sda2                         8:2    1 446.1G  0 part
  =E2=94=9C=E2=94=80rhel_storageqe--104-root 253:0    0    70G  0 lvm   /
  =E2=94=9C=E2=94=80rhel_storageqe--104-swap 253:1    0   7.7G  0 lvm   [SW=
AP]
  =E2=94=94=E2=94=80rhel_storageqe--104-home 253:2    0 368.4G  0 lvm   /ho=
me
sdb                            8:16   1 447.1G  0 disk
=E2=94=9C=E2=94=80sdb1                         8:17   1   100M  0 part
=E2=94=94=E2=94=80md0                          9:0    0 447.1G  0 raid1
  =E2=94=94=E2=94=80md0p1                    259:0    0   100M  0 part
sdc                            8:32   1 447.1G  0 disk
=E2=94=9C=E2=94=80sdc1                         8:33   1   100M  0 part
=E2=94=94=E2=94=80md0                          9:0    0 447.1G  0 raid1
  =E2=94=94=E2=94=80md0p1                    259:0    0   100M  0 part
sdd                            8:48   1 447.1G  0 disk
:: [ 01:50:09 ] :: [   PASS   ] :: Command 'lsblk' (Expected 0, got 0)
:: [ 01:50:09 ] :: [  BEGIN   ] :: Running 'cat /proc/partitions'
major minor  #blocks  name

   8        0  468851544 sda
   8        1    1048576 sda1
   8        2  467801088 sda2
   8       48  468851544 sdd
   8       32  468851544 sdc
   8       33     102400 sdc1
   8       16  468851544 sdb
   8       17     102400 sdb1
 253        0   73400320 dm-0
 253        1    8060928 dm-1
 253        2  386338816 dm-2
   9        0  468851392 md0
 259        0     102400 md0p1

Thanks=EF=BC=8C

