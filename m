Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 12:18:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/17] nvme: switch controller refcounting to use
	struct device
Message-ID: <20171019101855.GA17326@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-11-hch@lst.de> <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me> <20171019072053.GA12168@lst.de> <05edcff6-4c56-39d9-83c8-e3eae03b824d@grimberg.me> <20171019073741.GA12348@lst.de> <827bd4b9-4228-32e4-e8dd-17679f2dfeba@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <827bd4b9-4228-32e4-e8dd-17679f2dfeba@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 01:02:59PM +0300, Sagi Grimberg wrote:
>> By the time we call ->delete_ctrl in nvmf_create_ctrl we must still
>> have that reference because we are still in a ->write call and thus
>> ->release can't have been called yet.
>
> Thanks for the clarification. Is it worth a preparatory patch to
> change that before the ctrl device integration for change log
> clarity?

Well, the ctrl device integration is what enables us to do this.
Before that the ctrl refcount could have reached null by the time
we call the delete_ctrl method.
