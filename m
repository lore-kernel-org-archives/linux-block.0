Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FBC4743F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D17611BD
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhFHVFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHVFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 17:05:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578BC061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 14:03:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2426919pjx.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DmZFNXi9Vb57vKWOGYkmfVM6okptY5Tt7Ef17kHexkI=;
        b=0/UlSN+G3zH9gxCNvvpz1yav7LWJPbA6qpyphaU+c/mHz0vPdKHCr1lIG6Q7zhw+Zg
         DbD9jiprSyR1XnJYjzAicNYkCvdA+ro/hQI8ZEEbbiP+li44rGagu1kI22Y2q+4Yjn/G
         jXJIAha9BY7S3djKmSNeMQkruGnq3nhiAhwE6ZxDo1TFypKPK1+i55CXQVBSN1o8yqIi
         CvA1mHqxl7g8zitMZ9vo3puW1+fNmgTp2kAUvrrXnaVTh9hjzrfFfKpmrUN3PnDBpExn
         VqmwyvXjHIkP6mM4BLRKRIdSked4q2TO9jD89qAQ5+Lt9NH7QSqM+VGoAl0em/s6zheJ
         z9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DmZFNXi9Vb57vKWOGYkmfVM6okptY5Tt7Ef17kHexkI=;
        b=PXI5GoDclyU2ZbPZeKZ3OksLy2/ECFRVztP5e0U5D8CRjQ7fBTAV7xqEKavJDJVukz
         k8FnUhv2Ris70OCGngXG975ynF9G78pwDuoWiIMeDW94RaQJueVGb2jmjxKK5gUu20e+
         gve4UWmvPwp1hq+uQdel/p06pjW3V87MuP6crLdWXmjmhQi3c+VBKF6UuuS7uNtHFYw3
         DKtr0vGBeN0BSNhM9bfq+/7j9P3K+da+jIAWMWmv7C377PKicPx9bKZGmmmyu2VzAynl
         fcySG3Utd7PVpL+SWvDRhVEpOjnwVUFGsDHV5hT9KL7yWiUHGa8zTlyISJ30n95nmZiy
         +NjA==
X-Gm-Message-State: AOAM5310ku1k+NePDdS/mM62E90NffdjTqHMghWn1ggPMgoHKFR+Pd+M
        WvnfPY5LfqPGzSElJND9u24SFw==
X-Google-Smtp-Source: ABdhPJwPWtrMEbW76Lm545/yr9iAz/EEWCEGUEVx24jYSkJa/fbsRj8Jo5SxuHqeV4B8LfYRS09Idg==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr20413397pjb.219.1623186191772;
        Tue, 08 Jun 2021 14:03:11 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c4sm1770532pfo.189.2021.06.08.14.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:03:11 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YL9/KDQ2uGRVAh6F@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3534f5a-133e-85c9-8ec8-49972a228fa5@kernel.dk>
Date:   Tue, 8 Jun 2021 15:03:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YL9/KDQ2uGRVAh6F@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 8:31 AM, Christoph Hellwig wrote:
> 
> The following changes since commit 8184035805dc87dd826101b930d3dce97758f7b1:
> 
>   rsxx: Use struct_size() in vmalloc() (2021-05-24 06:47:30 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-08

Pulled, thanks.

-- 
Jens Axboe

