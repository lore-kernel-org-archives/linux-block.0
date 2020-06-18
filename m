Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14B5208B8
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="b9WT5+eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgFRVIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFRVI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 17:08:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742D0C06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 14:08:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so6544349wmh.2
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=02Vu+bINDzuf2b0xPZUYIyvP5wSDhrkIxvdtHn0W7rs=;
        b=b9WT5+eRHcneM8FY2YGi5tuRcxmK9IJl3jZfnOTVm8al/+xniTlXUMgbgWURwVGmgk
         RjBLN29v4Xzw3GTRdTUvk7tLNRHmQjt4C0EBL/TLBT5IgxW4wqRhWaUQmYXlvqLtrMi2
         vaZPJVkuMQ9siXZjJWbf9W7bxZIREr+uYsTFeOh7JWh7bMPQgK4FlcF0vpP7jCm9eSY0
         1wFUV2XUUQdr1epTKjge+PToAuLfXRt3J6SLc6cQBYF1C3Gz7ecVhgw4tf6Z99xOXbUN
         C9Du+9f7WSOuKdhjg9pOJz8zDIXbxAO71ceE7dR+jXB7YdKYM28QbqpsjxyuMgFiZ4AA
         h1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=02Vu+bINDzuf2b0xPZUYIyvP5wSDhrkIxvdtHn0W7rs=;
        b=hlIE/1ssRezmQNehMRtlWZVfE9e6Mzzu4qmi4lkKVxQTehuYatPQ4C2WfgHWG5J7Fu
         55RcqbJCnJeEkk1xGTKADzgh6iQzhuiVo3kda5ZwVAH0oePdfPDO/soztl8BZ+BssdQn
         gh81bQDED9smH+GhO6BeAZ+PI54s6asG3Oto8c7/OsRmNrzkIXctckX22pIWN7pQBJNi
         HC6T9LlANqA92FReRZBOWVevUHyFjyVqIeqwB2hxHjnx+D9IshpzP5p8Zm3atJwsOWP9
         J5bOzPFk3WWIBU9YZG5C5kZqZx6fw5axGiAP0MAVC3HsaQQA6PamQDMe0dixHn7LCj3U
         I52A==
X-Gm-Message-State: AOAM530iaEJj7yecYPygdk9DQiS8WXCoQ+vAjgTovCNkzqC74LSmil+Q
        fHiEJ7ut4a72jEycRZKlELfJFw==
X-Google-Smtp-Source: ABdhPJxZQFCHGTaHCqhXp5sBMeE/3MDQp1D9l7DQ3Ey7R+bs+Codum+YFieMOaakux2tpkFZ/iMofg==
X-Received: by 2002:a1c:1b11:: with SMTP id b17mr202521wmb.123.1592514508109;
        Thu, 18 Jun 2020 14:08:28 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id a15sm5480405wrh.54.2020.06.18.14.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:08:27 -0700 (PDT)
Subject: Re: [PATCHv2 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Niklas Cassel <niklas.cassel@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-4-kbusch@kernel.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e0dced95-e401-922a-02d9-026d5020cd76@lightnvm.io>
Date:   Thu, 18 Jun 2020 23:08:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618145354.1139350-4-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/06/2020 16.53, Keith Busch wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> Implements support for the I/O Command Sets command set. The command set
> introduces a method to enumerate multiple command sets per namespace. If
> the command set is exposed, this method for enumeration will be used
> instead of the traditional method that uses the CC.CSS register command
> set register for command set identification.
>
> For namespaces where the Command Set Identifier is not supported or
> recognized, the specific namespace will not be created.
>
> Reviewed-by: Javier González <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>   drivers/nvme/host/nvme.h |  1 +
>   include/linux/nvme.h     | 19 ++++++++++++++--
>   3 files changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9491dbcfe81a..45a3cb5a35bd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1056,8 +1056,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>   	return error;
>   }
>   
> +static bool nvme_multi_css(struct nvme_ctrl *ctrl)
> +{
> +	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
> +}
> +
>   static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
> -		struct nvme_ns_id_desc *cur)
> +		struct nvme_ns_id_desc *cur, bool *csi_seen)
>   {
>   	const char *warn_str = "ctrl returned bogus length:";
>   	void *data = cur;
> @@ -1087,6 +1092,15 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>   		}
>   		uuid_copy(&ids->uuid, data + sizeof(*cur));
>   		return NVME_NIDT_UUID_LEN;
> +	case NVME_NIDT_CSI:
> +		if (cur->nidl != NVME_NIDT_CSI_LEN) {
> +			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
> +				 warn_str, cur->nidl);
> +			return -1;
> +		}
> +		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
> +		*csi_seen = true;
> +		return NVME_NIDT_CSI_LEN;
>   	default:
>   		/* Skip unknown types */
>   		return cur->nidl;
> @@ -1097,10 +1111,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>   		struct nvme_ns_ids *ids)
>   {
>   	struct nvme_command c = { };
> -	int status;
> +	bool csi_seen = false;
> +	int status, pos, len;
>   	void *data;
> -	int pos;
> -	int len;
>   
>   	c.identify.opcode = nvme_admin_identify;
>   	c.identify.nsid = cpu_to_le32(nsid);
> @@ -1130,13 +1143,19 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>   		if (cur->nidl == 0)
>   			break;
>   
> -		len = nvme_process_ns_desc(ctrl, ids, cur);
> +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
>   		if (len < 0)
>   			goto free_data;
>   
>   		len += sizeof(*cur);
>   	}
>   free_data:
> +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> +		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
> +			 nsid);
> +		status = -EINVAL;
> +	}
> +
>   	kfree(data);
>   	return status;
>   }
> @@ -1792,7 +1811,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
>   		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
>   	if (ctrl->vs >= NVME_VS(1, 2, 0))
>   		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> -	if (ctrl->vs >= NVME_VS(1, 3, 0))
> +	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
>   		return nvme_identify_ns_descs(ctrl, nsid, ids);
>   	return 0;
>   }
> @@ -1808,7 +1827,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
>   {
>   	return uuid_equal(&a->uuid, &b->uuid) &&
>   		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
> -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0;
> +		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
> +		a->csi == b->csi;
>   }
>   
>   static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> @@ -1930,6 +1950,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>   	if (ns->lba_shift == 0)
>   		ns->lba_shift = 9;
>   
> +	switch (ns->head->ids.csi) {
> +	case NVME_CSI_NVM:
> +		break;
> +	default:
> +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
> +			ns->head->ids.csi, ns->head->ns_id);
> +		return -ENODEV;
> +	}
> +
>   	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
>   	    is_power_of_2(ctrl->max_hw_sectors))
>   		iob = ctrl->max_hw_sectors;
> @@ -2264,7 +2293,10 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>   
>   	ctrl->page_size = 1 << page_shift;
>   
> -	ctrl->ctrl_config = NVME_CC_CSS_NVM;
> +	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
> +		ctrl->ctrl_config = NVME_CC_CSS_CSI;
> +	else
> +		ctrl->ctrl_config = NVME_CC_CSS_NVM;
>   	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
>   	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
>   	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index c0f4226d3299..a84f71459caa 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -339,6 +339,7 @@ struct nvme_ns_ids {
>   	u8	eui64[8];
>   	u8	nguid[16];
>   	uuid_t	uuid;
> +	u8	csi;
>   };
>   
>   /*
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 5ce51ab4c50e..81ffe5247505 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -132,6 +132,7 @@ enum {
>   #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
>   #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
>   #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
> +#define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
>   #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
>   #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
>   
> @@ -162,7 +163,6 @@ enum {
>   
>   enum {
>   	NVME_CC_ENABLE		= 1 << 0,
> -	NVME_CC_CSS_NVM		= 0 << 4,
>   	NVME_CC_EN_SHIFT	= 0,
>   	NVME_CC_CSS_SHIFT	= 4,
>   	NVME_CC_MPS_SHIFT	= 7,
> @@ -170,6 +170,9 @@ enum {
>   	NVME_CC_SHN_SHIFT	= 14,
>   	NVME_CC_IOSQES_SHIFT	= 16,
>   	NVME_CC_IOCQES_SHIFT	= 20,
> +	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
> +	NVME_CC_CSS_CSI		= 6 << NVME_CC_CSS_SHIFT,
> +	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
>   	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
>   	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
>   	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
> @@ -179,6 +182,8 @@ enum {
>   	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
>   	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
>   	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
> +	NVME_CAP_CSS_NVM	= 1 << 0,
> +	NVME_CAP_CSS_CSI	= 1 << 6,
>   	NVME_CSTS_RDY		= 1 << 0,
>   	NVME_CSTS_CFS		= 1 << 1,
>   	NVME_CSTS_NSSRO		= 1 << 4,
> @@ -374,6 +379,8 @@ enum {
>   	NVME_ID_CNS_CTRL		= 0x01,
>   	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
>   	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
> +	NVME_ID_CNS_CS_NS		= 0x05,
> +	NVME_ID_CNS_CS_CTRL		= 0x06,
>   	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
>   	NVME_ID_CNS_NS_PRESENT		= 0x11,
>   	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
> @@ -383,6 +390,10 @@ enum {
>   	NVME_ID_CNS_UUID_LIST		= 0x17,
>   };
>   
> +enum {
> +	NVME_CSI_NVM			= 0,
> +};
> +
>   enum {
>   	NVME_DIR_IDENTIFY		= 0x00,
>   	NVME_DIR_STREAMS		= 0x01,
> @@ -435,11 +446,13 @@ struct nvme_ns_id_desc {
>   #define NVME_NIDT_EUI64_LEN	8
>   #define NVME_NIDT_NGUID_LEN	16
>   #define NVME_NIDT_UUID_LEN	16
> +#define NVME_NIDT_CSI_LEN	1
>   
>   enum {
>   	NVME_NIDT_EUI64		= 0x01,
>   	NVME_NIDT_NGUID		= 0x02,
>   	NVME_NIDT_UUID		= 0x03,
> +	NVME_NIDT_CSI		= 0x04,
>   };
>   
>   struct nvme_smart_log {
> @@ -972,7 +985,9 @@ struct nvme_identify {
>   	__u8			cns;
>   	__u8			rsvd3;
>   	__le16			ctrlid;
> -	__u32			rsvd11[5];
> +	__u8			rsvd11[3];
> +	__u8			csi;
> +	__u32			rsvd12[4];
>   };
>   
>   #define NVME_IDENTIFY_DATA_SIZE 4096

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

