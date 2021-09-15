Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9578C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 02:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913C161248
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 02:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhIOCFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 22:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhIOCFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 22:05:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F76C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 19:03:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h9so1251292ile.6
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 19:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfbBmk1hXvwnt129yEpMuT3B4Vbqd1dsVyXuZTAuS9c=;
        b=vkBY9eRS7RDyMYJVsExVMd1O7QTSKd2mYmA5VTloMhK1YkJiXeUSjNNCQYtkr8pSnM
         mCSIanIb1fAT7aWbCtl859dwygxCVIB7k2UyFD2dcFbwNIb5pjpQhEcEWdKQWNGkYDll
         Ma1tCtPjdqM0UlhNzxrUxAq9DOBBRI8oITpxVifvTPYShbN5ccq5WLq4yMLG5UXWG0mQ
         8TtGk696q9PyKUiOA3lv9eo1rmbIU6e/Roe7Bbd1yFHYe/NBSvWILhE0ct8wYsDw8zx5
         c00waGcpgzVdYqjMnw/MnZvIn91F3HBWxhncJvP8evuHT5ezS/VrAkbDYkr3qVj5xN4Z
         f6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfbBmk1hXvwnt129yEpMuT3B4Vbqd1dsVyXuZTAuS9c=;
        b=3xR3wkIqhI2CaN9KWlaG4Z/JyIgDs/llAFUgVbg/KDUH6Gx8Yar7RTeayPsnfPHXOD
         6U/tanQ6CnrhFhAAnuoomz1C7IXVq47e+k7YdvPcWh87ouRkopjpEnylV46cQBC6mxUT
         IwmwMZPB37OiKTxTOks8twJVpppKO1yRD5NPWSPRVQDrbqxMeZV8tv8YonGnl3zcRmwn
         rIhCuXSXo76sidy+bte4Ln6DM50IuBTSaTPSnRsjzTwg4PqgNprOt2M2ulbo2cCYB+Hn
         ZB2bMXTDkkiWozbnwQu7PXQ9XwwogULfVvcRaf6jCdGVpRPozTDkWdtveCLR6uhAvKNe
         eUfQ==
X-Gm-Message-State: AOAM532Ol1q7i+4gQ7+iTTmDWAy86Dv0NxON7nRKLoIVpA2mgbXKOz5G
        3FBK9fDY10mGpvHRaMJYgFKpwQ==
X-Google-Smtp-Source: ABdhPJywR6KZf7KbdFZ5ajpI1VT37AnlhnZ2JpoIcsOvCgyRF4LIKXKG27hrajJ9i47y64jATrpyBg==
X-Received: by 2002:a92:d0d2:: with SMTP id y18mr10650885ila.80.1631671433703;
        Tue, 14 Sep 2021 19:03:53 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c11sm7615757ioh.50.2021.09.14.19.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:03:53 -0700 (PDT)
Subject: Re: fix an integrity profile unregistration race
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe10467b-e45a-7c2e-433c-f52ef9b02e09@kernel.dk>
Date:   Tue, 14 Sep 2021 20:03:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/21 1:06 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a race when the integrity profile is unregistered on a
> live gendisk.  This is a slight twist on a patch sent by Lihong, which
> I've taken over as she is out on vacation for the next two weeks.

Applied, thanks.

-- 
Jens Axboe

