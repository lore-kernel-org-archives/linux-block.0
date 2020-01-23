Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE93C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6CD21D7E
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 18:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qrnuqwTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWSl4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:41:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35365 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAWSl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 13:41:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so1815828pgk.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hVVJiVofuq6jqT8tysqA5aMKgAsODtyC1uhbEikyAQ8=;
        b=qrnuqwTbuWLKb92ONC2CXaYTQWIYfF8DxdwKhjeaVXX6GAs7puvD94VO3ij/4IcOsk
         QliauhYOoWF4e4na4cD1Pve2IFiHHDPMc/r9o7NLl9AuTRiu7gJ4AKJYo4OsLW5LRV4F
         1IiT1yR8dcgGaLN4wfGR6Kn4vky0fGbPGMXf9Soc5VsFaWCemq0stfHFjiPn/U5KSQLS
         +wS24wFzJm21kkj+wSckN6tilYc98lc4PfKRh/EXA5g9/Hte1mxFZuaF6rBqGqIUPnpX
         aFnQaE/NxMZna4tB6oAf7PkQ4EVqDvyyj6g9Sa59qLEG+NaXcBS9/cokO/DAU/GA27EH
         Im7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVVJiVofuq6jqT8tysqA5aMKgAsODtyC1uhbEikyAQ8=;
        b=P5yGLBgmRAdkuPKcJ+EoVE7ceFX+Wo1Dynzw6BHmXIMy1h5uNjSlpQYwHHCFoB0uuy
         bm6YG1Jr90ZpMl5BA1tPCBfLHSWBE2yEq422bn3iKmMMZyyINPuDcFa29mR9jH7lO6pt
         +fA/k3eMgutYyvKVdaIMu+LIoQ2ytU/lkWPdXKE474PM2uawCd6QMxC+8KCiA883ujWh
         8c16qIhOiVAqEbzI2m+CmrPjLFxW/SWSABeMKpRX1g6e/34Qf0+z+ione4fCqZAzTjHo
         u4ELAdwS0GttgcOiSFpvH3sAf+7Cv2pDMUfBS64TPVRwkwZgU9L+RAAA51WLh5n9GeCA
         CqSA==
X-Gm-Message-State: APjAAAVEmCjyRzvLqqj+MvDdBBgfDt9beUKfyNleht5ybbRG/A5ZYBKZ
        IQPxi0M5iDKK40Asuex8HFt8ZQ==
X-Google-Smtp-Source: APXvYqxyUlS85/lEfnr4wwXVf6rmaypUzEXpVAItiquKi8D7EUEX0nSWXUwQiG3fuTzpGObtNiSJDQ==
X-Received: by 2002:a63:1210:: with SMTP id h16mr139816pgl.171.1579804915805;
        Thu, 23 Jan 2020 10:41:55 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id s26sm3520454pfe.166.2020.01.23.10.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:41:55 -0800 (PST)
Subject: Re: [PATCH] partitions/ldm: fix spelling mistake "to" -> "too"
To:     Colin King <colin.king@canonical.com>,
        Richard Russon <ldm@flatcap.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200123002921.2832716-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d383b8a-b2c5-7669-f989-4239531d3fc0@kernel.dk>
Date:   Thu, 23 Jan 2020 11:41:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123002921.2832716-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/20 5:29 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a ldm_error message. Fix it.

Applied, thanks.

-- 
Jens Axboe

