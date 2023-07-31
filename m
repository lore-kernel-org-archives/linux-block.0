Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14A1C001DF
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGaWPo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGaWPm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:42 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646619B6
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:36 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bbc06f830aso32491315ad.0
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841736; x=1691446536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xs3eQ100BztgYl07Pu6o58l3Ii8LAwrgxPmcbK9FQY=;
        b=GSbNyGJiQE0B2ERDdAfy+frkUxtkO4oOP2X0eI2IveyJG4e2TzMFNo4o2MG76D9aAV
         amHJCBW3y9Ym8caA3QcImLTA4ATvtwwbe1yBLLFBHHj/mR5S/7D6XUD6kM7VpBOzp1Ja
         k6WDmsJUgcwY72v9EjJ+TWoxk1oCa1JFXB64NUXNl7euNRr7UXznmkhEb91cih63StCa
         YDVz49CU/IRwSPoJNauYqPDFC+Rz9UJNvaEJTS4iqkcVct3meEgzACIQsxQylpSw8ZQ1
         pOeDBSWLQK/B5CTKUjlaUjplfhBjnBNE4kw6FExPUllP53FA3QImnl0EygJ99AXoRd9p
         qxdg==
X-Gm-Message-State: ABy/qLacogCmLx/aHYbUTsQLNvKvocYiNdFMNCEpmnfF8TnJixFHzBzD
        rwti6EhmQ5Wp6eFmGkItfbs=
X-Google-Smtp-Source: APBJJlH6ALD3nxRgLBtWnfKog0SPdjVRheFkzoq5I7LEYzkhMBBCiy4/7rXfCAoMhedUeN+Hk2kB2w==
X-Received: by 2002:a17:902:e546:b0:1b7:f64b:379b with SMTP id n6-20020a170902e54600b001b7f64b379bmr12696217plf.17.1690841736104;
        Mon, 31 Jul 2023 15:15:36 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <quic_cang@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 6/7] scsi: ufs: Split an if-condition
Date:   Mon, 31 Jul 2023 15:14:42 -0700
Message-ID: <20230731221458.437440-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the next patch in this series easier to read. No functionality is
changed.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 129446775796..ae7b868f9c26 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4352,8 +4352,9 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-	if (update &&
-	    !pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
+	if (!update)
+		return;
+	if (!pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
 		ufshcd_rpm_get_sync(hba);
 		ufshcd_hold(hba);
 		ufshcd_auto_hibern8_enable(hba);
