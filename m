Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0040.outbound.protection.outlook.com ([104.47.38.40]:27328
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934051AbdA0Rps (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 12:45:48 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 12/18] scsi: respect unchecked_isa_dma for blk-mq
Date: Fri, 27 Jan 2017 17:45:14 +0000
Message-ID: <1485539094.4267.14.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485365126-23210-13-git-send-email-hch@lst.de>
In-Reply-To: <1485365126-23210-13-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 18:25 +0100, Christoph Hellwig wrote:
> Currently blk-mq always allocates the sense buffer using normal GFP_KERNE=
L
> allocation.  Refactor the cmd pool code to split the cmd and sense alloca=
tion
> and share the code to allocate the sense buffers as well as the sense buf=
fer
> slab caches between the legacy and blk-mq path.
>=20
> Note that this switches to lazy allocation of the sense slab caches - the
> slab caches (not the actual allocations) won't be destroy until the scsi
> module is unloaded instead of keeping track of hosts using them.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
