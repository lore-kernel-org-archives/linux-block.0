Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA59C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbiDSLob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352175AbiDSLm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:42:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE863982C
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:38:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso1591805pjj.2
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=czltG6L2KkzB298LugAHRvgCtEThwrsgoIBIYbL/lmc=;
        b=mW1t99Tzzl//v4S6OsIZ7O7aaZ27kcJSkc7NEWIWcO0Uoau39paOP9AC0VwPLHYRb5
         tpKKIw0Q9Nmgbw5YNVW6j3mXEoZ1v5iq1Bgy5gkuHL1FHL1Uv4VUqKmo8MMRyXLJ2s2l
         IYYWiiVAlhU9OPfjBfqRdaZgckD4p8CCtXeyKrG7KbHCtgElYH3AhBxRn1JZkLD5jWyt
         09iHSLgBekvpDrV/9nzTh0Fgf6N80F5g/WSS0Hy7JV+G/sjBma9yPQWpmegzyzShyB/D
         vg/aJ4mrOHhf4C64FGNVB5IXt59uRqACzfB15PihqDViFiC+8VikE3d7Ay7JTtA6YXKU
         r3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=czltG6L2KkzB298LugAHRvgCtEThwrsgoIBIYbL/lmc=;
        b=PNBPPVmu1sO+86Wj0QC2sY10BKFGu0thuPNj9qa/OMNl6/+ULbCPgdI/Zw4Nm/AyK9
         zRce+D2AnxDqoyvVQTWsNpeuIsTrIXr1woLFWxRG9W1ogxuLX0xZZCd39XLHl8bwxwdb
         1JLB64NC44ZNKJFUtIr0xWjKFIT7e+ocgyM5zejQjmnrA2/zcFZpvdS7Yhbx+XP1LK8g
         g270skiJzQwnBJGdHEfU5/F1VB6kQwN5gx82hILaBt+rBhKkJt4jxgadGBm8ocXxXhQr
         V42Qg4deBtw3ICjPBSd8vhtfJcmSIBHVcUq61tBwUABa+23r0Kwp7639DdFrZSYLoasf
         tr7g==
X-Gm-Message-State: AOAM531eARTyK8/RbBCPb7kMPOg2jAiwS9EVjh8bjg3TLXGwfRi9DxCe
        pxNjZIhXVWJwtCyc02QDlxvK1A==
X-Google-Smtp-Source: ABdhPJxPAhtfomWeKdsxGXDr3c7zmgNdpnPo++Q7ZHAGZztXONhhmeU6M+A+FPJddomQbcFHtuZPTg==
X-Received: by 2002:a17:903:22ce:b0:158:f809:3116 with SMTP id y14-20020a17090322ce00b00158f8093116mr10472507plg.159.1650368312542;
        Tue, 19 Apr 2022 04:38:32 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l15-20020a62be0f000000b005059cc9cc34sm16311856pff.92.2022.04.19.04.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:38:32 -0700 (PDT)
Message-ID: <77dd9800-041f-edee-4ab2-911dc311466b@kernel.dk>
Date:   Tue, 19 Apr 2022 05:38:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Drop Documentation/ide/
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20220419011021.15527-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220419011021.15527-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 7:10 PM, Randy Dunlap wrote:
> Drop all Documentation/ide/ since IDE support was deleted by
> Christoph Hellwig <hch@lst.de>, Jun 16 2021.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

