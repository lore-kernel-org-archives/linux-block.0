Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83FC4361B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44D123139
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 00:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLFACl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgLFACl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Dec 2020 19:02:41 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0CC0613D1
        for <linux-block@vger.kernel.org>; Sat,  5 Dec 2020 16:01:55 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id o9so6445898pfd.10
        for <linux-block@vger.kernel.org>; Sat, 05 Dec 2020 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6ZOlEEYAPn5D22xKU47CZXMmwT6O45WhKH57Gwas7Q=;
        b=0ZxbUo2d5cEJjGu35LPR5RFVMu6yLLcXFKcAawJumEf8iYO4FGG42D8vdIScrKTb4Z
         E3KdAGayeRJMGeysdDzaJ+89ci68hGVl6l+By3UODnl4xn/eJCvm5npnSw2YaU0j9x85
         AFQ1JQD/phf0zMmCb4TAyRU5Oz0OzwK4RsKyAOPeh8F2cIIKz8ofB+LTnkhBpUSZ8iZK
         32YE0e0/m3KKUzSxWDRqIuNGe9up70UICCeTPQCBsaNzQxemk+izNRDohFnWN8GrFHoU
         SdAEEAQSjBUi2mZ87VAGY7hdFaZEwkevntZKGR/6Faz92k38rDn6N8OfByp3k+D9cn0B
         ApSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6ZOlEEYAPn5D22xKU47CZXMmwT6O45WhKH57Gwas7Q=;
        b=hk+LAsPI8vjVG3BYFgYLgTLfw4GNUE899r9n+9SnWdOvChq72+p1LxVP3af0aMAxlH
         5Gx+BQVeTgPqKsMnOLyOM0rhBtyVFRUDpBenhRyIolL79mAx2ZmnEv+c+EZQ3uLRntAx
         mqL4ZD2DGdwZobv1cEchekg3mlFyNZUxYfjBjgnu+EyxC3YBg1fNO4/8DWWxqrs5pj36
         n/GVFXL0b7MYv4VpqWUmY3RmA9LsFstNwf60s5A74JstLgcAD0WELV+KV8ZkbYm672xF
         QHI1us7UEa1uKpcV5NhguF5SfwI7VErk47vF/M6LC+H2KBz79yxowpb8qEwxcHkOFa/j
         IvOQ==
X-Gm-Message-State: AOAM533Z+L+ajHGWdgAN4AW2SzDFtUDfsaIvpje7EpPlQ2zQl+gZ7UHF
        AGB9CRP36KFTJYFYJj8ta2/kVqtYmBxPcg==
X-Google-Smtp-Source: ABdhPJxmhbAbH6cKdUjlfDN9h/wA73T9dbE2auWUmxNgPfGQac/Y5ONV+lE+pTL48MhCgnJydrfd0Q==
X-Received: by 2002:a62:2a81:0:b029:18c:310f:74fe with SMTP id q123-20020a622a810000b029018c310f74femr10124642pfq.50.1607212914836;
        Sat, 05 Dec 2020 16:01:54 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y3sm6363325pjb.18.2020.12.05.16.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 16:01:54 -0800 (PST)
Subject: Re: [PATCH v4 0/9] Rework runtime suspend and SPI domain validation
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20201130024615.29171-1-bvanassche@acm.org>
 <yq1k0u1c6ye.fsf@ca-mkp.ca.oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ad8e593-438f-c366-39e1-73a45045de04@kernel.dk>
Date:   Sat, 5 Dec 2020 17:01:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <yq1k0u1c6ye.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/20 6:51 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
> Any objections to me picking this up?

No, go ahead. Looks good to me, you can add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the series.

-- 
Jens Axboe

