Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB63C742AE
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 09:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E9920645
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 09:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z07apoYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGLJDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:03:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33255 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 05:03:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so4462109plo.0;
        Fri, 12 Jul 2019 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i93erGQBEdGUvhjnj900r6ImbBuHJewNb/EPkRjgFew=;
        b=Z07apoYj4RIC+0LNfxgd6x0FLOITlM4REZEHTQ3WMwMzpqrAF53njy07hpNn3Ijm58
         d/mzdc+qqSsp9G+WoR9XqJOptmNHHRUkvzm6S2YNE9k9Ulm4UvvmK+/kgXkEF2xRDawO
         p1S+JYa1HPNS00sY0DVPDBDep9dCVfm1pUlJz1BJNlLBp7rvK4pcQpc899o4irEYeILz
         EAb6qcJh23GPGjsxVmsBzQyQMui+qxfmyitaEYdN/adGMTNVFJaNVCtZaPAJi7AzQf5L
         S9nx6WNwKJcKrYvWU3BtOnQFRsdaK729Q42R9OAhqhRQAet/AWeSC4CGAnaUjokNS4KY
         i6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i93erGQBEdGUvhjnj900r6ImbBuHJewNb/EPkRjgFew=;
        b=GOKiam7eIas9O1o2Lz3LuNCsK3byA1GVLBDf62jn2uQfghPh+hn9z2kTxXXlsrmjws
         fZRZTpiF3UjpW2piSxkxEkz8AvA+DGpYM4GQadMGLedA8AHtrnJGbefjT6vEJz3sU3Fe
         mTIeTRrdoXPRwqWB4re7zXZRA0T1ZyYGSr2QqdpFn95jT0KIGqEAnQIjhRSohWr8lGkM
         +u/LBp2ZWtWTlWnT0xYneZQfKobWXgEcJB9+2Esg8TpyklxZTslnkl3N6HCS2sobOQvw
         yGqCGtDzLbmT1g2lWHe/JXwl+dHIYoT4tf27vmR1Pjb5Z/htBLZQSsWF8GbBRfJC7aab
         Y9og==
X-Gm-Message-State: APjAAAUD6jsSeq+h215ekbLrvjU/XsQI9d78fWSZwORd6PeEADSKkCak
        pT+RqbDe+tmTsbWfTSQumu8=
X-Google-Smtp-Source: APXvYqxdW9/IthRQ7rsmpCwbf0zLG/Lgcp8qZuEfY0tONfvOF6G0RNnXVCtqwWbLt7x1yyzKwe3SDA==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr10061115plt.102.1562922234461;
        Fri, 12 Jul 2019 02:03:54 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y8sm7341206pfn.52.2019.07.12.02.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 02:03:53 -0700 (PDT)
Date:   Fri, 12 Jul 2019 18:03:50 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [RFC PATCH 3/7] blk-mq: stop to handle IO before hctx's all CPUs
 become offline
Message-ID: <20190712090350.GB31048@minwoo-desktop>
References: <20190712024726.1227-1-ming.lei@redhat.com>
 <20190712024726.1227-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190712024726.1227-4-ming.lei@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-12 10:47:22, Ming Lei wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e5ef40c603ca..028c5d78e409 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2205,6 +2205,64 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
>  
> +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> +				     bool reserved)
> +{
> +	unsigned *count = data;
> +
> +	if ((blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> +		(*count)++;
> +
> +	return true;
> +}
> +
> +unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
> +{
> +	unsigned count = 0;
> +
> +	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &count);
> +
> +	return count;
> +}

Ming,

Maybe it can be static?

> +
> +static void blk_mq_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	while (1) {
> +		if (!blk_mq_tags_inflight_rqs(hctx->tags))
> +			break;
> +		msleep(5);
> +	}
> +}
