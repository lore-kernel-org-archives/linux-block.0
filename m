Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:27433
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751130AbdA0V2D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 16:28:03 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Date: Fri, 27 Jan 2017 21:27:53 +0000
Message-ID: <1485552454.4267.29.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
In-Reply-To: <1485365126-23210-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 18:25 +0100, Christoph Hellwig wrote:
> this series splits the support for SCSI passthrough commands from the
> main struct request used all over the block layer into a separate
> scsi_request structure that drivers that want to support SCSI passthough
> need to embedded as the first thing into their request-private data,
> similar to how we handle NVMe passthrough commands.
>=20
> To support this I've added support for that the private data after
> request structure to the legacy request path instead, so that it can
> be treated the same way as the blk-mq path.  Compare to the current
> scsi_cmnd allocator that actually is a major simplification.
>=20
> Changes since V1:
>  - fix handling of a NULL sense pointer in __scsi_execute
>  - clean up handling of the flush flags in the block layer and MD
>  - additional small cleanup in dm-rq

Hello Christoph,

A general comment: patch "block: allow specifying size for extra
command data" is a very welcome improvement but unfortunately also
introduces an inconsistency among block drivers. This patch series
namely creates two kinds of block drivers:
- Block drivers that use the block layer core to allocate
  request-private data. These block drivers set request.cmd_size
  to a non-zero value and do not need request.special.
- Block drivers that allocate request-private data themselves.
  These block drivers set request.cmd_size to zero and use
  request.special to translate a request pointer into the private
  data pointer.

Have you considered to convert all block drivers to the new
approach and to get rid of request.special? If so, do you already
have plans to start working on this? I'm namely wondering wheter I
should start working on this myself.

Thanks,

Bart.=
