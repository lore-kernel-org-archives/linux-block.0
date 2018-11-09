Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: remove the legacy BLKPREP_* values
Date: Fri,  9 Nov 2018 14:42:34 +0100
Message-Id: <20181109134241.29346-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this series gets rid of the old BLKPREP_* values from the legacy block
layer in favor of always using a blk_status_t (or a bool in one case).
