Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A3C3A5A8
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 13:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886242073F
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 13:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CkAGOaD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfIDNBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:01:14 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:42153 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDNBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 09:01:13 -0400
Received: by mail-io1-f49.google.com with SMTP id n197so42033733iod.9
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UO6cB8+486b+w6LkW22NNyxYlDr/fcp3IFzUgW+nTI=;
        b=CkAGOaD3qZpoP0YynPDzfnUkyMuaji/8xPbrIoq4xWjuw0twk0VMAgLR4BFpN2m+d+
         7HRTdHLrSO5gmwn/cd1tloUqdAep3LVoVuL9oAp20SY9Qcr2GUOMcSdVrtUE1AzQfeSX
         +TBavqlqRKpbJs5hqlr90ljJ+Izejfx5UjF3+A1skii8AUCJOj56mFV3RudM1gHYmFiJ
         EH9Ua/7JTo/NSqA6gNJRA2r4NoLE0q4NCxvERRi4HRpcatoJZkE6OjMaCMAyh5VVzTtH
         jkAAiIB9FA6fnWd9Nl9x+44lb9ttac4Wy20fKLE/uFazl8o9jJG0xAxZjhEczYObI9zs
         qnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UO6cB8+486b+w6LkW22NNyxYlDr/fcp3IFzUgW+nTI=;
        b=cvYyv/xfxh4K4fGrCkx/bKFqDJDvRs8XXUENhKwdlDT0x6I1dpSli8/+PkVZm1E9NX
         NgtX160YU/vCIGA4K8S0baRRAfJHVHydmitkulDjmoPrKhxMTJm7Rlux1SfX5dx8oKrI
         7yJ2yGYLTt6emNku+4aqecw3+OHSrMnuEGTTCSzfPlSiYayZLpZYUo9A9BxAEQWz0isQ
         MkVltPhy9KA5kaqOc3UgLJ8N3TdTZTIYfrYVFd8JG5hudgdKqjO0l2AbCwazNTcWTt67
         8zDT1iELvFHqlrMHJthSs7kNqOqn6PNYxsg+qcbq1v69DQyrXLKcxE1NvgaZngRJmPN8
         wzyg==
X-Gm-Message-State: APjAAAVtEA75CqetbFKwhlPUuVXzEx8CTeO2Jau0Cu06lTBx3csjHUoW
        rLVt6y8K52VY7skJ6KyzaMhC7/I9ZMxKeg==
X-Google-Smtp-Source: APXvYqxFyA+EC0f41sIb+hjQCTSz6RZ7HA0yWUUgtPb/jwmHDWTE8i0RUhPNLV8iM59K8fuw/ZC8cQ==
X-Received: by 2002:a05:6602:25d5:: with SMTP id d21mr15622434iop.177.1567602072931;
        Wed, 04 Sep 2019 06:01:12 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l186sm1259415ioa.54.2019.09.04.06.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 06:01:12 -0700 (PDT)
Subject: Re: [PATCH v2] paride/pcd: need to set queue to NULL before put_disk
To:     zhengbin <zhengbin13@huawei.com>, tim@cyberelk.net,
        linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <1565695660-13459-1-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be8df565-8208-b97c-0b23-279e483c4717@kernel.dk>
Date:   Wed, 4 Sep 2019 07:01:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565695660-13459-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/19 5:27 AM, zhengbin wrote:
> In pcd_init_units, if blk_mq_init_sq_queue fails, need to set queue to
> NULL before put_disk, otherwise null-ptr-deref Read will occur.
> 
> put_disk
>    kobject_put
>      disk_release
>        blk_put_queue(disk->queue)

Applied, thanks.

-- 
Jens Axboe

