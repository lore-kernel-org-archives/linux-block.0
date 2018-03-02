Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 08/11] target/tcm_loop: Use blk_queue_flag_set()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-9-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:17:28 -0500
In-Reply-To: <20180228192823.5191-9-bart.vanassche@wdc.com> (Bart Van Assche's
	message of "Wed, 28 Feb 2018 11:28:20 -0800")
Message-ID: <yq1woyut6d3.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Use blk_queue_flag_set() instead of open-coding this function.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
