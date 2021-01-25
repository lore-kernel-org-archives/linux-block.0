Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111C9208C7
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 04:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbhAYEZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAYEZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 23:25:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA7C061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:24:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q131so7660431pfq.10
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 20:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXbWe68djMIVtIYt6W4H05uTaMN0k3kSJK6jSjv4KSw=;
        b=obLak97ffbbJ/B6BzJCAWzyPvEoIz1719KUBGn6vuzbMN9U4ImmtY3x1o8rRv6Aa5B
         tvoCPSlIHaICsyKdJ3PGHWKOBclL0gaux+Hh92hH8PCmvloDJsRZGT2JuvWSMKczvG/z
         vumUOXo3UB3raNKbMg2n1NRkhHrKrPBujdtDDNcsO/2Gvl4ZmqHeJB3ONCPam5SsmOl5
         JfcqTKAeKKUiO8Qvo/p++o+wTz4EXFJdUw3+46ICjbl+YsA8Vm/jC3hzCo8gldIBysDq
         jivpkm/n9vvdLNRxoU4R/n0SQBP2+YKA8KumJIjDM13IQx1XDMFNrbA8FkyCV1frdYcs
         WP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXbWe68djMIVtIYt6W4H05uTaMN0k3kSJK6jSjv4KSw=;
        b=H/a6cO040jycyv3/TOen3bxwPEMrxK2PsqoOjV22JXlhSOPXmn1carvXLxirQkDtJk
         tdih2gFH5+DKACXY/+QdpgZQoiFgB7UNczvtjr0mNkZzEkj1gs9GDI5AvmL/L7B5dkAV
         L66xW8Nm8CX8ibUEeoiCwRwqDXbhq/tHFHvRQaqlnA6jdPQVLIaWjOsYYmTlwrh5Z+ur
         j1zCdDCrID/CWNyo7pveccDLbgcTKAKSMkxk0IAlKajrgQibK3ZGP9dA+3qQF7huwd/q
         /hNDWrpskTrLkP1CVm4AGdSLDkoT/uW9rsNwvkxfYh3N900ka1c9OcA5DI54VRz9zXf6
         7Lmg==
X-Gm-Message-State: AOAM533h9AxenoqleNSh40HaBI5vFJsFXwEiUpLzcZkortMip7lRYrTI
        9Yb1+zHDv3UPN1lbRM95yXsYer8XlrlAZQ==
X-Google-Smtp-Source: ABdhPJzMwLDF1vgQXU2WzhesPf3HmiXN51GeADDaYdF4Q+TITSCUMzNcKmkfqvPwdWp4KElsZLEIcQ==
X-Received: by 2002:a63:6344:: with SMTP id x65mr127729pgb.172.1611548685762;
        Sun, 24 Jan 2021 20:24:45 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 77sm2565226pfx.130.2021.01.24.20.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:24:45 -0800 (PST)
Subject: Re: [PATCH V3 0/6] block: improvement on bioset & bvec allocation
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <307bd8b4-3c59-dd45-7aaf-2ce814e798c5@kernel.dk>
Date:   Sun, 24 Jan 2021 21:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/21 8:05 PM, Ming Lei wrote:
> Hello Jens,
> 
> All are bioset / bvec improvement, and most of them are quite
> straightforward.

Queued up, thanks.

-- 
Jens Axboe

