Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
 properly initialized
To: Christoph Hellwig <hch@lst.de>
References: <1465831278-23653-1-git-send-email-hch@lst.de>
 <1465831278-23653-4-git-send-email-hch@lst.de>
Cc: mst@redhat.com, ooo@electrozaur.com, bhalevy@primarydata.com,
 nab@linux-iscsi.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <575F6942.5060406@kernel.dk>
Date: Mon, 13 Jun 2016 20:17:38 -0600
MIME-Version: 1.0
In-Reply-To: <1465831278-23653-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/13/2016 09:21 AM, Christoph Hellwig wrote:
> blk_get_request is used for BLOCK_PC and similar pass through requests.
> Currently we always need to call blk_rq_set_block_pc or an opencoded
> version of it to allow appending bios using the request mapping helpers
> later on, which is a somewhat awkward API.  Instead move the
> initialization part of blk_rq_set_block_pc into blk_get_request, so that
> we always have a safe to use request.  blk_rq_set_block_pc now goes away
> in favor of just setting cmd_type to REQ_TYPE_BLOCK_PC, or nothing in case
> it was overriden with a different type a little later (or earlier in case
> of the SCSI OSD code..)

It may be awkward, but we have those to avoid doing things like this:

+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
+	memset(rq->__cmd, 0, sizeof(rq->__cmd));

for every request we allocate, when we don't use ->cmd at all. Honest, 
I'd rather have

struct request *blk_get_pc_request();

and similar helpers around this, so we don't have to do extra 
initialization when we don't need it.

-- 
Jens Axboe
