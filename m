Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D363BC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjESToX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjESToX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 15:44:23 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3624318D
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:44:22 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d426e63baso321895b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684525461; x=1687117461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANN3zrnMy/seAq9+gwJBM5fspOXEE8GXxdamv4CVutc=;
        b=gUHwmY4B7tx/iqYyDy6gPnwyPhnerhJzizPJC2SsiVKIU66ThfEX5u3lARfbCrDzZh
         M2r9oXK04jEpTKabwIEGWoyJ/BOK3TJ0OySHe5s2ORwjoL2hjPQFuMm+sTN2ADDyPjtO
         v4MfI3opy3aet0QOYMN8b8lhDMfVxWE1Fzehd4nUYxaRMP2yq6oboTv3wFqMbAlm38Gr
         +RfP3hBDDNpucn/uHNr89W5BJFTj1WrhcdeUUIElXvyntNiUo0kyKAu6aGDnsEvLmFpV
         RUMVttL9QLiV7sip3OzvZ2L+FHivViwI0f/J55qaSfsu6ksM5i+lf83mQyMo3jbsgSZh
         HsEQ==
X-Gm-Message-State: AC+VfDyKsRoxkjl9VEcG98DkMsgcyZdhhA9q5aj66DkHx2eYR5/jnEku
        84aVApFLv5Q+GIBtEiLC2pM=
X-Google-Smtp-Source: ACHHUZ48YeIWDzU/z2rIU9TCwTL7U5x+ReU8bY981ccSS4eWWoCiFW1I3K8Pkhj7vM7cu367bWtMLQ==
X-Received: by 2002:a05:6a20:1590:b0:101:8b:43a5 with SMTP id h16-20020a056a20159000b00101008b43a5mr3644409pzj.8.1684525461336;
        Fri, 19 May 2023 12:44:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090ad49000b0024df2b712a7sm7248pju.52.2023.05.19.12.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:44:20 -0700 (PDT)
Message-ID: <27e6ec54-cd3d-0804-fde4-847182895b83@acm.org>
Date:   Fri, 19 May 2023 12:44:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230519044050.107790-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 21:40, Christoph Hellwig wrote:
>   	/*
>   	 * Three pointers are available for the IO schedulers, if they need
> -	 * more they have to dynamically allocate it.  Flush requests are
> -	 * never put on the IO scheduler. So let the flush fields share
> -	 * space with the elevator data.
> +	 * more they have to dynamically allocate it.
>   	 */

(commenting on my own patch) How about adding the words "private data" in the
above comment to improve clarity? That will change the above comment into:

	/*
	 * Three pointers are available for IO schedulers. If they need
	 * more private data they have to allocate it dynamically.
	 */

