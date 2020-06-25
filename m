Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616E2C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 18:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32106204EA
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 18:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gncokegj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406099AbgFYS5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403853AbgFYS5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 14:57:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D28C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 11:57:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ev7so2995398pjb.2
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/r+jmviS0T5Cngld+cIbW/oeILUuFOjszb7gCMcsBFk=;
        b=Gncokegj/Et5KXnljvNxiVT0vSjrHyQ4INSnPy3RQG3xjuZnquQo2zhUglWv+zJyDn
         pdK9iZvRc7WhaqXVU/jkXlsu7AUJJreppYgxcdvpGS887uVH9VYhksJAQPKXrq7OsNf9
         4yKDjixQ5NMgmJr5PKOSuG8lK1gOslyNlXR+L4PJG/LPo4gpsndG1gB8wSiBM+jRDesp
         iCiLcPn4gqlty6kgMUfdNs+zcbZu6VXR7noJN76CXK18I5Aee0k4rGnf0z90F9MjLs+K
         wCYjRyzCyd71aaBXCzZC0KSBRx3/Ohmyn5rVBnyUXscrP3q4yDlq5j7bLP8lPCNIZXvx
         T75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/r+jmviS0T5Cngld+cIbW/oeILUuFOjszb7gCMcsBFk=;
        b=MQEw/Woj+v96+1A9jU/c1JPr2N9PXut8D6xfN8xli7q4XmG4QuLnY3hADFc+fxiHVI
         g4WXV5sXlPz6AKns4WeBlbalB8bUSPnzj5I/UEOr92KfZZK01jbe9zgU9VGQdjUgqHCs
         gIsf79A6CNX0iwdoC6oU6j1Czs5m4BcpvKHRXkhdzd2bZQTFe63NixftxJwtt04J7OfT
         HT1Nyj4MF9O4buLpOwf8CeygFNUSBJe1Te/C5qPkLKwBpfpOGhpMLVUrQjtM5zhUFoPi
         dK7qHxDzkVQsrwt/MMKpyPbmI9zJRuxqCAYS4cwp7v9kThCxBlTgAn4K8VWSi6GzocDB
         8zgw==
X-Gm-Message-State: AOAM530apzJAy04sZoCmuD73a8N8ygIktHPM1ykEp6qPOJNQdEAQaCF9
        hAJi68//HEFFiQv5DIlU87sjmBsbylTmcw==
X-Google-Smtp-Source: ABdhPJwqj2hi624WpRVRcDX3+kgITvMH5tuQkynazXybRdwiIeSCnW9WtgoH+gHSS8ENKcicn1qHrA==
X-Received: by 2002:a17:90b:347:: with SMTP id fh7mr4870854pjb.64.1593111466308;
        Thu, 25 Jun 2020 11:57:46 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k2sm20662765pgm.11.2020.06.25.11.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 11:57:45 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20200625165333.GA1982738@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ab79476-516d-d7b4-74fd-89cd70d43a2c@kernel.dk>
Date:   Thu, 25 Jun 2020 12:57:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625165333.GA1982738@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/20 10:53 AM, Christoph Hellwig wrote:
> The following changes since commit 0b8eb629a700c0ef15a437758db8255f8444e76c:
> 
>   block: release bip in a right way in error path (2020-06-24 08:49:07 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8

Pulled, thanks.

-- 
Jens Axboe

