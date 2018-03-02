Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 03/11] block: Introduce blk_queue_flag_{set,clear,test_and_{set,clear}}()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-4-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:11:25 -0500
In-Reply-To: <20180228192823.5191-4-bart.vanassche@wdc.com> (Bart Van Assche's
	message of "Wed, 28 Feb 2018 11:28:15 -0800")
Message-ID: <yq1muzqul7m.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Introduce functions that modify the queue flags and that protect
> these modifications with the request queue lock. Except for moving
> one wake_up_all() call from inside to outside a critical section,
> this patch does not change any functionality.

Looks OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
