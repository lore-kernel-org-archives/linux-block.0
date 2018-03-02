Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 11/11] block: Move the queue_flag_*() functions from a public into a private header file
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
	<20180228192823.5191-12-bart.vanassche@wdc.com>
Date: Fri, 02 Mar 2018 18:20:52 -0500
In-Reply-To: <20180228192823.5191-12-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Wed, 28 Feb 2018 11:28:23 -0800")
Message-ID: <yq1o9k6t67f.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> This patch helps to avoid that new code gets introduced in block drivers
> that manipulates queue flags without holding the queue lock when that
> lock should be held.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
