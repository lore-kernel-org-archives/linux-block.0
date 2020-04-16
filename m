Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06BEC2BB85
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF303214AF
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P5GrsZid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgDPP3V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410310AbgDPP3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 11:29:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18C4C061A0C
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 08:29:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id t10so7224802ilg.9
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjYb46KKHQaM2QcIyYITIA3pOY9fTaV8ZXhY/h80qfU=;
        b=P5GrsZidGxsLQhO/f/2DgJ66F2RC71L7NdxP6UcLCeq0jDSp4Ip1n8eUNx4VUSfhdC
         sy72KquYgeRF4eogqD0vft6f2KZcFTxjjR2lQoSunaIyVJC468Vwc3nRc0eJbYhndjpR
         CUUuuF9raIEedRpjrkd+DSDZ3dJehjNDp4bDHMX7sDx+vr0nVQfQ1vLIQTWRhRxCipVi
         z4Ks8i9S2+Vz+vbGY9F7ooa421z8MT3TwQiGlSbyyJtgHtb7KnNUnt+lqZ/lXU3vmU24
         1dlmXjMEteADo7197Nu4zRMwm9SVYXP//56/SACdl1GdEREng8uPLwUT+ZqI+ZApq1kA
         zq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjYb46KKHQaM2QcIyYITIA3pOY9fTaV8ZXhY/h80qfU=;
        b=IWj2a83z1GPwI24oSFsnGbUrOJoqK7P7p6WZVdzgAommSbyIi30RxbJyw3R9t/rGl5
         H9Og6U66vvSwgbVVoz2t8PJZG63roz4w6VyLbcq+R1yNR0yXi8HmzQyEweyc7Pw3Y3Yg
         Zk4nlc97QLHNXvhRVE2VaEuI+4FhJOHDs+a6QAvhjVBgLQD+IJEs6GkAnQ803xz2VK+z
         TgJdICWJPCBUV5aJy65cI1FmOr71OHa1ABJVsGhnRCjkZCzTKbTm44dkWfSPUjlb5lH+
         5sytuQ7gpYSeuF6GIw/DB/Wv9QNjZe6HqqZuXLZbK6Vl579lLB7zOkse0hT+nADL6JtK
         i/zg==
X-Gm-Message-State: AGi0PuaLyhg6ik7+0RddWs4qqGy6nKVosmWXKyc1RqYvvTgjfcsnw2Oq
        jSJxVcqLOM9wAk/XaMIXsUjoMA==
X-Google-Smtp-Source: APiQypI4s/OJ6gLtvfesllrxcdSq/g1jWsDIawUun1QNTvXxdU1IPJGPEA+hKrhr5aWkUfJA2dWRZw==
X-Received: by 2002:a92:394d:: with SMTP id g74mr11039032ila.250.1587050954961;
        Thu, 16 Apr 2020 08:29:14 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u16sm3414326ilg.55.2020.04.16.08.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:29:14 -0700 (PDT)
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev)
To:     Christoph Hellwig <hch@lst.de>
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416071519.807660-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <874d57cb-90f1-db09-8f9d-29527451e241@kernel.dk>
Date:   Thu, 16 Apr 2020 09:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416071519.807660-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/20 1:15 AM, Christoph Hellwig wrote:
> Hi all,
> 
> the first three patches are my take on the proposal from Yufen Yu
> to fix the use after free of the device name of the bdi device.
> 
> The rest is vaguely related cleanups.

Applied, thanks.

-- 
Jens Axboe

