Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3047 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdCHJfi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2017 04:35:38 -0500
From: Umesh Patel <Umesh.Patel@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Umesh Patel <Umesh.Patel@wdc.com>
Subject: BIO request larger than our storage device supports in linux kernel
 4.x
Date: Wed, 8 Mar 2017 09:34:59 +0000
Message-ID: <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
References: <CY1PR0401MB13538108F3DFD6738AFC8A34E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com> 
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

We are registering BIO size of our storage device through linux kernel API =
blk_queue_max_hw_sectors worth of 104K. So max size of BIO that our block d=
evice can handle is 104 KB but kernel block layer is sending 256 KB worth o=
f BIO which is more than we are supporting.
This issue we are observing in 4.4 and also in latest 4.10.1 kernel release=
. Until this we had not seen this issue.

>From the kernel source code history I came to below things.
4.1 kernel version onwards=20
"nr_pages =3D min(sdio->pages_in_io, bio_get_nr_vecs(map_bh->b_bdev))"
has been removed which (bio_get_nr_vecs) was considering max_sectors_kb of =
queue which was 104 KB for our device.

Presently new code is something like
"nr_pages =3D min(sdio->pages_in_io, BIO_MAX_PAGES)"
which is sending 256 KB (BIO_MAX_PAGES) of BIO size to our device which we =
are not supporting.


So from some documentation I found out that 256 KB of bio size is the fix (=
from 4.x kernel) and that has to support by any drive.=20
Please let me know is there any way to change BIO size worth of 104 KB from=
 256 KB or any other way to register our BIO size with kernel or any other =
area to look in to ?.=20

-Umesh
