Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BC160232
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJROkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhJROkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:40:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DBFC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:38:24 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y67so16478202iof.10
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZIhp63Pfufc+i/B+UQ4MepqcxT4TUmXKNDOW2mSog8=;
        b=EyI12Ng4urMRzKav1tB4meel22lxWkTb17v9l8902o7rXDSTYWRdpuKhGe3kaBBjWx
         oGsTj6gLvm4EGweQYLBMsR8y2LSdBxwpc9VCZSROVvzVSsGtdpRVNO+wgMpDARYcIYE5
         3JGyvq+DRkY3m0yP9llPJGv1WqQKN9opcSQmdVX8HxxcdGBesKJ1iDUeU7v3FSLTg0OW
         11HehGG1dAGYrhYAjnbEMQ9lDgvKyrorGMOYI02Sh0U7/QeDrkzTAS4kYcQXD31kWiJo
         D+GUUuZcNrvuy19ke0Dqi+/7nq4YZIcreOx3d6ph7hQCLveFAshxRUVffJEbaJ6Sh0/a
         L6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZIhp63Pfufc+i/B+UQ4MepqcxT4TUmXKNDOW2mSog8=;
        b=sKnlPujCpRe0M+9AHina/Zq9nEkDFKZlWO0itHl6UiuuBPs8AXZBdwOcZQURUX4Uyh
         dQzI8HOiiCzmXzelVDarIUuiNp+zBwT+KCmNS1ej7ZGz9e4hHAHNAWFcHE8/USJtgMQO
         SIpYaxyKXMbmpyS2HlBBDdtgTgMc6shUIeGu13aQz2XU+A3obvjsl0eRhawUvK65cdy3
         SyomFT3V8TJ24AKfDMnqn0ypr9D3Xv6dmnbugj4GLbQJG0dmU4AmZVjyQjlmMa7jmU6k
         6i0nVGQmOrD9vePrTXoX5Ehc2MTv+aKdBqvkmT8Uf4WLGCn9Wi4+tCXRvDaBvWcqUcLz
         6sMQ==
X-Gm-Message-State: AOAM5308SNqJK63KX2+k9RXngDiQ1N9upizMcAX9mFBTx14I59DLtG3O
        6YImPvMTo2iM5MfsoaleHYp8fGX5DDA=
X-Google-Smtp-Source: ABdhPJwpRwq9VYitmJ2X7ZSYPjqpEzTZ9mveAOPjRzPPAr/86asPZ59flre0Vnun5pcir+M8W38Bbw==
X-Received: by 2002:a5d:8903:: with SMTP id b3mr9955711ion.44.1634567903283;
        Mon, 18 Oct 2021 07:38:23 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d5sm6971764ilq.16.2021.10.18.07.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:38:23 -0700 (PDT)
Subject: Re: [PATCH 01/14] block: inline fast path of driver tag allocation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-2-axboe@kernel.dk> <YW0zXEOcn/lkozM5@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <994eb1b3-90d0-0980-5c2a-46937d4d5a62@kernel.dk>
Date:   Mon, 18 Oct 2021 08:38:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW0zXEOcn/lkozM5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 2:42 AM, Christoph Hellwig wrote:
> On Sat, Oct 16, 2021 at 07:37:35PM -0600, Jens Axboe wrote:
>> If we don't use an IO scheduler or have shared tags, then we don't need
>> to call into this external function at all. This saves ~2% for such
>> a setup.
> 
> This looks correct, although the call chain gets a little confusing
> now.  How much difference is this over basically inlining the
> whole old blk_mq_get_driver_tag?

It just condenses the fast path into the checks upfront. I can run the
numbers, but it'll be extra work.

-- 
Jens Axboe

