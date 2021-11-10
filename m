Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 00:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59A1610A5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 00:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhKJA5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 19:57:14 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41714 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKJA5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 19:57:13 -0500
Received: by mail-pf1-f174.google.com with SMTP id g19so1045608pfb.8;
        Tue, 09 Nov 2021 16:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kf/FYN+gVGrcd1+PdmA4E4ZA2ZSxzGsOl4BVqKVilsQ=;
        b=HB8pxVJCX7C+4jsbxsD1jjooFnm48mDJPn6ZMxIOx7ZTKQ+yqMWr65voG6iRN2jamt
         9TRUnkOEALHkEvyXdJFv/G5yvNqclQp+UxwUpqcthM9GUPXR7agjp12q0xdfcNh/oHnZ
         2pHI4vhY00BgNHkiXg9QRmcxBvHs0S8OkHbYtAbFwfejwdA4Zf/dYXQQturvLjMeFvW1
         M/k09wyf5MNBpTT0ZUqLxeYI6zUXO1NpDyMm1VpMlpzGED2IkI926GfUDYk6N7b6p4Ul
         HjauKU4qzTSYA2M9hbO146enOBxq77RauyBSW7/dDBk6CBm0d0yHPht+cgDm5y97lINq
         25/A==
X-Gm-Message-State: AOAM532CRQvQgeFwCNLu3Y8X88Xt5ToBsyoYbcvdllgMRwSbZRkm/qh3
        gDoDl/O2PPh+czLSnQnlJvg=
X-Google-Smtp-Source: ABdhPJzEWtt8iAonAa2C4qRPqfJucenAynaePwW92eDYc4TJ+Ir64lLP5hEhOXLPyUmx8r2LN4St0Q==
X-Received: by 2002:a63:4a24:: with SMTP id x36mr7518498pga.67.1636505666927;
        Tue, 09 Nov 2021 16:54:26 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a582:6939:6a97:9cbf])
        by smtp.gmail.com with ESMTPSA id l1sm16190987pgn.27.2021.11.09.16.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 16:54:26 -0800 (PST)
Subject: Re: [PATCH] block: add __must_check for *add_disk*() callers
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        hare@suse.de, hch@infradead.org, jack@suse.cz, tj@kernel.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20211110002949.999380-1-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <00619aeb-94c0-85a9-4c11-68dec0345188@acm.org>
Date:   Tue, 9 Nov 2021 16:54:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211110002949.999380-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/21 4:29 PM, Luis Chamberlain wrote:
> Now that we have done a spring cleaning on all drivers and added
> error checking / handling, let's keep it that way and ensure
> no new drivers fail to stick with it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
