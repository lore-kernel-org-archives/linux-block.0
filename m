Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 04/11] block: Protect queue flag changes with the queue lock
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-5-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:12:12 -0500
In-Reply-To: <20180228192823.5191-5-bart.vanassche@wdc.com> (Bart Van Assche's
	message of "Wed, 28 Feb 2018 11:28:16 -0800")
Message-ID: <yq1inaeul6b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Since the queue flags may be changed concurrently from multiple
> contexts after a queue becomes visible in sysfs, make these changes
> safe by protecting these with the queue lock.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
