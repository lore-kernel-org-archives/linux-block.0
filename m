Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DAC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4825020851
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cMqPktH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfFMPx7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:59 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40122 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbfFMI5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:57:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id g62so7519534ybg.7
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mMgpu2dxgmVuzhoX6u/zbPwD9CD+MeWOEHICon///9s=;
        b=cMqPktH+OU7wdZUKzogFKsSP0nfdpoKy/x2Nyqa0OowSpgi0LQfiU/t2K3ZkK2sXN9
         hTmxXT68Csa91JfbZqASxynZtiQB/skJmaNZG3Id3wouwBNPxb6RH/fbeFQN9sXx/zGy
         tlRv5Avl5o3AW10g6Bds647VIvt6yECMXehdQYRKYyeIcDJa1Y2AUWX8RIC4xU0qeJfh
         4nMsD4hlOIwsv0g+mNYAZwGdSaT7q48/WOlwxWlSRf8Ij9lvDysXGcuyt8y0/9KFoqQ2
         oK35tCRSW7NESTtxlpQAs1BQBxafi4TzEYRsCAtb8SrLFSOvPH0Z54AMrDeGc4FhkDsT
         afNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mMgpu2dxgmVuzhoX6u/zbPwD9CD+MeWOEHICon///9s=;
        b=q4CXNzxtypQfRz7UgN4u5pbvTzMyQEQkI+7HrQ+jtEM5fkSR9eJ3ckgFmH7Y5RQZOs
         LySJmpDwAhQfELYm0YZipvOKXKcScm4Ba/t/3b4HHPJmjWmvqlpCC97Rb4YVzGvtyzcY
         tNmGBC3DAv9ep+oK4ULMF97tUTrrKJMhiGV3utX7Aiee5LDqFADBtl1msiknl7JX5XOf
         9gpnRpa9oTPjpT30r82tkXJctDJb6r3UmlOLhskPzlrkFO0GBl3j0WaCnvOblbfawFzc
         RmaA0vN9im4HgXXo/1+UgGR3RD5G7TDQKN0N3xJDzkgdAu4Hgu0ohQfXlhzQjNDgHTIA
         l/vw==
X-Gm-Message-State: APjAAAXQP9Jmfnw8EDsyGVWIRH/4i+Yd58hElW7Cwi8AHrleVTA2Ikxc
        8PWNjZf+slB9Nb836dzhzV+cAEsAAt3OWAb/
X-Google-Smtp-Source: APXvYqxf1bzcuSh30dG2NpWNrTKVGR5AGykk1c1mdSjDyFTHKq6k1lN5wergm1LinRG1Sgg2nzmXqQ==
X-Received: by 2002:a5b:64f:: with SMTP id o15mr34232575ybq.430.1560416224627;
        Thu, 13 Jun 2019 01:57:04 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id n62sm565961ywe.82.2019.06.13.01.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:57:03 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: no need to check return value of debugfs_create
 functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org
References: <20190612123019.25112-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0974f13e-37cf-6706-e1ae-7facf61c0215@kernel.dk>
Date:   Thu, 13 Jun 2019 02:54:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612123019.25112-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/19 6:30 AM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> When all of these checks are cleaned up, lots of the functions used in
> the blk-mq-debugfs code can now return void, as no need to check the
> return value of them either.
> 
> Overall, this ends up cleaning up the code and making it smaller, always
> a nice win.

Applied, thanks Greg.

-- 
Jens Axboe

