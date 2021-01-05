Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F7C433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1C622D6F
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbhAETMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbhAETMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 14:12:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293BC061793
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 11:11:56 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id h10so282882pfo.9
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3zIFBPQg8IPmi+klJdFBx9OZP1riJjqye12qq2Ji44Y=;
        b=o5roT/G77K1zjPOlknkmJMyAT0zIEi+6jXa6i9dStajstpKfU8DOGD7bj5JqErdsbs
         FlenuWrPGE5ZhhU+B93EIrlsJkLKY3R8Megj/R/bYmahQ5lq1FqjDjjhMyFIy0BIWSq+
         o14ADyREMc8IXlgQ6QlcR4T70Cus/GT+ywZdeY6woRHQd8A/OduSzDnfq5eQad83VeDf
         5Lk3y4iKhmmyU1Glv5tCkDudNt0Q612z/84v+F+UTYdDXQt79+NMrT3vMOFrmPR70yhg
         dQ0EOTS4w0/I7mhpOu9N5EAwu8bkdxLuwz8y/il07RGABdA7XAiyZpnHqp0ld0eABM+9
         wjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zIFBPQg8IPmi+klJdFBx9OZP1riJjqye12qq2Ji44Y=;
        b=IpghssXF4349wypa/2ozRn3O7lP5CWwfS0EbhGUb8C15ntLTwDx80XGk+SIJSL3WCL
         1rLEsF1FB24Uc9WVYYA6yQ/gf0jPCmp7h7cgZyPi1Y+pCb+tNr/EnRndjYAtrVPXQwp2
         Ba2pDEGShxpvtwb+t3O2rJm9eQ8ZKN8wo7TEHDz+kEF6zZaWAmU5Yg8XdEPnJR/shIQI
         icu7YTzWitLQzqQmEaNHNBrDyw9Sk5/yEqUKeAQ7Ka+rnsTVM8IRkxBj3qgH4OGAmeLx
         9zht2j79Kd3CV4grTCEk4vWXdM3GbF6Hrtaxmhgbfx1WVXp1udOjF8rye8QuZZaUVDZu
         u+Hg==
X-Gm-Message-State: AOAM530qOmtf1ZRNqpvKHtl5i7W9GiFmCUR8PzqFikxKeZRZuEMO4f/K
        7u4luX0dhcqliVynK0bMtnnuMqqtyepv1Q==
X-Google-Smtp-Source: ABdhPJwyAsMRMa6qi3/f5aIwb7buln5cWdj+WbjR15vMqBIr8HuFm3Xwussprj4gqDYLbQqmyxsxOg==
X-Received: by 2002:a63:fc42:: with SMTP id r2mr747278pgk.234.1609873916504;
        Tue, 05 Jan 2021 11:11:56 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id a18sm153176pfg.107.2021.01.05.11.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 11:11:56 -0800 (PST)
Date:   Wed, 6 Jan 2021 04:11:54 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH 2/6] nvme-core: introduce complete failed request
Message-ID: <20210105191154.GA4426@localhost.localdomain>
References: <20210105071936.25097-1-lengchao@huawei.com>
 <20210105071936.25097-3-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210105071936.25097-3-lengchao@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 21-01-05 15:19:32, Chao Leng wrote:
> When a request is queued failed, if the fail status is not
> BLK_STS_RESOURCE, BLK_STS_DEV_RESOURCE, BLK_STS_ZONE_RESOURCE,
> the request is need to complete with nvme_complete_rq in queue_rq.
> So introduce nvme_try_complete_failed_req.
> The request is needed to complete with NVME_SC_HOST_PATH_ERROR in
> nvmf_fail_nonready_command and queue_rq.
> So introduce nvme_complete_failed_req.
> For details, see the subsequent patches.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>  drivers/nvme/host/nvme.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bfcedfa4b057..1a0bddb9158f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -649,6 +649,24 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
>  extern const struct attribute_group *nvme_ns_id_attr_groups[];
>  extern const struct block_device_operations nvme_ns_head_ops;
>  
> +static inline void nvme_complete_failed_req(struct request *req)
> +{
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_set_request_complete(req);
> +	nvme_complete_rq(req);
> +}
> +
> +static inline blk_status_t nvme_try_complete_failed_req(struct request *req,
> +							blk_status_t ret)
> +{
> +	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE ||
> +	    ret == BLK_STS_ZONE_RESOURCE)
> +		return ret;

If it has nothing to do with various conditions, can we have this if
to switch just like the other function in the same file does:

	switch (ret) {
	case BLK_STS_RESOURCE:
	case BLK_STS_DEV_RESOURCE:
	case BLK_STS_ZONE_RESOURCE:
		return ret;
	default:
		nvme_complete_failed_req(req);
		return BLK_STS_OK;
	}

> +
> +	nvme_complete_failed_req(req);
> +	return BLK_STS_OK;
> +}
> +

Can we have these two functions along side with nvme_try_complete_req()
by moving declaration of nvme_coplete_rq() a little bit up ?

>  #ifdef CONFIG_NVME_MULTIPATH
>  static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>  {
> -- 
> 2.16.4
> 

Thanks,
