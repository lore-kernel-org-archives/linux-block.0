Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] block: Dynamically allocate and refcount
 backing_dev_info
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-4-jack@suse.cz> <20170201095007.GC17386@infradead.org>
 <20170201122257.GE11567@quack2.suse.cz>
Cc: linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <53f2bb8c-d4e6-7af9-2250-cccdf520660b@kernel.dk>
Date: Wed, 1 Feb 2017 14:45:20 -0800
MIME-Version: 1.0
In-Reply-To: <20170201122257.GE11567@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/01/2017 04:22 AM, Jan Kara wrote:
> On Wed 01-02-17 01:50:07, Christoph Hellwig wrote:
>> On Tue, Jan 31, 2017 at 01:54:28PM +0100, Jan Kara wrote:
>>> Instead of storing backing_dev_info inside struct request_queue,
>>> allocate it dynamically, reference count it, and free it when the last
>>> reference is dropped. Currently only request_queue holds the reference
>>> but in the following patch we add other users referencing
>>> backing_dev_info.
>>
>> Do we really need the separate slab cache?  Otherwise this looks
>> fine to me.
> 
> Yeah, probably it is not worth it. I'll remove it.

I agree on that, it should not be a hot path. Will you respin the series
after making this change? Would be great to get this queued up.

-- 
Jens Axboe
