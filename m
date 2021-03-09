Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD6C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33B0650DF
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCIPAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCIPAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 10:00:33 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D135C06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 07:00:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u20so14190170iot.9
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 07:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ejTnJzM6iJuTtHRnL+yATL8VRLcQ48UO3NVNkM8NRD4=;
        b=OV6wknNYp/4ACvu9wIRXaxzDf0touT4k4IO7/IKmv+DGrenmnxNY2cClEyyeDLl62I
         Ee+iRkIbPFyTncFgcWQ+R4Kx5Z3f6NnVdZBRTVBj4ANw8It+6zXHRI2vA94hr6VgHyi8
         wM71jdFls6e6rnP0y2t3FJuR/UxxgZ3Hk1Y5j+60Fr9R+KgjKOwDPveUlNvFMZQTTUXG
         Jc0PUlpa58iqXi+4Uh458lhUvE1zrUu1Zjsq23qZtIhsdlHuEz5wkP/+b4SrcsZeHeGx
         cQSZ6bOre6j7LpsbHWRWVkDdHhU4xFlB9mmMxRk0Kv6PT4OwZYaf8L9/rLWqS3iD+dgW
         leGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejTnJzM6iJuTtHRnL+yATL8VRLcQ48UO3NVNkM8NRD4=;
        b=GTzGA5r3kfxDAAO1y/5lljyZV+W3/k/fsIbwcapCrXPeRKlCqur6ZwH/BtKoQv+03a
         oJHCgnM/kv+8w2eXZZj7hGk4tAIYCedwFfVRq/vU3id7zKH2mCPl5PDtIYl2myRo5kFC
         AsLYlpHEbxf/bYvcNcoG5tzFDvYCTTTzt8ro9j0EFBBy+sjfCq6pyninbFRtq37MD/F5
         FWCxFtExZQQcBpFg4VkKc0iLSS4XluMcdEvUbAc0JaEcx4i1XWordV+iE20zAqXufiEr
         0OySVq+oCTWX8xDA9Y9snutxjN/B8DWJYNV6uds5iIrUJIJ7Y89kT+CtdTZG6fpBHdSc
         i+aQ==
X-Gm-Message-State: AOAM532jn0nvPPba//hgFCGQaeSOf7G5P2QcQqyoXX/plFZoL9LtMoqv
        X23KXsBJdIiBnQB9YjAIX4RC4A==
X-Google-Smtp-Source: ABdhPJy2Pmh5YFBu9aJxMMVwXi+IaOtBV+AtQLKTzQ8xkw83aDf7m0aQp6RHPH5+nd7dMLA7tZkRgw==
X-Received: by 2002:a5d:9641:: with SMTP id d1mr22806553ios.123.1615302032869;
        Tue, 09 Mar 2021 07:00:32 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i12sm7906594ilk.46.2021.03.09.07.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:00:32 -0800 (PST)
Subject: Re: [PATCH 0/2] spec: liburing-2.0 updates
To:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org
Cc:     Jeff Moyer <jmoyer@redhat.com>
References: <20210309141913.262131-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d3cf0b6-0ff5-a3f3-8463-21e7facf3e93@kernel.dk>
Date:   Tue, 9 Mar 2021 08:00:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309141913.262131-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/21 7:19 AM, Stefan Hajnoczi wrote:
> Update the liburing.spec file so the liburing.pc pkg-config file and rpms
> report version 2.0 instead of 0.7.
> 
> Stefan Hajnoczi (2):
>   spec: bump version to 2.0
>   spec: add explicit build dependency on make
> 
>  liburing.spec | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Jens Axboe

