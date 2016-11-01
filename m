Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: martin.petersen@oracle.com, don.brace@microsemi.com, axboe@kernel.dk,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: export blk_mq_map_queues
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1478009569-19026-1-git-send-email-hch@lst.de>
	<1478009569-19026-2-git-send-email-hch@lst.de>
Date: Tue, 01 Nov 2016 11:53:18 -0400
In-Reply-To: <1478009569-19026-2-git-send-email-hch@lst.de> (Christoph
	Hellwig's message of "Tue, 1 Nov 2016 08:12:47 -0600")
Message-ID: <yq1lgx319jl.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> This will allow SCSI to have a single blk_mq_ops structure
Christoph> that either lets the LLDD map the queues to PCIe MSIx vectors
Christoph> or use the default.

Jens, any objection to me funneling this change through the SCSI tree?

-- 
Martin K. Petersen	Oracle Linux Engineering
