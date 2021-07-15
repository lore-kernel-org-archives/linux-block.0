Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78692C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A336136E
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhGOPcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhGOPcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 11:32:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E34DC061760
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:29:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s23so7129861oij.0
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PC2VbGgFNMREyj7t2K6qMwTJqqmujTnFnTwETsTl8KE=;
        b=ZTkEOsNFqSsyfKnxnOTBkE8/wgJ/33qsotjSIS+MPztNmZ7sxk5xxqRKgMaMmufRXq
         pGXb3buYLa8d22iZc16hKU72UJKlG9BMfGYbCJvmjr/81LJV7rfAEHCXZvtF0jhc8+BX
         IsnyzyPfaqvpuHoV96ZEOhzyhN2drYCAtdRY+8buOoI446VAreXkeMWfjFBQyrI6v5AK
         xq4SDid+0zfwHALvdfzZFJFoTPp79pdCC62oZJrUfwALZNMWwQBCatRXAmeS1S/3Ezj5
         FFjN1VZ3o/XtFaV/w75AD6GlN1RX9agFPDIlFXYh6S7hb/Yjb5ZtRb8oPEb6tfAniIMX
         IRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PC2VbGgFNMREyj7t2K6qMwTJqqmujTnFnTwETsTl8KE=;
        b=rIMRKKJY7Jca4hAMjxRsYnzSiYfrprrUmzeDzZEG0cUiWyNR2xKOe2X1euom695mXd
         3dLJ4r4yLpUa8G8pcQsvBPnvMbwkHVGwS4mAz1w+gRZdXvvq/pYZq5sRuq1y1rpeBMoZ
         uidqSlEIp4rwuFCP9ov7CTLyaCUkkmKzXx2XUp9g3EhOy9B37oH7NZxqK5cpeS/eosQf
         l7/BxKqIEga6QzHwrPrkZC/wfGpDlmmVrBK05LMAxk/K4o3GCv9wsHnRNFsrK7L3Ztp+
         WazVnrETCnRjvky2VrdrrcTEbVgCzDpRZh5jCIF5rrd4wwF6+Jv46vK6/+9/EcpgrHW8
         hd4w==
X-Gm-Message-State: AOAM533jPsJnNCxiWP3HLr1as8oXoEpBNOlQTwTSXqIp8ORonXa+RqZe
        f1oS3pZG1evzh6XOK/aBLTXgIQ==
X-Google-Smtp-Source: ABdhPJxLUGGvParA/BhFVdZiL1shYP+EoD1vvgU3uqV+DmLA8OKC1ZEL3QwlDa5F+UBxM0EK5gM0tw==
X-Received: by 2002:aca:af91:: with SMTP id y139mr4048545oie.36.1626362998437;
        Thu, 15 Jul 2021 08:29:58 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k7sm778110otn.60.2021.07.15.08.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:29:57 -0700 (PDT)
Subject: Re: [PATCH] block: nbd: fix order of cleaning up the queue and
 freeing the tagset
To:     Wang Qing <wangqing@vivo.com>, Josef Bacik <josef@toxicpanda.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5668e8c-99db-e7d2-85a5-adacbd607ef7@kernel.dk>
Date:   Thu, 15 Jul 2021 09:29:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/5/21 3:25 AM, Wang Qing wrote:
> Must release the queue before freeing the tagset.

Applied, thanks.

-- 
Jens Axboe

