Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C636C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3205524650
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W5OFVKHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLSMrO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:47:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39997 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfLSMrO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 07:47:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so3058886pgt.7
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 04:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yW1IsyXNAje0QGXX1u9y0hF2DtFQjc7pR3jvloXZHWo=;
        b=W5OFVKHwErzq/LMoZZyOYiwu0LKg8Ab3t3E/xhT/wvo2ti0eBZONmHM6wws56BorFi
         isFWKEbVK7q/s2CUPdEqIav4T5vH3zzx/FWd7azF2zX/z/CDs5M5nxUsDAK+a21VWy1Z
         w2/DG+4wmTdVosl9F5GT+z8Y8z0xpam3uS54ZadgyZ+ArDKlDR6P8DBs+38cA67G6tkr
         0RV2lkbH+XpH1v/fOIPxYKAxk0Vn91X3kYTMZDw5gdMVQmturkKQ1VU9727LC/DkNH4w
         jWz7r8jYysH8T4Fsy6RIZEHN3KzMzFMDjgJcCqqe6vIcMMHFtcFanOqQK06chuls8GC4
         U1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yW1IsyXNAje0QGXX1u9y0hF2DtFQjc7pR3jvloXZHWo=;
        b=nwAKgAUkBhfGtPcPzdhNWYPM69QZIezP6JSpE9GhmVatgtvRxoW8EvkDZ9o5uuxxMt
         IxHp0qv8Yx5qnAtahDSJMY/3jJJ9Bou1qON6EU2yLO65OSljCbZsOiOE+mv6M2eMJZ6O
         cDQM7gNlOy3DI+NjzZrEbeRnmgaEXfMS9i5Bu58ba3mCGiMwyymzNqroVbm2iSs9/l+N
         4nqZ1vns4Hfay5ITceP20BWtF02U7n33zyTVQlr8ZGbrVpqgml/svLlP1AoOSrdnIx3D
         3he1TPD4gu0SpVODdBNUTbaLh/e6AoukhGDq++50LXStZ4Dx+xBqLLfrwjt2SLoZMjn1
         X+oQ==
X-Gm-Message-State: APjAAAWVNimVl05eVjITkhWbSdTav5Mknaf25AkcGL/ma0CwaHEOWnc8
        tinTOiQfralwgOGH4m5+6fUvfjap+2bpcQ==
X-Google-Smtp-Source: APXvYqwR+b/qCIp9sdqqkG82R1oJY2ONzlLPkIcOwPTWCccbch8FpMZmCbJqTa4q4kMvM7tHDTazNQ==
X-Received: by 2002:a63:d543:: with SMTP id v3mr8641639pgi.285.1576759633620;
        Thu, 19 Dec 2019 04:47:13 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b98sm6755767pjc.16.2019.12.19.04.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:47:13 -0800 (PST)
Subject: Re: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     damien.lamoal@wdc.com, Damien Le Moal <damien.lemoal@wdc.com>
References: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e63f8fd4-77bd-1031-bf15-b3155b262974@kernel.dk>
Date:   Thu, 19 Dec 2019 05:47:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/19 11:14 PM, Chaitanya Kulkarni wrote:
> This patch marks the zone-mgmt bios with REQ_SYNC flag.

This needs a much better commit message, you're not telling me
anything I can't see by reading the patch itself. A good commit
message contains the reason for the patch, there's no justification
right now.

-- 
Jens Axboe

