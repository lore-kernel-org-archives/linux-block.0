Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9FC2BC73
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723DA2077B
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B/ofvsRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLDLe5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:34:57 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61670 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLe5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 06:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575459297; x=1606995297;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Bzn/WoKTnTRsZTO04w/szontO0zw5vES16CetCc4zbU=;
  b=B/ofvsRjWzHEsW9ng7v27/2mBCm0K72pFsRdokEtfbldrQqiWZom5Mfu
   MCxm5DmJI5SHDyjkY42OdUeywccu8dXTjvJyGrxs079SMdCUYRK6qS7t8
   FbSHZ/dToEhNvWsKqZTTOEDPLItdHD7TB6aXxRwu+1P162ibafW+tU6wX
   I=;
IronPort-SDR: jCSDk7Xv2epMaj4kKWdPfyDpKCdj/3O+4jKjssgB2+nbR+jDo3lFgYUzXjjo4HYwtJHhjsCzoL
 4Irh0isXjsNA==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="12914899"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Dec 2019 11:34:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 2E602281ED5;
        Wed,  4 Dec 2019 11:34:38 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:34:38 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.249) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:34:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <axboe@kernel.dk>
CC:     <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.com>
Subject: [PATCH 0/2] xen/blkback: Aggressively shrink page pools if a memory pressure is detected
Date:   Wed, 4 Dec 2019 12:34:17 +0100
Message-ID: <20191204113419.2298-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D21UWB003.ant.amazon.com (10.43.161.212) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and be increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, `blkfront` running guests can cause a memory pressure in the
`blkback` running guest by attaching arbitrarily large number of block
devices and inducing I/O.  This patchset avoids such problematic
situations by shrinking the pools aggressively (further the limit) for a
while if a memory pressure is detected.


Discussions
===========

The shrinking mechanism returns only pages in the pool which are not
currently be used by blkback.  In other words, the pages that will be
shrunk are not mapped with foreign pages.  Because this patchset is
changing only the shrink limit but uses the shrinking mechanism as is,
this patchset does not introduce security issues such as improper
unmappings.

The first patch keeps the aggressive shrinking limit for one milisecond
from last memory pressure detected time.  The duration should be neither
too short nor too long.  If it is too long, free pages pool shrinking
overhead can reduce the I/O performance.  If it is too short, blkback
will not free enough pages to reduce the memory pressure.  I set the
value as 1 millisecond by default because I believe that 1 millisecond
is a short duration in terms of I/O while it is a long duration in terms
of memory operations.  Also, as the original shrinking mechanism works
for every 100 milliseconds, this could be a somewhat reasonable choice.
In actual, the default value worked well for my test (refer to below
section for the detail of the test).  Nevertheless, the proper duration
would depends on given configurations and workloads.  The second patch
therefore allows users to set it via a module parameter interface.


Memory Pressure Test
====================

To show whether this patchset fixes the above mentioned memory pressure
situation well, I configured a test environment.  On the `blkfront`
running guest instances of a virtualized environment, I attach
arbitrarily large number of network-backed volume devices and induce I/O
to those.  Meanwhile, I measure the number of pages that swapped in and
out on the `blkback` running guest.  The test ran twice, once for the
`blkback` before this patchset and once for that after this patchset.

Roughly speaking, this patchset has reduced those numbers 130x (pswpin)
and 34x (pswpout) as below:

    		pswpin	pswpout
    before	76,672	185,799
    after	   587	  5,402


Performance Overhead Test
=========================

This patchset could incur I/O performance degradation under memory
pressure because the aggressive shrinking will require more page
allocations.  To show the overhead, I artificially made an aggressive
pages pool shrinking situation and measured the I/O performance of a
`blkfront` running guest.

For the artificial shrinking, I set the `blkback.max_buffer_pages` using
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
the value to `1024` and `0`.  The `1024` is the default value.  Setting
the value as `0` incurs the worst-case aggressive shrinking stress.

For the I/O performance measurement, I use a simple `dd` command.

Default Performance
-------------------

    [dom0]# echo 1024 >  /sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s

Worst-case Performance
----------------------

    [dom0]# echo 0 >  /sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s

In short, even worst case aggressive pools shrinking makes no visible
performance degradation.  I think this is due to the slow speed of the
I/O.  In other words, the additional page allocation overhead is hidden
under the much slower I/O time.

SeongJae Park (2):
  xen/blkback: Aggressively shrink page pools if a memory pressure is
    detected
  blkback: Add a module parameter for aggressive pool shrinking duration

 drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.17.1

