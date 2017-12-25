Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
To: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <45a16b4c-fbc0-106d-df37-439374c7b5dc@kernel.dk>
 <118beb1f-54eb-c65d-1c9c-4775ebde1fa8@kernel.dk>
 <20171221210250.GA2975@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f980d842-7995-61cf-ece2-36af67b626dc@grimberg.me>
Date: Mon, 25 Dec 2017 12:12:52 +0200
MIME-Version: 1.0
In-Reply-To: <20171221210250.GA2975@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> But that does bring up the fact if we should always be doing the
>> nvme_process_cq(nvmeq) after IO submission. For direct/hipri IO,
>> maybe it's better to make the submission path faster and skip it?
> 
> Yes, I am okay to remove the opprotunistic nvme_process_cq in the
> submission path. Even under deeply queued IO, I've not seen this provide
> any measurable benefit.

+100 for removing it. Never really understood why it gets us anything...
