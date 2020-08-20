Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F132C433DF
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D8D2075E
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 15:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgHTPoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:44:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43514 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgHTPoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 11:44:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id y206so1210088pfb.10
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 08:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u8Sn+Pfg49VpUlwagz5wgkuY6jeYasKi2tCKCMPTqfo=;
        b=CHvykiJkWXts87oUfeo9CJETsb8XsATMa+d1QkIGnXVXnNAFOOy5Q6KdCfnCVAHx4r
         SNlx1hZ3Y5ZaYh0NFUQ2F2XbQIX7l3dEaTYnlF++I+En+/eEzOGrJVZmfey9o4ogYfJ4
         83g6UVRgqgb0qJJ34JlUONYPaQ6OTPbkkFmlQkbLL+jOqyrTVy/Wy04ylwAdXAXcteGB
         8DsfQiYaTLDyZY+dyTdplG8YS/Mpiv8OmygJbB2ahxjC5vZIscDKXrwo9heclbu1y4Bn
         VW7gNKU1gemlVlbIJjraUIpD8SQ3dQcvOpAIk/j6ws91XEalUyzHTEZDIIVQMSL2m8Nl
         NVPA==
X-Gm-Message-State: AOAM5321lgfix1oT2+N4C603CqklegQcYAw4Xg0loYPJCjNehb4pzRmY
        jUVCAwNgq0NNRY8Mv8ElT9g=
X-Google-Smtp-Source: ABdhPJw747cbKTtuaMrv2e29HAE9Ea/H1YS+qlJLyS6e+z6x/elBGl/Gp+tkBW/5wAAnb0EiGSxkbw==
X-Received: by 2002:a63:e154:: with SMTP id h20mr2844731pgk.428.1597938255508;
        Thu, 20 Aug 2020 08:44:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3? ([2601:647:4802:9070:7ced:8569:4373:1bd3])
        by smtp.gmail.com with ESMTPSA id r28sm3278280pfg.158.2020.08.20.08.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:44:14 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
Date:   Thu, 20 Aug 2020 08:44:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820082918.GA12926@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> We really need to take a step back here, I really don't like how
>> we are growing implicit assumptions on how statuses are interpreted.
>>
>> Why don't we remove the -ENODEV error propagation back and instead
>> take care of it in the specific call-sites where we want to ignore
>> errors with proper quirks?
> 
> So the one thing I'm not even sure about is if just ignoring the
> errors was a good idea to start with.  They obviously are if we just
> did a rescan and did run into an error while rescanning a namespace
> that didn't change.  But what if it actually did change?

Right, we don't know, so if we failed without DNR, we assume that
we will retry again and ignore the error. The assumption is that
we will retry when we will reconnect as we don't have a retry mechanism
for these requests.

> So I think a logic like in this patch kinda makes sense, but I think
> we also need to retry and scan again on these kinds of errors.

So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
cancelled requests and have the scan flow assume that these are
cancelled requests?

At the very least we need a good comment to say what is going on there.

   Btw,
> did you ever actually see -ENOMEM in practice?  With the small
> allocations that we do it really should not happen normally, so
> special casing for it always felt a little strange.

Never seen it, it's there just because we have allocations in the path.

> FYI, I've started rebasing various bits of work I've done to start
> untangling the mess.  Here is my current WIP, which in this form
> is completely untested:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup

This does not yet contain sorting out what is discussed here correct?
