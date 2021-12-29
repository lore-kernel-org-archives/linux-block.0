Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbhL2Rwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhL2Rwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:52:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE8C061574
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 09:52:34 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 2so19058827pgb.12
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/2gYt7+YP9UcYI5ZhLAWGb4uFFavysWqDWMBAaUFlU=;
        b=huwwDH+xrplC7VzvJ5V4Dru7OTPWF9La2yM2+kJQr71amL0mUt7WB59PDn5iuF0ouJ
         ZSVfleOOlN2y620iRt3ckxYtqDMM9m/O+QhuUKm0OalyAau9s0XnGxh3+nheKYEKUL1f
         MFpuQr+P1T2XeqSV/w9s3V1uzFhriU5vAoQzdpEF7vreKiavuQ33t2PrEdSMulKYTUBI
         9R0apJ79ezIcIE7uZgIJiJOJVqk3FkV/Vx8ZYFbdWjHhB4x/SQaFp4WcuTQ1MytnsY0i
         RZYP1BQPvq4FTvvOh/7ckbjl1r+ZE4Rj9NIK+lhWfGrcjySFYPthQv289Ju1soAuIIGG
         mROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/2gYt7+YP9UcYI5ZhLAWGb4uFFavysWqDWMBAaUFlU=;
        b=0EyPlUUFzZ0K3GNw2kuuMgCun5tyvlwKqhkrszXaUu015lUAH0czILKwexG4S80O9Y
         q4nfjTekOMw5xYu696JPP+JyplVRy3YgWPFCN6vz4uIbzKLpqNfUErR50L12ZnbZddHb
         vQBJkpVpgXL4PwizcRlzeKDaX4o4FtF9n4vKbHra1eNNWGAxrb6v/Se4MAVN3EfyCRVG
         h1kWRJ1f1LhEx95gE7UxhhDCRqz1u78DIezRbTjLUUsDYPj1UfxQOt+8kiseEX7fT/Fp
         1VWAY4utc3+GPAbqhqWJX8oDat8aX1SqslOAfqLnlk2ZmTBQW1RPDh6AfFAhW6phqMPM
         8Cgg==
X-Gm-Message-State: AOAM533lyz8DimvV62p6/SCgEkfINoqcF1MRWfuMuMeT/24nBJBlZWn7
        H76oN6KI7nkeGDTf2+cJFGt/6A==
X-Google-Smtp-Source: ABdhPJzZBGkkaqsZSRforFyh/+anNj7NrfXL8PCrrdRRH5KvVWJRUHPXcFnwXtT/IFg1oTZkML2xNg==
X-Received: by 2002:a63:82c8:: with SMTP id w191mr24149180pgd.92.1640800353669;
        Wed, 29 Dec 2021 09:52:33 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id qe14sm21183393pjb.44.2021.12.29.09.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 09:52:33 -0800 (PST)
Subject: Re: [GIT PULL] nvme updates for Linux 5.17
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YcyVq0hj1dPtRiGp@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <38daa193-e3e1-dc3b-3069-bccb3755f63a@kernel.dk>
Date:   Wed, 29 Dec 2021 09:52:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YcyVq0hj1dPtRiGp@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/29/21 9:06 AM, Christoph Hellwig wrote:
> 
> The following changes since commit 3427f2b2c533d97bcc57b4237c2af21a8bd2cdbc:
> 
>   block: remove the rsxx driver (2021-12-16 10:57:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2021-12-29

Pulled, thanks.

-- 
Jens Axboe

