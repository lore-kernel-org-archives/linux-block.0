Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A359C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 17:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGKRSs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGKRSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 13:18:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FEFCE37
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 10:18:45 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u20so5528006iob.8
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0tFRdeac06SJMsCOq/f2cgz2EY5sDCDg1mZk+43QRV0=;
        b=ka65AOIn5LxDbde2si8bwDbYBSN5qbpoeB2GLKlYUZKseQ/isw0mnUoMaMQUQa7JWz
         eQ8LecRXq7XZ+7i8GGZOOW3pdQ31Jh2bO47iYCh85DaiZeXFik9p0R8CheRULUcbX49x
         L6alNSRp/Hg56lhOQQK7CACBpdtw+TKsSaBEvWiVe4SJv8y7jILgKd78IRjzsjEqbnAB
         BzOLdUib9++niIUMMWWMMdSkeq2OlvNYWcPo3Mdrf4aefcSiWhNA9K9UkKICcpPYVMLJ
         Nr8H+/bNrI2wLcvqVpm551r3J8B5TZMnfW94RMEXkWMP32wjl/ABNhyQ/lMCuq2hh5LR
         lMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0tFRdeac06SJMsCOq/f2cgz2EY5sDCDg1mZk+43QRV0=;
        b=Si9yU6ZBz3TDluoZdt7JcR4RdQOdC3JSJmQ7tWp+SW7vjlh1b1bEHGnYzv9R7zxtjT
         svHpWRkKfLuKZTjj0gugCAlDPZERa5jjWu95ZqSudgwjuraQdO7eyAP6YHXy8uzIDQGE
         MBrI/Jt42bIwVsJ6N2YMBvHCjeJpsJpEwhDbBLwuLhE86rXv/eteaWTcqUIDp4I79KN9
         4gRiczby4RAU4N06j+iTf8ex6eshnN6vG1pmoRTfQOO0CSU+NehLdnkXO/U0mg7xTVvP
         pyDUMia2Q20jmN9KK40jAmiaJcK5S6D/azWOgkgXIAYF+GbGayFIHER06Hy6x6n6PKsd
         VaPg==
X-Gm-Message-State: AJIora+J1g2vStB2GesRRNB+wa0v9hl9fjyh1wXOsB2rNufKr1jAXeED
        M7/UmP0Di4QJy3Mb5pcZ8OmaKnGAGEX69g==
X-Google-Smtp-Source: AGRyM1tZ/tuzzEuYjxyhBIk6pqAW/CgmVerMDOF3aoAdK7DDenHSvDRfSrbmPmIdIqisEtD/k7IrLg==
X-Received: by 2002:a05:6638:328d:b0:33d:5615:a95a with SMTP id f13-20020a056638328d00b0033d5615a95amr11039045jav.96.1657559924743;
        Mon, 11 Jul 2022 10:18:44 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q17-20020a920511000000b002dc2a5abf44sm2856494ile.62.2022.07.11.10.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:18:44 -0700 (PDT)
Message-ID: <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
Date:   Mon, 11 Jul 2022 11:18:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me,
        kbusch@kernel.org
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220711110155.649153-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/22 5:01 AM, Kanchan Joshi wrote:
> Use the leftover space to carve 'next' field that enables linking of
> io_uring_cmd structs. Also introduce a list head and few helpers.
> 
> This is in preparation to support nvme-mulitpath, allowing multiple
> uring passthrough commands to be queued.

It's not clear to me why we need linking at that level?

-- 
Jens Axboe

