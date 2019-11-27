Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52589C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D84206E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 16:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK0QfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:35:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44126 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfK0QfL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 11:35:11 -0500
Received: by mail-pj1-f66.google.com with SMTP id w8so10231943pjh.11
        for <linux-block@vger.kernel.org>; Wed, 27 Nov 2019 08:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwIF8e7q2UxApcJmPweDTTJgiZUrq0rc489rErvdpRk=;
        b=R8z6Dqsysxgcd+a83QLUuXrE7CgAURXw39F/WtK5UNF/liOKVoHrr+TKJa5EWB2Gpl
         3cyj3LapjVzayZk4+vlZgptevkq+rHCSQYIeHavGFJS8QCOVYCbB9/NNiotB0O7yoYZ1
         lPJYM84lD/+9A0tOWkl1nUewrmIkCfMLG55qoMr73rDwXRt837uHUnkHo42uzWjMYDN/
         sJsG+zdv4Yz/aTi0gcYZxDXbVzPH/ZPrzbMePNmiqnLxrBA8HrawmBCmr48Kylz9FNN5
         28AHzGHNFrm+kglQoW5+XFfw5IsZ0t7Tj3zfEVWubGDMoudRzQuz0SROXfDsd/Aa2FVC
         MIKg==
X-Gm-Message-State: APjAAAVZ0jXpp+4fw5YIUieUGhwtIOFiMyE1gnZzFf83tHlE5G+Yu3Kv
        KAu6cVFtKqoDTUEPzavkLnBzoBBs
X-Google-Smtp-Source: APXvYqzUH2TdMKrKZZT2BPrv2ccf1L1d3/z4jMAWotrqWoCyFtuKil+S6maJpfSXlFQefm7GfJtfGw==
X-Received: by 2002:a17:902:760b:: with SMTP id k11mr4857935pll.272.1574872510180;
        Wed, 27 Nov 2019 08:35:10 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u9sm17203825pfm.102.2019.11.27.08.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 08:35:09 -0800 (PST)
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
 <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
 <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
 <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
 <20191127000407.GC20652@jaegeuk-macbookpro.roam.corp.google.com>
 <3ca36251-57c4-b62c-c029-77b643ddea77@acm.org>
 <20191127010926.GA34613@jaegeuk-macbookpro.roam.corp.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5e322380-0f3a-59ad-9d0d-2e1a4a9b676e@acm.org>
Date:   Wed, 27 Nov 2019 08:35:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127010926.GA34613@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 5:09 PM, Jaegeuk Kim wrote:
> +	if (drop_request)
> +		blk_set_queue_dying(lo->lo_queue);
>   
>   	/* I/O need to be drained during transfer transition */
>   	blk_mq_freeze_queue(lo->lo_queue);

Since blk_set_queue_dying() calls blk_freeze_queue_start(), I think the 
above code will increase q->mq_freeze_depth by one or by two depending 
on which path is taken. How about changing the above code into the 
following:

	if (drop_request) {
		blk_set_queue_dying(lo->lo_queue);
		blk_mq_freeze_queue_wait(lo->lo_queue);
	} else {
		blk_mq_freeze_queue(lo->lo_queue);
	}

Otherwise this patch looks good to me.

Thanks,

Bart.
