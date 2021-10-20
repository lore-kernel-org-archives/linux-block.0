Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D30BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A953610F8
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhJTAaf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJTAaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 20:30:35 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56E1C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 17:28:21 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b188so17610067iof.8
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCBYMmyWBTij8GrA0rmTzTTz81qB2hbsuZq37PhU+Ps=;
        b=8WHvWN4/ehC9bK0jRL/5g7a4EweYQ+d+pYmkPI4eZJSXgPJTJnQrUoRFPak8lhkY0m
         iztNqBcWXQJUvreARYLVWq9CHQXBBsLJk2BeayLgVCRnh9+JgJglYC2HUb09zujR3VL+
         NquDQPIHQ4jtGl+j7mB5O+Otl6aTuxoFOXHoWvmqVpEeekf1KGAIa+0kwbH4BFAFcQS4
         HI2LARMTs6JKC3QX5LmXtq+4LP8qgXe1K/C/MqI9+1bnr8erEay6CkI54CvYzc7dMHpm
         qGNxLfB04J33HjubZr4ECsN3tqyW8nL6VwubEpbhSMR5ghNC8nzS2sF64lZk/B44PhNQ
         jcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCBYMmyWBTij8GrA0rmTzTTz81qB2hbsuZq37PhU+Ps=;
        b=Cfdf68XjJBxXOozddqWQYaFdnEremeJGgaH3p+AS/7FpG/YDs8zmAsfK7vXXLg8t/C
         /ccQSB/kki9en4xeQMt+3MlkevvzrD+64Op2x2hWNaNGiINVbUjlMKNBMDAP5lqiGo38
         BotfsE0cicY68d1K7CEZMpkZbPMzV30D/GO8F7zXz/PJOgsl+/olziuc9tVoZA+2UNU0
         H9LrLE3q/umCi94bB1VOgrC3MHMmYNmliB2aEulmGjvJqiLQ7I82PdDnRjVk6oSdT+dI
         hZWqy9TlaLebQNGH9fTKHp6yUXIWJtkoI1f+2m3ooVlabmsRWhgHnDIpPDzSA0jxeZ7t
         vUhA==
X-Gm-Message-State: AOAM53074cqKEWm/vCcEQoyDRYHU+0WT5R7r1gxSqcF6f92uy2aqFkjc
        agIFuXdpw8ogWOXZJDL+PD1ZLw==
X-Google-Smtp-Source: ABdhPJyD0OAkDNxgyLxgJIgP7vJUdUIKldS2Up83evAkUunJNwIi0L7HMaS/NJxD13OEo7rUHpSy7A==
X-Received: by 2002:a05:6638:3396:: with SMTP id h22mr6462578jav.13.1634689701009;
        Tue, 19 Oct 2021 17:28:21 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l9sm340155ilh.19.2021.10.19.17.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 17:28:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Date:   Tue, 19 Oct 2021 18:28:16 -0600
Message-Id: <163468969358.719012.15754644754744739872.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Oct 2021 16:17:04 +0800, Ming Lei wrote:
> request queue quiescing has been applied in lots of block drivers and
> block core from different/un-related code paths. So far, both quiesce
> and unquiesce changes the queue state unconditionally. This way has
> caused trouble, such as, driver is quiescing queue for its own purpose,
> however block core's queue quiesce may come because of elevator switch,
> updating nr_requests or other queue attributes, then un-expected
> unquiesce may come too early.
> 
> [...]

Applied, thanks!

[1/6] nvme: add APIs for stopping/starting admin queue
      commit: a277654bafb51fb8b4cf23550f15926bb02536f4
[2/6] nvme: apply nvme API to quiesce/unquiesce admin queue
      commit: 6ca1d9027e0d9ce5604a3e28de89456a76138034
[3/6] nvme: prepare for pairing quiescing and unquiescing
      commit: ebc9b95260151d966728cf0063b3b4e465f934d9
[4/6] nvme: paring quiesce/unquiesce
      commit: 9e6a6b1212100148c109675e003369e3e219dbd9
[5/6] nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is reallocated
      commit: 1d35d519d8bf224ccdb43f9a235b8bda2d6d453c
[6/6] blk-mq: support concurrent queue quiesce/unquiesce
      commit: e70feb8b3e6886c525c88943b5f1508d02f5a683

Best regards,
-- 
Jens Axboe


