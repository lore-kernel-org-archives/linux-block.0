Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A658C2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7BC61159
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhFQPZv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQPZu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 11:25:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E6C061574;
        Thu, 17 Jun 2021 08:23:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y15so5283035pfl.4;
        Thu, 17 Jun 2021 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BGbeP7ZnDkY2DJidMpRViqieliUtB17GFMkW1zVFjRU=;
        b=Oa3ubTr0Q6/AN8zuP9Ab/2Kl+m1AAVUY/MDQf2YhYJMxoR2QNRnHh/uPRS4KEd8FwY
         7lYpYXWtliofo4M15KX6kB/FCkMTAvkAF5RyYzkFKpXKvFcmdbiszr2IFGVTZVh653X0
         JlXGmk/4/4qPnXOO/m3zhD3PlhS2nlPXPnbBDrYB95ZdveGJ8MePV/9NK38Q1rNXPizi
         QKad2ZO6qF2xPjJ6PWs5ki8uHBBzjnc1piJNAtBZfryD4TVocKpZsNdt08Prz2cW6xPh
         dwpLwl/ECtvKrpW71zqf6I/ocCQRj1JzvqPxhMJBmEKXb5ymNHU6ksoRABqmBJzbHy7l
         YMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGbeP7ZnDkY2DJidMpRViqieliUtB17GFMkW1zVFjRU=;
        b=PIWp0ZoCiSnAjkgrrXWJZ43NxUBoRi9I5seWERZ2liYi6+BefaXzV91K2vGVF/PJ4d
         gyAsgrrCv38bbwNO1cVkegwXFPwXfTmhO/zHF6OaFcrZRh67M3EGwhkwT+RZpOAWK8Nf
         8ziG223Kk4pOSiukybsE4TX2djJjKEb1HcUE7/yDGaJiTc5CHGCUK9QrVmbMIARFpf+I
         ounQutBb2Jgljh/0ao13CuaLvifUJCW2L5E2bBjzoLrGScGngC7EKlQnu1ke+WxctvrW
         /EFctzbQe6MNrytUU6YfVeaWA17dK2ezF3AKD+KwgeCq0VcWUySgeAzzYqGE0IAZU1GQ
         /aJg==
X-Gm-Message-State: AOAM530fF75sPLe7mTLAYADIrWdDEVZRH0h+lxeOUTXVC52fA4pLsxoK
        1RfDVsGnHG3t0yTWvzh8EWA=
X-Google-Smtp-Source: ABdhPJx/5easlY7XHWhEyK556EoCIVPAIfLRotdyXcjQ6+Cu9D7hlZkBnahXppkI8S5hMejMrFyBwQ==
X-Received: by 2002:aa7:905a:0:b029:2f6:d759:6c2d with SMTP id n26-20020aa7905a0000b02902f6d7596c2dmr249155pfo.33.1623943421659;
        Thu, 17 Jun 2021 08:23:41 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id v6sm6434212pgk.33.2021.06.17.08.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 08:23:41 -0700 (PDT)
Subject: Re: [PATCH] block: break circular locks in blk_request_module
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
References: <20210617092016.522985-1-desmondcheongzx@gmail.com>
 <YMs3O/cg4V7ywlVq@infradead.org>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <ce1567cf-bc94-790c-cfc0-e4e429e1a86a@gmail.com>
Date:   Thu, 17 Jun 2021 23:23:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMs3O/cg4V7ywlVq@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17/6/21 7:51 pm, Christoph Hellwig wrote:
> On Thu, Jun 17, 2021 at 05:20:16PM +0800, Desmond Cheong Zhi Xi wrote:
>>   	mutex_lock(&major_names_lock);
>>   	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
>>   		if ((*n)->major == major && (*n)->probe) {
>> -			(*n)->probe(devt);
>> +			probe = (*n)->probe;
>>   			mutex_unlock(&major_names_lock);
>> +			probe(devt);
> 
> And now you can all probe after it has been freed and/or the module has
> been unloaded. The obviously correct fix is to only hold mtd_table_mutex
> for the actually required critical section:
> 

Thank you for the correction, Christoph. I hadn't thought of the 
scenario where the module is unloaded. I'll be more conscientious in the 
future.

> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index fb8e12d590a1..065d94f9b1fb 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -529,13 +529,11 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>   		register_mtd_user(&blktrans_notifier);
>   
>   
> -	mutex_lock(&mtd_table_mutex);
>   
>   	ret = register_blkdev(tr->major, tr->name);
>   	if (ret < 0) {
>   		printk(KERN_WARNING "Unable to register %s block device on major %d: %d\n",
>   		       tr->name, tr->major, ret);
> -		mutex_unlock(&mtd_table_mutex);
>   		return ret;
>   	}
>   
> @@ -545,12 +543,12 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>   	tr->blkshift = ffs(tr->blksize) - 1;
>   
>   	INIT_LIST_HEAD(&tr->devs);
> -	list_add(&tr->list, &blktrans_majors);
>   
> +	mutex_lock(&mtd_table_mutex);
> +	list_add(&tr->list, &blktrans_majors);
>   	mtd_for_each_device(mtd)
>   		if (mtd->type != MTD_ABSENT)
>   			tr->add_mtd(tr, mtd);
> -
>   	mutex_unlock(&mtd_table_mutex);
>   	return 0;
>   }
> 

This fix passes the Syzkaller repro test on my local machine and on 
Syzbot. I can prepare a v2 patch for this. May I include you with the 
Co-developed-by: and Signed-off-by: tags? If another tag would be more 
appropriate, or if you want to submit the patch yourself, please let me 
know.

Best wishes,
Desmond
