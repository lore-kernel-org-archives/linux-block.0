Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A6C54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3D820728
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 15:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IkWK5Iy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDYPox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbgDYPox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 11:44:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0BC09B04B
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 08:44:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so5176979pjb.0
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ExvF5yzwyh3XkPGGHmYzgGyZ3kPWf12OD0JJeMkAhHo=;
        b=IkWK5Iy9+SLYFmUdWyur4g/GcbKsctWg8bhFurjQeeu8UiEUgw7zZAY2qYDHWDzmEr
         8D8n0bLQ8b9vJggU8URbxP2/lPtks8cQ0rZ+L+YO1HuqowvzMN4oSjb1qIw8hwPlt9xT
         3ZGXV7huuVozx2Wx2gFUr+KPWoceD9eptplWp0ZBwaWUUvrayAXWw3yVJFHQHgpLAIrW
         tBLv0IaM1vx6U5epKttrtTDrrXF2RedJHCRhJnZysSMbWhzlD6jLxkIMf8ScsxOPnn1F
         5DZzMPSPBdgvpYfIBjsDj2VIs1OdZrFCEIyDeuxrdE1FnXLxFXhvulHQbKZLVSJpgM8R
         jGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ExvF5yzwyh3XkPGGHmYzgGyZ3kPWf12OD0JJeMkAhHo=;
        b=fo6eEyzxgcY482m1lmj1xZDWVnrZs5NX2F76ZgQCaampW+kVtifHHcpjQtxp+ZT9HM
         yDol4MFKTMhPQqPSmMMK9DTLz0CyDcrwjlcK6l5uOkKVLhE3AGUdDkaAR3hlynBLtjfU
         mu1LKi7bGz5PcoEze1RESTlAUIe069qcXmLBvoMNIAQwyfAYsh4rLybu18DKbi64CYaW
         IR+eBaFSDNzgJKwUdJSCXehr3mdtz/9yDe7fNJfUy+whClMPwmTV4HPpdTd6PEOfi9tR
         KOtdBvrIBzXRk/S9/8ZnyaUUWzMgL+ep3XV1VAK1NdKg5BDd9hWt+r6anvRwqmbWjrRv
         wzkA==
X-Gm-Message-State: AGi0PuYleqIAl9hS6sXeviub8n+J1Z+BH0Av4DH1T5KcCpOWkpKwioC2
        culxEmh78zFzUhci7G92PdrqPTsQb2gBEQ==
X-Google-Smtp-Source: APiQypKolYsWDC7RZQYG6YGlGGnQb+teSbVgcC2HnUxFqMx6+Rqx0MkJgqRGPXjnpuiqRo1WbBcdmw==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10mr15474314plp.259.1587829491249;
        Sat, 25 Apr 2020 08:44:51 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id e2sm7273602pjt.2.2020.04.25.08.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 08:44:50 -0700 (PDT)
Subject: Re: [PATCH v2] block: remove create_io_context
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200425075551.721581-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b415661-11bd-c16e-f369-9cd08202bda9@kernel.dk>
Date:   Sat, 25 Apr 2020 09:44:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425075551.721581-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/20 1:55 AM, Christoph Hellwig wrote:
> create_io_context just has a single caller, which also happens to not
> even use the return value.  Just open code it there.

Applied, thanks.

-- 
Jens Axboe

