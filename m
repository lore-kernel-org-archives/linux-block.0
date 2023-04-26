Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAFC7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 06:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbjDZGWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbjDZGWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 02:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD62D5E
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682490072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHwGEapmhrAwN0n7d+ZptbPb1j1HhcpCEs5BJ8I9ahY=;
        b=f6Q+OmMyAy5Su/9vtAAj1I9xMpfjvadD43tSAVbBc2DELYe3bIoMNoQo0vhl4slsPB0zRo
        LuAtW4BKbDme6VSDk3pOzgYjIx5hbklAK4VDHAQaXNMXV2zqTSlCud2prL1Gt9pf79Q9iS
        fC64rQbYbNbtkYXxpfiRFr5SzNhe2kI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-XhB9-j5XNCWIbNd0_5vLfA-1; Wed, 26 Apr 2023 02:21:10 -0400
X-MC-Unique: XhB9-j5XNCWIbNd0_5vLfA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5069f2ae8eeso20019677a12.0
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682490068; x=1685082068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHwGEapmhrAwN0n7d+ZptbPb1j1HhcpCEs5BJ8I9ahY=;
        b=FaB/7KtLvYknbQKnf91vnYBiLkUDWOTWg2gsz39cisHu5HkoPE5MjVWYQyxY2R6Vbn
         SUq9UQxFUMBbCm0bTciqXibpYazLCnhE5KEixQ13hrpSaAFBHfrr2iAxcsPckhIqoCFS
         vl9VxHOTFFb+3Rc5MJkQpmVJNGEkkHms5sw4UvxFdElKBGsgtNUEkStsXbPbRhWm7du7
         xYjDtzyvJPwdHQjhW1r+QSFSIUsE1leS3YoygVdXxMAJren0d+lSlvNJYb7gCH5UdkNZ
         8VzKAUzoNOmPuRrskwvN72HTdxagJrkv05TJ00BJ3+0EOOxFi6E4ckX40URaO/ZAR/8o
         mpDQ==
X-Gm-Message-State: AC+VfDxQ8rTLh0EQYNUG19EJn7jh8U2p06+d+FrfDcgjXyIMZ7eayXkK
        uAlNWvkdnTExmZYrtJncE6Q43GXnCdzBkQ/Jyde8ez3vkLkdx3c77d55DoFOFtv48Ln4QBaFJ6T
        UMeWd3bwuw7uTwDRZ1VgbcSqxz6Vnp5d2Sp3HdEs=
X-Received: by 2002:a05:6402:35d3:b0:509:d5d6:ae39 with SMTP id z19-20020a05640235d300b00509d5d6ae39mr1231217edc.10.1682490068652;
        Tue, 25 Apr 2023 23:21:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WnJbrdD039Y9j2W7DYgtaDx0jm3P85CGS7UkJ9iCA+KgISp8MgYaZMEfsqLcQKIjgyXcXNSZVhXTHhEq21Tw=
X-Received: by 2002:a05:6402:35d3:b0:509:d5d6:ae39 with SMTP id
 z19-20020a05640235d300b00509d5d6ae39mr1231195edc.10.1682490068236; Tue, 25
 Apr 2023 23:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
 <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com> <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
 <f5d3b05b-33a6-818f-6476-c3993f9d4e87@huaweicloud.com>
In-Reply-To: <f5d3b05b-33a6-818f-6476-c3993f9d4e87@huaweicloud.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Wed, 26 Apr 2023 14:20:56 +0800
Message-ID: <CAGVVp+W9SnHaEyi7o2Pkh6XEJsWL1E7W7esHvyXfXed8DFjt8g@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 00000000000000fc
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 26, 2023 at 2:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/04/26 13:56, Changhui Zhong =E5=86=99=E9=81=93:
> > On Tue, Apr 25, 2023 at 11:27=E2=80=AFAM Ming Lei <ming.lei@redhat.com>=
 wrote:
> >>
> >> On Tue, Apr 25, 2023 at 10:37:05AM +0800, Changhui Zhong wrote:
> >>> Hello,
> >>>
> >>> Below issue was triggered in my test,it caused system panic ,please
> >>> help check it.
> >>> branch: for-6.4/block
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >>>
> >>> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> >>> sgdisk -n 0:0:+100MiB /dev/md0
> >>> cat /proc/partitions
> >>> mdadm -S /dev/md0
> >>> mdadm -A /dev/md0 /dev/sda /dev/sdb
> >>> cat /proc/partitions
> >>>
> >>>
> >>> [   34.219123] BUG: kernel NULL pointer dereference, address: 0000000=
0000000fc
> >>> [   34.219507] #PF: supervisor read access in kernel mode
> >>> [   34.219784] #PF: error_code(0x0000) - not-present page
> >>> [   34.220039] PGD 0 P4D 0
> >>> [   34.220176] Oops: 0000 [#1] PREEMPT SMP PTI
> >>> [   34.220374] CPU: 8 PID: 1956 Comm: systemd-udevd Kdump: loaded Not
> >>> tainted 6.3.0-rc2+ #1
> >>> [   34.220787] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
> >>> Gen9, BIOS P89 05/21/2018
> >>> [   34.221188] RIP: 0010:blk_mq_sched_bio_merge+0x6d/0xf0
> >>
> >> Hi Changhui,
> >>
> >> Please try the following fix:
> >>
> >> diff --git a/block/bdev.c b/block/bdev.c
> >> index 850852fe4b78..fa2838ca2e6d 100644
> >> --- a/block/bdev.c
> >> +++ b/block/bdev.c
> >> @@ -419,7 +419,11 @@ struct block_device *bdev_alloc(struct gendisk *d=
isk, u8 partno)
> >>          bdev->bd_inode =3D inode;
> >>          bdev->bd_queue =3D disk->queue;
> >>          bdev->bd_stats =3D alloc_percpu(struct disk_stats);
> >> -       bdev->bd_has_submit_bio =3D false;
> >> +
> >> +       if (partno)
> >> +               bdev->bd_has_submit_bio =3D disk->part0->bd_has_submit=
_bio;
> >> +       else
> >> +               bdev->bd_has_submit_bio =3D false;
> >>          if (!bdev->bd_stats) {
> >>                  iput(inode);
> >>                  return NULL;
> >>
> >> Fixes: 9f4107b07b17 ("block: store bdev->bd_disk->fops->submit_bio sta=
te in bdev")
> >>
> >
> > Hi,Ming
> >
> > I retest the latest updated branch for-6.4/block
> > (https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/=
log/?h=3Dfor-6.4/block),
> > which contain your fix patch "block: sync part's ->bd_has_submit_bio
> > with disk's".
> > the kernel panic  no longer happen, but the test will failed, the
> > system will reread partition table on exclusively open device,
>
> Is this patch in the branch for-6.4/block?
>
> 3723091ea188 ("block: don't set GD_NEED_PART_SCAN if scan partition faile=
d")
> >

Hi, Yu Kuai

this patch was not found in the for-6.4/block branch, and found it
exist in the master branch


> > :: [ 01:50:05 ] :: [  BEGIN   ] :: Running 'mdadm -S /dev/md0'
> > mdadm: stopped /dev/md0
> > :: [ 01:50:06 ] :: [   PASS   ] :: Command 'mdadm -S /dev/md0'
> > (Expected 0, got 0)
> > :: [ 01:50:06 ] :: [  BEGIN   ] :: Running 'mdadm -A /dev/md0
> > /dev/"$dev0" /dev/"$dev1"'
> > mdadm: /dev/md0 has been started with 2 drives.
> > :: [ 01:50:06 ] :: [   PASS   ] :: Command 'mdadm -A /dev/md0
> > /dev/"$dev0" /dev/"$dev1"' (Expected 0, got 0)
> > :: [ 01:50:09 ] :: [  BEGIN   ] :: Running 'lsblk'
> > NAME                         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
> > sda                            8:0    1 447.1G  0 disk
> > =E2=94=9C=E2=94=80sda1                         8:1    1     1G  0 part =
 /boot
> > =E2=94=94=E2=94=80sda2                         8:2    1 446.1G  0 part
> >    =E2=94=9C=E2=94=80rhel_storageqe--104-root 253:0    0    70G  0 lvm =
  /
> >    =E2=94=9C=E2=94=80rhel_storageqe--104-swap 253:1    0   7.7G  0 lvm =
  [SWAP]
> >    =E2=94=94=E2=94=80rhel_storageqe--104-home 253:2    0 368.4G  0 lvm =
  /home
> > sdb                            8:16   1 447.1G  0 disk
> > =E2=94=9C=E2=94=80sdb1                         8:17   1   100M  0 part
> > =E2=94=94=E2=94=80md0                          9:0    0 447.1G  0 raid1
> >    =E2=94=94=E2=94=80md0p1                    259:0    0   100M  0 part
> > sdc                            8:32   1 447.1G  0 disk
> > =E2=94=9C=E2=94=80sdc1                         8:33   1   100M  0 part
> > =E2=94=94=E2=94=80md0                          9:0    0 447.1G  0 raid1
> >    =E2=94=94=E2=94=80md0p1                    259:0    0   100M  0 part
> > sdd                            8:48   1 447.1G  0 disk
> > :: [ 01:50:09 ] :: [   PASS   ] :: Command 'lsblk' (Expected 0, got 0)
> > :: [ 01:50:09 ] :: [  BEGIN   ] :: Running 'cat /proc/partitions'
> > major minor  #blocks  name
> >
> >     8        0  468851544 sda
> >     8        1    1048576 sda1
> >     8        2  467801088 sda2
> >     8       48  468851544 sdd
> >     8       32  468851544 sdc
> >     8       33     102400 sdc1
> >     8       16  468851544 sdb
> >     8       17     102400 sdb1
> >   253        0   73400320 dm-0
> >   253        1    8060928 dm-1
> >   253        2  386338816 dm-2
> >     9        0  468851392 md0
> >   259        0     102400 md0p1
> >
> > Thanks=EF=BC=8C
> >
> > .
> >
>

