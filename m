Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B11C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E1161AF8
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 19:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355335AbhJATgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353675AbhJATgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 15:36:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5023C061775
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 12:34:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b22so6971003pls.1
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fuyqMiFJnUGhQHWGFhMZy7JP08f5bW+jHkKZjbfvO1g=;
        b=AEtBHBrOGEINot1qkvJQI4GRy4yyHRSPLRGcvsVPuhnpweQhNqvGce4L6WAHKsLcMV
         Q+YP9IYnju1wzIi5Xz1k9qYFy0E3PR7e92Tkq7IwTAepCB+1qxklluhbRrenlPwkst1G
         BNwCo9hMw8jYbsfAQxWVL2yFQe6fAk8kvr8xqeF3qRjBmGK3dOrnCyEu7UmD44k0Bho/
         0S6W9NoyhncofcXUOyTgtaDq7Sikt4rqj6TwrSKMNsavPVk49hvLvkml9NX1Ctnjnjux
         V7Zuwh6AsxHz/WPLUPMWtVkB3UjsoQdrj5KxyMVVSGAjrMvFE5Eg/4zk3kHwmnr31D8y
         Y80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fuyqMiFJnUGhQHWGFhMZy7JP08f5bW+jHkKZjbfvO1g=;
        b=XR8pBksKplC8/yDbZjVy6yNd+M/sGkl8c1eTw5xjhb5vwWnOn/5LwD+3M9QTIY7iMz
         nO37BnzCn8Ja4M7diDzk+/sX5g4O6hjOXp3BiIUPF39vZJEH0RUpI3wgGbipXbR/sdq4
         nA0iI6ZW6sRz+AqX60q64u/tRKG0H4WkMOqKRDHAiNKdCLHzGoUNO7xAqrNH3B8GCkOC
         zYF/elo3ykEoALTeNVlZV0tQxzoclupopBp5YPPnw3/GKsykxu25jMZ8z6Va1OiGx1FH
         bpmD+WX2oTxElodgbYSDwKPiFKSTYFSAadn+kIYK9qa9MFtblNaSDI9b5yqQoPf0+t5Q
         SIJQ==
X-Gm-Message-State: AOAM530Um09jNisXZQoRGEvffReCUPF8LNQkXvyjJqiLHphghl7SV/Oq
        b85G+9PPUo5rywi1xpHM3pBZgA==
X-Google-Smtp-Source: ABdhPJzsEovtPRet63z1mHrmopLak0VlKuvKZWeD54AE4Mc23RVkwIqZYe4cMkHLoaUM2jIZICEwYQ==
X-Received: by 2002:a17:90a:5894:: with SMTP id j20mr15521193pji.82.1633116863307;
        Fri, 01 Oct 2021 12:34:23 -0700 (PDT)
Received: from ?IPv6:2600:380:4a74:fb92:622f:875a:688c:3102? ([2600:380:4a74:fb92:622f:875a:688c:3102])
        by smtp.gmail.com with ESMTPSA id d15sm8751501pjw.4.2021.10.01.12.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:34:23 -0700 (PDT)
Subject: Re: [PATCH] pf: fix error codes in pf_init_unit()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tim Waugh <tim@cyberelk.net>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20211001122654.GB2283@kili>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f094b67f-546d-697a-25ef-10448e24c70a@kernel.dk>
Date:   Fri, 1 Oct 2021 13:34:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211001122654.GB2283@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/21 6:26 AM, Dan Carpenter wrote:
> Return a negative error code instead of success on these error paths.

Applied, thanks.
-- 
Jens Axboe

