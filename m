Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/6] Split scsi passthrough fields out of struct
 request sequel
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ef560d3f-9516-7614-9df0-649d7a75b207@kernel.dk>
Date: Thu, 1 Jun 2017 12:11:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170531214350.31157-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/31/2017 02:43 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> The patches in this series are a sequel of Christoph's "Split scsi passthrough
> fields out of struct request" patch series. The changes compared to v1 of this
> patch series are:
> - Renamed QUEUE_FLAG_SCSI_PDU into QUEUE_FLAG_SCSI_PASSTHROUGH and
>   blk_queue_scsi_pdu() into blk_queue_scsi_passthrough().
> - In the cdrom driver, moved the SCSI passthrough support test from
>   register_cdrom() to cdrom_read_cdda_bpc().
> 
> Please consider these patches for kernel v4.13.

Applied for 4.13 (2-6).

-- 
Jens Axboe
