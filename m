Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv2 1/2] block: Merge discard requests as a special case
To: Keith Busch <keith.busch@intel.com>,
 Linux Block <linux-block@vger.kernel.org>,
 Linux NVMe <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <20180201203158.24761-1-keith.busch@intel.com>
 <20180201203158.24761-2-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d55e87e6-e59c-9a22-297b-039febcb953c@kernel.dk>
Date: Thu, 1 Feb 2018 14:00:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180201203158.24761-2-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/1/18 1:31 PM, Keith Busch wrote:
> Discard requests operate under different constraints than other operations
> and have different rules for merging. This patch will handle such requests
> as a special case, using the same criteria and segment accounting used
> for merging a discard bio into a reqseut.

I already fixed this one up.

-- 
Jens Axboe
