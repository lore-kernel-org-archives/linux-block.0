Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC1EC49EA5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D7A613E3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhFXP4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFXP4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 11:56:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404CC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 08:54:14 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so6081481ota.4
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQ3mrMP5A65hndWth+b0LVNbcFy+IhPV+TjaBxR0TZ4=;
        b=JU7KVpNjyD5F7a+L1JBI4+cHo/cPNHomZ/lWoRsz2POOaMNODi6uyM+P7HiBvfN5/L
         OAUrpDsuN93cioDZJl+XdgTNWHErTC1rLX9TwWsj3RSYXtHZAH5loeNF3/FebNz3ZL4d
         qkhL7aLHGdSzfPnJ8B81rJLdQkP/rWkoMghfP31LD6Xt9iZ5wnGvgahJcwtStTNd8mpC
         YtxIPdjonrxmqeuBvyYIm2QDUoURdVT9eJk444Xy1Br4D8YGR8ySM3xTJ3S7UyT/ILXf
         4WzTpOWOaslWmPU5dZrdinHLZxGqpL01ORiECZOUMCct9p1QmyyYCXnBcEmcOzT/8itd
         oMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQ3mrMP5A65hndWth+b0LVNbcFy+IhPV+TjaBxR0TZ4=;
        b=a3oHD86sHSUm9F5KCaeZhjY94wfqGZKyoatME7l9r3ZdysMa555IfkrWcwylMUReuS
         XVvDhtma1aRBW6zkFC5xLTlkZmZfJIG/gzk+g2j6r1j1Xn3j0r+oWw6lvP2dbZLPotsP
         MemFtIc2qgor5HNFAjtBDmfBZSkOeh5ntPknJyq3tk5Nk7bH2znzrr21Lunv9qlHXjXz
         ralBfqWSnHj/yYc5hXhsCCHfT7BauAqQYT9hSj0JjeQ25Tu87QgTIhqtYLMtyqO5dAyC
         O/oOA023VKPU50YFBf0l21CywsA65t8reU+DX7udVrBgdv198+7gnEBcUhQJMIdVSz7+
         ySRg==
X-Gm-Message-State: AOAM532QG3ZoqJSt+ZmLbi0JrwBgT9x/JRH8fIQiY85OWiKkeq81WupK
        eW3BI5YT/3Qhzot9p/lhm+cDtQ==
X-Google-Smtp-Source: ABdhPJz7cFjUzoJofL5Yv52Ws4njxQHN777y/lveN/RFoj4zMUeALrUNA46nEwNzXnDwjZWL4JQ32g==
X-Received: by 2002:a05:6830:15cd:: with SMTP id j13mr5254350otr.147.1624550054100;
        Thu, 24 Jun 2021 08:54:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id q5sm356389oti.56.2021.06.24.08.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 08:54:13 -0700 (PDT)
Subject: Re: [PATCH v4] block: fix trace completion for chained bio
To:     edwardh <edwardh@synology.com>, neilb@suse.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com,
        Wade Liang <wadel@synology.com>
References: <20210624123030.27014-1-edwardh@synology.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff63b647-0c0b-e7c7-0daf-499dc358e0dd@kernel.dk>
Date:   Thu, 24 Jun 2021 09:54:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210624123030.27014-1-edwardh@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 6:30 AM, edwardh wrote:
> From: Edward Hsieh <edwardh@synology.com>
> 
> For chained bio, trace_block_bio_complete in bio_endio is currently called
> only by the parent bio once upon all chained bio completed.
> However, the sector and size for the parent bio are modified in bio_split.
> Therefore, the size and sector of the complete events might not match the
> queue events in blktrace.
> 
> The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
> completion of all bios.") wants multiple complete events to correspond
> to one queue event but missed this.
> 
> The issue can be reproduced by md/raid5 read with bio cross chunks.
> 
> To fix, move trace completion into the loop for every chained bio to call.

Applied, thanks.

-- 
Jens Axboe

