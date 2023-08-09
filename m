Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F301BC001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 03:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHIDmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 23:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHIDmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 23:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3313F10D4
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 20:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27F162F02
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 03:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7165C433C7;
        Wed,  9 Aug 2023 03:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691552532;
        bh=o/NkuSH+uNiaN3nyTlzp/kSrx5fcQFsDn3CrPm+0d4g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=og5bdyUssv9DhhdO1sn8VrOnSu1BZNdiRrXMCQ8+SVS48pljGpBWCMiD8USPk7rmR
         YqFpC+W5UPj4KjRl/iu5TYMUtQAcFNKETPbG3STRsLbRU7wkMkRXGAA5CsXbkYe60n
         PVgQAZwRsqwaoeWelnNNYi8i5/ioSDNEj84QTL/SwHnOcIv9oPG6AfE8Eq/fMN5amY
         Rs/8WWncAB+6Sx3Cb5l+w1TR63rKgoDWqpc1AejCxVaLgXBWyJYv3Q1TZWgfwIIu6+
         vbjym6oHDztQ2Cfpj1XF2IvUdeiGMybjHZJ7r9W7qxISQ8+P6iiM71M1wvtta2K00l
         YqpjObVzhK3iA==
Message-ID: <0c740117-f398-7b12-9a0b-7ad402ca034d@kernel.org>
Date:   Wed, 9 Aug 2023 12:42:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition
 code
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-4-dlemoal@kernel.org>
 <723ae935-2374-fcc6-5a27-36cff41e163b@nvidia.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <723ae935-2374-fcc6-5a27-36cff41e163b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/23 11:07, Chaitanya Kulkarni wrote:
> On 8/8/2023 6:57 AM, Damien Le Moal wrote:
>> Replace calls to printk() in the core, atari, efi and sun partition
>> code with the equivalent pr_info(), pr_err() etc calls. For each
>> partition type, the pr_fmt message prefix is defined as "partition: xxx:
>> " where "xxx" is the partition type name.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
> 
> why not merge with previous patch ?

To make the patches smaller and easier to review. I can merge if everyone is OK
with that.

> 
> either way :-
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 

-- 
Damien Le Moal
Western Digital Research

