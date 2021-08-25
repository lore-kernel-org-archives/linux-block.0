Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B1C432BE
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 20:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF56961002
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 20:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHYUPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbhHYUPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 16:15:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C329C0613CF
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 13:15:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk29so772750qkb.8
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7JUe9utKIklg7WbbREol5f/k2StuipgLZg/3eym4DS4=;
        b=HiQQEhCyUu5BIN42qNWJg8J5kWmSQNWBbTEnyKng+eBnCt4JZvBY+/JqBa3P1nrTXp
         8q8TFb3+QL57fkQIO29ILeT3QbCJFz6ltjahxGwqzUqZI22s+Q1c1CKF8CxsKqDpWmRf
         Itvsb0B5DlGNYp+BSPxJF5GXraN2WYh2ErnHxUv+4SXPqSO93nqJFZsFdVb/tuhp0ne+
         nXaX0Do4ihSLGfh1rVxLCM5bfa1dHA1a6JiCiJ+8yaPfCnQxw0R9gZATiDcLLwczOMti
         xmXDnY/8ROk/PrTGTEBeJAR42+usIy4pW8ppky8Jsb3SzZQ1CrKxRNDRxH4x6wwi854M
         IeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JUe9utKIklg7WbbREol5f/k2StuipgLZg/3eym4DS4=;
        b=j/JcXbyWsOJ1MdQUKGxXrttmWSM3WRWGE5VCqb5aufFDDd3QnQPeegXnoi8F1uTj1W
         nlQRhijU6g54pZ+n17odhw+zIGwIz1wxQuB9ByaAl/nQLYSBRu+nTymb4DsX4IMBDsGP
         mAOwd+YKcvO05+SbDsOCK3N7qhJLrd5EH26paxXboKeDez8JX6NK/2iw5XkQtHXWW6m1
         yz4AEGSx20XshiiauGbL9g/gwP4buAZC5OhBPZ1cxvkhdROirmrHi/ZAbBoGjKo3lHSD
         lYZ+MibloZ8ar1lv+lC2TMZ7+/1RdUXKr5pnqREItTXjHqN8+M2tyu8xs1TR0ResXASP
         vlAQ==
X-Gm-Message-State: AOAM532/LpHvds18Bh5B00dReKnN71Ow9fnmqwumfIN1qzFmRDpWHoGs
        /ZdYgwkfgubzmpLwcg/bJP7BNg==
X-Google-Smtp-Source: ABdhPJznD+HfZVv+ttHkdzt0+Qvgl7BZglrYwPLehfVZ8hUl3QNf8vcQHrvGPBjohBzcpVluGYvuMA==
X-Received: by 2002:a05:620a:4151:: with SMTP id k17mr314635qko.51.1629922500094;
        Wed, 25 Aug 2021 13:15:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n5sm509518qtp.35.2021.08.25.13.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 13:14:59 -0700 (PDT)
Subject: Re: nbd lifetimes fixes
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20210825163108.50713-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <78dad9ba-c89e-2a30-c083-16ef0324b48e@toxicpanda.com>
Date:   Wed, 25 Aug 2021 16:14:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/21 12:31 PM, Christoph Hellwig wrote:
> Hi Josef and Jens,
> 
> this series tries to deal with the fallout of the recent lock scope
> reduction as pointed out by Tetsuo and szybot and inspired by /
> reused from the catchall patch by Tetsuo.  One big change is that
> I finally decided to kill off the ->destroy_complete scheme entirely
> because I'm pretty sure it is not needed with the various fixes and
> we can just return an error for the tiny race condition where it
> matters.  Xiubo, can you double check this with your nbd-runner
> setup?  nbd-runner itself seems pretty generic and not directly
> reproduce anything here.
> 
> Note that the syzbot reproduer still fails eventually, but in
> devtmpfsd in a way that does not look related to the loop code
> at all.
> 

Looks good to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
