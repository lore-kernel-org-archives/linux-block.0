Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E42C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 09:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E95D64E9F
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 09:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhBHJtJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 04:49:09 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:36623 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhBHJrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 04:47:02 -0500
Received: by mail-pj1-f47.google.com with SMTP id gx20so8482531pjb.1
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 01:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+5lag2Pu6I7LiNjAlkA3XIIi+18BqMl/gWMUP4PB43A=;
        b=DGDt8sByMkDYmmF1pHeu4T6cl3hTCtPxboeoTAo2jfurLbXKEy9ISbdyVHkFDWzdt1
         Xm0gwTHtUfZdL0X/0XoY7nxOJMSKm+oCfsGgF3Pl9j9HIT6LRKH+JYgjef/FjCwSaOeG
         Sx0lhD0JwUjhALF1uecDeXWNuz56bQkAypqf5ltKaidJqHAQF0IH5eUU78E/n3OnSEf/
         3D3AU2G9Z1pd6MrgLCI6fAqQTMGOXSbOVgSXWzxsULhVv0yAZHNvPcmZ98ewUz6/4VlG
         Spi+u5MnFL26SrxE99G4mPxQFJwXEr8Ac8ICBJgv/1U92apm0Z4dui/LQJvTGfSR5tg9
         H/3Q==
X-Gm-Message-State: AOAM530kAmwtRenWeglCrGyrU4xAMja4veLfdmPy6yEQLrxfzjVNs61T
        jYJEAaaSVV7nnYRVk8EaIx4=
X-Google-Smtp-Source: ABdhPJy8xQLPSwWLgKj+ORWAdbX7wyFKae7Xnn0rh4IR5FnLBcnBgwMyNw18lwvLuxv1Aj5O+MLVyQ==
X-Received: by 2002:a17:902:b485:b029:e1:916c:a4d6 with SMTP id y5-20020a170902b485b02900e1916ca4d6mr15412946plr.57.1612777581324;
        Mon, 08 Feb 2021 01:46:21 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a769:ced1:851:e710? ([2601:647:4802:9070:a769:ced1:851:e710])
        by smtp.gmail.com with ESMTPSA id g5sm17831358pfm.115.2021.02.08.01.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 01:46:20 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
Date:   Mon, 8 Feb 2021 01:46:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello
> 
> We found this kernel NULL pointer issue with latest linux-block/for-next and it's 100% reproduced, let me know if you need more info/testing, thanks
> 
> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
> 
> Reproducer: blktests nvme-tcp/012

Thanks for reporting Ming, I've tried to reproduce this on my VM
but did not succeed. Given that you have it 100% reproducible,
can you try to revert commit:

0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter

Also, would it be possible to share your config?
