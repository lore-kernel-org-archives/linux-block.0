Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601E2C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB5620838
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TNNmw+zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2Rh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Rh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 13:37:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABAAC061794
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:37:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w12so11792407iom.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ShmMwXzkkP7njO5YzqKQMO3gMDOR/zuGA+4L2KDGm4=;
        b=TNNmw+zXBsq+YBWbnSJi8eLISVP4F/VAiSJWP8uYSltZGIz5hhQUxh4KMQno2sP/Zv
         D6jicJdBuOYNiDHC5BAtXx1eVhNq73fIBmWFyBWMhFArGHGbJRXqXE8j9HRQ4HrW+Ovb
         /LkkX1xonPjHdwO6eVcPymEEf8kOW2/VHMchVHBFWbjkUXeQb0vbFV1srwusTpeCc94G
         0n3fTh+2D5kiIAMEKjIrj4NJ3Iy4NgtsWQ+Sy2+pNPCDr3cCa2TYZWBKy+Zz//00DAWY
         0nz/gXHMdiLMIuYNSncHnnZ5NEIcOqp+is4Mzd7LWcGziYNRJrhzSbrNQ9hmBktwvuw/
         4AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ShmMwXzkkP7njO5YzqKQMO3gMDOR/zuGA+4L2KDGm4=;
        b=NUnSBBy9tapusmXLki1FFubOv+R0L6FCA7hWk2M0L/t+dmdg5Qmk7Q8yNVf7BcPj9h
         eL10tvJY4SZ1cw9JGk0t5ZkVZyeUnNQ65RccVOc8xHXoDU/xup2Jr7wKOnJX5t7ExNgw
         /s/q3cSfmUo/167YohXSQ5GuI/KNc2DRjvLxrI1JJEvuPnqzvlT6tUcu4hFS09zHA+vk
         91OavxdR658p2NCgkWTevyAVJTB9+aUfmR6VGxdri9204KfOg50zkAaZUW4lwXtukJw9
         t3G5lPMnkcAup/vt6Zf/D7QPxTVop6GKvWPaDOewOTgtJX1PLtx7+6mBLrTfu9vqLnzz
         DF5w==
X-Gm-Message-State: AOAM533Thm6lqMFWaSx19cQDN+Pe84k1wmUZMvyGK8zBxSH49e7j1jye
        4LL899WDPwt7hX+6xLYwUV5CBQ==
X-Google-Smtp-Source: ABdhPJzruCBTayo9Mb74tmi8U1AaRmn4DDDvgiPjKHcV2/0wWJZjOinznj9QoC18PIZGGvKzu0UfUg==
X-Received: by 2002:a05:6602:482:: with SMTP id y2mr5603582iov.188.1596044277199;
        Wed, 29 Jul 2020 10:37:57 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm838624ili.2.2020.07.29.10.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:37:56 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200729173010.GA25167@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e9fbc3a-3e86-5d0e-5473-93485a237963@kernel.dk>
Date:   Wed, 29 Jul 2020 11:37:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729173010.GA25167@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/29/20 11:30 AM, Christoph Hellwig wrote:
> The following changes since commit 1f273e255b285282707fa3246391f66e9dc4178f:
> 
>   Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-16 08:58:14 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8
> 
> for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:
> 
>   nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       nvme: add a Identify Namespace Identification Descriptor list quirk
> 
> Kai-Heng Feng (1):
>       nvme-pci: prevent SK hynix PC400 from using Write Zeroes command
> 
> Sagi Grimberg (1):
>       nvme-tcp: fix possible hang waiting for icresp response
> 
>  drivers/nvme/host/core.c | 15 +++------------
>  drivers/nvme/host/nvme.h |  7 +++++++
>  drivers/nvme/host/pci.c  |  4 ++++
>  drivers/nvme/host/tcp.c  |  3 +++
>  4 files changed, 17 insertions(+), 12 deletions(-)

Thanks, pulled.

-- 
Jens Axboe

