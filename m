Return-Path: <j-nomura@ce.jp.nec.com>
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "chaitanya.kulkarni@hgst.com" <chaitanya.kulkarni@hgst.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't try Write Same from __blkdev_issue_zeroout
Date: Mon, 6 Feb 2017 01:27:24 +0000
Message-ID: <ce89f586-21f3-f0fd-14f0-d718c060107e@ce.jp.nec.com>
References: <20170205171035.5993-1-hch@lst.de>
In-Reply-To: <20170205171035.5993-1-hch@lst.de>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 02/06/17 02:10, Christoph Hellwig wrote:
> Write Same can return an error asynchronously if it turns out the
> underlying SCSI device does not support Write Same, which makes a
> proper fallback to other methods in __blkdev_issue_zeroout impossible.
> Thus only issue a Write Same from blkdev_issue_zeroout an don't try it
> at all from __blkdev_issue_zeroout as a non-invasive workaround.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
> Fixes: e73c23ff ("block: add async variant of blkdev_issue_zeroout")

Thank you. I tested your patch and confirmed it works for me.

--=20
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
