Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432DBC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E84207E0
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1CSg2oZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfI0TSq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:18:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55456 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0TSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 15:18:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so7107340wma.5
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ow1TJdn0wU/PNvtjCyUuemBEiSzz/wD4mCwzclK+jE4=;
        b=1CSg2oZbMen4+lKMUxzaYn6bDfZbuRwQO6MSThdXL9uKza2KMExYFMpW43eVMdaC23
         sEQeAd7YAYrL85AphrfaIuL2lMK2uJDWaIhlsuvOOgVLULJAfVFkLOK3zUbnpiToAvLU
         4br1ui0eeic0KFKSMfgjLoLK/RIi6eqeLnO/QQBfAQWMystTjYjsjyi/UZzkIt0q/OFN
         hgCBYMpphXAYONSIc0vGOwpqZJj1Syz4Z0vn6U5HHagpjVLqXlV68lH0iE4kyvi5VnJE
         oFTHtSr8U6Yb9LGnad3pXJIuHSTp1wfMsQ8kap9XG26z2Lduu0xcvkxBr5dCwOx9EpCZ
         URSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ow1TJdn0wU/PNvtjCyUuemBEiSzz/wD4mCwzclK+jE4=;
        b=R7xpGZqsEBTtvMRUBpwJTTCODr6z5H4xAk2WwmH4ZR5vSjYkYe9Md9YbbPir/31xrw
         sHA7gsRsDlG0/V40FgSBsfSTIENjVM0h+G3y/TH0qC5dggCdoDh4On3MEklYnsYXidMS
         x9wutDJSkJ0r+ki4zDBKaIrLiCnsjPXvSbjau3KZ3U15ieNb8QgwANHTpCSKFQd/F99C
         sULSQUN9rrhDHY/lL4X8L8HT83RFYQSDwrL32BFY1gMxX5xLLSG4CJjWIOuFno+I5vGk
         i98WZpJxuHxFDHael+cMGL0SG4LvFLku5NORh1FVyX3W4R20q3mdawM8GSsq6LBWGp1t
         LWEg==
X-Gm-Message-State: APjAAAUzYDbQh1+JG5Yb/k9nKEOfoa/2EgDFY3YiPgGUQMoT5EyWAgTf
        kc1VvB1+Qhl/ppWQmPwCaXhwiQ==
X-Google-Smtp-Source: APXvYqy+DB2pKLFOKCCvLDcFv/gFHFWMTek4vUq7c5TH1yiEsm1E0UXCZnuWa3GhtpxFNGyIR7VxBA==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr8149712wmh.155.1569611922524;
        Fri, 27 Sep 2019 12:18:42 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id v8sm3964262wra.79.2019.09.27.12.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 12:18:41 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for kernel 5.4-rc1
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190927175801.12900-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d599517-dd43-6f40-a605-86fe011854e5@kernel.dk>
Date:   Fri, 27 Sep 2019 21:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927175801.12900-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/19 7:58 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> This set consists of various fixes and clenaups:
> - controller removal race fix from Balbir
> - quirk additions from Gabriel and Jian-Hong
> - nvme-pci power state save fix from Mario
> - Add 64bit user commands (for 64bit registers) from Marta
> - nvme-rdma/nvme-tcp fixes from Max, Mark and Me
> - Minor cleanups and nits from James, Dan and John

Thanks Sagi, pulled.

-- 
Jens Axboe

