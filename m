Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:34249
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753708AbcIADNJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2016 23:13:09 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Omar Sandoval <osandov@osandov.com>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Use non-atomic operations to manipulate the
 sw-ctx busy bits
Date: Thu, 1 Sep 2016 03:13:07 +0000
Message-ID: <BLUPR02MB16839985957DF473C379BFB981E20@BLUPR02MB1683.namprd02.prod.outlook.com>
References: <aa1d8314-3c5e-4554-61e1-95c61aa11624@sandisk.com>
 <20160901011849.GA8276@vader>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/31/16 18:18, Omar Sandoval wrote:=0A=
> NAK, we can't protect each bit with a separate lock, multiple software=0A=
> queues share the bitmap. There's a race if we do non-atomic bit=0A=
> operations on two software queues with bits in the same word.=0A=
=0A=
Hi Omar,=0A=
=0A=
You are right of course. This is something I should have realized =0A=
myself. Jens, please ignore this patch.=0A=
=0A=
Bart.=0A=
=0A=
=0A=
