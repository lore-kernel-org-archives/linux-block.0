Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH 2/3] block: move dif_prepare/dif_complete functions to
 block layer
To: Keith Busch <keith.busch@linux.intel.com>
CC: <keith.busch@intel.com>, <linux-nvme@lists.infradead.org>,
	<sagi@grimberg.me>, <hch@lst.de>, <martin.petersen@oracle.com>,
	<linux-block@vger.kernel.org>, <axboe@kernel.dk>, <vladimirk@mellanox.com>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
 <1532439222-5668-2-git-send-email-maxg@mellanox.com>
 <20180724203323.GA13926@localhost.localdomain>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <cb6d5265-b20c-c1db-f678-8e4613039ea5@mellanox.com>
Date: Wed, 25 Jul 2018 01:32:32 +0300
MIME-Version: 1.0
In-Reply-To: <20180724203323.GA13926@localhost.localdomain>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 7/24/2018 11:33 PM, Keith Busch wrote:
> On Tue, Jul 24, 2018 at 04:33:41PM +0300, Max Gurtovoy wrote:
>> +void t10_pi_prepare(struct request *rq, u8 protection_type)
>> +{
>> +	const int tuple_sz = rq->q->integrity.tuple_size;
>> +	u32 ref_tag = t10_pi_ref_tag(rq);
>> +	struct bio *bio;
>> +
>> +	if (protection_type == T10_PI_TYPE3_PROTECTION)
>> +		return;
>> +
>> +	__rq_for_each_bio(bio, rq) {
>> +		struct bio_integrity_payload *bip = bio_integrity(bio);
>> +		u32 virt = bip_get_seed(bip) & 0xffffffff;
>> +		struct bio_vec iv;
>> +		struct bvec_iter iter;
>> +
>> +		/* Already remapped? */
>> +		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
>> +			break;
>> +
>> +		bip_for_each_vec(iv, bip, iter) {
>> +			struct t10_pi_tuple *pi = kmap_atomic(iv.bv_page) +
>> +						iv.bv_offset;
>> +			unsigned int j;
>> +
>> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
>> +				if (be32_to_cpu(pi->ref_tag) == virt)
>> +					pi->ref_tag = cpu_to_be32(ref_tag);
>> +				virt++;
>> +				ref_tag++;
>> +				pi += tuple_sz;
>> +			}
>> +
>> +			kunmap_atomic(pi);
>> +		}
> 
> Since you're incrementing 'pi', you end up unmapping an address that
> you didn't map. It does appears harmless in current kunmap_atomic()
> implementation, though.

ohh, good catch. This code is taken from the scsi remap, but I guess 
it's time to fix some stuff while we doing this patchset.
I'll use another variable pi_map that will be unmapped.

in the nvme code:

pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;

...
but

kunmap_atomic(pmap);

should we unmap the same bv_page we mapped (without the offset) ?

> 
> You are also incrementing 'pi' by too many bytes since it is of type
> struct t10_pi_tuple. The nvme driver used void* to make the pointer
> arithmentic easier.
> 

I'' use void*.
Thanks
