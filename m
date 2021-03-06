Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B87C433E0
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D664FE9
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhCFSNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Mar 2021 13:13:40 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35406 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhCFSNQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Mar 2021 13:13:16 -0500
Received: by mail-pj1-f50.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so856742pjb.0;
        Sat, 06 Mar 2021 10:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjqFOEuF/irQ0wQ7BMz3JdcfoaUBCUP+26117l0UxWo=;
        b=EdedKj+kyaRs843I9nODkBSga3MwcdRMamAxpSIMSN35msixygy0u4/32hRqTWI7Lq
         6dn3ym71yN6XAiJeaYEx9WklIU/i184IoLROLQa/tKIxhmTRfw78IQxnlL8z+b68uDgC
         f5eRXaSd25zft5OU7UgV/CsG8e6EUBhbF4lpDQqS9ThoWPrqrbXa0GrnM9UfGZs3+QcC
         PIjlKuGYWcrdcdpS0k22lEivLvBCLKuefi9SXnJL1SGnnOO/Joo+pT8Bw1IWkt41B+py
         Zi/wIt65M+d+YFXJ50BqoJA3ywnQvkxVvmScnf7QtdzsP5ZtypVOa88NrGZAN4zJbyxg
         EUlw==
X-Gm-Message-State: AOAM530tvjNVWnyCbtUOoEfzzJqogJyG3k99TMGDO21Nf0eZWaoLQRLh
        Ad0G0K6/k0W6QR/D/cEl+6MmFPFD6OQ=
X-Google-Smtp-Source: ABdhPJyYbm/S/JfNG4pysZBmANmlNFNJ6xx2wpr3076gFmpnSxxnR4XY0YOf2ghPIv9NyxQYSu57IQ==
X-Received: by 2002:a17:90a:20c:: with SMTP id c12mr16287332pjc.224.1615054395496;
        Sat, 06 Mar 2021 10:13:15 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:9183:7829:b654:e538? ([2601:647:4000:d7:9183:7829:b654:e538])
        by smtp.gmail.com with ESMTPSA id q9sm5646141pgs.28.2021.03.06.10.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 10:13:14 -0800 (PST)
Subject: Re: [RFC PATCH v3 1/3] blk-mq: Clean up references to old requests
 when freeing rqs
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-2-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ab2c3bc2-6dac-3c5c-3589-9383c459f478@acm.org>
Date:   Sat, 6 Mar 2021 10:13:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1614957294-188540-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 7:14 AM, John Garry wrote:
> @@ -2296,10 +2296,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  
>  		for (i = 0; i < tags->nr_tags; i++) {
>  			struct request *rq = tags->static_rqs[i];
> +			int j;
>  
>  			if (!rq)
>  				continue;
>  			set->ops->exit_request(set, rq, hctx_idx);
> +			/* clean up any references which occur in @ref_tags */
> +			for (j = 0; ref_tags && j < ref_tags->nr_tags; j++)
> +				cmpxchg(&ref_tags->rqs[j], rq, 0);
>  			tags->static_rqs[i] = NULL;
>  		}
>  	}

What prevents blk_mq_tagset_busy_iter() from reading hctx->tags[...]
before the cmpxcg() call and dereferencing it after blk_mq_free_rqs()
has called __free_pages()?

Thanks,

Bart.
