Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B652C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3698120854
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hbe7jFUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCMSxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:53:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45430 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfCMSxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 14:53:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so1994863pfm.12
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6ewGx6SjxO3ZRR5kyRZnWz2O7mm8gqSfI76kN+JmLBI=;
        b=hbe7jFUnisnTgNU3syeZsHvxPBaVn4eMSKu+sMz7FyO5u5W6fKdST/5W7RzKmwl3Jc
         KCs+yCBZdxHOlecLvfwMsVGFbzoTCq96HvmiOyhtQCMH27Nqw7d+j1dBWJ1JCNF9wg7j
         BAmj0fE/P+Nybe3FXgR2sjckAkjv/NWG02DME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6ewGx6SjxO3ZRR5kyRZnWz2O7mm8gqSfI76kN+JmLBI=;
        b=ixYrMQFUjFVWDlqoD51SFS7PDfPTOVsTny6ga2UvgdIl0yJTvt5jRzqpXHSYcxpwL/
         wT8QZ90Nf9NZi94TRy6tpL3DPPc02Kk5jgGzqpfz7ylZ8weBnorpHXGEIXhHxtlS5Nk/
         Yvq6VI4rL0RAYe/wA5Bk/TfLxcTMZIuD2DJsEQ/wLpe3rpLgUpwUcYWJIBaPGv/nT5Tz
         0cAES/pjIrX/WydNX0zfMzfxsATqnDwLYEcfdZI597UHaDxjnad3yECDLjaJB4eIVswW
         W/bxRTorjgGrbuE+w8VP1EvDn6ne74ETyaD/+30AP/jpvTXucEqdtZTlipL0MXKZHjS+
         z4bA==
X-Gm-Message-State: APjAAAUUnhoBxR+TtZEmydDLgRAyUTXlmiyfZPQnvyEF2Ow6a0GxgjVA
        VcXyK9AF3GS7iI7U/TMXLY9Jhw==
X-Google-Smtp-Source: APXvYqxYI5WdWWvSOEYXvP+YR5zARtBFpUW8r0lfonU3tTuDS7eELjw4f3o++RnE139z3Bgt3z2PTA==
X-Received: by 2002:a63:ce:: with SMTP id 197mr23851010pga.212.1552503182364;
        Wed, 13 Mar 2019 11:53:02 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g12sm8934951pfd.72.2019.03.13.11.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:53:01 -0700 (PDT)
Subject: Re: [PATCH 10/17] nvmet-fc: fix issues with targetport assoc_list
 list walking
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Nigel Kirkland <nigel.kirkland@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-11-hch@lst.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <73182b96-5113-005a-fb18-7cc126de8b69@broadcom.com>
Date:   Wed, 13 Mar 2019 11:53:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190313175510.20725-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/2019 10:55 AM, Christoph Hellwig wrote:
> From: James Smart <jsmart2021@gmail.com>
>
> There are two changes:
>
> 1) The logic in the __nvmet_fc_free_assoc() routine is bad. It uses
> "safe" routines assuming pointers will come back valid.  However, the
> intervening next structure being linked can be removed from the list and
> the resulting safe pointers are bad, resulting in NULL ptrs being hit.
>
> Correct by scheduling a work element to perform the association delete,
> which can be done while under lock.
>
> 2) Prior patch that added the work element scheduling left a possible
> reference on the object if the work element couldn't be scheduled.
>
> Correct by doing the put on a failing schedule_work() call.
>
> Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/fc.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 1e9654f04c60..8d34aa573d5b 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1143,10 +1143,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>   				&tgtport->assoc_list, a_list) {
>   		if (!nvmet_fc_tgt_a_get(assoc))
>   			continue;
> -		spin_unlock_irqrestore(&tgtport->lock, flags);
> -		nvmet_fc_delete_target_assoc(assoc);
> -		nvmet_fc_tgt_a_put(assoc);
> -		spin_lock_irqsave(&tgtport->lock, flags);
> +		if (!schedule_work(&assoc->del_work))
> +			nvmet_fc_tgt_a_put(assoc);
>   	}
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   }
> @@ -1185,7 +1183,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
>   		nvmet_fc_tgtport_put(tgtport);
>   
>   		if (found_ctrl) {
> -			schedule_work(&assoc->del_work);
> +			if (schedule_work(&assoc->del_work))
> +				nvmet_fc_tgt_a_put(assoc);
>   			return;
>   		}
>   
V1 was checked in 
(http://lists.infradead.org/pipermail/linux-nvme/2019-February/022193.html
V2 was skipped 
(http://lists.infradead.org/pipermail/linux-nvme/2019-February/022540.html)

V2 changes the last
+            if (schedule_work(&assoc->del_work))
to
+            if (!schedule_work(&assoc->del_work))


Jens - can you do this manual fixup ?

-- james


