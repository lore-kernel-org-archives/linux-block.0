Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F68C761A6
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjDFONG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjDFOM4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:12:56 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD4A83C1
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:12:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-325ac3266a1so263275ab.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680790374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqh19fkOr0pi7dX65UY+GAAk6xTRxBZRTJ5c5VySkMM=;
        b=cIpruUuxWqhYJ5N7xSwL0s9breWS1dch+YX9FYKKx9Q9tNVGRtAHiIY1VPGll8X+35
         dVBwLSkSnWBLU0te63OGQ+n2BBPw+x39v8+UaMt2AlfQIFWD08Z9j1DDWuWvc0flJAML
         ubswh+oGaO7G4nP8vJmMDDDsTTGdLIoSrwqklaSbNbTY97c+AuaouR12Tp7LRk2nJcwc
         eE7cV9pmJ1v9Pt8btJk0DEE18+QPV0vlZxafnc5OxLGtcFFsXISktmcYi2DDruskYMAz
         NB62Ba+JNB/1TIIV6HLdxLFshTCcaSaddlbeJpORqkRD8fPrzJKCQ13pMAShN+QViqVY
         P4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqh19fkOr0pi7dX65UY+GAAk6xTRxBZRTJ5c5VySkMM=;
        b=GvqvSw8VH4a7/XRWMBjOLOOuYKAEvl9eC0lXUoZ3gjp5kX2yKivO1CpFOf6BUcdtWe
         k/aJuJhNUqCkf7Jybgzm0IkA6bEB8rHyw2D5ku5mvcVCwAHaqSaBH5rzhh1JIBrhZHqk
         DtJt8NI861p4tVKOKvpQmcntQqVk/6WZCdRoebhPfKKa7eyD3xNe4TqtOnoL5y1SG74l
         N2hA5+y3/zbiQUeLVir2SZXBH6rGgAUEvN7zv5N4XbWu/ejFNDwDj+/q1vdfZwyj3edS
         vD6pCKvDjg5QufTYp0lNMo38ldbkbc3eiVRw4Xcugj6oVjzzbWh41L75Iz4nry+/2u00
         c9xA==
X-Gm-Message-State: AAQBX9fNEB58A65vitJu1sYeXIHYiUFOP1DNkI92Jyzs78m+BUi63bGz
        LJH/G9Gj3k16pwDg9deGJ3MC6Q==
X-Google-Smtp-Source: AKy350YoLHhKBysGu8vXUaqghH7yrxoog5J1+Qw5ElQjnE8a0scXGNxxVNcHyB66T7XnGcyQDYykHw==
X-Received: by 2002:a05:6602:2d11:b0:75c:f48c:2075 with SMTP id c17-20020a0566022d1100b0075cf48c2075mr4232485iow.2.1680790374294;
        Thu, 06 Apr 2023 07:12:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 62-20020a021d41000000b004051ff71eacsm402443jaj.144.2023.04.06.07.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:12:53 -0700 (PDT)
Message-ID: <e9c66380-40f4-9ed0-4cf6-8de0c8b5f26d@kernel.dk>
Date:   Thu, 6 Apr 2023 08:12:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fix for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZC7PkTumUFAzsKNJ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZC7PkTumUFAzsKNJ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/23 7:56 AM, Christoph Hellwig wrote:
> The following changes since commit 38a8c4d1d45006841f0643f4cb29b5e50758837c:
> 
>   blk-mq: directly poll requests (2023-04-04 16:11:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-04-06
> 
> for you to fetch changes up to d3205ab75e99a47539ec91ef85ba488f4ddfeaa9:
> 
>   nvme: fix discard support without oncs (2023-04-05 17:13:17 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - fix discard support without oncs (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe


