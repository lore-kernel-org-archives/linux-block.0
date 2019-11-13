Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C27C432C3
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4521A206D8
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I5W72ILq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfKMTvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:51:16 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:33768 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMTvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 14:51:16 -0500
Received: by mail-il1-f178.google.com with SMTP id m5so2967047ilq.0
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2019 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ef1f/PdCcKzFdmtEAurRHSiBIp69Vea7tsZwHU00GvQ=;
        b=I5W72ILq7hyu89Z/dlDetrs/gEtASA3i8vwvHBwNFY4h8AJDoyn2wuYwXfUyI64VAO
         ORJrP4Kp6ySoHO9Iwitau/q9pP3HAOib5Yvi2SCDzS2LKK0Gx9jFdLBtsRwDzdq5svFI
         YXTEC53jWG3Bv9zp7UnvovIJUOUir6FXd7iSNVjCzW6l/U/ypGLBeww58RLW7SoOWK5E
         hsKNTzNznULhFlVDucl9xm6/VgauSy9q5LB1ckBG1q6B4l9+CznxhF/A+HyL6mgI8A4J
         18Z0qwZkJNnrqlmugjZ8wwxudP0JYxMGFmarjVk7Mp56QkfhBOxKv4jbAK1Om2avrMGI
         ET6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ef1f/PdCcKzFdmtEAurRHSiBIp69Vea7tsZwHU00GvQ=;
        b=k8yHKSX2GSqSPUYDV+14Zxx+7x2/QEa4/SfbQCNYk49Deqhc+y77lYbVRPensj4QTm
         MKkKlUSpgiVSRM9Nn5Dj0SPREPG0j8AOTfzC/qhRe6IFUqJGVMXAo7oHXk5dDtvV0Z8P
         VZzqPNOjBUWNQKRA5XkqlDLNBfXMJ3Z9HXipL6PyU6WAihbz5uPXDle14jHoDeklNqiF
         B4T7FFjmIpbGnxS+1UBlXNYFhja0PkhiG9Ny5u4szLWa6Ssa9auT0apgnl95wfdRc6Jd
         hcyn3XKkvOOvendzUd/YL2vrR2/y8+q/fNytUeew3VW84Yeqc7XGiJH4vYhcowxE7tin
         EsHQ==
X-Gm-Message-State: APjAAAWp0UA5WXGau3+NNOMnNjsDKJvExbRuOWwdiqgLkmHYrRnpBKA4
        fjbkd7BDcac8RKWv3M9UlsX72g==
X-Google-Smtp-Source: APXvYqzCQgYFZqroQI2tVwbNNw1V4/Sb+rbJqPRVd83F1uKeb6xzpf/drlH1jtgSSp6EyhQbiCUGWA==
X-Received: by 2002:a92:d746:: with SMTP id e6mr5810296ilq.111.1573674674654;
        Wed, 13 Nov 2019 11:51:14 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a11sm422678ilb.72.2019.11.13.11.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 11:51:13 -0800 (PST)
Subject: Re: [PATCH 0/2] blk-mq/sbitmap: Delete some unused functions
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2a1502d-5af3-cfaf-f4c3-a8cffffc5aed@kernel.dk>
Date:   Wed, 13 Nov 2019 12:51:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/19 10:27 AM, John Garry wrote:
> Function blk_mq_can_queue() never seemed to ever have been referenced, so
> delete it and any other now-unused callees.

Great, I like killing dead code. Applied for 5.5, thanks.

-- 
Jens Axboe

