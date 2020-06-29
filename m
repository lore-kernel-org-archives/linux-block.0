Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A22C433E1
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC762067D
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t5TIYhxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgF2Tcv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733239AbgF2Tcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD113C0307B2
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:56:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so6366406plm.10
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=th0U890eQq2i+YMi4c6QMAAurVM5oWeXTtf5cZ9rQXA=;
        b=t5TIYhxWZIXkB15IUg2fUHlEAAK49VtzU+8Q1W/RFLQKkyOVpVEzwDSirqYdcHbj5q
         c2/QcfF8VtZSYmoZGudp0miae6icFhQ2Sq2L7dVtIrB86oJ1QRPWc89Gq6z9+82Hx4jM
         uTDRu3DnjuacBtK94ixz5Ai0lv8M9DypctzFefX5wiDShfU7RnMoD2UqnNyx9DpGhu9n
         AoB5/fJqR9mUCN72sBhFDTxU79p97IjCXajbtmWe5M8QycvGtb8OfBGzCaF2i4s3CtJk
         ozlKiyFsrUn7EhdkqgpHsuHr/tfsMlmhcYWeghZxteGO30KZmRlPaTYgoadsbxWC9N3M
         3Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=th0U890eQq2i+YMi4c6QMAAurVM5oWeXTtf5cZ9rQXA=;
        b=XE1hVJfdu7En9sve0RgZa6l7AwLPH4JfQ87CRLHGV0aYaccyFOT7CGnDk59OS3+QYc
         kt+jmohrPdIFiZ/y73Q02PQz8ILkqoNjiNJfMWFCNwl6ZAp4edN7wodJBptwg8VqStEc
         jdJFaGL1BbpWV421EqvkH9rZvVi7yBgGtiCL677ZkoewX3XJhf1hoecsmhlt5tMzfchW
         tTYbeag0y12azQOc3KRpJ0LCN/HrSsVkke2CWPYB/hMpXlxwIH31XaRIhdEa3GgcMhzU
         NSdJO1l1AxICFVyQHUep7LGAsAc88UDZgL/PnEINL6cKvTPskYPsST9Eg1pFTa5mwbZb
         KVUw==
X-Gm-Message-State: AOAM531iM+SF8gHfj+/cBWG7G/j/24s8OUmvgd9xYv7sALjUmrobf/Mz
        7sIn6gGpVlFTDDkV7/zi3EH3kFdU7uB4fQ==
X-Google-Smtp-Source: ABdhPJwFUZ35sgPDvE+DjzvrFGAt9OdiHF5XNMbsO1S/wsdpFMhf2+SGerMFfuer3SUub4IsUJzeNw==
X-Received: by 2002:a17:902:d392:: with SMTP id e18mr2520358pld.139.1593446206013;
        Mon, 29 Jun 2020 08:56:46 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id 4sm201315pgk.68.2020.06.29.08.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:56:45 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove the BLK_MQ_REQ_INTERNAL flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200629150834.2699386-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82ebdc59-adc9-5afb-d70f-baec5c14a7e3@kernel.dk>
Date:   Mon, 29 Jun 2020 09:56:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629150834.2699386-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 9:08 AM, Christoph Hellwig wrote:
> Just check for a non-NULL elevator directly to make the code more clear.

Applied, thanks.

-- 
Jens Axboe

