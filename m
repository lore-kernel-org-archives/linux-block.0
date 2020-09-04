Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABCC43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 16:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EC820796
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 16:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q7CFVqfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgIDQxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgIDQxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 12:53:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12239C061245
        for <linux-block@vger.kernel.org>; Fri,  4 Sep 2020 09:53:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so4604127pgd.12
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2020 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lC0AlfwmZlpXeFpa/LGTAh3XxfRABk0wlmEHVW6V7fE=;
        b=Q7CFVqfCLCtDBrZDi/ZGTtwMxmb2/Myx2mQsdKxdDh/3t33apZQYU3Iai4UApZLOLW
         ANYnA2xCpzS7qfDQiff7ZIJKCKfWvTETq897Hgx4W3m3wYLvA721kbBrQIcFinJFuRga
         yhzH/cAhqels7FptH8Qc5dNmobzyaVmwKNdJJqFVimdyTenmHo+YYiDvxB125mchBoNt
         XQofTmLKgJfcTn5KPu45URFCUvXiOsa2gAqmhc3BFw4hRYMv4TDp40gXYvVZgyqv28rU
         UbqLKx37auf+HdwMcqp9Geq4fdyk1NjHYl65+r96KX+LEnCnX8ZRjQa2xGTR+6C6AR62
         8TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lC0AlfwmZlpXeFpa/LGTAh3XxfRABk0wlmEHVW6V7fE=;
        b=X5SEyF4lzBGJs25czihC0I12i/dY4PBfzgcGTd6OkklOa69hkIWaW/Jdwx3UqKiH7i
         jpVDvZkfip8ymks/VZWhMgs08mQJs7pSkzllNiDWVHM6U9rmvyst7YS5bMU6bfoX2zdr
         2oB2Bq+EDvlhDrrccVqtceDZtJoJeYnNDHQTrPqBo1tdimJmysQXRy1vG8SMkm0tLvK7
         4HHSdVFcsg7qpWNeBa9hvbNw5EXPIzaDlovQ5hBhhB8tncf4c2kMMA4Q3LAQwV48zWVe
         Iu3HswPnq4+PvFp1i9eW/LKLpMVUqNDMvkxWjrB40CpTpKA3vH9cUjcJ1aKvOHiGUMSL
         cPJw==
X-Gm-Message-State: AOAM53371OlZmMzB4cKplB/tbvoGN6QEw+xrYgo5jkrzqtabiyYcdkRW
        VPhAeldtExNxVWKxublmDbnD6PwF72BBoTOA
X-Google-Smtp-Source: ABdhPJyvhH5BRWXhwxslu96Xy5h5enqyHsLxdiKc2cUiZyDMbeBs0eCAgFOnGT6mOyg9uccQ2aAtbg==
X-Received: by 2002:a63:4810:: with SMTP id v16mr964781pga.374.1599238383613;
        Fri, 04 Sep 2020 09:53:03 -0700 (PDT)
Received: from [192.168.1.11] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 19sm4650788pgz.42.2020.09.04.09.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 09:53:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] use generic_file_buffered_read()
To:     Bean Huo <huobean@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
References: <20200904091341.28756-1-huobean@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e857400e-f6e8-9d84-804e-88f3c34edb50@kernel.dk>
Date:   Fri, 4 Sep 2020 10:53:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904091341.28756-1-huobean@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/4/20 3:13 AM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> 
> Bean Huo (2):
>   block: use generic_file_buffered_read()
>   fs: isofs: use generic_file_buffered_read()

The change is fine, but the title/commit message should reflect that
this is just a comment change. The way it currently reads, it sounds
like a functional change where something is switched over to using
generic_file_buffered_read().

-- 
Jens Axboe

