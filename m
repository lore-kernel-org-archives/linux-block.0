Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA197C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8136120673
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfIYXcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:32:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39805 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfIYXcD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 19:32:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so505470pff.6
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 16:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zv+S6pjWtvFhuQbYqez+zraCSpqOxxH8byyf3vdShY8=;
        b=RMpFJgEBWvRPcC49ocCCBJxKMDWxY+r/V8vFHbgVX5Y03uHyyF1mOENQtzLc97iD+G
         RO/PuZjaoLE3SNc1gILJglNgo1hQPm1cSlhC9BwcnGnzV6NqlPmN2hebeToznH7oApTI
         Oj+OXUFt9f+rqZ1wd4n6AuAeYtk3uGcxdfpQiLq/P6Ad11prbSaa+9rOsU4s8efhnHPr
         tkMycmD+ItCghlK9NEbXP/x3fp3EidE1j7QnaZKui1PRwrfOQg0p0whavCXXBSJLi+Ve
         vWhJlelWjSNntao7DVVJNWgu8WYmduBXB1yuhCdxuukn8xYHB4jIiMM/pQEDPevbel1P
         beRg==
X-Gm-Message-State: APjAAAWxkLyBGvbp2PRNfQv39iKZzBaRxCYJ3rdc+ow+YTEtYB4Uopdu
        KMBC/mEpydRPCG7Gjz4IABqdsdwL
X-Google-Smtp-Source: APXvYqxbsIk+2Js9U9t4kDbJcYgCQHgUGJUHXj5TD56WxxKrvkBwwoJq2SCTP6Vh5rfGKRThg73zgg==
X-Received: by 2002:a17:90a:db47:: with SMTP id u7mr284929pjx.40.1569454321508;
        Wed, 25 Sep 2019 16:32:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v4sm104183pff.181.2019.09.25.16.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 16:32:00 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: move lockdep_assert_held() into elevator_exit
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com
References: <20190925222354.26152-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <492f8cb4-2fbe-2c34-4792-7cc56f81a14a@acm.org>
Date:   Wed, 25 Sep 2019 16:31:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925222354.26152-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/25/19 3:23 PM, Ming Lei wrote:
> Commit c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_mq")
> removes q->sysfs_lock from elevator_init_mq(), but forgot to deal with
> lockdep_assert_held() called in blk_mq_sched_free_requests() which is
> run in failure path of elevator_init_mq().
> 
> blk_mq_sched_free_requests() is called in the following 3 functions:
> 
> 	elevator_init_mq()
> 	elevator_exit()
> 	blk_cleanup_queue()
> 
> In blk_cleanup_queue(), blk_mq_sched_free_requests() is followed exactly
> by 'mutex_lock(&q->sysfs_lock)'.
> 
> So moving the lockdep_assert_held() from blk_mq_sched_free_requests()
> into elevator_exit() for fixing the report by syzbot.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
