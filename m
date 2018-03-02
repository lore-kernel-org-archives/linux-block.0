Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 01/11] block: Reorder the queue flag manipulaton function definitions
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-2-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:09:10 -0500
In-Reply-To: <20180228192823.5191-2-bart.vanassche@wdc.com> (Bart Van Assche's
	message of "Wed, 28 Feb 2018 11:28:13 -0800")
Message-ID: <yq1vaeeulbd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

s/manipulaton/manipulation/ in Subject. Otherwise OK.

> Move the definition of queue_flag_clear_unlocked() up and move the
> definition of queue_in_flight() down such that all queue flag
> manipulation function definitions become contiguous.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
