Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE4C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DAA61075
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhHJCBD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhHJCBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 22:01:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C680C0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 19:00:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt11so7680504pjb.2
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jyg3h9YD/l7v++rwDIcj7NKt8ibdDEOy85xZxBpzgVo=;
        b=dmA6lFK4CAg+wvPQTU0zUVA7r2m/6OjkkHyj7hFfeyTgwd6zpvVJs+/jLkEkbWnhUk
         oSlsgnAq4d4IIm+YURwiFJQCUh5/lBduDfdqr/00zqX5+iReaDqNjhkIMAa2FJdRh96+
         HFIvsv1iswL3uSaVs/pAu/yA6Dp2j6Zkp07D0rqg61kaueOj8vgVMA4YIjGJtnHooyEo
         S+grwwObkj3hSpovEEWeW0uU7mOiXeW7E7XmSo5QpGmuk/KFnGsGhCQxgp3Ozn9qD3ay
         FcpHFw7G0vn2VYA5LnFPDsp5ls4Kva+Qw99DcbTeqmTatpey1PbWp/DsnuoX/KmoYnrB
         IhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jyg3h9YD/l7v++rwDIcj7NKt8ibdDEOy85xZxBpzgVo=;
        b=SyRbd4A1Y2qOYg5W9jpM5mys3un3gdMIS1qaBht5e6lFK0pn6VVcfzDMZ1RPr2P1Vm
         SnsKdUcHPH0ovf/Jmi0AvhmMiUWuO8k/ykXDgVGbs4lsboHxduHhgkDzTlNlSEgmHQiG
         PQ3w/29yfXwdal0WZf9zRw+iIh4wQbNvXnQO8BtCz5UW36kjfbEwORG5NS56dAxmBv7s
         8octCcT4HVX1Q1QA7w8ZEELLi2kENl6Ada7UrnCMuvSOoTDbcBi2aWHJa3lCVrbtV3uQ
         UuO8KPmqHBwj/HAFsRMBvfNUoACwZMRHUNFpVfYwxt4YbRPhJt1SuE4NdP/28XCVI2ES
         hsKQ==
X-Gm-Message-State: AOAM532Ua/L+VSqT/M0bbPiwqZOzTFaWB1Ua9JIsnCKTyNtd5JK65O8i
        LgJeAexCpJMtkZrfPxkSaujN1g==
X-Google-Smtp-Source: ABdhPJzEGF1e8a24PbEwPGl0hpmUD+HP9Gw6rGODPcCRTjWUl66UmylWvDoEZtSlgGUDeLyffEXEdw==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr2193848pjr.83.1628560841876;
        Mon, 09 Aug 2021 19:00:41 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id r4sm34361pfc.167.2021.08.09.19.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 19:00:40 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <20210803070608.1766400-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f048cec-69b4-cb87-5e41-68714a36d10f@kernel.dk>
Date:   Mon, 9 Aug 2021 20:00:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210803070608.1766400-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 1:06 AM, Ming Lei wrote:
> blkcg->lock depends on q->queue_lock which may depend on another driver
> lock required in irq context, one example is dm-thin:
> 
> 	Chain exists of:
> 	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock
> 
> 	 Possible interrupt unsafe locking scenario:
> 
> 	       CPU0                    CPU1
> 	       ----                    ----
> 	  lock(&blkcg->lock);
> 	                               local_irq_disable();
> 	                               lock(&pool->lock#3);
> 	                               lock(&q->queue_lock);
> 	  <Interrupt>
> 	    lock(&pool->lock#3);
> 
> Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().

Applied, thanks.

-- 
Jens Axboe

