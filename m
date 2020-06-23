Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF565C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 08:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EC820723
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 08:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgFWIx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:53:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWIxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 04:53:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id b6so19622652wrs.11
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 01:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MEMKTEgjM6sWI8lDir9zpf/W6RewuawyMRVpLGof+Gw=;
        b=VH8lhP+vVhEumlKvwHM/nBYCpGvSrWurBqcrqLrpQaKxtYip606I3cRGnZxaKxmDn5
         oqsWMs6Ohn7dCKa1aj3nRPDXV9NLkbn+HdHoPfPFUVpq4zUbONEUfR874QtUdvPW3MUD
         Hx8y0mcj9NsNePdyvVe53kvlY7KMCIq5M0tAH+J6N0Yx7Mx91q/9PRlC5xZr7jcqlb5j
         +FMOrOnlwEUTSGvUWqqiZyVwj553++IgBQXUPNTvsWd/5eiYILyVC0DTrpX+QMkv6MUL
         Qmq5f75EGe4lEL7z7TKHCLUhzDU6EabvnIB2NnhkgAdHZA2kIGK6L2MQw/W5uRw14Rc+
         C/rw==
X-Gm-Message-State: AOAM5316gfUMvrrCS7h5bT3qOgaaYfxoyJLggYRSiRuWeFO6fAcOsrMr
        QqjiETg5iWYhUf2JaKZxe2c=
X-Google-Smtp-Source: ABdhPJzqOGaqCpozirPhU8Q9v7lOxmAzhV+fRwTx7PNaIOQGHZ3oec/G8nd0LSEHapl679m48VtAog==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr22821955wrp.378.1592902432348;
        Tue, 23 Jun 2020 01:53:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8927:798c:48dc:eaa9? ([2601:647:4802:9070:8927:798c:48dc:eaa9])
        by smtp.gmail.com with ESMTPSA id 1sm2679461wmf.21.2020.06.23.01.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 01:53:51 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
Date:   Tue, 23 Jun 2020 01:53:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-4-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/22/20 9:25 AM, Keith Busch wrote:
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
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
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

We will clear the status if we detect a path error, that is to
avoid needlessly removing the ns for path failures, so you should
check at the goto site.

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

Not sure we need a switch-case statement for a single case target...
