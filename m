Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056FCC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 13:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiFQN1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFQN1y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 09:27:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8AC37
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:27:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u2so4194949pfc.2
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lxDlYPZcVzjgd9PAojpNUDFDRQjvezx+RpyMap7mtIA=;
        b=fSlaza0o3/B8zPGqiAZJg0Q4rm2s3IDz/Znk5pG6+lbYAV77PU2F0Snl7+tmL94uCJ
         fV22XIiPMjWaa/sqadYWtyC/sF3o+3QSSMuTP2WXj2RJMq+CupEgbiWya8A1hRAI1QL7
         Ft4mKpwcExCtY8BcfArTnNedhUa6NBjwgMYkgee7RIyjmqL5Hu1OXrSMyaKpsb/o2f4/
         KleHR3HdeKtQPHG44Tt+cbmvO0RncVCH6AEyAEg7EF2stMNlBuRmKjMS1+9eEPmcLGoT
         xPQA5FL1NK+gpCUMOKo7gRZGpwjVLLBJyt4B/XBin5+wNt623u8cBO/lLjkF1TEmj0Pd
         OYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lxDlYPZcVzjgd9PAojpNUDFDRQjvezx+RpyMap7mtIA=;
        b=rBaOzK+HAhiT6Kbhk04OXjnNuDGUiaBJ+vSnqEBy6lm5nkISW3gtwu7JxNIlM0EEvn
         RdSIi/6MZnuj3ALQ/7AxbRq8tQZkJrtxQ7RV6DZ9tmz/LBRSFCb8vS22XVxAbZGaguxp
         7gOo/6TJAebVP3Navu2wF34ak6YjqhpD87bGoUlB5W2u4KO6/jQR0xEwETGzCe9JhTAP
         CZP2bbpuViZ/6TVSUxSXWmfGnO5TZfqFNGzTv0E8zssnV/cvrPFnv7qwC7ipHOZAdWhv
         ZL7Twk2yXnhJtuZtHJFY0T8bKXhCHG2WYF9HtZ3YUllBML0QUg39uh9ujcmZLvkL+Kjl
         Nd/w==
X-Gm-Message-State: AJIora/J/e5Z9D702dvSCMtARRwqi6t/m0aQGbX2XTFN4DTznRBEQD/A
        Plwiftv4HMGqCwszxPEGuahmmX0QYGug7w==
X-Google-Smtp-Source: AGRyM1tgtgCFCQNLA/92WNK1Z8DZzp0WNAaG/odyTaOlgzY4TqTWlkMpy2iBcW7A6POAPPFujUGtpQ==
X-Received: by 2002:a65:6d97:0:b0:3fc:af2f:7be8 with SMTP id bc23-20020a656d97000000b003fcaf2f7be8mr8922049pgb.246.1655472471087;
        Fri, 17 Jun 2022 06:27:51 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x27-20020aa78f1b000000b0051c78a6fb9csm3717417pfr.111.2022.06.17.06.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:27:50 -0700 (PDT)
Message-ID: <1a49ef85-dea2-e202-f842-e5d70a398141@kernel.dk>
Date:   Fri, 17 Jun 2022 07:27:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] block: disable the elevator int del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, shinichiro.kawasaki@wdc.com,
        dan.j.williams@intel.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
References: <20220614074827.458955-1-hch@lst.de>
 <20220614074827.458955-2-hch@lst.de> <YqhFiDx0/IW25bSp@T590>
 <20220614083453.GA6999@lst.de> <Yqhwv0POjMi1TNo3@T590>
 <d76649ab-7392-33e9-13fd-785073bbfe4c@kernel.dk>
 <20220617132659.GA26192@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220617132659.GA26192@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/22 7:26 AM, Christoph Hellwig wrote:
> On Fri, Jun 17, 2022 at 06:50:50AM -0600, Jens Axboe wrote:
>>> Then looks this pattern has problem in dealing with the examples I
>>> mentioned.
>>>
>>> And the elevator usage in __blk_mq_update_nr_hw_queues() looks one
>>> old problem, but easy to fix by protecting it via sysfs_lock.
>>>
>>> And fixing blk_mq_has_sqsched() should be easy too.
>>>
>>> I will send patches later.
>>
>> Just checking in on this series, Ming did you make any progress?
> 
> He send the patches in the "blk-mq: three misc patches" series and you
> already applied them.

Ah ok, guess they are already queued up for 5.19. Hard to keep track
with the backlog.

-- 
Jens Axboe

