Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D5C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 20:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC086139A
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 20:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhFIUL1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:11:27 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:33692 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIULY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 16:11:24 -0400
Received: by mail-pl1-f180.google.com with SMTP id c13so13293547plz.0
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 13:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWNyH3PrTLHPhINXosCqEXI/kii6QlAfoRcWZR+MShs=;
        b=mipOWtt9pNTsQCFIoHmoFwRav/qZ7XyTcEscrORD5h6WAw/B+nJIJy9z+5a+3pK77P
         XSQyoZRPst/ybaa4O1wZB2pF2GqJV166Mrgi0FuLHEBHmP2vbuF/aZex+b8nv/r6IJme
         5ggAKk0OD7CGsL0RDWRwqWZF3oL5xyhEv3/1i9obg3Mgx79UAWZCH3yqS8scS6dkUB0z
         9tCWRlmPDk6Y+eiwGpL82KY93pz9HUSAJmNYNiEcRYfT4IAmv5vWnUzxyONkfT1xC8gI
         WfCcRs5FiIMuzYQPR4/EvHQhzcdQAp3VXSgQtRnganpdARxONJG76SIHBn8BWUctB5Ok
         PufQ==
X-Gm-Message-State: AOAM530BlL0/GaJTIbnLECNFXq+e+ood6I8FPDRhTisP+TkyFAFkSREM
        EgF2X30RmcZc3kFgjn9vxu0=
X-Google-Smtp-Source: ABdhPJy6pfY45GbgWhThk8c+MSjDZyDA9bOHeDfqkGWUDDKfK/myovBFj4TQOolzQaKl2/3EHD83pA==
X-Received: by 2002:a17:90b:8d:: with SMTP id bb13mr1296673pjb.98.1623269355299;
        Wed, 09 Jun 2021 13:09:15 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 141sm481098pgf.92.2021.06.09.13.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:09:14 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] block: mark queue init done at the end of
 blk_register_queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20210609015822.103433-1-ming.lei@redhat.com>
 <20210609015822.103433-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f8180796-b24f-e250-b253-fdd17ef39335@acm.org>
Date:   Wed, 9 Jun 2021 13:09:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609015822.103433-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 6:58 PM, Ming Lei wrote:
> Mark queue init done when everything is done well in blk_register_queue(),
> so that wbt_enable_default() can be run quickly without any RCU period
> involved since adding rq qos requires to freeze queue.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
