Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24160 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbdCMOXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 10:23:17 -0400
From: Umesh Patel <Umesh.Patel@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: blk_init_queue vs blk_alloc_queue
Date: Mon, 13 Mar 2017 14:23:13 +0000
Message-ID: <CY1PR0401MB1353DF0CD31F0D4FAC7C3EA3E1250@CY1PR0401MB1353.namprd04.prod.outlook.com>
References: <CY1PR0401MB1353F4C37A081FCB3E6E145EE1250@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <20170313133629.GA29232@infradead.org>
In-Reply-To: <20170313133629.GA29232@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently we are using below API to initialize request queues for our devic=
e which is not calling blk_queue_split. But there is one more function blk_=
init_queues which is internally calling blk_queue_split.=20
So I was thinking to replace blk_alloc_queue with blk_init_queue but since =
I was not aware of impact I shoot this mail.
I wanted to use blk_queue_split to split BIO that block layer is sending si=
nce it it too large.


Thx


dev->osdev.queue =3D blk_alloc_queue(GFP_KERNEL);

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]=20
Sent: Monday, March 13, 2017 7:06 PM
To: Umesh Patel
Cc: linux-block@vger.kernel.org
Subject: Re: blk_init_queue vs blk_alloc_queue

On Mon, Mar 13, 2017 at 09:14:12AM +0000, Umesh Patel wrote:
> Hello,
>=20
> I Would like to know difference between blk_init_queue and blk_alloc_queu=
e API.
> Can anyone explain when to use what ?

The short answer is that you should neither.  The long answer is that you s=
hould send a link to your driver source if you want anyone to help you.
