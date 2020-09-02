Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B0C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5378E208C7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vJ/l8822"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIBRxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBRxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 13:53:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C5C061244
        for <linux-block@vger.kernel.org>; Wed,  2 Sep 2020 10:53:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g128so6689675iof.11
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91UZKG1J4qBk22lSZKa0s+5Z4bowSWL4lH0j9j5Vv9o=;
        b=vJ/l8822l4Kvh3z2gq2h0+JaVuQThpa0qfjxUlK7iKrmd3WWhp9mdZ53WOaISOMebH
         LU3Nw3V0dI1VVToTn5QkKcIPthMWRYsh4XAdKp2Hm/h/LiGFGT+Otn9gwMFx3FnVDVEw
         P3bhp9+knBKZA6nZ7OFmpIIeYO48b6IS0Iam1rk4RuULN48hF1yXf6DTQ5s1QHJNw3xT
         iWdlKfyd1tTd3yxxY1FIHCWPfVNacjTIe46Df38IAj+hf9nGaA/TEyGSl0KGcGLxigsJ
         zyj8vYt3loF8A3dRe42c1n0w8Bji4UJpbhg9aLJd+vJO8saZyrBq+fT4YujERh5HdSPw
         zWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91UZKG1J4qBk22lSZKa0s+5Z4bowSWL4lH0j9j5Vv9o=;
        b=dPnQysnhOtqSsjdNjc8YBlhsxAnAmKxOBZLHI2Yyxhu5B+TSpr2RfbyWR91PIo2pL3
         mI9udfUCoovUb1SLRwvJvr5XzHVsKB/SGGL/f05IZdn3lZBPwB6XTDyRiAejmYCUyDIZ
         LDv/GnZrk/w38Fg4+gCbxsrim5R37jcrvvsvm9eO7UnEV6p0zKuib5vPblL6NQC6ny8s
         M7l02/YnJ9BKnHGIP9o6sftoukwVpixMMb+g309+O+hcIoB+yefi+9wpky4VzCSQPUVH
         ZkZMuVBZ+cVD6Q/MzJMoVyrVciIE+JzfTLtbPz6JnM1KhW/pESXfF8cpHYUDe9FeULqI
         YV8w==
X-Gm-Message-State: AOAM531EOVeC09lsW3PZGBMJlR/6Daic6dExzV0JN/A7Xgf9wHqeLBxA
        R4k6rIpe1mpvfJR4CL8EWlQXgw==
X-Google-Smtp-Source: ABdhPJyhTpy+8bz+fTPwfhakHl++2PspwoVL4SNWicN+Jya6KmiEGx/VesjWVR8RbDA+HpWq9CFCpw==
X-Received: by 2002:a6b:d203:: with SMTP id q3mr4504852iob.20.1599069181651;
        Wed, 02 Sep 2020 10:53:01 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g6sm127577iop.24.2020.09.02.10.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:53:01 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200902031144.GC317674@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
Date:   Wed, 2 Sep 2020 11:52:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902031144.GC317674@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 9:11 PM, Ming Lei wrote:
> On Tue, Aug 25, 2020 at 10:17:32PM +0800, Ming Lei wrote:
>> Hi Jens,
>>
>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>> and prepares for replacing srcu with percpu_ref.
>>
>> The 2nd patch replaces srcu with percpu_ref.
>>
>> V2:
>> 	- add .mq_quiesce_lock
>> 	- add comment on patch 2 wrt. handling hctx_lock() failure
>> 	- trivial patch style change
>>
>>
>> Ming Lei (2):
>>   blk-mq: serialize queue quiesce and unquiesce by mutex
>>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
>>
>>  block/blk-core.c       |   2 +
>>  block/blk-mq-sysfs.c   |   2 -
>>  block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
>>  block/blk-sysfs.c      |   6 +-
>>  include/linux/blk-mq.h |   7 ---
>>  include/linux/blkdev.h |   6 ++
>>  6 files changed, 82 insertions(+), 66 deletions(-)
>>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Sagi Grimberg <sagi@grimberg.me>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
>> Cc: Chao Leng <lengchao@huawei.com>
>> Cc: Christoph Hellwig <hch@lst.de>
> 
> Hello Guys,
> 
> Is there any objections on the two patches? If not, I'd suggest to move> on.

Seems like the nested case is one that should either be handled, or at
least detected.

-- 
Jens Axboe

