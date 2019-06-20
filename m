Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6E2C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5568F20656
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CKKHZrXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfFTJTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:19:19 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45083 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:19:19 -0400
Received: by mail-yw1-f67.google.com with SMTP id m16so864678ywh.12
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QdjD56MgVXUYBO6jnMHiFZNNgOFJE3xLcc5gtNhLG+w=;
        b=CKKHZrXCl+aTE2zSwfeXeWqfsgEI1neBHlzaeahsSdz7FXUD54S+diXPDoiZHYh0oS
         Yrkc6TUuH3/ivQniE1YNh0z4HYeRvpPUEEhW0JuS96SF69r6RqsPLVpq0cscUjwQws3T
         7obc4tyE0B2PqBGrxgUAblVtJWFQ3dR7dhi9lSF0sOO6BN1tbrVKMYSDdrx2VyqeTKJY
         wjATb0Ex1pEXcxpBQ82jvVTw0G2iJaIcfQXkv1Ji+uYjIos5nU0PfjUauDz6wJ4IWxwF
         kx5KgHOx5aZ3Wt/HvsBJmsBbCsUdpwdzmZfpvlzSgyV/PhU92ePDydFypITUHiDH1+xv
         /UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdjD56MgVXUYBO6jnMHiFZNNgOFJE3xLcc5gtNhLG+w=;
        b=PLK4VUHcqGGUWIfbAY1FC9nAJQ0CaLhs3sx6Y82DUX4dZDTx0uqKvuaKgLzF1yH4Rc
         KdqjUiHb8Z8dt97vhVl6nJ0w8qkNDS57a4vv3zGCA5pSkYOhrvT5gpKB086RGRcGrJ1j
         /+qee0PdvSaUsVemNwlkcOudRtL/YrJ4ctkg6JkuPpZk69/tvJNEi1J5NAY8hJHAO70x
         Xnye2O8tqohOuM3TbC8ILSISJPaaH2FaKnrVlSXo+i8DAD8AD96p3uk/goMOCsfmXRnM
         UvKALjVY1qMKR5AZiGPwnRz2Yu850Hz4anvkHQUKs9eiqN2g44zgE3eN2dQOuBtys6Us
         Bqfg==
X-Gm-Message-State: APjAAAXWh1Cop1gNJvrjWqfETBGqx+cnFiVpKclRq/QPW+Vto8AgeSxY
        fUMq0lni9ZbLkFa/ta2ri0Nawtg/FzfxaDWI
X-Google-Smtp-Source: APXvYqyRGcalI5aJSZpvVVIzmIPM5d+vbXz9XvIWLR6ruJjTI2pTUqpzoKHj1xqzlth1L2gF/iJGUw==
X-Received: by 2002:a81:4789:: with SMTP id u131mr66853790ywa.14.1561022358631;
        Thu, 20 Jun 2019 02:19:18 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id 207sm5387243ywo.98.2019.06.20.02.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:19:17 -0700 (PDT)
Subject: Re: [PATCH] null_blk: remove duplicate 0 initialization
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190620045658.3662-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3ff53d9f-57a3-d659-9b84-970dd384e487@kernel.dk>
Date:   Thu, 20 Jun 2019 03:19:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620045658.3662-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 10:56 PM, Chaitanya Kulkarni wrote:
> In function null_add_dev() struct nullb *nullb member is allocated
> using kzalloc_node() which returns 0red memory.
> 
> In function setup_queues() which is called from the null_add_dev(), on
> successful queue allocation we set the nullb->nr_queues = 0 which is not
> needed due to earlier use of kzalloc_node().

Applied, thanks.

-- 
Jens Axboe

