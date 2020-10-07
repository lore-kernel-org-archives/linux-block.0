Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631BEC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E666E2076C
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NM2EJSU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgJGNxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNxa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 09:53:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC8C0613D2
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 06:53:29 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q7so2320330ile.8
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdKwGBt3vgEIkMtFrGuBx1104sQ/OZxI5mRem7H/luA=;
        b=NM2EJSU9oepcqmQFPhB+ORVpWNM8GYWasYStTx8+pD9QdARrzWi7qYyFClCE5qKcVU
         xg7TJY7jhnUYiNcvHPO7FFvTxdLf1L2WN3ZWn2HQAe3hprZKzhCkUFakz+tBMA92RlcF
         lFg+3mHuuKfEEOIRF2LAPskq43J+IOltuBtaj7X7FJAOSrySbAWd/Z4gyuYia99TguLN
         PnMkWU930Rg9yDQ6h11ZrXOoL48Omu8h9X0a5HUL7ZaaM1TtdT3x7PM6cDK0WeNEuCay
         hA9FQrNJzccvOgUxScko+Vdz2BMYE2oYexAHq2iqdTmCUjvbFJhEmSUqJIlRTflTsDGK
         xIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdKwGBt3vgEIkMtFrGuBx1104sQ/OZxI5mRem7H/luA=;
        b=iq+lVONJzACcwqz059e9zgoTngmfE6B1FYNlB4gRCeRVcjvM9FzYDOUaOSMDQ849j0
         PafNWzeIb9GqoE+v8OlcepmnKOcFPNQBuiNAaAWuiHfpOG4lKDrMuOEgJpvag4CPKY8C
         ZEA9kCNY0I0maGYlzuy5JKWYW41tTZoNHZ5+QuJ5D4qoVbnpfuTw3bIXMs0OzrLMWoeh
         ESxy6o5bCDm+I+2vnhk94STP7oZjCq/EG/g7amA6QRPnc3PDQIx/WVv9jbp6BTgazl/e
         AqvwZZvIezCg4xBppRLYc9uR0vvnXDM0Y6QeyIEFZJ8Phnic3qQnBq3RhG+iD2vCqDS6
         BDOg==
X-Gm-Message-State: AOAM532t6ADUP26HO7IkHKlkMsPobHnU91twO1W5JdsSbjWWdGUUWGyJ
        zApWSW1/2TdQN6bI4Fqki72NH0C0WVQZKQ==
X-Google-Smtp-Source: ABdhPJy+KHwm4tS/zT5SnmmwL9ihwwYYWTSFP8EZ49Y85mXn9AVlsDgS/j8gAC1w4xi4cTs4QqM0CQ==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr2962127ild.16.1602078809013;
        Wed, 07 Oct 2020 06:53:29 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t64sm1114077ild.10.2020.10.07.06.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:53:28 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201007124009.1438269-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
Date:   Wed, 7 Oct 2020 07:53:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007124009.1438269-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 6:40 AM, Christoph Hellwig wrote:
> Don't error out if the dasd_biodasdinfo symbol is not available.

Should this be marked for 5.8-stable?

-- 
Jens Axboe

