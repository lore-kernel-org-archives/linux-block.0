Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95D9C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 08:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbjDZIj2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDZIj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 04:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243962D74
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682498320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XUSaaDV0Es4kUR1ZaSItH27gq5XoIwQzK5bBMH2/cI=;
        b=AqkxyvrBo5ksEavflbsshyjOrJ2JMKiVlq9/DJzCK0vBag3TcJuMrjYecx7dLOT+YPy1op
        mDQpJC0XmWje3a0GtE4zyGjp4gZJR5td4AZ2ZWMKl2hf7/elsPpcq8jOp7Pf1gJ3iegFXI
        wTEgCXSn/QP8wsNyBcr+qgHp3x0OJeo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-1R3n2ul0NVWPaA39byXyKA-1; Wed, 26 Apr 2023 04:38:38 -0400
X-MC-Unique: 1R3n2ul0NVWPaA39byXyKA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9537db54c94so637056966b.2
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682498316; x=1685090316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XUSaaDV0Es4kUR1ZaSItH27gq5XoIwQzK5bBMH2/cI=;
        b=eZriUcOzVVGhCjtuT3Z0dkiAHV6iR8+FmpT8pJDhSJMbkuBN/mpAURC+sXoLUM5WiO
         pJmd5zmay8ApTS5GgWqWc7nibVyik/3Ovm9MqmqTnUy93i7pPveaVLDdX/7dy/gr2dAl
         PHNfckKN/qKPZtE0G/1GG+REq5hhTHNpdpnyBmGYykq36KaJUZFxhx/YwC4p1UPAxReF
         14q1PaBrVwHoGB282uKfUzOsX37PGnIwmrBYwhnDnPUQy/kjf9sEGPtBF0zGl8HaDuZf
         yw3uVMNbtmvmDrFoZKXHoWXqQ0x0VhjiwwCMfE1cb5wRMFHtIh3SQGjmkw528F1+1Mmn
         Nitw==
X-Gm-Message-State: AAQBX9fv6UNIUQeQU1Sq6rKISEpZy8thxxUbfsYowICAK9HGlfxinN2D
        mhbKCKykeeAFY4kmozNQehYOPHgGRc4pBQ1J+z1Gec0FiS+8MxqfDB0Mkwg0YJDXORrPA2m4Qqi
        QC2lekKt7t0Sgg+AxNvhiMnlNwGv6JQdhtI8KWWAgwi0yzD6Wef43POQ=
X-Received: by 2002:a17:906:19ce:b0:94e:dd3f:b650 with SMTP id h14-20020a17090619ce00b0094edd3fb650mr16360212ejd.18.1682498316119;
        Wed, 26 Apr 2023 01:38:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350aw8D2hOkcB64XSohlKDUHo8BBPLqrO3IHndL/MxLBGuOEAS7gIJhmgUgpOzKpniTnp0b74q8b4UFdRN/DR7vI=
X-Received: by 2002:a17:906:19ce:b0:94e:dd3f:b650 with SMTP id
 h14-20020a17090619ce00b0094edd3fb650mr16360200ejd.18.1682498315743; Wed, 26
 Apr 2023 01:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
 <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com> <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
 <f5d3b05b-33a6-818f-6476-c3993f9d4e87@huaweicloud.com> <CAGVVp+W9SnHaEyi7o2Pkh6XEJsWL1E7W7esHvyXfXed8DFjt8g@mail.gmail.com>
 <c1277414-bc3c-b191-de9c-1620c5533aa0@huaweicloud.com>
In-Reply-To: <c1277414-bc3c-b191-de9c-1620c5533aa0@huaweicloud.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Wed, 26 Apr 2023 16:38:24 +0800
Message-ID: <CAGVVp+W1hT_1Q5L9boo0QnAMjqkzYZLb+FQr5fHDdoaCzUmkNA@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 00000000000000fc
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 26, 2023 at 2:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/04/26 14:20, Changhui Zhong =E5=86=99=E9=81=93:
> >> Is this patch in the branch for-6.4/block?
> >>
> >> 3723091ea188 ("block: don't set GD_NEED_PART_SCAN if scan partition fa=
iled")
> >>>
> >
> > Hi, Yu Kuai
> >
> > this patch was not found in the for-6.4/block branch, and found it
> > exist in the master branch
> >
>
> Can you try to test with this patch?
>
> Thanks,
> Kuai
>

Hi, Kuai

after patching this patch, the script test passed, confirm that this
patch can fix this issue.

:: [ 04:31:01 ] :: [  BEGIN   ] :: Running 'mdadm -S /dev/md0'
mdadm: stopped /dev/md0
:: [ 04:31:02 ] :: [   PASS   ] :: Command 'mdadm -S /dev/md0'
(Expected 0, got 0)
:: [ 04:31:02 ] :: [  BEGIN   ] :: Running 'mdadm -A /dev/md0
/dev/"$dev0" /dev/"$dev1"'
mdadm: /dev/md0 has been started with 2 drives.
:: [ 04:31:02 ] :: [   PASS   ] :: Command 'mdadm -A /dev/md0
/dev/"$dev0" /dev/"$dev1"' (Expected 0, got 0)
:: [ 04:31:05 ] :: [  BEGIN   ] :: Running 'lsblk'
NAME                         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                            8:0    1 447.1G  0 disk
=E2=94=94=E2=94=80md0                          9:0    0 447.1G  0 raid1
  =E2=94=94=E2=94=80md0p1                    259:0    0   100M  0 part
sdb                            8:16   1 447.1G  0 disk
=E2=94=9C=E2=94=80sdb1                         8:17   1     1G  0 part  /bo=
ot
=E2=94=94=E2=94=80sdb2                         8:18   1 446.1G  0 part
  =E2=94=9C=E2=94=80rhel_storageqe--104-root 253:0    0    70G  0 lvm   /
  =E2=94=9C=E2=94=80rhel_storageqe--104-swap 253:1    0   7.7G  0 lvm   [SW=
AP]
  =E2=94=94=E2=94=80rhel_storageqe--104-home 253:2    0 368.4G  0 lvm   /ho=
me
sdc                            8:32   1 447.1G  0 disk
=E2=94=94=E2=94=80md0                          9:0    0 447.1G  0 raid1
  =E2=94=94=E2=94=80md0p1                    259:0    0   100M  0 part
sdd                            8:48   1 447.1G  0 disk
:: [ 04:31:05 ] :: [   PASS   ] :: Command 'lsblk' (Expected 0, got 0)
:: [ 04:31:05 ] :: [  BEGIN   ] :: Running 'cat /proc/partitions'
major minor  #blocks  name

   8       48  468851544 sdd
   8        0  468851544 sda
   8       32  468851544 sdc
   8       16  468851544 sdb
   8       17    1048576 sdb1
   8       18  467801088 sdb2
 253        0   73400320 dm-0
 253        1    8060928 dm-1
 253        2  386338816 dm-2
   9        0  468851392 md0
 259        0     102400 md0p1

Thanks=EF=BC=8C

