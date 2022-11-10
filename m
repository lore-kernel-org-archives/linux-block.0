Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6466DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKJNzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 08:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKJNzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 08:55:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB3F03B
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 05:55:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so4704999pjs.4
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 05:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ9RcxcCkW2M7OPQ/OJGApyhr3Ci1CM13lpfXbD2VU0=;
        b=UOfFvHnIDiCu0HqzK+oKurNlylWD8R28WYdw+OpALlIqhupx/zXZledxaa3H3oQN81
         uAtpQeR9gssMjyE1hBqVnHpTq8CRMd7KiQytmDn6uF4DY18uMnxLqjpQf4ogIXk4Y+vR
         3W9K1b/pnNZ6mpUhvxhYXlC+afQrxz/BTe+RZuBvWoNzywpLx9QeuUizkeVz37q2cx0l
         gdX+0xby/vhBUyOW5iGs7ruddeuSfZqM19vm76nFSVX64JRS9UIj7UE0/JZcC3qWKw/R
         hmbIm/YFamIbjPYJJSMgTm6ybdQodD2KDndWGi46W0sinTIc6pkjl6TWlcLItdy81Ovu
         JfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ9RcxcCkW2M7OPQ/OJGApyhr3Ci1CM13lpfXbD2VU0=;
        b=4BWPTil4Rg5PpXP3v/e9Mrs/DG77I+IvClGmNY9iXmXY8H2kJEnXsbs/voUB5ew2Ns
         U9PBRi3oqBMiPcA2eBHDVSHL33VIy7PHEen8iBDn1QqJR5PepGOnef+eN1uCsRH2mZfc
         8sFmR4lwlz8/+eeXphZyEsNgzKJzvqW4O1dPHjplmVSk1de4UtWPqJ/2U6FGkbbDHF0f
         qLeMhl3uXMs9Jil4Y55kQs2yI1Tjtfv2Zy9Gl/mvIgl17RNqNuKJHBq2mMsY7+Ox5zIp
         JHrHqZYqf2Zj1zcKRcu5TBcuDn7waC8ZuhtGD9QnCMngiy3v585GutmhgsCMygJh783K
         HEGw==
X-Gm-Message-State: ACrzQf2x7BUu0OdYKMEZ0mNqb8JdpuoEwCC+WwwZUmHMy0oaKfD5qILq
        ba9xClBhXciglVQf0inySKzXrA==
X-Google-Smtp-Source: AMsMyM7atE7lTTwF9STan7M4HamFf6AO8qtlF/PgNBnvo15LitZ0xLgt7Fm65pCTXz4D+QkkIJTm2A==
X-Received: by 2002:a17:90b:3148:b0:214:199e:7e6f with SMTP id ip8-20020a17090b314800b00214199e7e6fmr46727295pjb.126.1668088541372;
        Thu, 10 Nov 2022 05:55:41 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b0056bb7d90f0fsm10212236pfr.182.2022.11.10.05.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:55:40 -0800 (PST)
Message-ID: <8f69c93b-f1dd-e9ea-5e4e-a4caed4b983a@kernel.dk>
Date:   Thu, 10 Nov 2022 06:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] nvmes fixes for Linux 6.1
To:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y2zL45ll7KIIc0zF@infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2zL45ll7KIIc0zF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/10/22 3:01 AM, Christoph Hellwig wrote:
> The following changes since commit f829230dd51974c1f4478900ed30bb77ba530b40:
> 
>   block: sed-opal: kmalloc the cmd/resp buffers (2022-11-08 07:14:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-10

Pulled, thanks.

-- 
Jens Axboe


