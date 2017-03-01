Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:31405
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751392AbdCABMt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 20:12:49 -0500
From: Parav Pandit <parav@mellanox.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: connect cmd error for nvme-rdma with eventual kernel crash
Date: Wed, 1 Mar 2017 00:57:20 +0000
Message-ID: <VI1PR0502MB3008851A3D20ECF93FC70FCCD1290@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

With your commit 2af8cbe30531eca73c8f3ba277f155fc0020b01a in linux-block gi=
t tree,
There are two requests tables. Static and dynamic of same size.
However function blk_mq_tag_to_rq() always try to get the tag from the dyna=
mic table which doesn't seem to be always initialized.

I am running nvme-rdma initiator and it fails to find the request for the g=
iven tag when command completes.
Command triggers error recovery with "tag not found" error.
Eventually kernel is crashing in blk_mq_queue_tag_busy_iter() with NULL poi=
nter. Seems to be additional bug in error recovery.

To debug, I added initializing dynamic tags as well.

blk_mq_alloc_rqs() {
			tags->static_rqs[i] =3D rq;
+			tags->rqs[i] =3D rq;

This appears to resolve the issue. But that's not the fix.
It appears to me that nvme stack is broken in certain conditions with recen=
t static and dynamic rq tables change.

Can you please confirm?

Regards,
Parav Pandit
