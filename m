Return-Path: <SRS0=/IjG=WH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8BCC0650F
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 03:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74C3208C2
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 03:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QHCWuK88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfHKDpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Aug 2019 23:45:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36341 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfHKDpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Aug 2019 23:45:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so48085806pfl.3
        for <linux-block@vger.kernel.org>; Sat, 10 Aug 2019 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxzWz/evQ1KsQ7ZftF2noWahcKKD/r51cymtnyUFh/o=;
        b=QHCWuK88duzxNb1RruZ8h+Nq0sfYe+0VIldOWt1zpmyhoM9Ksf6Wn1fSKS/xFaaOte
         BoWUS4Bi+jLdJ6NDyX5BEUvz17nSZRCUGp+Q4LRwYImFhHbrGCBGGwKWhds8gQSimVnx
         FkykqNt7ZzMbqAYVsRDdzT0KHSSMGZ/HIQUZsryvq+JDZEVPgkttedvoGgqwArsyunpd
         U2Dgj8Von15/QYwn2ApS9zIDiFcyS+ui4NrUR+YizXRRB7fy0lP9GteYE8kENlMN+/3B
         JTffKQ2DPVLQ14RWALEy1vxWW5MgrTYQVzfsBzTQarvSt5nOkmNWELLKR5YheRRjzOWm
         xNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxzWz/evQ1KsQ7ZftF2noWahcKKD/r51cymtnyUFh/o=;
        b=kJRlWGIyOWAOpaIfjy2Ms8zoYET3oOvvB3o+ZzFHuM5mi81Hu/pFWv256avTZVbYlQ
         hXCopG+rYlcPHgsmUyBvbxkjiS62bHVhTThI62DeOKpWPz2Kq9LUddJN4oM9l9YAeLc9
         9QmaXC1lOZTOz0vIwrRZUX/7aMoNlAaeVy8rEOvNKIS7SE/R8+wb7oMTrqrp0Q2tw7po
         1pzN9lTAo5VnpkSwjT2ducjP0wpMdnYAN4yYowMTGRBNxGSdViEdJy0Pme5bHfWGvQby
         CAwK64lIeJOo7EjA99eQ5I+PAeXS4jLC2Y164Me/VmarnnGwfhTHm2l2yWHCV6rnYlp/
         M56Q==
X-Gm-Message-State: APjAAAUxmkzokOZXg6XAs4aTqhAspZdlp/ESNEnsf/qtq5eKv1Tv4ONp
        Zispx4llgiQqX89fr1peTq7TLQu4/I3akA==
X-Google-Smtp-Source: APXvYqwPMjX24tCM6KKd9JGf4kt7038iq1x/QOBltsToAl3AJ/6eENg8njP4X5lsjQyZlg5EfU6aOg==
X-Received: by 2002:a17:90a:f0c7:: with SMTP id fa7mr4542834pjb.115.1565495149853;
        Sat, 10 Aug 2019 20:45:49 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id d189sm9090996pfd.165.2019.08.10.20.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 20:45:49 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: remove unused variable 'geo'
To:     Anders Roxell <anders.roxell@linaro.org>, mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190810073936.28700-1-anders.roxell@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3827599f-da34-c226-8183-0c3807a46d6c@kernel.dk>
Date:   Sat, 10 Aug 2019 20:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810073936.28700-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/19 12:39 AM, Anders Roxell wrote:
> The variable 'geo' is no longer used.
> 
> ../drivers/lightnvm/pblk-read.c: In function ‘pblk_submit_read_gc’:
> ../drivers/lightnvm/pblk-read.c:421:18: warning: unused variable ‘geo’
>   [-Wunused-variable]
>    struct nvm_geo *geo = &dev->geo;
>                    ^~~
> 
> Rework to remove the unused variable 'geo' and also the unused variable
> 'dev' that got unused when the 'geo' variable was removed.

This was fixed a few days ago:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.4/block&id=f0e6f41669d9e07f45b472e4de33d7c233a847bd

-- 
Jens Axboe

