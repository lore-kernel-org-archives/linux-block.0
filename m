Return-Path: <james.smart@broadcom.com>
Return-Path: <james.smart@broadcom.com>
Subject: Re: nvme-fc: fix status code handling in nvme_fc_fcpio_done
To: Christoph Hellwig <hch@bombadil.infradead.org>,
 Jens Axboe <axboe@kernel.dk>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-3-hch@bombadil.infradead.org>
Cc: Josef Bacik <jbacik@fb.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Christoph Hellwig <hch@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <96441c26-93b1-751d-6995-d9d0fab00eee@broadcom.com>
Date: Tue, 18 Apr 2017 14:08:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170418155229.5977-3-hch@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


On 4/18/2017 8:52 AM, Christoph Hellwig wrote:
> From: Christoph Hellwig <hch@lst.de>
>
> nvme_complete_async_event expects the little endian status code
> including the phase bit, and a new completion handler I plan to
> introduce will do so as well.
>
> Change the status variable into the little endian format with the
> phase bit used in the NVMe CQE to fix / enable this.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>

look good

-- james

Signed-off-by: James Smart <james.smart@broadcom.com>
