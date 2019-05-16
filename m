Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D54C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E614420815
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w/tKRjyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfEPOtM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:49:12 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:36855 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPOtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:49:12 -0400
Received: by mail-it1-f176.google.com with SMTP id e184so6732309ite.1
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=22/xjhesb0GBWqJDCdK+0hk00XLqImYJHZjdTNaPt5U=;
        b=w/tKRjycacC0XNhoaCzk/KPKnHYj9xXuN48bU2MIRvikGbC2KcczE8KunPijFSZDUH
         HVBzis6Y6hW+b40Qp4GXehJh1tvn/2Gjx/OwhuBrIJcVpZ3Ox0vnsI4qQ1ZgLypMtpLY
         Tu1ztr5RY38rbmUC2Yr0PS7SgG7z8YP+NUzIHoH3iWcXQCHfnNuaKgr77gi4AWnbcsgH
         cwnAjtN24T4R2gBx+6gr3l2lpssH5zXZjHy4ayv5Ax5ucvW0vrZGXIk2u8ELJefWg4Bh
         OYtFPYj7plg1cKbuRYMgG38kbNgc9wvZf8DvCjg6UUVGAp/4+GTbgtTpnUD33IBr8xTJ
         U7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22/xjhesb0GBWqJDCdK+0hk00XLqImYJHZjdTNaPt5U=;
        b=fJZyf5w/TW5yjc6LJWjek/qguMMKtvggUKmffaUjNXkzS8DR9luI1lOal5lPCSRMQf
         K/5W2rOGwv+3DxChsZsKN57XBe2/DmqMFkW2aI2Fre0ug2ifopKhg7KsBWJa6t68oljN
         g4UHbbK7yf4D7JFFmwVA/ZFfk2KyUBG2jSHHFENvO5/grGJrucQp0Vbq06nu2AJIj1aV
         VgoThV5xBvy4/VtUZ1gngeA31Qh0Bn+rZD3DBKHQzcCfPXcDR7sT1v3wzqHWG44izMDK
         LLTry4IvNc9q6sBPK5ceVtBvQw9qTZeDyBCvSD5aOm00Zey6H5UVUW6HEPu3/sobtU2V
         BkCQ==
X-Gm-Message-State: APjAAAUUBtXfQ1Z1BsNv56xJpSU5AGtUhsAhSume2iBArR5UVbLiGXe5
        8frO4LYrQOsd9ApP2SLM7MAniiqr6Mhy5g==
X-Google-Smtp-Source: APXvYqxugJd3u6C/3qehCg2h08xVvKQjfq3JRo4CcTHx83sIr3J4NSMpPSqNl7iwuRVTmnDZF8gKQQ==
X-Received: by 2002:a24:2490:: with SMTP id f138mr12674785ita.111.1558018150829;
        Thu, 16 May 2019 07:49:10 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r6sm1653556iog.38.2019.05.16.07.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:49:09 -0700 (PDT)
Subject: Re: [PATCH] block/bio-integrity: use struct_size() in kmalloc()
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1557910339-2140-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4e5835e-a2c5-40dd-6658-32f263a2f003@kernel.dk>
Date:   Thu, 16 May 2019 08:49:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557910339-2140-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 2:52 AM, Jackie Liu wrote:
> Use the new struct_size() helper to keep code simple.

Applied, thanks.

-- 
Jens Axboe

