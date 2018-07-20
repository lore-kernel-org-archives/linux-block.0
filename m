Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Fri, 20 Jul 2018 07:41:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720144146.GA22454@infradead.org>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719212618.2406-2-keith.busch@intel.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Has this been tested?  Especially with the blk_abort_request corner
case?
