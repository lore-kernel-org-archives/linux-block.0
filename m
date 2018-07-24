Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH 2/3] block: move dif_prepare/dif_complete functions to
 block layer
To: Christoph Hellwig <hch@lst.de>
CC: <keith.busch@intel.com>, <linux-nvme@lists.infradead.org>,
	<sagi@grimberg.me>, <martin.petersen@oracle.com>,
	<linux-block@vger.kernel.org>, <axboe@kernel.dk>, <vladimirk@mellanox.com>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
 <1532439222-5668-2-git-send-email-maxg@mellanox.com>
 <20180724135546.GB29918@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2fdb170d-e8de-b7cc-429a-9b6e5f36de86@mellanox.com>
Date: Tue, 24 Jul 2018 17:33:24 +0300
MIME-Version: 1.0
In-Reply-To: <20180724135546.GB29918@lst.de>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 7/24/2018 4:55 PM, Christoph Hellwig wrote:
>> +/*
>> + * The virtual start sector is the one that was originally submitted
>> + * by the block layer.	Due to partitioning, MD/DM cloning, etc. the
>> + * actual physical start sector is likely to be different.  Remap
>> + * protection information to match the physical LBA.
>> + *
>> + * From SCSI protocol perspective there's a slight difference between
>> + * Type 1 and 2.  The latter uses command's 32-byte exclusively, and the
>> + * reference tag is seeded in the command.  This gives us the potential to
>> + * avoid virt->phys remapping during write.  However, at read time we
>> + * don't know whether the virt sector is the same as when we wrote it
>> + * (we could be reading from real disk as opposed to MD/DM device.  So
>> + * we always remap Type 2 making it identical to Type 1.
>> + *
>> + * Type 3 does not have a reference tag so no remapping is required.
>> + */
> 
> Please convert the comments for  t10_pi_prepare/t10_pi_complete to
> kerneldoc format, and remove the mention of 32-byte CDBs, which
> are SCSI specific.
> 

something like this:

/**
  * t10_pi_prepare() - prepate PI prior submitting request to device
  * @rq:               request with PI that should be prepared
  * @protection_type:  PI type (Type 1/Type 2/Type 3)
  *
  * Description:
  *    For Type 1/Type 2, the virtual start sector is the one that was
  *    originally submitted by the block layer for the ref_tag usage. Due to
  *    partitioning, MD/DM cloning, etc. the actual physical start sector is
  *    likely to be different. Remap protection information to match the
  *    physical LBA.
  *
  *    Type 3 does not have a reference tag so no remapping is required.
  */

> Otherwise this looks good to me.
> 
> Note that after this patch only sd_dif_config_host is left in sd_dif.c,
> at which point it might be worth merging into sd.c as a separate patch.
> 
