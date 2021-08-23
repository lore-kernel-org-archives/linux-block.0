Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB8BC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5CB613CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 18:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHWS61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhHWS60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 14:58:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7BEC061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 11:57:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j18so23070899ioj.8
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1nBzSQmWWTfp042vNf+P2c8qnyXZ+jEQ/eBzrN54mNE=;
        b=BNWeCJBtBRKtRo3hSv/8sdIgYjOhua0M0Zcb+VT8TGPkrbI/iVRINV5myxJtT4EpYr
         KRIS0UpI64PzmE89WsMELu8ey1jgl/QIC2/oy31l6VghN5iw/d0Ntv8qLyVENj5ma8rs
         0FIP7M5WuO+d6q14b4u6kv2rg5Nz5j96P4zQhlwh+Mj04P6zSxuyPzB3ZFnT0Rsur4kd
         qmPSJ9YHeI1pU4bxKB/9JptwDSX1UUZ1SU+Yt5xa2FDQOzlCmY38Zr9xlMh3Uyre8TrU
         gza3MGjN8QV6vwrqbOt20ZipV+sejOqi/2qlJMS3ESNcYdGRcD6VLg5ZxyipNHEUNZnW
         7Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1nBzSQmWWTfp042vNf+P2c8qnyXZ+jEQ/eBzrN54mNE=;
        b=ngpd0GucLOme7+v4rTaqSj5GTHx1tZytI0wC22NOld3NPtHmfGvaANWVQ7sxf7kagU
         j5fQWXUBKxWmQpmo9Rqc6XKGY8vUJvP9MSvgUyhJvVaewvT8b9CsQM/vtjC74zIfCzfr
         CY9QBbhlIF5nKSd6lYFkB/v2EyljCc+5kp7x08YzYgqzG70kAQN/xQZR1I1tUgwfAIwe
         nWGH+tkhQH/jF873ZrxhZU10a1QUKBH2IDkiNOk4/0VuRgUiLQMdLFSeK/UNda5XZZ/v
         OqiPb7CmQEC/ODjRXsK4rrcWjA/5nhGMvOOYSWLGYCn+teVn2Em+OKzxfkZSr/H8x7J2
         0YcA==
X-Gm-Message-State: AOAM5312cIsFbxWBig2E+flagFPUajE7LoYVdtfornJLx8n/xTmQ3RKK
        RucDxADv22VAG6Q9OZUmEpK8iRIST0IIYg==
X-Google-Smtp-Source: ABdhPJzSs5n0A0o0D+03gPBjwCDs4uiUHM/5YvPl43IXeRv/7JloHv7QHXAzhUGTcIZQ0B3EIuK8iw==
X-Received: by 2002:a05:6638:3789:: with SMTP id w9mr31039543jal.131.1629745062955;
        Mon, 23 Aug 2021 11:57:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f9sm8964560ilk.56.2021.08.23.11.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 11:57:42 -0700 (PDT)
Subject: Re: add error handling to add_disk / device_add_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21685c1f-5fde-cb85-3bd7-4396c6042e11@kernel.dk>
Date:   Mon, 23 Aug 2021 12:57:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 8:45 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series does some refactoring and then adds support to return errors
> from add_disk (rebasing a patch from Luis).  I think that alone is a huge
> improvement as it leaves a disk for which add_disk failed in a defined
> status, but the real improvement will be actually handling the errors in
> the drivers.  This series contains two trivial conversions.  Luis has
> a tree with conversions for all drivers in the tree, which will be fed
> incrementally once this goes in.  Hopefully we can convert all the
> commonly used drivers in this merge window.

Applied, thanks.

-- 
Jens Axboe

