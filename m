Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40562C433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiDHVPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiDHVPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 17:15:10 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E9B18A78E;
        Fri,  8 Apr 2022 14:13:05 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 125so8767036pgc.11;
        Fri, 08 Apr 2022 14:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oa6tEjnvDMnnIhr8KVKX02K0vgGshiCUWcFKT9upXTU=;
        b=ep+U2RJGWBS84KS+Mc6cgPFq6ymmT258koTTQutRdzKZepoB4/0jzo4011KOXxzRDD
         k3mMIqjCh0j1tAWIbOTUp+Y5cVWtu9z6h4vfbw4NnDozhTp9z7HlTWRQcWzzVkokQf9B
         ZA2JWTkDSrfhbY4wPxtooH3QJHRP6/SXqERUMGB6sWFp+fd52w6ipCrT2mcRwGnUUHA4
         Wb1eUhGMVM60mLBQTxtFWahv1UkkvREVl7BZJP2Itb3xf1pDX7KaPKaHsXM0bzkQsNeN
         aMmAQtwT3tc3c72gaEvzt/96e2KAxWqKgWdTEGvCKaG3i18pLK2nSWs+XtWkTsI2RfPx
         Y/zA==
X-Gm-Message-State: AOAM530xgN0SzsHQtqMBO3/UBqDiU0Kh3YmpOTn7VUieUz57D39+cTmn
        I7oZR5oYzrsXJ+USiZcqVaY6/xGOYKk=
X-Google-Smtp-Source: ABdhPJwlztK2b8oW+rwuZc7Az8vOPNFvwTT9Ylef+jMoUjV2H9pTHV5fOPbKIxYyqJmcWm9eBTzy9w==
X-Received: by 2002:aa7:8256:0:b0:4e0:78ad:eb81 with SMTP id e22-20020aa78256000000b004e078adeb81mr21487742pfn.30.1649452385282;
        Fri, 08 Apr 2022 14:13:05 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm25712602pfw.144.2022.04.08.14.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 14:13:04 -0700 (PDT)
Message-ID: <6470d923-8fa5-cda1-e519-6f890cdcb00a@acm.org>
Date:   Fri, 8 Apr 2022 14:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads
 based on required tags
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-9-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220408073916.1428590-9-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/22 00:39, Yu Kuai wrote:
> +static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned int nr_tags)
> +{
> +	struct sbq_wait *wait;
> +	struct wait_queue_entry *entry;
> +	unsigned int nr = 1;
> +
> +	spin_lock_irq(&ws->wait.lock);
> +	list_for_each_entry(entry, &ws->wait.head, entry) {
> +		wait = container_of(entry, struct sbq_wait, wait);
> +		if (nr_tags <= wait->nr_tags)
> +			break;
> +
> +		nr++;
> +		nr_tags -= wait->nr_tags;
> +	}
> +	spin_unlock_irq(&ws->wait.lock);
> +
> +	return nr;
> +}
> +
>   static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   {
>   	struct sbq_wait_state *ws;
> @@ -648,7 +668,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   	smp_mb__before_atomic();
>   	atomic_set(&ws->wait_cnt, wake_batch);
>   	sbq_update_preemption(sbq, wake_batch);
> -	wake_up_nr(&ws->wait, wake_batch);
> +	wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
>   
>   	return true;
>   }

An additional comment: my understanding is that __sbq_wake_up() should 
wake up exactly `wake_batch` waiters. The above patch changes that into 
waking up at most `wake_batch` waiters. I think that's wrong.

Bart.
