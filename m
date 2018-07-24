Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Max Gurtovoy <maxg@mellanox.com>, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, axboe@kernel.dk, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 1/2] block: move dif_prepare/dif_complete functions to block layer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1532252998-2375-1-git-send-email-maxg@mellanox.com>
	<20180723072854.GA18365@lst.de>
Date: Mon, 23 Jul 2018 21:54:38 -0400
In-Reply-To: <20180723072854.GA18365@lst.de> (Christoph Hellwig's message of
	"Mon, 23 Jul 2018 09:28:54 +0200")
Message-ID: <yq1bmax5rfl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

>> +void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
>> +			       u32 ref_tag)
>> +{
>
> Maybe call this blk_t10_pi_prepare?

The rest of these functions have a blk_integrity_ prefix. So either
stick with that or put the functions in t10-pi.c and use a t10_pi_
prefix.

I'm a bit torn on placement since the integrity metadata could contain
other stuff than T10 PI. But the remapping is very specific to T10 PI.

>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index 9421d9877730..4186bf027c59 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -1119,7 +1119,9 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
>>  		SCpnt->cmnd[0] = WRITE_6;
>>  
>>  		if (blk_integrity_rq(rq))
>> -			sd_dif_prepare(SCpnt);
>> +			blk_integrity_dif_prepare(SCpnt->request,
>> +						  sdkp->protection_type,
>> +						  scsi_prot_ref_tag(SCpnt));
>
> scsi_prot_ref_tag could be move to the block layer as it only uses
> the sector in the eequest and the sector size, which we can get
> from the gendisk as well.  We then don't need to pass it to the function.

For Type 2, the PI can be at intervals different from the logical block
size (although we don't support that yet). We should use the
blk_integrity profile interval instead of assuming sector size.

And wrt. Keith's comment: The tuple_size should be the one from the
integrity profile as well, not sizeof(struct t10_pi_tuple).

-- 
Martin K. Petersen	Oracle Linux Engineering
