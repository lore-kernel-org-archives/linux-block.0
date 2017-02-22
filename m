Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
To: Christoph Hellwig <hch@lst.de>, Jon Derrick <jonathan.derrick@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
 <20170222071342.GA17472@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Scott Bauer <scott.bauer@intel.com>,
 Rafael Antognolli <rafael.antognolli@intel.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
Date: Wed, 22 Feb 2017 09:10:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170222071342.GA17472@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 12:13 AM, Christoph Hellwig wrote:
>> +	if (!lock_held)
>> +		mutex_lock(&dev->dev_lock);
> 
> No conditional locking, please.  I guess I causesd this by asking you
> to remove __opal_lock_unlock, but it seems we'd either need to keep it
> in the end.
> 
> Except for that the series looks fine to me.
> 
> Jens: given that 1-3 are the important fixes how about you pick those
> up ASAP?  They all also had my Reviewed-by for previous postings.

I picked up 1-3, and re-added your reviewed by. #4 should be sorted
before -rc1, though.

-- 
Jens Axboe
