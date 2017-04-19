Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] scsi: Implement blk_mq_ops.show_rq()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
	<20170418232949.5228-9-bart.vanassche@sandisk.com>
Date: Wed, 19 Apr 2017 19:25:21 -0400
In-Reply-To: <20170418232949.5228-9-bart.vanassche@sandisk.com> (Bart Van
	Assche's message of "Tue, 18 Apr 2017 16:29:49 -0700")
Message-ID: <yq1efworndq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Bart Van Assche <bart.vanassche@sandisk.com> writes:

Bart,

> Show the SCSI CDB, .eh_eflags and .result for pending SCSI commands
> in /sys/kernel/debug/block/*/mq/*/dispatch and */rq_list.

SCSI_EH_CANCEL_CMD is no more (as of a06586325f37).

-- 
Martin K. Petersen	Oracle Linux Engineering
