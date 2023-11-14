Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2172FC44
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C39121;
	Tue, 14 Nov 2023 13:18:51 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1cc4f777ab9so47036455ad.0;
        Tue, 14 Nov 2023 13:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996731; x=1700601531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNaII3DND/2IYpwh5Jy74a0kz8WOg4MBJJED5/gaHxY=;
        b=wZ7eBYb5cz4qEa7hUGnYfpE4eSO3h7cZHTfdEWD+bGAnNBNrO/Dd2Zdpu/wg/oVGvr
         KDSnFiVlV+N+5UfvEu7OIxAV7xTLY2/OE89kWQLnCzlw+3wOTO3DQbis3hfXRO558vXd
         1604vz3OX7+49i55/kpBq2uwfSMj0c92EStz2B/avgp67raZRrJ84qArUqG0Km8/zOBz
         TtfWwIRslS/Od+O3vnWmIUGTc4wK3JNDpEfHEcq3853zBypugaawC0NI2Z2Gi17zDYY6
         twlXIZjvjCn35231CvJvIRvvaBVSA4ucj6XDtneaPpXBsOz53d7dr2A4qYPBBVwTJKNJ
         LnRA==
X-Gm-Message-State: AOJu0YxJllsdN2hAHH70DVtwr0rx2h3xbTgIC5Ga7LZ3Gsy2QeCYm2gB
	k6slX23w5puB9sukabQvwvM=
X-Google-Smtp-Source: AGHT+IFltOELmXW1lWl4h45zu2rS7AGfH6Qm3CcVnB/raF3IwylxbNF/pxTiv8+54MPB4qT06N5FcQ==
X-Received: by 2002:a17:902:db85:b0:1cc:476c:896c with SMTP id m5-20020a170902db8500b001cc476c896cmr3298348pld.60.1699996730970;
        Tue, 14 Nov 2023 13:18:50 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001c71ec1866fsm6169288plb.258.2023.11.14.13.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:18:50 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v15 13/19] scsi: scsi_debug: Support injecting unaligned write errors
Date: Tue, 14 Nov 2023 13:16:21 -0800
Message-ID: <20231114211804.1449162-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114211804.1449162-1-bvanassche@acm.org>
References: <20231114211804.1449162-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user space software, e.g. a blktests test, to inject unaligned
write errors.

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6f0c78e727ec..23ea090698df 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -183,6 +183,7 @@ static const char *sdebug_version_date = "20210520";
 #define SDEBUG_OPT_NO_CDB_NOISE		0x4000
 #define SDEBUG_OPT_HOST_BUSY		0x8000
 #define SDEBUG_OPT_CMD_ABORT		0x10000
+#define SDEBUG_OPT_UNALIGNED_WRITE	0x20000
 #define SDEBUG_OPT_ALL_NOISE (SDEBUG_OPT_NOISE | SDEBUG_OPT_Q_NOISE | \
 			      SDEBUG_OPT_RESET_NOISE)
 #define SDEBUG_OPT_ALL_INJECTING (SDEBUG_OPT_RECOVERED_ERR | \
@@ -190,7 +191,8 @@ static const char *sdebug_version_date = "20210520";
 				  SDEBUG_OPT_DIF_ERR | SDEBUG_OPT_DIX_ERR | \
 				  SDEBUG_OPT_SHORT_TRANSFER | \
 				  SDEBUG_OPT_HOST_BUSY | \
-				  SDEBUG_OPT_CMD_ABORT)
+				  SDEBUG_OPT_CMD_ABORT | \
+				  SDEBUG_OPT_UNALIGNED_WRITE)
 #define SDEBUG_OPT_RECOV_DIF_DIX (SDEBUG_OPT_RECOVERED_ERR | \
 				  SDEBUG_OPT_DIF_ERR | SDEBUG_OPT_DIX_ERR)
 
@@ -3898,6 +3900,14 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u8 *cmd = scp->cmnd;
 
+	if (unlikely(sdebug_opts & SDEBUG_OPT_UNALIGNED_WRITE &&
+		     atomic_read(&sdeb_inject_pending))) {
+		atomic_set(&sdeb_inject_pending, 0);
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, LBA_OUT_OF_RANGE,
+				UNALIGNED_WRITE_ASCQ);
+		return check_condition_result;
+	}
+
 	switch (cmd[0]) {
 	case WRITE_16:
 		ei_lba = 0;
