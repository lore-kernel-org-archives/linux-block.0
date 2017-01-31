Return-Path: <axboe@kernel.dk>
Subject: Re: make SCSI passthrough support optional
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com, jasowang@redhat.com
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eef9850f-07f7-ef61-22b6-246fc44fbfc0@kernel.dk>
Date: Tue, 31 Jan 2017 09:56:59 -0800
MIME-Version: 1.0
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/28/2017 12:32 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series builds on my previous changes in Jens' for-4.11/rq-refactor
> branch that split out the BLOCK_PC fields from struct request into a new
> struct scsi_request, and makes support for struct scsi_request and the
> SCSI passthrough ioctls optional.  It is now only enabled by drivers that
> need it.
> 
> In addition I've made SCSI passthrough support in the virtio_blk driver an
> optional compile time feature, as it's not actually needed for most
> common setups.

Appled.

-- 
Jens Axboe
