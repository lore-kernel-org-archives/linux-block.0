Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 10/17] nvme: switch controller refcounting to use struct
 device
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-11-hch@lst.de>
 <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>
 <20171019072053.GA12168@lst.de>
 <05edcff6-4c56-39d9-83c8-e3eae03b824d@grimberg.me>
 <20171019073741.GA12348@lst.de>
 <827bd4b9-4228-32e4-e8dd-17679f2dfeba@grimberg.me>
 <20171019101855.GA17326@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <58a30ee0-f268-2d92-eccd-9d241402a460@grimberg.me>
Date: Thu, 19 Oct 2017 13:33:55 +0300
MIME-Version: 1.0
In-Reply-To: <20171019101855.GA17326@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> By the time we call ->delete_ctrl in nvmf_create_ctrl we must still
>>> have that reference because we are still in a ->write call and thus
>>> ->release can't have been called yet.
>>
>> Thanks for the clarification. Is it worth a preparatory patch to
>> change that before the ctrl device integration for change log
>> clarity?
> 
> Well, the ctrl device integration is what enables us to do this.
> Before that the ctrl refcount could have reached null by the time
> we call the delete_ctrl method.

OK, maybe a change log mention then?
