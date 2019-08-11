Return-Path: <SRS0=/IjG=WH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DE2C433FF
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 19:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D41D2085B
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 19:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IgyVz+Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKTnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Aug 2019 15:43:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44895 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKTnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Aug 2019 15:43:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so96478467ljc.11
        for <linux-block@vger.kernel.org>; Sun, 11 Aug 2019 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2JM7oqrhQCTVMvk3eVplIHNbjHRhWyn3FtkoaPBDQIA=;
        b=IgyVz+Gq75priv9lK3TzHFpAv3V2oXw8fKQJjqjm4A6m6e1qS+tK/DusATZpvDdLG/
         XQ+nPOAEJcnAhCtuVzlWJq6OYpwk12TSknR11FbXkGDy9kQD9cTU+FSM8ixXiAuQxkMG
         VOxY1bpJvnpNqogOZS2h7XcPJ76W8hkeWvuIo8VfX2sOOQvBw2AJRhL2dZy1Rx9vyrQS
         d4vtKFziknmn5FqWlMLEnWccsLaFXYWhxWXWcUDI2LUCn4NNSNB2VtwLEU2KkL5cZEYS
         eyWJjo9jEB3VjzpLdzZcUpzGgZN8+OdP9bAtUQC92UtbIAo9QzVtSe9JlE2otvD2XdRf
         p5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JM7oqrhQCTVMvk3eVplIHNbjHRhWyn3FtkoaPBDQIA=;
        b=RR+qZCOaeodji9W7g2Y3cPjAvWDKyyD4+P0doYq0sW4WvT48Ti1XbaaF6T0RFG1U8g
         twmP0ry6ncCAnHeTZjtZStmStVqkmyHplG663OZCq2CMyPOuLl3ORrYWoj/FXGBGDMb1
         kFWPl+HvGFEU30HskbB6t98gs7DeaupcaL6OFVMmPZWRYNlAykKl0xp9g8JBb1efsOCZ
         sGDWj1pISzFtsAZcsUcy6nHA5cXuI4ZH5LhTB+YJWGvQnbqt2mXWn51twp7dfrq3V9o+
         7oXMue6ZVADpzFJ1q3zuVKak+MPC8PE3P6olORZbFwcYzgwKmutCAJwT68wtTjSayULw
         OUjA==
X-Gm-Message-State: APjAAAWxlf6s6jNkaY6s0KHTxr3r9HPk0HLliqO70pvyN8bsbrR0uWGP
        b3IK8hnsNitXhGQtfiUX+wXM4g==
X-Google-Smtp-Source: APXvYqxvXaRtaeT96Y+guDysDnh4OydQ/TMiHiAjsrut7gx2Sz+63XT/Ir68bX6E3XCSVLdfotk6jA==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr17085129ljg.37.1565552628036;
        Sun, 11 Aug 2019 12:43:48 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id f1sm20432278ljk.86.2019.08.11.12.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 12:43:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] lightnvm: introduce pr_fmt for the prefix nvm
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Klaus Birkelund <klaus@birkelund.eu>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20190727182626.27991-1-minwoo.im.dev@gmail.com>
 <20190727182626.27991-2-minwoo.im.dev@gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <712c30cc-4b23-087c-39fa-b919ed0529da@lightnvm.io>
Date:   Sun, 11 Aug 2019 21:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190727182626.27991-2-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/19 8:26 PM, Minwoo Im wrote:
> all the pr_() family can have this prefix by pr_fmt.
> 
> Changes to V2:
>    - Fix typo in title (s/previx/prefix)
> 
> Changes to V1:
>    - Squashed multiple lines to make it short (Chaitanya)
> 
> Cc: Matias Bjørling <mb@lightnvm.io>
> Cc: Javier González <javier@javigon.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Javier González <javier@javigon.com>
> ---
>   drivers/lightnvm/core.c | 48 ++++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index a600934fdd9c..4c7b48f72e80 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -4,6 +4,7 @@
>    * Initial release: Matias Bjorling <m@bjorling.me>
>    */
>   
> +#define pr_fmt(fmt) "nvm: " fmt
>   #include <linux/list.h>
>   #include <linux/types.h>
>   #include <linux/sem.h>
> @@ -74,7 +75,7 @@ static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
>   
>   	for (i = lun_begin; i <= lun_end; i++) {
>   		if (test_and_set_bit(i, dev->lun_map)) {
> -			pr_err("nvm: lun %d already allocated\n", i);
> +			pr_err("lun %d already allocated\n", i);
>   			goto err;
>   		}
>   	}
> @@ -264,7 +265,7 @@ static int nvm_config_check_luns(struct nvm_geo *geo, int lun_begin,
>   				 int lun_end)
>   {
>   	if (lun_begin > lun_end || lun_end >= geo->all_luns) {
> -		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
> +		pr_err("lun out of bound (%u:%u > %u)\n",
>   			lun_begin, lun_end, geo->all_luns - 1);
>   		return -EINVAL;
>   	}
> @@ -297,7 +298,7 @@ static int __nvm_config_extended(struct nvm_dev *dev,
>   	if (e->op == 0xFFFF) {
>   		e->op = NVM_TARGET_DEFAULT_OP;
>   	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
> -		pr_err("nvm: invalid over provisioning value\n");
> +		pr_err("invalid over provisioning value\n");
>   		return -EINVAL;
>   	}
>   
> @@ -334,23 +335,23 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>   		e = create->conf.e;
>   		break;
>   	default:
> -		pr_err("nvm: config type not valid\n");
> +		pr_err("config type not valid\n");
>   		return -EINVAL;
>   	}
>   
>   	tt = nvm_find_target_type(create->tgttype);
>   	if (!tt) {
> -		pr_err("nvm: target type %s not found\n", create->tgttype);
> +		pr_err("target type %s not found\n", create->tgttype);
>   		return -EINVAL;
>   	}
>   
>   	if ((tt->flags & NVM_TGT_F_HOST_L2P) != (dev->geo.dom & NVM_RSP_L2P)) {
> -		pr_err("nvm: device is incompatible with target L2P type.\n");
> +		pr_err("device is incompatible with target L2P type.\n");
>   		return -EINVAL;
>   	}
>   
>   	if (nvm_target_exists(create->tgtname)) {
> -		pr_err("nvm: target name already exists (%s)\n",
> +		pr_err("target name already exists (%s)\n",
>   							create->tgtname);
>   		return -EINVAL;
>   	}
> @@ -367,7 +368,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>   
>   	tgt_dev = nvm_create_tgt_dev(dev, e.lun_begin, e.lun_end, e.op);
>   	if (!tgt_dev) {
> -		pr_err("nvm: could not create target device\n");
> +		pr_err("could not create target device\n");
>   		ret = -ENOMEM;
>   		goto err_t;
>   	}
> @@ -686,7 +687,7 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>   	rqd->nr_ppas = nr_ppas;
>   	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
>   	if (!rqd->ppa_list) {
> -		pr_err("nvm: failed to allocate dma memory\n");
> +		pr_err("failed to allocate dma memory\n");
>   		return -ENOMEM;
>   	}
>   
> @@ -1048,7 +1049,7 @@ int nvm_set_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
>   		return 0;
>   
>   	if (nr_ppas > NVM_MAX_VLBA) {
> -		pr_err("nvm: unable to update all blocks atomically\n");
> +		pr_err("unable to update all blocks atomically\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1111,27 +1112,26 @@ static int nvm_init(struct nvm_dev *dev)
>   	int ret = -EINVAL;
>   
>   	if (dev->ops->identity(dev)) {
> -		pr_err("nvm: device could not be identified\n");
> +		pr_err("device could not be identified\n");
>   		goto err;
>   	}
>   
> -	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
> -				geo->major_ver_id, geo->minor_ver_id,
> -				geo->vmnt);
> +	pr_debug("ver:%u.%u nvm_vendor:%x\n", geo->major_ver_id,
> +			geo->minor_ver_id, geo->vmnt);
>   
>   	ret = nvm_core_init(dev);
>   	if (ret) {
> -		pr_err("nvm: could not initialize core structures.\n");
> +		pr_err("could not initialize core structures.\n");
>   		goto err;
>   	}
>   
> -	pr_info("nvm: registered %s [%u/%u/%u/%u/%u]\n",
> +	pr_info("registered %s [%u/%u/%u/%u/%u]\n",
>   			dev->name, dev->geo.ws_min, dev->geo.ws_opt,
>   			dev->geo.num_chk, dev->geo.all_luns,
>   			dev->geo.num_ch);
>   	return 0;
>   err:
> -	pr_err("nvm: failed to initialize nvm\n");
> +	pr_err("failed to initialize nvm\n");
>   	return ret;
>   }
>   
> @@ -1169,7 +1169,7 @@ int nvm_register(struct nvm_dev *dev)
>   	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
>   						  exp_pool_size);
>   	if (!dev->dma_pool) {
> -		pr_err("nvm: could not create dma pool\n");
> +		pr_err("could not create dma pool\n");
>   		kref_put(&dev->ref, nvm_free);
>   		return -ENOMEM;
>   	}
> @@ -1214,7 +1214,7 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
>   	up_write(&nvm_lock);
>   
>   	if (!dev) {
> -		pr_err("nvm: device not found\n");
> +		pr_err("device not found\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1288,7 +1288,7 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
>   		i++;
>   
>   		if (i > 31) {
> -			pr_err("nvm: max 31 devices can be reported.\n");
> +			pr_err("max 31 devices can be reported.\n");
>   			break;
>   		}
>   	}
> @@ -1315,7 +1315,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
>   
>   	if (create.conf.type == NVM_CONFIG_TYPE_EXTENDED &&
>   	    create.conf.e.rsv != 0) {
> -		pr_err("nvm: reserved config field in use\n");
> +		pr_err("reserved config field in use\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1331,7 +1331,7 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
>   			flags &= ~NVM_TARGET_FACTORY;
>   
>   		if (flags) {
> -			pr_err("nvm: flag not supported\n");
> +			pr_err("flag not supported\n");
>   			return -EINVAL;
>   		}
>   	}
> @@ -1349,7 +1349,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
>   	remove.tgtname[DISK_NAME_LEN - 1] = '\0';
>   
>   	if (remove.flags != 0) {
> -		pr_err("nvm: no flags supported\n");
> +		pr_err("no flags supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1365,7 +1365,7 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
>   		return -EFAULT;
>   
>   	if (init.flags != 0) {
> -		pr_err("nvm: no flags supported\n");
> +		pr_err("no flags supported\n");
>   		return -EINVAL;
>   	}
>   
> 

Thanks Minwoo. Applied.
