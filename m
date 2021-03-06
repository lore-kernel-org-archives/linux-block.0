Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD5C433E0
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 04:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FCE64FBD
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 04:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCFEcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 23:32:39 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:33788 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCFEc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 23:32:27 -0500
Received: by mail-pj1-f41.google.com with SMTP id j14-20020a17090a588eb02900cefe2daa2cso151487pji.0;
        Fri, 05 Mar 2021 20:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0FLdb7WRYyetMAGeVkmVyaxyT94n1/im6YgyjkPRT3E=;
        b=CGCJrIPfnZ7Mgz/1f6l55lxDaAjW9oRsxkl9RmG4YzHZqO5MzkjqVmWevj5B3eKirb
         X9we6corwSdoP2XxUcYWO1kQX3hBFjvxXjRJnCO3IJU49qcTENl9R3RVkZ2PjAR3+fuI
         DAFRTb303F02N7+uCq6y0RmxdoHFzoVaZEcWxMuwQbfRPYATXNzYmBZk428BTkt4OsMS
         G6tDxzElikvAhrJO4qUYL2/FndpxSUpxyOkyaBGial9nWpqd73hBtMNPEC56Uk33sizM
         rUQUQ6PD6hLUocHV9YxVGxnBa6X5TBq6IGf9s0p3LK9zUOu1xKIYoj6VnSWBx2CwWk90
         gvjA==
X-Gm-Message-State: AOAM533fyeUmVKntMeeY/xlZIRBvs9TyoFk7YcYyM5Ctxj8MyzlY+yvD
        gqIelo7BLo2Pud+ExThDJeTafsagqKk=
X-Google-Smtp-Source: ABdhPJywIhgawDTlWs6vOPCOvxkKzRxO0NIFJq96trJk5+cU+UtxNV74qZdVpuhUal9m/JelfZChkg==
X-Received: by 2002:a17:90a:4381:: with SMTP id r1mr14325348pjg.20.1615005146889;
        Fri, 05 Mar 2021 20:32:26 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:508e:d398:f4d5:3d44? ([2601:647:4000:d7:508e:d398:f4d5:3d44])
        by smtp.gmail.com with ESMTPSA id z3sm3233394pff.40.2021.03.05.20.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 20:32:26 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <52618092-07ca-ecb5-320f-957af26ab146@acm.org>
Date:   Fri, 5 Mar 2021 20:32:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614957294-188540-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 7:14 AM, John Garry wrote:
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e..1a948bfd91e4 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -201,10 +201,29 @@ void elv_unregister_queue(struct request_queue *q);
>  static inline void elevator_exit(struct request_queue *q,
>  		struct elevator_queue *e)
>  {
> +	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *tmp;
> +
>  	lockdep_assert_held(&q->sysfs_lock);
>  
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
> +		if (tmp == q)
> +			continue;
> +		blk_mq_freeze_queue(tmp);
> +		blk_mq_quiesce_queue(tmp);
> +	}
> +
>  	blk_mq_sched_free_requests(q);
>  	__elevator_exit(q, e);
> +
> +	list_for_each_entry(tmp, &set->tag_list, tag_set_list) {
> +		if (tmp == q)
> +			continue;
> +		blk_mq_unquiesce_queue(tmp);
> +		blk_mq_unfreeze_queue(tmp);
> +	}
> +	mutex_unlock(&set->tag_list_lock);
>  }

This patch introduces nesting of tag_list_lock inside sysfs_lock. The
latter is per request queue while the former can be shared across
multiple request queues. Has it been analyzed whether this is safe?

Thanks,

Bart.
