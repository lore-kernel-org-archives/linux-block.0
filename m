Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF3C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599C020679
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QfclChbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHLOOc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:14:32 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45433 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfHLOOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 10:14:32 -0400
Received: by mail-pg1-f177.google.com with SMTP id o13so49538145pgp.12
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2019 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k8hrsgF7WvvM3EE1A3rx8pROFmuTtd7HpPZGWv5+Fpc=;
        b=QfclChbYP0qDEio5VrOdsHiled5xpDKUSs0z9AT2U7kPrGq3bAxCgPUAQvGj3QN6B8
         aK6kvC+vJSuTAmNPMMsDwSH94P/s6pFiIGiVylC/GCjA6gcFkeoRWfHYTQnlu8+R+Lku
         WFANALGTm8Mm/TtTkAGYJHd2n03Q8oV1KSRMS16gyOol8Vg6S0f5IeoKFb9T0D+EugZ4
         9sa4iJw9cYr8Z66EnwHV6yTAbBzHCzG5KbXvyva21KKesKOVLIXKobv2gH09iflF91j1
         byuGfIST82luD5+303VE8h8a+6UKrzqYiP4Sxt2StZeyKE1nb3+6gq9MhWEoZoqzzv0m
         /ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k8hrsgF7WvvM3EE1A3rx8pROFmuTtd7HpPZGWv5+Fpc=;
        b=gAjP5B6qF7fdqDv7vTNLJo2wMR5g6AITLytUli/sR7QJypavW0XgRfGmyNLuGdaRMS
         ItZPVLeeYdgVM9ZR2RanMij8oVzvDnM1NCiWFujbrKVmDybvw+JGhAQzSczS8s/GGLrr
         Tb2lm0bqwxaBV4XWt4bJbFVwMYKdSI1BxwMPlbTTvT93VCZB0jbTz9Ld78dFfJrjNNKU
         X0IZjuPgWN5XvvLx8nxGSx9kfynnzG0gtlXjjg6Taklkk8SnK0SugCmOsLfVzGTaVY46
         kS2qdjYWQa0GvUTwjywdEYOSy3CVCBqga0wyS0PRPgFj412Ge10FS8VNTEKr5NjGagCY
         vCqA==
X-Gm-Message-State: APjAAAV/Ye4V5RK2tIYir9UxhwSetffVjJiwkvEOuNat0ab8SZgDaVL3
        QUdJiRRCySrtPswS7h795rCJ4A==
X-Google-Smtp-Source: APXvYqytKdinFVQqk9wwWZowJTA5a+GujVkRC8GttGli/yOowDtqD8GHZu8J8hYXMD+eGYPiRqTUpg==
X-Received: by 2002:a62:1901:: with SMTP id 1mr18039803pfz.172.1565619271901;
        Mon, 12 Aug 2019 07:14:31 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g3sm3817861pfm.179.2019.08.12.07.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:14:30 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: move cancel of requeue_work to the front of
 blk_exit_queue
To:     zhengbin <zhengbin13@huawei.com>, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com
References: <1565613415-24807-1-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ba4e1fd-99e6-ac8f-9c48-fc51b9d1e234@kernel.dk>
Date:   Mon, 12 Aug 2019 08:14:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565613415-24807-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/19 5:36 AM, zhengbin wrote:
> blk_exit_queue will free elevator_data, while blk_mq_requeue_work
> will access it. Move cancel of requeue_work to the front of
> blk_exit_queue to avoid use-after-free.
> 
> blk_exit_queue                blk_mq_requeue_work
>    __elevator_exit               blk_mq_run_hw_queues
>      blk_mq_exit_sched             blk_mq_run_hw_queue
>        dd_exit_queue                 blk_mq_hctx_has_pending
>          kfree(elevator_data)          blk_mq_sched_has_work
>                                          dd_has_work

Applied, thanks.

-- 
Jens Axboe

