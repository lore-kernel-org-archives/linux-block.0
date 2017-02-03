Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH] dm: don't allow ioctls to targets that don't map to whole
 devices
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, snitzer@redhat.com
References: <20170203100613.9023-1-hch@lst.de>
Cc: agk@redhat.com, pbonzini@redhat.com, dm-devel@redhat.com,
 linux-block@vger.kernel.org
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <60c7f620-403c-5ec2-ae9f-e99676410b38@suse.de>
Date: Fri, 3 Feb 2017 11:10:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170203100613.9023-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 02/03/2017 11:06 AM, Christoph Hellwig wrote:
> .. at least for unprivilegued users.  Before we called into the SCSI
> ioctl code to allow excemptions for a few SCSI passthrough ioctls,
> but this is pretty unsafe and except for this call dm knows nothing
> about SCSI ioctls.  As SCSI the SCSI ioctl code is made optionally
                                              ^~ duped SCSI or should it 
read "as in SCSI the SCSI ioctl code [...]"

> now we really don't want to drag it in for DM, and the exception is
> not very useful anyway.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Note: this should go into the block tree, as that's where
> scsi_verify_blk_ioctl becomes optional.
>
> ---
Rest looks OK to me,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
