Return-Path: <hch@lst.de>
Date: Tue, 29 Aug 2017 16:51:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guan Junxiong <guanjunxiong@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	niuhaoxin <niuhaoxin@huawei.com>,
	"Shenhong (C)" <shenhong09@huawei.com>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20170829145108.GB32673@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de> <e751810f-bb91-f764-dd51-ce2faaf209f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e751810f-bb91-f764-dd51-ce2faaf209f0@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 06:22:50PM +0800, Guan Junxiong wrote:
> Does this introduce conflicts with current DM-Multipath used for NVMe/NVMeF
> when path IO error occurs?  Such IO will be retried not only on the nvme-mpath
> internal path, but also on the dm-mpath path.

It will not reach back to dm-multipath if we fail over here.
