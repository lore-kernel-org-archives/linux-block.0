Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: split scsi passthrough fields out of struct request V3
Date: Fri, 27 Jan 2017 18:58:53 +0000
Message-ID: <1485543514.4267.23.camel@sandisk.com>
References: <1485534918-18239-1-git-send-email-hch@lst.de>
In-Reply-To: <1485534918-18239-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-01-27 at 17:34 +0100, Christoph Hellwig wrote:
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
> Changes since V2:
>  - remove req->cmd tracing
>  - minor spelling fixes
>=20
> Changes since V1:
>  - fix handling of a NULL sense pointer in __scsi_execute
>  - clean up handling of the flush flags in the block layer and MD
>  - additional small cleanup in dm-rq

Hello Christoph,

Version 3 of the patch with title "block: split scsi_request out of
struct request" (commit 3c30af6ebe12) differs significantly from v2
of that patch that has been posted on several mailing lists. E.g. v2
moves __cmd[], cmd and cmd_len from struct request into struct
scsi_request but v3 not. Which version do you want us to review?

Thanks,

Bart.=
