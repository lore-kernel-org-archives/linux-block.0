Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED5C43217
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 19:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKITlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKITlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 14:41:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB97B18B2A
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 11:41:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so2845302pji.1
        for <linux-block@vger.kernel.org>; Wed, 09 Nov 2022 11:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1VP0ON/R/XNlpNpYrF7swSAsbd3KSc6Uo6XVXcsTwU=;
        b=yiVotmZB2Sbm9qDeTAvvcgQhDxSpuANW1NkuyhiOLzcuS4tPYDuP9XCrW/u/jyGpo3
         Mtu79aNm4z3CrVGL1nDmz9cY5TGWnQphoZjdwPbAlLScd0/iHFW0GN17XUDNdtFR8hkq
         Xne0iHnMg4E2V6QXpU0w1wGvzIIbbDN7hGCHrVdR7tYmprlFjnXLtn2NjDGgZ3MbEVqi
         QEFJ9Z77TZwqgxrrGtUVdUIJeW5WwQf2HwHwk5jAH8odLm/NtlE+B8qrk0/uxbK3eEJt
         y13OeCVS4LTHbwblFiZdrLu3rNVhXBFCVUL8ngKmnb9+/8TKRO98tzHW6gh0x8f2kE5R
         y0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1VP0ON/R/XNlpNpYrF7swSAsbd3KSc6Uo6XVXcsTwU=;
        b=ZWLD00oLptxvQu6r6DZSZtL7k8VSIs1hUX+7+2XUjzlhkO9u3rPZrT7F+B4R/NFy7/
         qYqg563T9Gi293Z+fhX05MGsvxblmVrBdmNseoVYHCJjpj5PMyp4wgO1ug0/XZBsTEjS
         xtz55u1XUjWE9LPFyJ1NuliWBgOd5NakrcjujnYqys/2QV/Q9zWmRSTf0uWM3C4AKkEd
         6EnL1H3FMmNXggPIBzJOiSM1WeUKxIV3l6c+rK6SA60wDMy9RgXsfq/ELEfrVAKlVbA/
         oiEq9HdKqPpC7PzVLHagUbDGBRfEoFw1rX5n67c8bq8WF0fC5grdW8KVf+9cHA2Wf00K
         zOXg==
X-Gm-Message-State: ACrzQf2r1xvAdPKBDFt0WdlnOtZobObgzgjwVmPKkf854MJN9cw5/K7G
        533HsG2wtt9wJyaTq2foPxjtWwHx8HdQoQ==
X-Google-Smtp-Source: AMsMyM49TSh6z5LyV/VltfEckXkKbPOSCs7nKZgP8CRF+QeMrA2wQRKiLKxA6RpLVjELI1zL6PAaYQ==
X-Received: by 2002:a17:90a:1946:b0:212:f926:5382 with SMTP id 6-20020a17090a194600b00212f9265382mr62639532pjh.218.1668022871185;
        Wed, 09 Nov 2022 11:41:11 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090ad80e00b00213d08fa459sm1612677pjv.17.2022.11.09.11.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:41:10 -0800 (PST)
Message-ID: <f249f608-d9cf-7ba9-5050-dfc97e543d55@kernel.dk>
Date:   Wed, 9 Nov 2022 12:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] blkdev: make struct block_device_operations.devnode()
 take a const *
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20221109144843.679668-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221109144843.679668-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/22 7:48 AM, Greg Kroah-Hartman wrote:
> The devnode() callback in struct block_device_operations should not be
> modifying the device that is passed into it, so mark it as a const * and
> propagate the function signature changes out into the one subsystem that
> actually uses this callback.
> 
> Cc: linux-block@vger.kernel.org
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> Jens, I have some dependent kobject/driver core changes that require
> this change in the works.  Can I take this through the driver core tree
> for 6.2-rc1?

Yeah go ahead, you can add my:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


