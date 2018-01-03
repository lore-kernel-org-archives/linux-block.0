Return-Path: <keith.busch@intel.com>
Date: Wed, 3 Jan 2018 13:21:05 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
Message-ID: <20180103202105.GC11172@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <45a16b4c-fbc0-106d-df37-439374c7b5dc@kernel.dk>
 <118beb1f-54eb-c65d-1c9c-4775ebde1fa8@kernel.dk>
 <20171221210250.GA2975@localhost.localdomain>
 <6ffc074a-3c5b-c76d-d213-6606a77626e0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6ffc074a-3c5b-c76d-d213-6606a77626e0@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 02:01:44PM -0700, Jens Axboe wrote:
> I haven't either, but curious if others had. It's mostly just extra
> overhead, I haven't seen it provide a latency reduction of any kind.

I've removed the submission side poll in a local build, and amazingly I
am observing a not insignificant increase in latency without it on some
workloads with certain hardware. I will have to delay recommending/posting
removal of this pending further investigation.
