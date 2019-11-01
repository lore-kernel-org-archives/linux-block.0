Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D905CCA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA95220862
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g1GLnDVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKAOhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:37:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40674 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKAOhH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 10:37:07 -0400
Received: by mail-io1-f67.google.com with SMTP id p6so11126428iod.7
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1rbnpTyGfeZpN1pWkk1MYpYhs/Xr++6zuoFV3yNkMJg=;
        b=g1GLnDVLH7nCaw+BucVNXOfEjzvmOkqZkZaB2mCPrpoASzR0dGwpcLYymYLKMMf88O
         G5ojL0gwkVtsaXKxkTHQm/82SI1JCnJSvv5RZEVgq1Uo3VYDhb4W08LAR2CPgbBpWA0v
         vipMNLhkQq+GKjFgFNUrYvIEI1qc9g5yMPcz48/OoCxw1k1s5llnxmYagDIUmsPWucXs
         3L242vC1sDtGEO6lMl1DEMEHq48IPZGQcvaaTJkd4tqdxKD9INseSQsg5b1mHDZMlzya
         woz/D2Ep6QLFXIcKay3a9k/6WH4X/405BI0Z/Z6Gju3uvCNTFlgGacDzrLO+BgxpSprE
         fU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1rbnpTyGfeZpN1pWkk1MYpYhs/Xr++6zuoFV3yNkMJg=;
        b=ZcVDPgMFJaW931tDRC5L/vvHwUxnBQCcxB5X8q45IJn9uthQEgCsJoDXrD5Egarler
         A6LhFjx0DIkFpF0lLTVIWS/lIZejuCC8ZksE1E1fM/bZlOSUKLmAj+BaWUyF0PNgbH1S
         VG95kuIrQ+cW9iLP28EAJW0D6bFtoZyxdzc6BjmD5NenhxFeiIs1Pe0BiLerYfYiuE1+
         C+45FBDg3hbqouwAkPH9VSxNLxCRmqPnil1aYUWyLXoxc8iAwJG88Tr7kHTrdrBizVEE
         ZuYxsohB5SIwbLbFPzd2OT7TROOha1kk03dTWbJ7a9i0pfdN5Cynw7dNRIvkkS2COLPD
         nxlw==
X-Gm-Message-State: APjAAAU8BgIZ+N807QlP/QyKhqpxVlssJTS/dMBStMu/T9SVYmZ+lC+8
        mRApuEspcZVdWNKZMgPtanc+BoNkirn6aA==
X-Google-Smtp-Source: APXvYqyeHNt6rsfmO2+OGxB53BvwD77zNtre+8qjW8i/1hiyUy0CGKryvjRCn2UaCoScge7lR9XcNg==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr10866089ion.70.1572619024511;
        Fri, 01 Nov 2019 07:37:04 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e18sm1018609ilc.46.2019.11.01.07.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:37:03 -0700 (PDT)
Subject: Re: [PATCH] io_uring: set -EINTR directly when a signal wakes up in
 io_cqring_wait
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1572319002-9943-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93057b1d-f7af-c8aa-3c4b-e63455a6f163@kernel.dk>
Date:   Fri, 1 Nov 2019 08:37:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572319002-9943-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/19 9:16 PM, Jackie Liu wrote:
> We didn't use -ERESTARTSYS to tell the application layer to restart the
> system call, but instead return -EINTR. we can set -EINTR directly when
> wakeup by the signal, which can help us save an assignment operation and
> comparison operation.

Looks good - patch looks like it's against 5.3 though, I've queued it up
for 5.4 with a bit of mangling.

-- 
Jens Axboe

