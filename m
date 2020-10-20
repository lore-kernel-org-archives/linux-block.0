Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8211AC433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2394722404
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 13:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cqQOg5Tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407265AbgJTNI5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407241AbgJTNIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 09:08:53 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8AEC0613CE
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 06:08:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j8so2146680ilk.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vMjv69Q8ygJTDYUmtmqR5brlN9bQw64VIyI24z18jzA=;
        b=cqQOg5TlBhSHYK8ucEO8iGioZ3ug3JvxYTXOjTVruEHdm9SvDU5nrkAwp9nMQNNSiO
         EcwqyjcskunxgNXegcl9ilsGpyw0hpdo0FDdRoKIi+U1Q92X+dvrugsHSrDUQuM5O8NE
         db30d7d6VKywjCwMbZQyAqPxAxPxjGSAHsAN9PBY6JVofOH281yX0TUdUceYJ5s4nyf0
         G44npvNgm5E817+gLEokiS/RfoNI3E4xmOF9UEZooKfdhCoCBoT/RTPjSfK63YG4hpwu
         ZuopdYqg7vHZ+TmaHzpOqEKOq8/UT/t3M2wt1Zo2m0E9mEx0IcEPq/eBQZ2hwPrhdnJT
         +cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMjv69Q8ygJTDYUmtmqR5brlN9bQw64VIyI24z18jzA=;
        b=D7GvxSu21B6SIaCZixId61AXocSyyieFZ/sRvYKF4P9U9h7Vli+wDA/+XbTpXJ8lTj
         TPWQl1YQorYN24tC7MSW68moK0e1N6GMYeWpo+gxqzrMc5hZTB4c/aNpzjJ1PgXpnEk/
         6ElV/B63iVRCi9SrDZAB7GTSdNp18qfH9RMgHfGhYgjjZkZC0NDtyBAz0oj9CqqyNlMH
         njqQsdycRO1odjGG71+CqCcrAQ+Bb/a90VFiguLt+TbbXHhwx/9xU8H7MdyzY52Ha3ey
         YHm3gqzyrN05F6o+MoSRMi0es+imXrZbMOJ4x36qfTnWYOjdE2HiZU/J5fqkaX4ReSQf
         L1QA==
X-Gm-Message-State: AOAM531zGPrwvbjcDrpM57606+8myvu22LSpueAIc7x2incpf+N4a9J6
        h0oV71D8eSO8tCrm1DiLYlqfsg==
X-Google-Smtp-Source: ABdhPJzm9BWlfeceU/Pa8coannvqHVejEwNaW+D/pLKRy4IBr4U+OwVIbd3EIC8zCU9He1KiPKZ4fw==
X-Received: by 2002:a92:9119:: with SMTP id t25mr1811593ild.90.1603199331115;
        Tue, 20 Oct 2020 06:08:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o19sm1767373ilt.24.2020.10.20.06.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 06:08:50 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove the calling of local_memory_node()
To:     Xianting Tian <tian.xianting@h3c.com>,
        raghavendra.kt@linux.vnet.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com
References: <20201019082047.31113-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1db7f790-b4df-435b-25b1-d99222ed7c50@kernel.dk>
Date:   Tue, 20 Oct 2020 07:08:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019082047.31113-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/20 2:20 AM, Xianting Tian wrote:
> We don't need to check whether the node is memoryless numa node before
> calling allocator interface. SLUB(and SLAB,SLOB) relies on the page
> allocator to pick a node. Page allocator should deal with memoryless
> nodes just fine. It has zonelists constructed for each possible nodes.
> And it will automatically fall back into a node which is closest to the
> requested node. As long as __GFP_THISNODE is not enforced of course.
> 
> The code comments of kmem_cache_alloc_node() of SLAB also showed this:
>  * Fallback to other node is possible if __GFP_THISNODE is not set.
> 
> blk-mq code doesn't set __GFP_THISNODE, so we can remove the calling
> of local_memory_node().

Applied, thanks.

-- 
Jens Axboe

