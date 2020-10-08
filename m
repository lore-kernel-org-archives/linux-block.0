Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5703CC433E7
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C97221F1
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uTcjROP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgJHQRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgJHQRb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 12:17:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEEC061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 09:17:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so6843864ioo.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKt5sARbaeBXD8SOAPswCPhU8AGRqOPEdIpYITIFbpc=;
        b=uTcjROP5kCykWunpt0CCBXWJ/L3iIcpcUyxdl6arX84OxXF3JdNtNwJhbQ//GiXO0d
         uxdkL5S0GXLmOFTFf86uMvQfh0v2sVtmfl/D/vOCXvsddrLUVtOB98+64p9RYQ1vMyVk
         ZDUCOHbMP8BlW6C2exMOZbQlNvWFfJQHsiuQHwyzJHojlUktINJHvFq5uKA3b1anJewX
         RQkK/LUW2GEUXXiDlSc8U/ji057BjziIebSk8x4gOhsBiAygLTXmcCEnR4eMYBg3vG8y
         Au7aHH0isC7b4XDx8M9tRSkIl7uTnxuX2D1MWqW/oK6re/E8m4bchr7b1H2elQiuKICZ
         ZfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKt5sARbaeBXD8SOAPswCPhU8AGRqOPEdIpYITIFbpc=;
        b=fRd5YIariH+XRakw1FvWCvIiHH0bxhYvpbdKWyg/x1SZHzhzT2/L+HOC50piwWoCN9
         9ALvV4t+58aQAHbVQGDrC9bofcoPzpvEOKQ48kQ431P7+qtgqGH4tT9eeKe18ir8i5Jj
         OiAtb9cmZyGcNROjzccsvfGzYPlcpTXhqlFHXUk+1JtSYtLvTqeWNLxIKdviLm1yQa4B
         +VvCvfDBixMb7CyDXQm6MHPIm8lYPq8rM1Yz0ca7a8pU2MX0o0z6RqcBwEMmpvol4m03
         pQiCNvOWTPdjmThmS06v6e3mVI/tC0qlJ5IjOSELNcLc0Le4J8+sGTHk6lVNO/VF486Z
         u/YA==
X-Gm-Message-State: AOAM5316YLVWCHgCOZlAC3yNq68tNdx7JA0YRaIB6hceMotyaX774qiD
        iHNjzWeo1bfn4Ey98nRt6ujOxbqgXz5nMQ==
X-Google-Smtp-Source: ABdhPJy/lHH7Gvjz9pqKYlY4lzuzEYxBRUUj0g3Qttib3Hpze9ZqluaiBh2km0pCvRd1LAk81mdBEA==
X-Received: by 2002:a5d:9e16:: with SMTP id h22mr6469555ioh.141.1602173848935;
        Thu, 08 Oct 2020 09:17:28 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w78sm1259384ila.85.2020.10.08.09.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 09:17:28 -0700 (PDT)
Subject: Re: [PATCH v2] block: ratelimit handle_bad_sector() message
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20201008064049.GA29599@infradead.org>
 <20201008133723.5311-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <977fabb8-b049-a36b-aed2-dacae694049e@kernel.dk>
Date:   Thu, 8 Oct 2020 10:17:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008133723.5311-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 7:37 AM, Tetsuo Handa wrote:
> syzbot is reporting unkillable task [1], for the caller is failing to
> handle a corrupted filesystem image which attempts to access beyond
> the end of the device. While we need to fix the caller, flooding the
> console with handle_bad_sector() message is unlikely useful.

Applied, thanks.

-- 
Jens Axboe

