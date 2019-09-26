Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E109C432C2
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 06:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20642222C5
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 06:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Kj6aM/+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbfIZGpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:45:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45496 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfIZGpU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 02:45:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so983225wrm.12
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sqp145p90cnGV3yfvpt32B+iO1OZV3mHAzH1lXP7hY8=;
        b=Kj6aM/+eFNuf6swwzzC9CmcBlR5XL5ToGh+Mzva5MCLi0mzYxhz0Ha8DRAGbxWB+x4
         69wrdJpvFET2+osyFpgTBv9N+E7xqqTqSz/KWzJGpMtDtMMAZK0+pCW5hWeI4JUFT/gL
         t5vRp0AFIAaIK9irMcbLJ61vpepuyVITK6k87rmFJ0nRabD3UutQuOO+UYEygdB/375K
         u8pMfi6MsaIB4b/mchjNoppwvgWr4JrNzOgC2ZR6EVWsvwH8jF0dl3ZST5OqPJLGzSm4
         o2MbM7AMvA1yS/UAI2oUlzanBU463X23uzLB5j2E+40IRwDirKdmRDWHbEwbUI2G/X77
         B5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqp145p90cnGV3yfvpt32B+iO1OZV3mHAzH1lXP7hY8=;
        b=HICEuHliDOMFwDAAPoUa2eOuPkNjPfWFG4RMdbwk1/ioNczPVCfRy82R4wAFS8GY2T
         kTBPXDLvBKtkuzwNoHC35T2YcL6MRaTI8NToSOg2+he3vzCJj/94U9jfXGClqcVMlvBT
         WQ7wLNtff4xT4145forekCGD1Wc3X22P2V5jAzsAl4ipXy7QXOYNPp6U+BDMc/15pZqA
         XPVJB+Mp3QHFYj3KsJxyx1gL5fcSkx/C/VBxhE1dyqi6wB+ia13rUyZzVI3Eb2ioADxn
         tnM3VqYZX14ZxDfV/v70DTngXXSXo/AITfTxDN8gPM65Zgw6n1n3FcI8hz1gngZqCIHD
         d2oA==
X-Gm-Message-State: APjAAAUoslkypSlpBkaBIJfNq1qUA9rdsGpkCpAGUlNht0F0X5NAPpNQ
        qyZ8QQdVw2r1zwbca375+QFRvbJkf+T5SQK7
X-Google-Smtp-Source: APXvYqxWS/XA3P3x670yE4wYmdZ1hWnZfS5+DQ9kOZNIZcjgrXZ0I3xUNTMkjRmTD6BnsQrv4S/kvA==
X-Received: by 2002:a5d:650d:: with SMTP id x13mr1407698wru.37.1569480318976;
        Wed, 25 Sep 2019 23:45:18 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id 79sm2045101wmb.7.2019.09.25.23.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 23:45:18 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: move lockdep_assert_held() into elevator_exit
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com
References: <20190925222354.26152-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16675629-c4b3-0b5e-deb6-a1f3f41c6e98@kernel.dk>
Date:   Thu, 26 Sep 2019 08:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925222354.26152-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/19 12:23 AM, Ming Lei wrote:
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

Applied, thanks Ming.

-- 
Jens Axboe

