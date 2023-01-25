Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281DFC54EAA
	for <linux-block@archiver.kernel.org>; Wed, 25 Jan 2023 14:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjAYOcP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjAYOcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2023 09:32:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09614EB5
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2023 06:32:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso2219023pjg.2
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2023 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSv8WpaqrU88nGheGtiai7Y/5wRVY8MkM9KRN4G+ukg=;
        b=6TUazUJSiXGMCc9BZgnJ+ncR58zGFe+HwYOk/rr3xHuxMwoEBSZXgJ8YDUrwx+QrDs
         0yoqVhDUylo/qQV9t9vD7a48v/MA1BWUmvM1KIIeVhk9zteWjxsufEqEqKwKSefrLD53
         rSSTFz/23fiMM4UZHT7qYjhZz0GkfpM88GDQ7GMPWjY7hn8sbVgZTMjZHU1pL4UXDB98
         mK4uNvSGO4tCZYMv3DSy8Y3aHSj87MDVVD6wat1ztVKQ+06I9/6tzukHWdAci17SsAz8
         ApNiiBU/qtAwtuPS0o1YadtuehG3+LqSVZvQM9bAhT/U2JtZKE9mLtINVYY4tX9+UwFG
         PNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSv8WpaqrU88nGheGtiai7Y/5wRVY8MkM9KRN4G+ukg=;
        b=2DorIJBiaeCScDQVAR7muVoPxVUpGR0YTQyQv8UzGV583KCK2Gt8lnnKXw+joGzQH/
         wN0XbsAZqZgvrRk36XdFvOjZoulJD99wB2NQD50yZqxI2jpmC6VYZKGyZJmk1zgVEI3o
         IpC9v9tflcDwGMDN63JIGnz4UtrtwEuV83m+FK8xigu8+BVQzw4ZuNpc3rmtU7h7xQhL
         Z9J8H51mtbSsV512OO3hPi1aaAy0nSmjwQV16PsHnmzaqP6iqs3ZzcKE3ATQuwEZbvOD
         iRF1nmQKaKE++DWayxiMN0nF7BjHo5JBVGq8hYtffcsctXlunH2BqTx0+esPSUmz5LIX
         tajg==
X-Gm-Message-State: AFqh2kqv1fVKcX6/IlcOr17BZkjEWfnTIgBzscIHzbNxHdnC20f6+4Mq
        Hd9G3Ey9XLG/o/zhohWRQCO8rgrmZ6pRs9Ws
X-Google-Smtp-Source: AMrXdXtSjhgXq/ti77BjIjNmng+Rkvj5Dbfyvd4sgmo3FggcVSTo6y9uVmruhdChTgf8/MyBasa0Dw==
X-Received: by 2002:a17:902:b591:b0:18f:a0de:6ac8 with SMTP id a17-20020a170902b59100b0018fa0de6ac8mr7903292pls.2.1674657128759;
        Wed, 25 Jan 2023 06:32:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bb2-20020a170902bc8200b0018bc4493005sm3664530plb.269.2023.01.25.06.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:32:08 -0800 (PST)
Message-ID: <aa5ca868-d8ca-8278-509a-dd511ffdb4a8@kernel.dk>
Date:   Wed, 25 Jan 2023 07:32:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: remove ->rw_page
To:     Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20230125133436.447864-1-hch@lst.de>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230125133436.447864-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/23 6:34 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the ->rw_page block_device_operation, which is an old
> and clumsy attempt at a simple read/write fast path for the block layer.
> It isn't actually used by the fastest block layer operations that we
> support (polled I/O through io_uring), but only used by the mpage buffered
> I/O helpers which are some of the slowest I/O we have and do not make any
> difference there at all, and zram which is a block device abused to
> duplicate the zram functionality.  Given that zram is heavily used we
> need to make sure there is a good replacement for synchronous I/O, so
> this series adds a new flag for drivers that complete I/O synchronously
> and uses that flag to use on-stack bios and synchronous submission for
> them in the swap code.

This is great, thanks for doing it. There's no reason for this weird
rw_page interface to exist.

-- 
Jens Axboe


