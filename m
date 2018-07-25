Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH v3 2/3] block: move dif_prepare/dif_complete functions to
 block layer
To: Christoph Hellwig <hch@lst.de>
CC: <keith.busch@intel.com>, <linux-nvme@lists.infradead.org>,
	<sagi@grimberg.me>, <martin.petersen@oracle.com>,
	<linux-block@vger.kernel.org>, <axboe@kernel.dk>, <vladimirk@mellanox.com>
References: <1532508421-2711-1-git-send-email-maxg@mellanox.com>
 <1532508421-2711-2-git-send-email-maxg@mellanox.com>
 <20180725112247.GA24190@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a1d9dc80-6fe9-78c7-2eed-9912ae01e456@mellanox.com>
Date: Wed, 25 Jul 2018 14:47:17 +0300
MIME-Version: 1.0
In-Reply-To: <20180725112247.GA24190@lst.de>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 7/25/2018 2:22 PM, Christoph Hellwig wrote:
>> +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
>> +			p = pmap;
> 
> Maybe:
> 
> 			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;
> 
>> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
>> +				pi = (struct t10_pi_tuple *)p;
> 
> No need for the cast, also the pi declaration can be moved into the
> inner scope:
> 
> 				struct t10_pi_tuple *pi = p;
> 
>> +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
>> +			p = pmap;
>> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
>> +				if (intervals == 0) {
>> +					kunmap_atomic(pmap);
>> +					return;
>> +				}
>> +				pi = (struct t10_pi_tuple *)p;
> 
> Same here.
> 
> Also the intervals check would make sense in the for loop I think, e.g.:
> 
> 			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;
> 			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
> 				struct t10_pi_tuple *pi = p;
> 


Yes it make sense, but we can do more iterations before we return but I 
guess it's rare and it's worth to have less lines of code.
I'll update it for the next version.
