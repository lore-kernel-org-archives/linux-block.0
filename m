Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63681 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdCMKFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 06:05:48 -0400
From: Umesh Patel <Umesh.Patel@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Getting kernel crash
Date: Mon, 13 Mar 2017 10:05:46 +0000
Message-ID: <CY1PR0401MB1353BBDD3F1049AD32C64BD1E1250@CY1PR0401MB1353.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I'm calling blk_queue_split kernel function from my driver to split larger =
BIO and that is working fine for block size 4K and 8K but getting below cra=
sh for block size 1M.
Using stable 4.10.1 kernel version


[  890.227865] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000724
[  890.305384] IP: _raw_spin_lock_irqsave+0x22/0x3f
[  890.343896] PGD 0
[  891.381744] Call Trace:
[  891.415424]  try_to_wake_up+0x40/0x3e0
[  891.449074]  ? mempool_free_slab+0x17/0x20
[  891.483213]  wake_up_process+0x15/0x20
[  891.517492]  blkdev_bio_end_io_simple+0x1d/0x20
[  891.551363]  bio_endio+0x56/0x60


Thx.
