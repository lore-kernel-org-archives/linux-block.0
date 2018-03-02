Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>, Shaohua Li <shli@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 09/11] block: Use blk_queue_flag_*() in drivers instead of queue_flag_*()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-10-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:17:09 -0500
In-Reply-To: <20180228192823.5191-10-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Wed, 28 Feb 2018 11:28:21 -0800")
Message-ID: <yq11sh2uky2.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> This patch has been generated as follows:
>
> for verb in set_unlocked clear_unlocked set clear; do
>   replace-in-files queue_flag_${verb} blk_queue_flag_${verb%_unlocked} \
>     $(git grep -lw queue_flag_${verb} drivers block/bsg*)
> done
>
> Except for protecting all queue flag changes with the queue lock
> this patch does not change any functionality.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
