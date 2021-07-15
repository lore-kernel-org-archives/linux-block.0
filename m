Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102ACC47E48
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D746136E
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbhGOPfs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhGOPfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 11:35:48 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D6C06175F
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:32:53 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id a17-20020a4ad5d10000b0290263c143bcb2so198580oot.7
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ctPsCQnCwOWC1BXWqxdnW65MNFL9SGWc9DV0HhUmFp8=;
        b=b0Q4rQVW5qzDbmL8dXl4Xl18PnpkfjVwt3adPgkOOLeKrOPcTs7mOV+KmzlE0QlalO
         M76Um9GwwJ6MLrZWrdh5GBZNrlEks/A4ooKQDIEqKBaeq11yk/dm1mJCfKwMvuRvqpZ6
         +LGsjvcpnCrOUhr5cMwsFn6pyoFOP09Sfyqt6fA6sFt2UHVUFrt/XH1KdTlQEelBUmdq
         nVyKl9c7jx+jBhZSNxYTS+bwSligsBTISOBwPBfRyKx0nwyRO/lDn6yO6cGms4tAXtXp
         nQB/zNyAb/tg4H6EtGiWM8DXz7m3GQrQ3LO3QEdQOS9wnDI//+xh2GdnJMWjdbrwsb0A
         lKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ctPsCQnCwOWC1BXWqxdnW65MNFL9SGWc9DV0HhUmFp8=;
        b=UkI3eq7tQyZo6Ikjn+ZIAU39z27cZZHaQDo9tsS7nRsIN5hAtQoey/8c3uyA7zoihO
         IqAIby9nPPzlC7WVgeoWXYCOGWQxNB0DicxD8myEQ5GAP/j1LQUyM8STaV+M7CcABVss
         Pk8AcKyDXhLa1j3tw/2n3S/g5/ZotNDFqEQXYwcCQgGMi3k4c3OfKrpuMxmGJH5tIev9
         uFYtPJWAsU8PgUS+5xIpQKEmiW/bdNfKPak8BPZD97YiRAiTFzs6mdSylyOIpXjCjcPY
         6ewFukvz4TnTWLeaAb/S+nYAQjN/reaNAeuhnc4NdjJ7ylpCZYoiQIyQ3dMij2a7XSQt
         ZtUg==
X-Gm-Message-State: AOAM531iCMKCrXOWujSrSjr9bFjh+g4AX/kQXYUh0/6aIgs2aNwcnVK/
        fgNF6bHdcevgTPjnRfFit3lWBA==
X-Google-Smtp-Source: ABdhPJxKk5KqRByjITyE6sC3mMa6jH/2QpqLo9/XviaZcs14zGBZ5ciDB+yJtGrNf83V/USGE/zOpQ==
X-Received: by 2002:a4a:bf11:: with SMTP id r17mr3859881oop.29.1626363172973;
        Thu, 15 Jul 2021 08:32:52 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d7sm1128969oon.18.2021.07.15.08.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:32:52 -0700 (PDT)
Subject: Re: [PATCH] xen-blkfront: sanitize the removal state machine
To:     Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210715141711.1257293-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <69452380-d55b-4329-73d4-151265351fc5@kernel.dk>
Date:   Thu, 15 Jul 2021 09:32:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210715141711.1257293-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/21 8:17 AM, Christoph Hellwig wrote:
> xen-blkfront has a weird protocol where close message from the remote
> side can be delayed, and where hot removals are treated somewhat
> differently from regular removals, all leading to potential NULL
> pointer removals, and a del_gendisk from the block device release
> method, which will deadlock. Fix this by just performing normal hot
> removals even when the device is opened like all other Linux block
> drivers.

Applied, thanks.

-- 
Jens Axboe

