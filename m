Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 05/11] mtip32xx: Use the blk_queue_flag_*() functions
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-6-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:12:32 -0500
In-Reply-To: <20180228192823.5191-6-bart.vanassche@wdc.com> (Bart Van Assche's
	message of "Wed, 28 Feb 2018 11:28:17 -0800")
Message-ID: <yq1efl2ul5r.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Use the blk_queue_flag_*() functions instead of open-coding these.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
