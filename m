Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32840C10DCE
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0059B20848
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 14:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bEAHGGsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFOBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:01:19 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46139 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCFOBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 09:01:19 -0500
Received: by mail-io1-f67.google.com with SMTP id f3so2124911ioc.13
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AWXTIoNVi4PmeX46l4KNCpC/lKX/W4g0cGjnMBlBabQ=;
        b=bEAHGGsNghxj8J2XZ+vEC4dVLlFBj0NK3HWR5S+2uOR9wjYWcsBPXMothiN91WUBLm
         60wlMf2kd2Xa8o7GkPIatBTQFdzMHAnWcpeyMyWIpdv3fGSlySIif5QJKC8buBZiwuDa
         mHs4PlCikyk6sF98eoW0eTZs/CTOnYq8bXeHujLNG2/3pXTlRvvMKZD/CcYyjLR/NSeR
         d+1a35P7OtbRmsmbYKBhcPPodZwfrwY2EOukQFKFRQCEhVmFPcpSYHekdXFe3fapeKax
         DMImB+ZrteJFkGFEL2TgU2+d81UvdNf0yTvCbC2kau2Tutl44MCG1zfmIGsA58FAdH3Q
         WoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWXTIoNVi4PmeX46l4KNCpC/lKX/W4g0cGjnMBlBabQ=;
        b=bzUaawW1sVWxiPNCVAIwzqBmGR39e3w9RWcVQ1+uIPv8CLoveaQl1G2qJQ8t0hhk0o
         vkQRovSLALukbCJxPoVo6FQOHE5oQIi6WHteTq9EaanOMcIMDNJILw5SNO0BI6lisukU
         Jir7Gz5G+Iu1LvonK2BdaJNCfWEB0LLOtE+c8bck3KlPIt8J0SiENC8rVLELTidn6hVt
         /tgBhae8mNmwgNgeSJLKNnUCJARKqXYss1Diw2lHCkNc1ZSOu+eUY9MpTvSuc1W0UirL
         VlM2rxF72UIi4hPLFHPIoFCe0VNdDe4U7lHnGPSqfNUPYlCTmemahJ2C9yOlKVS+OnzZ
         GZ3A==
X-Gm-Message-State: ANhLgQ2cnHuCSF6Jc5DZt3xGz6ExaYeYbAJzFY+a/0lctplIT26VGS5F
        2hGb1uurb0K6htBTwqEPGnPWCQ==
X-Google-Smtp-Source: ADFU+vsnbO6wc+MqayVXq5o+cuIvNennIgyjYnSjIeTIJjHArSUhi9gqCOum4BkReUdddYI2gFw8Ng==
X-Received: by 2002:a02:a415:: with SMTP id c21mr3058353jal.45.1583503278541;
        Fri, 06 Mar 2020 06:01:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b19sm6586986ior.43.2020.03.06.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:01:18 -0800 (PST)
Subject: Re: [PATCH BUGFIX] block, bfq: fix overwrite of bfq_group pointer in
 bfq_find_set_group()
To:     Carlo Nonato <carlo.nonato95@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Kwon Je Oh <kwonje.oh2@gmail.com>
References: <20200306122731.5945-1-carlo.nonato95@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5e49715-6098-41d5-f964-9e6c4ff5e602@kernel.dk>
Date:   Fri, 6 Mar 2020 07:01:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306122731.5945-1-carlo.nonato95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/20 5:27 AM, Carlo Nonato wrote:
> The bfq_find_set_group() function takes as input a blkcg (which represents
> a cgroup) and retrieves the corresponding bfq_group, then it updates the
> bfq internal group hierarchy (see comments inside the function for why
> this is needed) and finally it returns the bfq_group.
> In the hierarchy update cycle, the pointer holding the correct bfq_group
> that has to be returned is mistakenly used to traverse the hierarchy
> bottom to top, meaning that in each iteration it gets overwritten with the
> parent of the current group. Since the update cycle stops at root's
> children (depth = 2), the overwrite becomes a problem only if the blkcg
> describes a cgroup at a hierarchy level deeper than that (depth > 2). In
> this case the root's child that happens to be also an ancestor of the
> correct bfq_group is returned. The main consequence is that processes
> contained in a cgroup at depth greater than 2 are wrongly placed in the
> group described above by BFQ.
> 
> This commits fixes this problem by using a different bfq_group pointer in
> the update cycle in order to avoid the overwrite of the variable holding
> the original group reference.

Applied, thanks.

-- 
Jens Axboe

