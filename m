Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D588C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 19:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB08206E9
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 19:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VQC1R9Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDCTpL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:45:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43087 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgDCTpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 15:45:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id g20so4011535pgk.10
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2020 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=synan7emoQzCrOOf8QruJu/LUg5gASb8B5DV46TlaWA=;
        b=VQC1R9OygKVmEO8RLR9nuWP2nMuRI1kSA3Zk93cZN+1ZF+CsHPkuMpXdIKlJ6wU7ZC
         naTKaCim7sYXXUC44ryYwuqH3Km3yb4sBYlOlSX2p8WDca020BCBNh/ZXDBP0uzsVtr2
         +RNEDAXkKrwpQrFIeM1IAK8Z8SSZR62bQA3oImKiB5llUM991FLof+b8fMfrpcRWgvn3
         NfjoDGHa3y8qjE7CDxH/8/DZWlWb9Nta8a/oWdgzgInyvwnaApCrpCqqj1KKe10SdRAA
         2EFfxneG2qkjGbOdH8SuPU2oHWZdPG+HHLwQL84LuB+pXs43283sVVRzymOAQRnH9JrU
         UVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=synan7emoQzCrOOf8QruJu/LUg5gASb8B5DV46TlaWA=;
        b=kUuw64NJiZUWjUyZyMWH8kc1eqLSoSUntvHrguKc6/uqGC9CI/1odRU7+hrG1aWv9r
         b6kO8UfcCITAWIazlPxTGP7LF+BqRCHWbxMFo1gwvFo44Q28Exz2wauCr/AzdGE1pImP
         TitVG6iyRyLM3hWUQYSLoPJKb1Wt+8zaNQ0xxuUixduXbwUur46cCKxPvQ0JJKhvz9Ih
         rfv4/FqW4TcGUosketvFpCrfDo0vxAZCCnwgvQ/iVN9IU3sBoKRZk/j7RKo66YFq33bU
         yv5GENz7wvbCf0/ntM3qOGQX3YI9/DJkxcmWwAXcVLavU5apuqvy6zHO2dzOvqZnGz89
         wZCQ==
X-Gm-Message-State: AGi0Puah/Kxbj4bilHqXJl7rVOC3oev0I8vgSWEM0UV+DTOgz3+PJc82
        9vrsbYfIdC295KuRWOrYfoBXCw==
X-Google-Smtp-Source: APiQypKpWFQ7NZ6t60hxt87r2r5t/jC27Yo11RBZ18e4cpHT8daraERbQ6RKhXx6AjTDR2i3HOBakw==
X-Received: by 2002:a63:581e:: with SMTP id m30mr6225293pgb.295.1585943108935;
        Fri, 03 Apr 2020 12:45:08 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::15af? ([2620:10d:c090:400::5:8ed0])
        by smtp.gmail.com with ESMTPSA id s137sm6622522pfs.45.2020.04.03.12.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:45:08 -0700 (PDT)
Subject: Re: [PATCH v9 0/2] Better discard support for block devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        evgreen@chromium.org
Cc:     asavery@chromium.org, bvanassche@acm.org, darrick.wong@oracle.com,
        dianders@chromium.org, gwendal@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, kernel@collabora.com
References: <20200403144304.11630-1-andrzej.p@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cedd204c-4fbb-f336-de96-b84d669c5d32@kernel.dk>
Date:   Fri, 3 Apr 2020 13:45:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403144304.11630-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/3/20 8:43 AM, Andrzej Pietrasiewicz wrote:
> The series is a v8 with small issues eliminated (see changelog below)
> and more Reviewed-by tags - from Christoph.
> 
> This series addresses some errors seen when using the loop
> device directly backed by a block device. The first change plumbs
> out the correct error message, and the second change prevents the
> error from occurring in many cases.
> 
> The errors look like this:
> [   90.880875] print_req_error: I/O error, dev loop5, sector 0
> 
> The errors occur when trying to do a discard or write zeroes operation
> on a loop device backed by a block device that does not support write zeroes.
> Firstly, the error itself is incorrectly reported as I/O error, but is
> actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
> report the error.
> 
> The second patch prevents these errors from occurring by mirroring the
> zeroing capabilities of the underlying block device into the loop device.
> Before this change, discard was always reported as being supported, and
> the loop device simply turns around and does an fallocate operation on the
> backing device. After this change, backing block devices that do support
> zeroing will continue to work as before, and continue to get all the
> benefits of doing that. Backing devices that do not support zeroing will
> fail earlier, avoiding hitting the loop device at all and ultimately
> avoiding this error in the logs.
> 
> I can also confirm that this fixes test block/003 in the blktests, when
> running blktests on a loop device backed by a block device.

Applied, thanks.

-- 
Jens Axboe

