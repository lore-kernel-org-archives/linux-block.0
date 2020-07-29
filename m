Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B184C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4003720809
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qBBef4Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2RXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2RXE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 13:23:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41019C061794
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:23:04 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b18so14897286ilo.12
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r5j5Y8oTddaFgghXor3+5c5b1GvGHTVAH7g8aQIrlqQ=;
        b=qBBef4SpKxzPViluEeCB6LB2Q++UHIqFNLYulCEVR4sdJEvYnoiDPHUzyN/UAWwPmn
         73tgnHl9SulwuFuR/lBtP479UCSlgz0mYoCuhayDNqzBDgmYGuGlZFVcYrbOYG1niDZe
         mDHslJ2NYX7/CvL+Oq7qrFmZhGt+KiR3IyTlhe9jntwd76o2XFOJOQ+ZO6X15h0XlwyD
         /wllqifxvpDutVP3XQ1uEquuahMkkUpgYKXKmcQjNAF/FeBWXvA0jCubOA4mT/Dexall
         4uYBIQS8WaEI0Bh0F5L8XvQvLRDbaFJpZ8PfKWCb9ECDRCirZk36h2zPVk0TGJQW4dMb
         yIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5j5Y8oTddaFgghXor3+5c5b1GvGHTVAH7g8aQIrlqQ=;
        b=sTfJ5jNQjM4FFhtOgMAveh4OY2t/LNhMUiEs/8fN0xBEYnQ9SA3tWPbba8wo/UjZ3/
         XjsLE4FJGejD+/wmkqKUSp4jATZmNO6BnJQ0ApLayX20TFpsQKo9VdsXA0L/hsvX3FH/
         GzdeDQYYkFu9P3FvL5fyS0sEq/+efZStnFfUIrJX1osh8dDb+IbQx9IQKG1IRsw7LhuW
         iA455aX2nWywzhoyCBPj8Uva5+HOPK8EZaaoMIpGCaUzs+d92L9i3YMlh65+hS8/FZY5
         Zg5NSSDQOho25bHN2GdeU3SielvViUH6EhwKA4MqKMETvxm3+DnByRjc9BjSHVPiIYk7
         ilEA==
X-Gm-Message-State: AOAM532a7txrAL8iSOdTfdZerxfzxQhgMn12/2nwGIBvPna0aSkFabHe
        wzwQRF+OMTefVPxsPSfhgB0aHA==
X-Google-Smtp-Source: ABdhPJwRgDt8tMkAQyMeDj8Fv5J3WZJQ8JLGe7izO8gvYu3Jx6aPHLYZQO0/9M3q1rFnPnW6VhFHIQ==
X-Received: by 2002:a92:a04e:: with SMTP id b14mr36056630ilm.261.1596043383642;
        Wed, 29 Jul 2020 10:23:03 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s10sm1485481ilh.4.2020.07.29.10.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:23:03 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200729171125.GA21194@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d50ca734-3f52-6399-b62d-7a401a53e320@kernel.dk>
Date:   Wed, 29 Jul 2020 11:23:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729171125.GA21194@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/29/20 11:11 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git nvme-5.9

Pulled, thanks.

-- 
Jens Axboe

