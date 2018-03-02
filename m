Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 10/11] block: Complain if queue_flag_(set|clear)_unlocked() is abused
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-11-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:18:16 -0500
In-Reply-To: <20180228192823.5191-11-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Wed, 28 Feb 2018 11:28:22 -0800")
Message-ID: <yq1sh9it6br.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Since it is not safe to use queue_flag_(set|clear)_unlocked() without
> holding the queue lock after the sysfs entries for a queue have been
> created, complain if this happens.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
