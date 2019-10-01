Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD077C352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F902086A
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PGOhX1ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfJAPpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:45:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32831 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfJAPpD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 11:45:03 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so49276038ior.0
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2FQ7h8PlUPexVQ4SErsdRg9fch/Ili1SumdwNo+CuGE=;
        b=PGOhX1typrW/DdFt1VNA8LXSgPONjgn/VwRLwa1RzrzsQdisUP04uuJIh89CFHHtgy
         AiK6BpvaD67feenvq/RC3zuCeeYbibmlO7sOY2nofS2Pks78qHwPoCI2l+SRELBoZ3pG
         FM//74+r/TwVUnKTQNhYWS78tduKtq3Jh9hNBx4FZ5fD54pcP3gIMly7ekPX9Mms0fCI
         tbR4LPDdNL7LszIbySMBHm7XLr2Nw8Zj/Jzzk380brULZeqrRLmN6BOi0NQ9dnHcCGIz
         oMHDsQspidge6DRWf/bGKDpDdID0ymutZ5qpcgdr8ZoYeT4d0j7JMgC4FLOf/fK8Itb/
         NrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FQ7h8PlUPexVQ4SErsdRg9fch/Ili1SumdwNo+CuGE=;
        b=RovTxwFsJWYOdbe9N/IbLZZwxwP8J8L3sIMaHGuxXUiqecdfsj1XpFK/MMIf1WUljf
         lgmRn8EZ6yjREmEtEuKdPjZMMjrhD3g5Wpayg1t1/vAlw9yEBVx9NowCD0+tVsUd7TLB
         hbrZEESbVszUWPG7iwIp/tRO/M5/bPq5gN8Cs19OU0c1CrpXel0SWlYjabQTupp66QUX
         WBpM84DMNwCcCi5jgtHk90RuwFJSaTl7NKkmX0PVEkxMygKLURoKL+/P5AQu1Lv8KpIs
         NvL0G5LTVXU02b6sQJICAx/pCBRsMUY/+gxnl8SLZZ5YKevPC5MAQaWcT+i+WHvxBvoB
         M4Tw==
X-Gm-Message-State: APjAAAXv19F68jfxIuovI+l9M6uFJ4bEuHg3HX99ecxAGtSsThxaIRdd
        5sTYIo8At+iWUOjkHNGBVSOz1w==
X-Google-Smtp-Source: APXvYqzVLqLxf6IrL3xdLHLHlgtql0RK4SaTmUAx7AzwBBaPfe4GaXN28iewATx8LVZ9doiakpovVQ==
X-Received: by 2002:a6b:8e82:: with SMTP id q124mr3144396iod.267.1569944702907;
        Tue, 01 Oct 2019 08:45:02 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm6851713iok.87.2019.10.01.08.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:45:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] s390/dasd: fixes for thin provisioning support
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20191001153439.62672-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <deaa7dff-5b1a-851f-4f08-74ab369e58b8@kernel.dk>
Date:   Tue, 1 Oct 2019 09:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001153439.62672-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/19 9:34 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following two patches that
> 
> - fix a bug in the thin provisioning base support
> - revert a commit because of possible data corruption

Applied, thanks Stefan.

-- 
Jens Axboe

