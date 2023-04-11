Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC46C77B70
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDKRrW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDKRrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:47:21 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849207689
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:46:58 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id la3so8433085plb.11
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235218; x=1683827218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiItn63537QUWZ/MaNaDoa1PgQEeZ3A+ttY2ChWcM2U=;
        b=x7x/blBtsnvUNpO89bmvZFBnEkuf50vV8UtSQRdcHG5z+VHkW411X+Uk3pSLSZsH/f
         WYC06vE8jaCdyR71Mx2PsAvFzFJKYumtZXrNgsKSHAMTGqO3w/PoUHv7KLG4o4VV2BRt
         A5EEhxUMs29YdZEKB2FzaQxQfxoXdbj789cnvz/qCAvbptLOZ0nIFaLuuwbGhgm4aDSy
         dUe9fbWI/3zG+SmsGopDlVHkPY2Iti2pGe2xALw/BpBvIuNd0vIWRaiB4O3EPh3QlE1g
         t48WMbd4DaLZiZjdyrVeIKJ0nPCMUiTy4Bwq3BV268xwh4BKhhVDDJeBZQIqeSvFNaTe
         AE+w==
X-Gm-Message-State: AAQBX9eqndlPo47FSZxpbq2FNTfEFLd5Cb9nFoSRLYtw52AuYlry2X36
        CrHSIzwz4oQtMmWlVRzFb5s=
X-Google-Smtp-Source: AKy350ZyzMifROha9i3JYx1g7W/E0qyxdA5hJqn68jTKuK/d9+y16BkQ0NBGTlNwUrbysL1itH8sSQ==
X-Received: by 2002:a17:90b:3ec2:b0:246:82f9:9b0a with SMTP id rm2-20020a17090b3ec200b0024682f99b0amr5063829pjb.3.1681235217869;
        Tue, 11 Apr 2023 10:46:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id jh3-20020a170903328300b001963a178dfcsm8074892plb.244.2023.04.11.10.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:46:57 -0700 (PDT)
Message-ID: <c46e5d7f-4b22-1c38-7835-9013e39ece89@acm.org>
Date:   Tue, 11 Apr 2023 10:46:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/16] blk-mq: move blk_mq_sched_insert_request to
 blk-mq.c
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> blk_mq_sched_insert_request is the main request insert helper and not
> directly I/O scheduler related.  Move blk_mq_sched_insert_request to
> blk-mq.c, rename it to blk_mq_insert_request and mark it static.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
