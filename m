Return-Path: <martin.petersen@oracle.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/2] scsi-mq: Only show the CDB if available
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171205003809.1705-1-bart.vanassche@wdc.com>
	<20171205003809.1705-2-bart.vanassche@wdc.com>
	<20171205011536.GC8365@ming.t460p>
Date: Mon, 04 Dec 2017 22:42:28 -0500
In-Reply-To: <20171205011536.GC8365@ming.t460p> (Ming Lei's message of "Tue, 5
	Dec 2017 09:15:37 +0800")
Message-ID: <yq1zi6x3knv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Hi Ming,

> Please cook a patch for fixing the crash issue only, since we need
> to backport the fix to stable kernel.

I thought you were going to submit a V5 that addressed James' concerns?

-- 
Martin K. Petersen	Oracle Linux Engineering
