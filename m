Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F991C4332F
	for <linux-block@archiver.kernel.org>; Fri, 16 Dec 2022 01:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLPBgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Dec 2022 20:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPBgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2022 20:36:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907602E9F2
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2022 17:36:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g10so820008plo.11
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2022 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUxgBUchjwfFgwVAeUZQZdjmftiHITCsE/ZmyrGERkU=;
        b=mdtb/tPulG/eVWDSw679Lrwa7QpZngLol1fZQKHbE1PKOGFUbwuGWOvkcGfRewp6C4
         0oJDkz3zRqQNoNs5XcwiHZXnPPNtE7YJqvaznHg1asrR7IvO74Smf0Zz3DWfOGADJeL5
         i6Yon1OAe+Igj6MNkP1ZzTB4gATPzqhaZcyn4FECAq0eNpfTzsrY/4qN6/5Vak8u5p1j
         Cwbz3TH2ASjWQtWBttF0XHW+FvE5DR2fx3CZKvAAaAHXNpICh8B0ZAeNlme5acUYVbpP
         yEX9u+tX2f5FtvkHAp1bRxS1u/QzwNcNrSpGshNreNvuYU1OmXpwquDmvvtKFWcSS6gb
         dQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iUxgBUchjwfFgwVAeUZQZdjmftiHITCsE/ZmyrGERkU=;
        b=VfdYC7z3D1VpMdSQb3FqXrtfdNFBG1rxOma84yAU9SFAMB6tlQCgSjqwvE5/UNZ48k
         y0NdarXmeE6sjuzlgM6waPlbOfhr5PmvySM4BHRNVAHsazoAXXwCTJMdHul8CwLyMzuo
         S0CshMT/ehhVyRCAbcXJCwml6X1Z5CbSxuO/Zbr82hF6S9HupriiEE87f4zFyAG9qV2r
         9RZoH4OJTUGOfVkujK8ujJJvwc8tIP97nsyF3fYB6oNbuMEnxzKU81pz/oUhrL3vx6XE
         TBDD5x3JKQuyfrii/leaZyeNvbNkfPNprlU7by7UN+B1qVWS4aigzqFSl7rBUkqLNryS
         EQ1Q==
X-Gm-Message-State: ANoB5plNwQawHmqWT/af7+W4edmeBiCgSkAJCVsSP1AxrfKnExL1LGCG
        mg+FIRTxSOOq7MUKNQfNByBJRg==
X-Google-Smtp-Source: AA0mqf4qSPK+ZjERyg/LrIl71EiqbTjU4LOZ0M23UCRKAvLA1SmHu7MIKHSM//hIgbE/53rknX4M9w==
X-Received: by 2002:a05:6a21:2d8a:b0:a5:cc8f:cd14 with SMTP id ty10-20020a056a212d8a00b000a5cc8fcd14mr38001497pzb.35.1671154572077;
        Thu, 15 Dec 2022 17:36:12 -0800 (PST)
Received: from [10.4.227.8] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id n20-20020a638f14000000b00478c48cf73csm332438pgd.82.2022.12.15.17.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 17:36:11 -0800 (PST)
Message-ID: <2bd8080a-6b57-124d-c3e0-6d5baf4c2ce8@bytedance.com>
Date:   Fri, 16 Dec 2022 09:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [RFC PATCH] blk-throtl: Introduce sync queue for
 write ios
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
 <Y5et48VryiKgL/eD@slm.duckdns.org>
 <1e53592f-b1f1-df85-3edb-eba4c5a5f989@bytedance.com>
 <Y5tPftzjXN6RcswM@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y5tPftzjXN6RcswM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/12/16 上午12:46, Tejun Heo 写道:
> Hello,
> 
> On Wed, Dec 14, 2022 at 12:02:53PM +0800, hanjinke wrote:
>> Should we keep the main category of io based READ and WRITE, and within READ
>> / WRITE the subcategory were SYNC and ASYNC ? This may give less intrusion
>> into existing frameworks.
> 
> Ah, you haven't posted yet. So, yeah, let's do this. The code was a bit odd
> looking after adding the sync queue on the side. For reads, we can just
> consider everything synchrnous (or maybe treat SYNC the same way, I don't
> know whether reads actually use SYNC flags tho).
> 
> Thanks.
> 

okay, the patch v1 will be sent based on your suggestion.

Thanks.
