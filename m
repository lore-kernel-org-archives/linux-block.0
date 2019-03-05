Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0440EC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80FA20842
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fWFVIvgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCELgh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:36:37 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46251 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfCELgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 06:36:36 -0500
Received: by mail-oi1-f173.google.com with SMTP id j10so6546106oij.13
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 03:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:mime-version:thread-index:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8QK8NVufTNeGGGTLfV2UoyYgP9Mhsrk10ad1VxIZOJA=;
        b=fWFVIvgEcsGAPCDSdeIOU9vG3JuJbyf9PZGO944wdr5OFbUT98D0rZGTcjrF8JsODG
         XbexFe40FovUrb1/rgpLrA6O1tTjwqP3i0mcPgjtHDACZ1xsEWsTcfgepMbhageEpg4n
         DDmg2ttScNy6+FHB6rcZgpzpBa2CJNEkj8asw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:thread-index:date:message-id
         :subject:to:content-transfer-encoding;
        bh=8QK8NVufTNeGGGTLfV2UoyYgP9Mhsrk10ad1VxIZOJA=;
        b=nskR0Dow+9rjogy77Ey2x9Uqt6+1JrMzwmF10uH5yAUJujResi4u2hCK2CpnkLBZTj
         bgvxOX6n3QkVIbmVtR89eUyrsE6W81QZpZNZWAw3gGxcuWPDt3zM4l67yJC1+oWiuDM/
         VKXuosPyukcQS+77Ms4uwF7C6Kr3TvzyrecNF09sZpcR0p6wyd2EyodjE2JrOld2Pwb1
         gwtObN372BWf7aoeVQCdBvyyldFazF+aaFJBv2f6IEKVaMKdK0ip6m7taGkU3o9FoyEy
         P4j3Y62BLkgMYVWjiLHv7tGGKdsbJ6h4a0zl8iXTX1O2J9ycMEufhCqcNj+xM/NdGMVt
         r31Q==
X-Gm-Message-State: APjAAAXgtwTLN8ZV4AnD0JGCppW2ZEW5yyYyFRv/57wXdiI8vc1pcKXu
        Byskp6D9FxMV/XayzBJxkH1as0qYpLK7No2sLNec4Tsf
X-Google-Smtp-Source: APXvYqyONviaaLtObp63GsmHs+xF8wZfUNaC3MtOssseul32G947rucWWhDMAnSg03S6nJW1cAt8ocZDQDjZy3q2R4Y=
X-Received: by 2002:aca:3786:: with SMTP id e128mr1731645oia.120.1551785795266;
 Tue, 05 Mar 2019 03:36:35 -0800 (PST)
From:   Muneendra Kumar M <muneendra.kumar@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdTTRts7AwDmUBW9T5qtbC0vW+jJqA==
Date:   Tue, 5 Mar 2019 17:06:32 +0530
Message-ID: <27226a7453efa3b147da2ea9f361437b@mail.gmail.com>
Subject: number of write I/Os processed keeps changing for a same test case
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi ,

Iam running the below fio test case and collecting the cat
/sys/class/block/sda/stat before after the test.

And below are the max_sectors_kb  and max_hw_sectors_kb settings for the
device.

 cat /sys/class/block/sdb/queue/max_hw_sectors_kb

32767

[root@localhost ~]# cat /sys/class/block/sdb/queue/max_sectors_kb

1280

Test Case:
[root@localhost ~]#
io --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite  --norandommap
--randrepeat=3D0 --ioengine=3Dsync
 --bs=3D1m  --iodepth=3D1 --numjobs=3D1 --group_reporting --name=3D4ktest -=
-size=3D50m

 And below is the o/p of the test .

[root@localhost ~]#cat /sys/class/block/sdb/stat

    6439        0  1513128     1618     4645        0  3332736     2697
0     3356      633        0        0        0        0

[root@localhost ~]#
io --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite  --norandommap
--randrepeat=3D0 --ioengine=3Dsync
 --bs=3D1m  --iodepth=3D1 --numjobs=3D1 --group_reporting --name=3D4ktest -=
-size=3D50m

4ktest: (g=3D0): rw=3Dwrite, bs=3D(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB,=
 (T)
1024KiB-1024KiB, ioengine=3Dsync, iodepth=3D1

fio-3.1

=E2=80=A6..

Run status group 0 (all jobs):

  WRITE: bw=3D943MiB/s (989MB/s), 943MiB/s-943MiB/s (989MB/s-989MB/s),
io=3D50.0MiB (52.4MB), run=3D53-53msec



Disk stats (read/write):

  sdb: ios=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%

[root@localhost ~]# cat /sys/class/block/sdb/stat

    6519        0  1517272     1628     4795        0  3435136     2785
0     3420      633        0        0        0        0



And when I compare the difference between the number of write I/Os processe=
d
between the two stats(4795-4645) it gave me 50 as it has submitted the 50
requests of 1MB each(since max_sectors_kb is set to 1280).

But when I ran the same test multiple the  number of write I/Os processed
(collected as above) keeps changing which is more than 50.

Not sure on what basis the requests are getting splitted when I run same
test case on the same setup.

Any input here will help me to understand more.

Iam running kernel  of 5.0.0-rc+ version.

Regards,
Muneendra
