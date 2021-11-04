Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2905C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833F461216
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKDTdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhKDTdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 15:33:10 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39CEC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 12:30:31 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso9741625otv.7
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MeYisuq+vUW9J7l2Lr88HFx0iiLWmgDecqeDwjZ+2qk=;
        b=zuSHtViCEWnQsJsL6q/0tDVx87LUy0SMqpxq/NvvoXTYQN3B7hzy84TR3VgaFEyMDb
         /728d4PYphMiunkdXoYyo436T3+xHt9CWSmq8TpEsKfb8ENYY50lJ8sfGMe2puctoQqf
         JgopvIEG8reC9eyRaapkqpQAXXjGdFVj4yZ1fmDtBOUo0AbVbcgRs7JMcIRbaEhUfGiR
         Nyr4/ZtlLuey5bwsmNYwta4cR5onAurKy1b9TQxfkKOV+mIh6SYDGmP3+/0PrwYt1Zuu
         QWuAJqBu/1aCAeDF/W5wCaMkqYVNHLiyIq2oqcCoiXVzDmwdKWXwGz8zSWkZqCvAtcbR
         1RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MeYisuq+vUW9J7l2Lr88HFx0iiLWmgDecqeDwjZ+2qk=;
        b=8Mru3GthYZwFS5dEY3NNtbD1+uKoWKk6SjMbVIzWyFyb+xGu4x4qK8caOyt8cvAkmP
         7sSz04bv9Nck4bDyJ2LdJq3iFTs3Ik2voK4jDU8Bd+962XhvHC+33qgECGOnaForDwaB
         15BD7zNXqezxeIfSx4QrAUsno4Vl9qBfzUgeajW6+3MAvqC0tJlfUfSIHYUF4+mP01wj
         eQIf4IMPfgphv1v9ICL5iO3ynBmXgnSTUv8bPCT2To85RrI7bH0jvnDCCAvC1l/mMb3s
         YWzqNAvvBrfR0mCGbHKKrYEMpBzuhKbM4k9nYBqGJT2qMprZR98xq7Qy12GBeJD8y1lb
         U6Rg==
X-Gm-Message-State: AOAM531FCnl70QmYQ3IQaauH42rb+zorLSGjxLplHGy0y2AFIcfZtKrb
        TMKrcchriRobUxhidqhUXZedJg==
X-Google-Smtp-Source: ABdhPJxg+y91Jbc69Q+2+Q/MVoYSU62FQZhW1K7X1KyYAgqlwTtC4svfwTPJkXab0YjZpf9Jg5J82g==
X-Received: by 2002:a05:6830:2b1f:: with SMTP id l31mr32042959otv.333.1636054231348;
        Thu, 04 Nov 2021 12:30:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n10sm1748848ooj.42.2021.11.04.12.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 12:30:30 -0700 (PDT)
Subject: Re: [PATCH] block: fix bd_holder_dir kobject_create_and_add() error
 handling
To:     Luis Chamberlain <mcgrof@kernel.org>, hare@suse.de,
        hch@infradead.org, wubo40@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211104192959.2355827-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <993a116a-72bf-9304-1577-3f2e4300daeb@kernel.dk>
Date:   Thu, 4 Nov 2021 13:30:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211104192959.2355827-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 1:29 PM, Luis Chamberlain wrote:
> Commit 83cbce957446 ("block: add error handling for device_add_disk /
> add_disk") added error handling to device_add_disk(), however the goto
> label for the bd_holder_dir kobject_create_and_add() failure did not set
> the return value correctly, and so we can end up in a situation where
> kobject_create_and_add() fails but we report success.

I'm just going to fold this one in, as it's top-of-tree.

-- 
Jens Axboe

