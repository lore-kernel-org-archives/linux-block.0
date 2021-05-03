Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAADAC433ED
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84B6611BF
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhECOza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 10:55:30 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:38585 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhECOza (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 10:55:30 -0400
Received: by mail-pj1-f51.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so5886090pjj.3;
        Mon, 03 May 2021 07:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ub/LErhdbHR7AtDCQwrZWioyDIzI1kev/KhOCF9bYpo=;
        b=FdFvEgOiRyr4RAGCP0eAtNK9emfbLXw9KeSEfEvMXRKSq3Vhd8ANzGwbmbl9HGL/Zv
         KRfvCgaFNrnycIfH5WM6Qsvv6PLB1lw1W9TVg37FsdTUAZ0u3xaxyJWqZ5NSAOcAYkqp
         rNmILmJykTZ5qCjJhMthH5hz0kEFTky9IS3FdVBbJHPt6IFrYkJcsWThhcpqstyQI+Ip
         HSRFzjfZJAmyaN4AfimTiOkEdA0wLUU1yYW1U46PG3TKr7v+vR6zgX0J4DWkeGGSIb9E
         YQT4y3Nw3G1YTf72IWZuxzioB869Q+I6rjP6EBTV1eoAvQ95prbDtFKa70zzh7G7GxRg
         LZlw==
X-Gm-Message-State: AOAM530fOv4Elk2eQHZpjQ3cvYncnUQXwMT1hmdxVjf0W9APrEdlsWiq
        vV9z3t11fVTr/EZchSAFQms=
X-Google-Smtp-Source: ABdhPJyvf1ENO6i+mxvDHfzZpFnn92lB5ZvZJ/ZWYb8nGFjlNZEvhbytQ5xqWaHwfbnMUJH3XG6l0g==
X-Received: by 2002:a17:90a:7e92:: with SMTP id j18mr10703282pjl.231.1620053676675;
        Mon, 03 May 2021 07:54:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e960:31db:6b4:8ca7? ([2601:647:4000:d7:e960:31db:6b4:8ca7])
        by smtp.gmail.com with ESMTPSA id g35sm5097128pjg.17.2021.05.03.07.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:54:35 -0700 (PDT)
Subject: Re: [PATCH v9] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, axboe@kernel.dk,
        yi.zhang@redhat.com, ming.lei@redhat.com, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot@kernel.org
References: <CGME20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa@epcas1p2.samsung.com>
 <20210503095203.29076-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <72a0b4e7-a374-97fb-ae73-ed24f719da98@acm.org>
Date:   Mon, 3 May 2021 07:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503095203.29076-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/21 2:52 AM, Changheun Lee wrote:
>  struct queue_limits {
> +	unsigned int		bio_max_bytes;
> +
>  	enum blk_bounce		bounce;
>  	unsigned long		seg_boundary_mask;
>  	unsigned long		virt_boundary_mask;

On April 23 Damien Le Moal posted the following comment about the
bio_max_bytes member: "Please move this below in the structure together
with all other fields that are unsigned int too." Making that change
sounds like a good idea to me.

Thanks,

Bart.


