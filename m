Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540502607.66186.54.camel@acm.org>
Subject: Re: [PATCH 05/28] IB/srp: remove old request_fn_active check
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Parav Pandit <parav@mellanox.com>
Date: Thu, 25 Oct 2018 14:23:27 -0700
In-Reply-To: <20181025211039.11559-6-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
	 <20181025211039.11559-6-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
+AD4 This check is only viable for non scsi-mq. Since that is going away,
+AD4 kill this legacy check.
+AD4 
+AD4 Cc: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 Cc: Parav Pandit +ADw-parav+AEA-mellanox.com+AD4
+AD4 Cc: linux-scsi+AEA-vger.kernel.org
+AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 ---
+AD4  drivers/infiniband/ulp/srp/ib+AF8-srp.c +AHw 7 -------
+AD4  1 file changed, 7 deletions(-)
+AD4 
+AD4 diff --git a/drivers/infiniband/ulp/srp/ib+AF8-srp.c b/drivers/infiniband/ulp/srp/ib+AF8-srp.c
+AD4 index 0b34e909505f..5a79444c2f3c 100644
+AD4 --- a/drivers/infiniband/ulp/srp/ib+AF8-srp.c
+AD4 +-+-+- b/drivers/infiniband/ulp/srp/ib+AF8-srp.c
+AD4 +AEAAQA -1334,13 +-1334,6 +AEAAQA static void srp+AF8-terminate+AF8-io(struct srp+AF8-rport +ACo-rport)
+AD4  	struct scsi+AF8-device +ACo-sdev+ADs
+AD4  	int i, j+ADs
+AD4  
+AD4 -	/+ACo
+AD4 -	 +ACo Invoking srp+AF8-terminate+AF8-io() while srp+AF8-queuecommand() is running
+AD4 -	 +ACo is not safe. Hence the warning statement below.
+AD4 -	 +ACo-/
+AD4 -	shost+AF8-for+AF8-each+AF8-device(sdev, shost)
+AD4 -		WARN+AF8-ON+AF8-ONCE(sdev-+AD4-request+AF8-queue-+AD4-request+AF8-fn+AF8-active)+ADs
+AD4 -
+AD4  	for (i +AD0 0+ADs i +ADw target-+AD4-ch+AF8-count+ADs i+-+-) +AHs
+AD4  		ch +AD0 +ACY-target-+AD4-ch+AFs-i+AF0AOw

It seems like Hannes' and my Signed-off-by/Reviewed-by tags are missing?
See also https://marc.info/?l+AD0-linux-scsi+ACY-m+AD0-153970174514608.

Bart.
