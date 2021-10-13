Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3959C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9742460E0B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhJMRs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbhJMRs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:27 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01545C061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:46:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id s3so648893ild.0
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PtrnhfuIdMNZh2EeJx/AgwU9YutKc0Vk8xVYQP6XTCw=;
        b=4OGITBhQu+wrHQS2Qap5ddG1NN6jJqtJNOFah6b6FsopHpGo4OMTCxaJvchqZ6E01s
         CTQZRmue2m6WEaFd2TdoYE44H2gKM/3Ltu6q/CZoGexJCtHkV39PVRgbC8WebrSf52OP
         yWsXjbVIuvhqSPnkqHVhFvCeeq8X1HXl/e863v42mUB9W33zm1d96yiqjsTaZViJMu7G
         XuZvEDXN3HRe3IZdp+8xIqH5gLgiejFUZkJytb5XFB2u9yyVk45enhw4+DsbJzKF+MVw
         531OYD/s7+mw3fDE+PhvHb2hN+7YKozwMmKMJq0XqI5tvmQSxaOvXAPqdCrEItJFWurp
         qi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PtrnhfuIdMNZh2EeJx/AgwU9YutKc0Vk8xVYQP6XTCw=;
        b=4Rsx4rSjN7LhWXc/nopMvdl8PiXO+yuz9ytN1/n3TWe2sFjNfB+TjKBwTjBIh24YzG
         VB6pjgoybH/EUXCbcp/NMmwXGnHdqRLIzJhiBvcpn09vcPInsq+reVgTlLZgIfWCUQnQ
         DuIvShwD1pq5jm1vn7BpVk4xENCILt5jTa4e4ZTI+P5H3XTw2bubMTL4mqQ/IDLPHpOH
         W5E7/4HxWBNo3O96EWHs4vPZ37rRziJNWT86g+xel8ZgQC0i0kfG1W8Z/6PrIlzn/Cmo
         L4Hg0EHBjx4tml3M2LZxTDr6vjJ9KMtUGiNinZnGgqJ3AVaZfG7jug4mj5C+JHzRmZjj
         Mhrw==
X-Gm-Message-State: AOAM532/yrGDV6Y8MVEvEQgO4B0AxGgow45bgLk6JLVtX75hrDcX/O2T
        cNS0ADyOWagRMWvstLlos1YYB0fX6c8yBw==
X-Google-Smtp-Source: ABdhPJwg5dhz8wTx0JpCMR+CRDzJKb/E43+HzeSy9VMX5p2EhvrhlRU+nahajig9EnCgtNMepcm1mQ==
X-Received: by 2002:a05:6e02:17cf:: with SMTP id z15mr323228ilu.161.1634147179155;
        Wed, 13 Oct 2021 10:46:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t10sm77899ile.29.2021.10.13.10.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 10:46:18 -0700 (PDT)
Subject: Re: [PATCH 3/4] block: don't bother iter advancing a fully done bio
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-4-axboe@kernel.dk> <YWcWvdwVNoM6Stag@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ea76e22-87ba-ccb4-70c1-7b0ac516eee9@kernel.dk>
Date:   Wed, 13 Oct 2021 11:46:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcWvdwVNoM6Stag@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:26 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:49:36AM -0600, Jens Axboe wrote:
>> +extern void __bio_advance(struct bio *, unsigned);
> 
> No need for the extern, but it would be nice to spell out the argument
> names.

Done

>> +static inline void bio_advance(struct bio *bio, unsigned int nbytes)
>> +{
> 
> The kerneldoc comment for bio_advance needs to move here now.

Ah yes, done.

-- 
Jens Axboe

