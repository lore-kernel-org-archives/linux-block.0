Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D9C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 10:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B2E20776
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 10:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jjuu1L7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgFPKd0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPKdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 06:33:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759AC08C5C2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 03:33:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j10so20186666wrw.8
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=74A51GVtFd+2eybj/+XN0W0IMI+UM9Mrii9ayhYc0zU=;
        b=jjuu1L7YAv5R9WABRXO9yhm7l9OVhKrB/6btXHEbcv8hWFrmB8p9IzWUpJI9femWme
         QxR39ciGhuUpdDpXJcEQkDfDgjYUKLdQCoWKiesSzX+7mGOSEXZpZHH0okYnjaNsDo4B
         ax0Ep9I2VGOgi4zIQQvNyJDY7jnCX2YioOvv2hjq5XzCxIwHFfFYbkgZD1mbBu8etWw3
         J7bo2ITEInNMyJrVAsS5AgmbKvI1cG8k5B63cTKqvaWlWnrbqEdp1JrK0zBUpL7k/7ne
         O/RMUqxLnBhT0r7WR7BA24N7oBbf/Z54n3mZYm7z71Y1qGbXWV7/abIN01wPNenPcFeZ
         5+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=74A51GVtFd+2eybj/+XN0W0IMI+UM9Mrii9ayhYc0zU=;
        b=MrX9VFVPMUgD1D+nN8Ga/HqrMAqVzc6s2C5E2WxebyVSJBwDSG9Bk1fXqp3yZlxwg2
         BFt9UjsyCVdfDJGd+yUbtUwFAaMrkK0lwkRUQEneLgl6W8mpGuwOBLsqXwACXdSDhmjY
         VZLuN6cmneXVnEIEGl0aTnS6ql0ZWFNeyvZ1Ocpnq2BkItKa4yA3rGwQujr4WWpevci8
         /eErfkUV0uH++NQya93MT23znn3ehQ91WXOBTEKIvnKu/nuc4UbXCQHaj6ykZpjDdf2s
         DhvImjPH2fgZ+aoeNlQoHW2pK92svqULYErzgJxqtuGZwFZjQ2CGY+8CX/9nXqXg5PP7
         1HyQ==
X-Gm-Message-State: AOAM5322qrcBYl4E1WvjtSVlgbGSXUNGNyUF/fFxuf5erHrVHCRS0wFf
        a/0X4bOXbTnZVRqZ5y3w2qYCTQ==
X-Google-Smtp-Source: ABdhPJxjTXs9sLXJpA673IXIR4STXMBswcoFY44auS3xipa7PD5genHb5MaCQbOYSQnqeaE8TJepeA==
X-Received: by 2002:adf:e381:: with SMTP id e1mr2233286wrm.320.1592303597323;
        Tue, 16 Jun 2020 03:33:17 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id a14sm29538407wrv.20.2020.06.16.03.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:33:16 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:33:15 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200616103157.6q5ubyfjpnmee4hx@mpHalley.local>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-4-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615233424.13458-4-keith.busch@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 08:34, Keith Busch wrote:
>From: Niklas Cassel <niklas.cassel@wdc.com>
>
>Implements support for the I/O Command Sets command set. The command set
>introduces a method to enumerate multiple command sets per namespace. If
>the command set is exposed, this method for enumeration will be used
>instead of the traditional method that uses the CC.CSS register command
>set register for command set identification.
>
>For namespaces where the Command Set Identifier is not supported or
>recognized, the specific namespace will not be created.
>
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>---
> drivers/nvme/host/core.c | 53 ++++++++++++++++++++++++++++++++--------
> drivers/nvme/host/nvme.h |  1 +
> include/linux/nvme.h     | 19 ++++++++++++--
> 3 files changed, 61 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 07a270b408a3..2f774d1e2acb 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -1056,8 +1056,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
> 	return error;
> }
>
>+static bool nvme_multi_css(struct nvme_ctrl *ctrl)
>+{
>+	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
>+}
>+
> static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>-		struct nvme_ns_id_desc *cur)
>+		struct nvme_ns_id_desc *cur, bool *csi_seen)
> {
> 	const char *warn_str = "ctrl returned bogus length:";
> 	void *data = cur;
>@@ -1087,6 +1092,15 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
> 		}
> 		uuid_copy(&ids->uuid, data + sizeof(*cur));
> 		return NVME_NIDT_UUID_LEN;
>+	case NVME_NIDT_CSI:
>+		if (cur->nidl != NVME_NIDT_CSI_LEN) {
>+			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
>+				 warn_str, cur->nidl);
>+			return -1;
>+		}
>+		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
>+		*csi_seen = true;
>+		return NVME_NIDT_CSI_LEN;
> 	default:
> 		/* Skip unknown types */
> 		return cur->nidl;
>@@ -1097,10 +1111,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> 		struct nvme_ns_ids *ids)
> {
> 	struct nvme_command c = { };
>-	int status;
>+	bool csi_seen = false;
>+	int status, pos, len;
> 	void *data;
>-	int pos;
>-	int len;
>
> 	c.identify.opcode = nvme_admin_identify;
> 	c.identify.nsid = cpu_to_le32(nsid);
>@@ -1113,8 +1126,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> 	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
> 				      NVME_IDENTIFY_DATA_SIZE);
> 	if (status) {
>-		dev_warn(ctrl->device,
>-			"Identify Descriptors failed (%d)\n", status);
>+		if (ctrl->vs >= NVME_VS(1, 3, 0))
>+			dev_warn(ctrl->device,
>+				"Identify Descriptors failed (%d)\n", status);
> 		 /*
> 		  * Don't treat an error as fatal, as we potentially already
> 		  * have a NGUID or EUI-64.
>@@ -1130,13 +1144,19 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> 		if (cur->nidl == 0)
> 			break;
>
>-		len = nvme_process_ns_desc(ctrl, ids, cur);
>+		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> 		if (len < 0)
> 			goto free_data;
>
> 		len += sizeof(*cur);
> 	}
> free_data:
>+	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>+		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
>+			 nsid);
>+		status = -EINVAL;
>+	}
>+
> 	kfree(data);
> 	return status;
> }
>@@ -1792,7 +1812,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
> 		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
> 	if (ctrl->vs >= NVME_VS(1, 2, 0))
> 		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
>-	if (ctrl->vs >= NVME_VS(1, 3, 0))
>+	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> 		return nvme_identify_ns_descs(ctrl, nsid, ids);
> 	return 0;
> }
>@@ -1808,7 +1828,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
> {
> 	return uuid_equal(&a->uuid, &b->uuid) &&
> 		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
>-		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0;
>+		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
>+		a->csi == b->csi;
> }
>
> static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>@@ -1930,6 +1951,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> 	if (ns->lba_shift == 0)
> 		ns->lba_shift = 9;
>
>+	switch (ns->head->ids.csi) {
>+	case NVME_CSI_NVM:
>+		break;
>+	default:
>+		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
>+			ns->head->ids.csi, ns->head->ns_id);
>+		return -ENODEV;
>+	}
>+
> 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
> 	    is_power_of_2(ctrl->max_hw_sectors))
> 		iob = ctrl->max_hw_sectors;
>@@ -2264,7 +2294,10 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>
> 	ctrl->page_size = 1 << page_shift;
>
>-	ctrl->ctrl_config = NVME_CC_CSS_NVM;
>+	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
>+		ctrl->ctrl_config = NVME_CC_CSS_CSI;
>+	else
>+		ctrl->ctrl_config = NVME_CC_CSS_NVM;
> 	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
> 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>index c0f4226d3299..a84f71459caa 100644
>--- a/drivers/nvme/host/nvme.h
>+++ b/drivers/nvme/host/nvme.h
>@@ -339,6 +339,7 @@ struct nvme_ns_ids {
> 	u8	eui64[8];
> 	u8	nguid[16];
> 	uuid_t	uuid;
>+	u8	csi;
> };
>
> /*
>diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>index 5ce51ab4c50e..f8b5b8d7fc7e 100644
>--- a/include/linux/nvme.h
>+++ b/include/linux/nvme.h
>@@ -134,6 +134,7 @@ enum {
> #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
> #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
> #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
>+#define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)

Small niptick: maybe move this under NVME_CAP_NSSRC to keep order?

>
> #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
> #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
>@@ -162,7 +163,6 @@ enum {
>
> enum {
> 	NVME_CC_ENABLE		= 1 << 0,
>-	NVME_CC_CSS_NVM		= 0 << 4,
> 	NVME_CC_EN_SHIFT	= 0,
> 	NVME_CC_CSS_SHIFT	= 4,
> 	NVME_CC_MPS_SHIFT	= 7,
>@@ -170,6 +170,9 @@ enum {
> 	NVME_CC_SHN_SHIFT	= 14,
> 	NVME_CC_IOSQES_SHIFT	= 16,
> 	NVME_CC_IOCQES_SHIFT	= 20,
>+	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
>+	NVME_CC_CSS_CSI		= 6 << NVME_CC_CSS_SHIFT,
>+	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
> 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
> 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
> 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
>@@ -179,6 +182,8 @@ enum {
> 	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
> 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
> 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
>+	NVME_CAP_CSS_NVM	= 1 << 0,
>+	NVME_CAP_CSS_CSI	= 1 << 6,
> 	NVME_CSTS_RDY		= 1 << 0,
> 	NVME_CSTS_CFS		= 1 << 1,
> 	NVME_CSTS_NSSRO		= 1 << 4,
>@@ -374,6 +379,8 @@ enum {
> 	NVME_ID_CNS_CTRL		= 0x01,
> 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
> 	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
>+	NVME_ID_CNS_CS_NS		= 0x05,
>+	NVME_ID_CNS_CS_CTRL		= 0x06,
> 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
> 	NVME_ID_CNS_NS_PRESENT		= 0x11,
> 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
>@@ -383,6 +390,10 @@ enum {
> 	NVME_ID_CNS_UUID_LIST		= 0x17,
> };
>
>+enum {
>+	NVME_CSI_NVM			= 0,
>+};
>+
> enum {
> 	NVME_DIR_IDENTIFY		= 0x00,
> 	NVME_DIR_STREAMS		= 0x01,
>@@ -435,11 +446,13 @@ struct nvme_ns_id_desc {
> #define NVME_NIDT_EUI64_LEN	8
> #define NVME_NIDT_NGUID_LEN	16
> #define NVME_NIDT_UUID_LEN	16
>+#define NVME_NIDT_CSI_LEN	1
>
> enum {
> 	NVME_NIDT_EUI64		= 0x01,
> 	NVME_NIDT_NGUID		= 0x02,
> 	NVME_NIDT_UUID		= 0x03,
>+	NVME_NIDT_CSI		= 0x04,
> };
>
> struct nvme_smart_log {
>@@ -972,7 +985,9 @@ struct nvme_identify {
> 	__u8			cns;
> 	__u8			rsvd3;
> 	__le16			ctrlid;
>-	__u32			rsvd11[5];
>+	__u8			rsvd11[3];
>+	__u8			csi;
>+	__u32			rsvd12[4];
> };
>
> #define NVME_IDENTIFY_DATA_SIZE 4096
>-- 
>2.24.1
>

Otherwise,

Reviewed-by: Javier González <javier.gonz@samsung.com>
