Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5FAC10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E3120674
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3huMklB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCLLNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:13:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLLNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 07:13:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id m15so2906583pgv.12
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=s4xrk+HnF+jfJtmkVe1G8qQIgd/9nFoSdLjc5Ywv17I=;
        b=D3huMklBWXR0LzlF/SWFEuBHBJOYRDGs3Sr7+BOTChuVfaz/eTLBjETqGaoozwvLbg
         sklQywuzXuEn1OBLDlEEq4VZ04MQK6CxOf414HWybDe6amld+y9F92aAZ31Zt6gG/CGU
         Yl3ZcE5tKTwNpuouGl3o4MB3Tw8qOLb2xzgKWI/LdrrknDd44l7PsNJ1nHKfZ5U0IyPt
         TnwItpffDOJ7DaoJVw2q7AGmnZ2o/rEZgMUw+X7l3FnZhOS++wiR23sQFS903qvTpcXI
         VRbMcOX9nPKeEZzw2Z3Ho1JP2h2V1AW9Z1BM+avzrwOrmwVvYSiQeWdHoPfklk8AaiV9
         wyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s4xrk+HnF+jfJtmkVe1G8qQIgd/9nFoSdLjc5Ywv17I=;
        b=ioheGHjOV+XU/Ofk8Ja/+hLhryAOvS5MNNsqLkjYEOAhNVm6PJvOFJECJ6TiYwiimI
         gZHXCj9ekQOCPuyFFJV/NdB+HzMj4zzFSdBNa+gl9rOTZd2jtSqq1+36lOwfmqIlqdDG
         GjgKCe5ZQJAsCJCLvpSHLKjbK3kpW+jKRbemmhkBQZQty2AI7TUbbI6FIBy6SXGYIV2Y
         NUJvJRgwEN5xbHVDMT0m05hGOlpKKkxI6i0/ioPr64SxuLa+juBRlA8BblLIsGynAmMx
         2FfJWKBFqr5/R7q5mBqYfj5ildL8+0+VRJ5sxD8eeS6wDb6t940mQTWVErUw8xf7Hh5D
         6HgQ==
X-Gm-Message-State: ANhLgQ0JvzzUAPHt/5+9EPcwlMIo7pzX4An4oqfi+kwtOrcJLsq1Ii4i
        WFGgpspFFx/f6UT8sm9VqKR1T8ltuh5RE+jr4AJ4o6Vm2rO6fQ==
X-Google-Smtp-Source: ADFU+vu/1rY1p1Vi8eGsEQ/fUspiElwE2MS4gbX100gS319EQsWBVL9FEmDjZyGAylNeI5+oPigluH++b5/K4vAzEtI=
X-Received: by 2002:a65:67d9:: with SMTP id b25mr7460895pgs.190.1584011634489;
 Thu, 12 Mar 2020 04:13:54 -0700 (PDT)
MIME-Version: 1.0
From:   Feng Li <lifeng1519@gmail.com>
Date:   Thu, 12 Mar 2020 19:13:28 +0800
Message-ID: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
Subject: [Question] IO is split by block layer when size is larger than 4k
To:     linux-block@vger.kernel.org, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi experts,

May I ask a question about block layer?
When running fio in guest os, I find a 256k IO is split into the page
by page in bio, saved in bvecs.
And virtio-blk just put the bio_vec one by one in the available
descriptor table.

So if my backend device does not support iovector
opertion(preadv/pwritev), then IO is issued to a low layer page by
page.
My question is: why doesn't the bio save multi-pages in one bio_vec?

the /dev/vdb is a vhost-user-blk-pci device from spdk or virtio-blk-pci device.
fio config is:
[global]
name=fio-rand-read
rw=randread
ioengine=libaio
direct=1
numjobs=1
iodepth=1
bs=256K
[file1]
filename=/dev/vdb

Traceing result like this:

/usr/share/bcc/tools/stackcount -K  -T  '__blockdev_direct_IO'
return 378048
 /usr/share/bcc/tools/stackcount -K  -T 'bio_add_page'
return 5878
I can get:
378048/5878 = 64
256k/4k=64.

__blockdev_direct_IO splits 256k to 64 parts.

The /dev/vdb queue properties is as follows:

[root@t1 00:10:42 queue]$find . | while read f;do echo "$f = $(cat $f)";done
./nomerges = 0
./logical_block_size = 512
./rq_affinity = 1
./discard_zeroes_data = 0
./max_segments = 126
./unpriv_sgio = 0
./max_segment_size = 4294967295
./rotational = 1
./scheduler = none
./read_ahead_kb = 128
./max_hw_sectors_kb = 2147483647
./discard_granularity = 0
./discard_max_bytes = 0
./write_same_max_bytes = 0
./max_integrity_segments = 0
./max_sectors_kb = 512
./physical_block_size = 512
./add_random = 0
./nr_requests = 128
./minimum_io_size = 512
./hw_sector_size = 512
./optimal_io_size

Sometimes the part io size is bigger than 4k.
some logs:
id: 0 size: 4096
...
id: 57 size: 4096
id: 58 size: 24576

Why does this happen?

kernel version:
1. 3.10.0-1062.1.2.el7
2. 5.3

Thanks in advance.
