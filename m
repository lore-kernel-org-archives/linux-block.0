Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A639C43332
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BE364EBB
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378984AbhCCQjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 11:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhCCQYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Mar 2021 11:24:52 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E609C0613D9
        for <linux-block@vger.kernel.org>; Wed,  3 Mar 2021 08:24:14 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id c10so21890430ilo.8
        for <linux-block@vger.kernel.org>; Wed, 03 Mar 2021 08:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ihYiaJFOB9DYTRhB/PyeoELBx0bDt4gsenP9UzgjlqQ=;
        b=NTwXCtWQ4Pqx46ICAK8qJCNcwh9OdFYNBbglI0W7QCBBDmKq5ifnmU3sahf7vZOnhA
         LFmuTUyePf67r8tlxU5rMktb8Oe5BrM7BOYhPUklDQe5lXOj4YsxsfFGltHp2SGPD3cx
         zJnpKd35ySd30+uqDc3ayakJZsPwJVSvZdgowJikgOAZJO2X9sp7PwMxKMXxzKfEjDPT
         YHZUowz4aB3YgVPQJIboUTpqPAVhqbbbiXmf7PkJk3Z9qD836Z20whixK4CIR0Vo7t6C
         rsKIPP52yONbxMqvxrJw24dO6805S0Gy9J8i9OHq8WqfKiFI5jm2NkfD20osqmwInk47
         1DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihYiaJFOB9DYTRhB/PyeoELBx0bDt4gsenP9UzgjlqQ=;
        b=ZV4ilz27kqRuucJAS6sJ6PiJ0PB7f+Cc+rhjleCGTD2F5o/fj0vWdmZaQqsjItGG+/
         +1TJ8B8D7/sk44RxHkXV+X6ry49LiPi7ddxo/KMYtZ6pAF1NJPa9D9SeCri9ZOQQSUXW
         ledWH965MpGnK2o2j30aGR76xh7rdlgwyDOGFYlRLfgg3rk5hNt1VISbc1/t8wrc3MZB
         zIUcXDZJP8ts7ITaMV/uPyW2sbg65vwCgA9PM+3djxjp4XcaJ91OSKyhzLl58FGfNErz
         AteIceX03zo01XYX2lAxf37wMHZj+K1LPOykdURLdYhy6ip5/hisJM7gs1QUxo+mneQr
         dCdw==
X-Gm-Message-State: AOAM533q5oGujLTjV6+qv4JckpWy0IECcDr5A3PNYAFLRCJkSZQMbPgR
        gRWuIGBLQxqoaFlT+jLMjsawxQ==
X-Google-Smtp-Source: ABdhPJxqJiJfaUOLML8ghvodO3ZGgw4isNJmhlvEU3rLB7l+Qy38SE7bO3qNmV3feWzpjKvm5fSRSw==
X-Received: by 2002:a05:6e02:20ee:: with SMTP id q14mr1516ilv.259.1614788653972;
        Wed, 03 Mar 2021 08:24:13 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s6sm12193292ild.45.2021.03.03.08.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 08:24:13 -0800 (PST)
Subject: Re: [PATCH] swap: fix swapfile read/write offset
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org
References: <6f9da9c6-c6c5-08fe-95ea-940954456c40@kernel.dk>
 <YD+vZW2bJsmpCGn5@technoir>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <910b8b56-e16d-ec91-5e76-c88cac69d89b@kernel.dk>
Date:   Wed, 3 Mar 2021 09:24:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YD+vZW2bJsmpCGn5@technoir>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/21 8:46 AM, Anthony Iliopoulos wrote:
> On Tue, Mar 02, 2021 at 03:36:19PM -0700, Jens Axboe wrote:
>> We're not factoring in the start of the file for where to write and
>> read the swapfile, which leads to very unfortunate side effects of
>> writing where we should not be...
>>
>> Fixes: 48d15436fde6 ("mm: remove get_swap_bio")
> 
> Presumably the usage of swap_page_sector was already affecting swap on
> blockdevs that implement rw_page (currently brd, zram, btt, pmem), so it
> may worth adding:
> 
> Fixes: dd6bd0d9c7db ("swap: use bdev_read_page() / bdev_write_page()")
> Cc: <stable@vger.kernel.org> # v3.16+
> 
> for backporting, since it also affects stable.

yes indeed, in fact that is the source of the original issue (copy/paste
from that broken path).

Fix is already upstream, but would be nice if someone would turn it into
something that could be applied to stable.

-- 
Jens Axboe

