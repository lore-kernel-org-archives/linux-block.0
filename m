Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC204C433E2
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9425C20760
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VGM5EjPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgGPQXJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGPQXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 12:23:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E4C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 09:23:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q74so6667959iod.1
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o7vioyeJtfXqaTWC1ftoXXX0ZgNVC9TTmnLN+3HE5V4=;
        b=VGM5EjPMF4BqA3SwlPSDwN3f+adgl4wg4lh9udMmdtl358whUIMCyswJrhvtCH7xSI
         /2yx6LDdu/NtF41wa28Bp8WWOzadGkO4pEThHXJ10ZMgjAX888U8cDwmRNTBJSWus6RT
         oPRAfva/AQiI/qzf8ZjdoKuYaZ3d1Y9Zp6CRiyHGl5nA1rDNoUewL4sEj/LuXjJ9sEno
         3J8dMDpgjK1UBNSLrIsutgXkd7MNRHuBA4PjP1HQL+09exc1rHP9obnJzk3XHy6itbxT
         4BCwnsrlcaIfEZ/6XN0WHAaHn710vbuPPn/unut+HbKYtyRNcE/GS1E40pl0zHoDK6+n
         r8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o7vioyeJtfXqaTWC1ftoXXX0ZgNVC9TTmnLN+3HE5V4=;
        b=S/PquVk2kKd2jacJYCKhNKMVPxEiWrDlonM7qrG6ddIwHYxeK8VfJYkRaxPEvirhj8
         con8/MrRdDG+1goa03GRjskf48RFWMsnk7fYN6+zokLcuHD7z37Jd///9a8eoLkqUNez
         FvOaSthnlYeRBXPHqruVGG1npci+LdkzA2elUocfmTXHF5z7GaRIn+GJE7hYwUFtAY/n
         CK9oH/eHs+jDX0GEWUUJfH6uYnrUZ5hu9XYtlpsqClv7Q5A+DgazN0fFXsjh38aq6M39
         2wyaKZKxSiL/12flZny5V0ISHFf5ynVsO/RMLAo/0catfllTZAwhzYX6+AhDa25bJsuN
         XKtQ==
X-Gm-Message-State: AOAM530CpSBChIhpZmrljL1X6sV3zJy3o7xcKRxI2zIn36RzvlmqgL3e
        wqJfjV7inKKHK4b++poPYXTxDg==
X-Google-Smtp-Source: ABdhPJw2BMCa8GFE43BTcssRj6BBZCeaVh37+lnCXadsVSvr/R0cL9+H3bsiraMAlTvn9FCQdjCmbw==
X-Received: by 2002:a6b:2c1:: with SMTP id 184mr5135872ioc.167.1594916587715;
        Thu, 16 Jul 2020 09:23:07 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p124sm2963526iod.32.2020.07.16.09.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 09:23:07 -0700 (PDT)
Subject: Re: [PATCH 0/2] block: remove retry loop
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200619151718.22338-1-john.ogness@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb08b3f1-1b8f-c981-2264-fb921a9cda02@kernel.dk>
Date:   Thu, 16 Jul 2020 10:23:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619151718.22338-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 9:17 AM, John Ogness wrote:
> Hello,
> 
> This series removes a retry loop in the ioc reverse-order
> double lock dance, replacing it with an implementation that
> uses guaranteed forward progress.
> 
> While at it, it also removes the nested spinlock usage,
> which no longer applies since CFQ is gone.

Applied for 5.9, thanks.

-- 
Jens Axboe

