Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E94C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F5620874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JJ4Rimyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeLQM4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:56:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36675 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeLQM4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:56:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so6099910plo.3
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 04:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5LjDS91RpSM1MlkSLHTNJwJafKO4p59lXE09FUxh6vQ=;
        b=JJ4Rimyjf/sOyR18yTpPwCGv7ENoW5O84svGiInhmRVi2tyf6uQQFP+t1n5ETODzAX
         1R5Rknh0It695L6cuUAyzCJiXJ/o+NoF4s3sMEbCHE21BBxssDZfcy1XpQRLIMOEj8JK
         iAbTI5XfgGXpvhSSgrhKzebS94pREnzeFfe0MFdknEOwhuLGToBP3J66PL7SYh9NSw4H
         gzWQcUKnpXkVzEkEpMDJUstws5j89mxsjY4+tx0YS6k32E5m9TovXg/Y3/BIXRPrFA6O
         xxc2x0ZduG0fxTS8NmXGVbUCMl9lQNd2xfgf+guhMfAcUOARLZ0h5tMC2jNusFrFCQNA
         PRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5LjDS91RpSM1MlkSLHTNJwJafKO4p59lXE09FUxh6vQ=;
        b=fVly0y12TfCbYbshP7J7AC7ZzZMiSPeuMkLWHU9AwP6uXFQSbVJoCiKCGXqf3fvDWM
         XjEHhV4xJrqBTHVwfm9jbvOPpQMGhD/8ewRKGeK7qhmIz3j5/q9pWsHAEc8gywwy7kYX
         2y6nKSHOzWn4fKeRAZ/Bc/RAeLYMlGsTgC/e/zXcDWFeNcxGBMpar8V6pqn8lY9Dj9lO
         csWQ2iXUP7xxnVRBj/GX2GvI8L+clU08Ym0ENAFwqXGfOvIkfikcVfnjwvYI5OG9pWo3
         solFUGocNuAchB+Zq4SNzdlTAxbT84gAZG/Dh4aEgsXZTkXG6tdvxgjQvzBIDWXYbQMi
         JwWQ==
X-Gm-Message-State: AA+aEWbWlvwvYQAL1ewrMIArvkxJTgSR2EUit2kfRLyNQf9wl184Kf4h
        CrZP+8Lk5DKSs2jPc//CyoNQew==
X-Google-Smtp-Source: AFSGD/WHRmEQdy8+nl/EtaciL45pmZYa/IHF48jI74WqUNcec7bXwxLFULjkjY7mDx7qk/8Oa+W4zA==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr12607175plb.115.1545051365496;
        Mon, 17 Dec 2018 04:56:05 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n70sm18134565pfi.185.2018.12.17.04.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:56:04 -0800 (PST)
Subject: Re: [PATCH V3 0/4] blk-mq: queue mapping fix & improvement
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20181217120844.8131-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ecf2d25-74e5-111b-4883-1e74e2676afd@kernel.dk>
Date:   Mon, 17 Dec 2018 05:56:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217120844.8131-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 5:08 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch fixes allocation for queue mapping table.
> 
> The 2nd patch exports hctx->type in debugfs, so that we can write
> debugfs based test for verifying if queue mapping is valid.
> 
> The 3rd patch fixes dispatch from sw queue when there is either
> write queue or poll queue.

Applied 1-2, please respin 3/3 with the mentioned change.

-- 
Jens Axboe

