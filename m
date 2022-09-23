Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B2C6FA91
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 14:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIWOPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiIWOPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 10:15:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A9110ED2
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 07:15:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v128so10371357ioe.12
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UWmSkIcj2Zi0W95Qe0q25OStbn3befeirPvCr4MRQSQ=;
        b=D2yf3TlFalE7EQgO4dw4+/YaX1DhboXIHpiQ3fxco/I0FzbFXMnkI9U2xiatkh9t2c
         nLQASI0sqeJwJmqy0E/wtVtgC5vep4UieANkH0I9W+I9WGrki+D76hbN6Fp/9Pw5dp6x
         mHDFqkjHesmdGr8jaIw2/O7AclhwSxCIZk2vlreVNrOngHhTBr2RigHvgR8mMR83xHVc
         15f4/Op6S+4vymQP3tWaR4DgF8plZoCLH35Biwinj73bIpozGDLUX2UUle7+TxE7VGAc
         vb1P0oFzD1imNOhDp9l3X75Uaqt5Kx5GNBoTfyBHWJ1gHgJEgKBk1mjJ/3iVZa/r7C3r
         FY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UWmSkIcj2Zi0W95Qe0q25OStbn3befeirPvCr4MRQSQ=;
        b=Pf7YT43kAy/94qFC/6Khn3QNNRFdfTphBWTRX1DPTefEpxUNTI8K/UlBBHNak8Daii
         PVGFlz7J6ejg44AOJEZz/GigpY3OEttpgYPZCqDeh4QZdP0nSAWYKg7b2szrselNkdmk
         v5M8532SuOjcy+p4YwaeiieaFKvTnAZDzQ8alNu7iK8FeOJhcToaGEn3nVeebe+lIXRZ
         9Fq5EM4k7OjSb8zzog7R/S+T/JGQYIw7l6h0u/eqrNxbsXlhlGFjNbhxutNj5s4vGCRr
         FlqT+4LdmJjW1ace69EPH4lcPH60jK4TbkjygFT80ys8JBKSGTLBNcepRB+y4IKnCRMy
         EwRQ==
X-Gm-Message-State: ACrzQf3QZnpULhgdWbFpAY9cg7HxnaxfyQWrf+mh5BMsWuwnN2pnsmxs
        Szan/7LjRrAR9+wwz7sjZWVj/w==
X-Google-Smtp-Source: AMsMyM53Z12Kuv8H+dqvBgr3DBBg4AIRzLDXTvx9NPbXSHl0B74YnwyuZKRp6Ju5owk5lxsokGhe1Q==
X-Received: by 2002:a02:cc83:0:b0:35a:1461:5be8 with SMTP id s3-20020a02cc83000000b0035a14615be8mr4925685jap.32.1663942531405;
        Fri, 23 Sep 2022 07:15:31 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k10-20020a6bba0a000000b006a19152b3f0sm3653752iof.5.2022.09.23.07.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:15:30 -0700 (PDT)
Message-ID: <c9750503-b16b-a756-b3e3-c9dfa0c482c3@kernel.dk>
Date:   Fri, 23 Sep 2022 08:15:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v8 0/5] fixed-buffer for uring-cmd/passthru
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220923093906epcas5p1308a262f3de722a923339c2e804fc5ee@epcas5p1.samsung.com>
 <20220923092854.5116-1-joshi.k@samsung.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220923092854.5116-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/22 3:28 AM, Kanchan Joshi wrote:
> Currently uring-cmd lacks the ability to leverage the pre-registered
> buffers. This series adds that support in uring-cmd, and plumbs
> nvme passthrough to work with it.
> 
> Using registered-buffers showed IOPS hike from 1.9M to 2.2M in my tests.

Ran my peak test on this, specifically:

t/io_uring -pX -d128 -b512 -s32 -c32 -F1 -B0 -R1 -X1 -n24 -P1 -u1 -O0 /dev/ng0n1 /dev/ng1n1 /dev/ng2n1 /dev/ng3n1 /dev/ng4n1 /dev/ng5n1 /dev/ng6n1 /dev/ng7n1 /dev/ng8n1 /dev/ng9n1 /dev/ng10n1 /dev/ng11n1 /dev/ng12n1 /dev/ng13n1 /dev/ng14n1 /dev/ng15n1 /dev/ng16n1 /dev/ng17n1 /dev/ng18n1 /dev/ng19n1 /dev/ng20n1 /dev/ng21n1 /dev/ng22n1 /dev/ng23n1

Before:

Polled (-p1): 96.8M IOPS
IRQ driven (-p0): 56.2M IOPS

With patches, set -B1 in the above:

Polled (-p1): 121.8M IOPS
IRQ driven (-p0): 68.7M IOPS

+22-26% improvement, which is not unexpected.

-- 
Jens Axboe


