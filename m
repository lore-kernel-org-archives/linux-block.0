Return-Path: <gmazyland@gmail.com>
Return-Path: <gmazyland@gmail.com>
Subject: Re: dm-crypt: Fix error with too large bios
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>
References: <alpine.LRH.2.02.1608151245120.13026@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.11.1608181742260.10662@mail.ewheeler.net>
 <alpine.LRH.2.02.1608251426590.26645@file01.intranet.prod.int.rdu2.redhat.com>
 <24746705-a3af-e634-e675-f2214b6cf356@kernel.dk>
 <20160826140501.GA1061@redhat.com>
 <alpine.LRH.2.02.1608271102560.14465@file01.intranet.prod.int.rdu2.redhat.com>
 <CACVXFVP36-XU4J0D2xgvPBqvEMC6oGfXbbF8aGB0Rj-J10SizA@mail.gmail.com>
 <alpine.LRH.2.02.1608291752340.29067@file01.intranet.prod.int.rdu2.redhat.com>
 <CACVXFVOP6BkgTbWOmMrc6tJ_ekEanKWwRaGmBFXyz+mVwCukFQ@mail.gmail.com>
 <alpine.LRH.2.02.1608300813280.9336@file01.intranet.prod.int.rdu2.redhat.com>
 <20160830205732.GA53993@redhat.com>
 <alpine.LRH.2.02.1608301825540.10943@file01.intranet.prod.int.rdu2.redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Eric Wheeler <dm-devel@lists.ewheeler.net>, Christoph Hellwig <hch@lst.de>,
 johnstonj.public@codenest.com, linux-block <linux-block@vger.kernel.org>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <6a58fece-c60b-9dc2-e2e6-bee4e877a376@gmail.com>
Date: Wed, 31 Aug 2016 08:26:36 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1608301825540.10943@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 08/31/2016 12:27 AM, Mikulas Patocka wrote:

...
> 
> Drop that "#ifdef CONFIG_BCACHE". Anyone should be allowed to create a big 
> bio, not just bcache.

Yes. Please, do not hide it behind #ifdef.
If it is in code, it should be enabled always.

There can third party modules or some new code appears and creating strange
config dependence only adds more problems later.

Milan

> 
> That one test has no performance impact, there is no need to hide it 
> behind #ifdef.
> 
> Mikulas
> 
>> From: Mikulas Patocka <mpatocka@redhat.com>
>> Date: Tue, 30 Aug 2016 16:38:42 -0400
>> Subject: [PATCH] dm crypt: fix error with too large bcache bios
>>
>> When dm-crypt processes writes, it allocates a new bio in
>> crypt_alloc_buffer().  The bio is allocated from a bio set and it can
>> have at most BIO_MAX_PAGES vector entries, however the incoming bio can be
>> larger if it was allocated by bcache.  If the incoming bio is larger,
>> bio_alloc_bioset() fails and an error is returned.
>>
>> To avoid the error, we test for a too large bio in the function
>> crypt_map() and use dm_accept_partial_bio() to split the bio.
>> dm_accept_partial_bio() trims the current bio to the desired size and
>> asks DM core to send another bio with the rest of the data.
>>
>> This fix is wrapped with a check for CONFIG_BCACHE because there
>> currently isn't any other code that generates too large bios.  So unless
>> bcache is configured there is no point wasting time making this check.
>>
>> Signed-off-by: Mikulas Patocka <mpatocka redhat com>
>> Cc: stable@vger.kernel.org # v3.16+
>> ---
>>  drivers/md/dm-crypt.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
>> index eedba67..743f548 100644
>> --- a/drivers/md/dm-crypt.c
>> +++ b/drivers/md/dm-crypt.c
>> @@ -1924,6 +1924,12 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
>>  		return DM_MAPIO_REMAPPED;
>>  	}
>>  
>> +#ifdef CONFIG_BCACHE
>> +	if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_PAGES << PAGE_SHIFT)) &&
>> +	    bio_data_dir(bio) == WRITE)
>> +		dm_accept_partial_bio(bio, ((BIO_MAX_PAGES << PAGE_SHIFT) >> SECTOR_SHIFT));
>> +#endif
>> +
>>  	io = dm_per_bio_data(bio, cc->per_bio_data_size);
>>  	crypt_io_init(io, cc, bio, dm_target_offset(ti, bio->bi_iter.bi_sector));
>>  	io->ctx.req = (struct skcipher_request *)(io + 1);
>> -- 
>> 2.7.4 (Apple Git-66)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
