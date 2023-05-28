Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61574C77B7E
	for <linux-block@archiver.kernel.org>; Sun, 28 May 2023 20:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjE1Uux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 May 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1Uux (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2023 16:50:53 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59634BD
        for <linux-block@vger.kernel.org>; Sun, 28 May 2023 13:50:52 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d24136663so1788928b3a.0
        for <linux-block@vger.kernel.org>; Sun, 28 May 2023 13:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685307052; x=1687899052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDAV33FcVT+F+L2puiKpOvTS/us25nNABDQuRIAnp1Q=;
        b=U+9ZnIAAoCwrVIy1ilWYUTc+klsna2CbKBevisxRyuOPjlr9xqEpCyHCx+8zCl7jq7
         6/Bjrp5EdOZipV7KvlW/3/SgOfD/X6yHtf4Rv9Wmz+lY4vGZMuu71+rTUFMa6Zjd/Yr0
         Q0vYv9EzPoRfH78bqlSLW1oxUD8K4u341FCIOV6Yonz6H2XD5YnhAicSGlgShOvDs4jy
         Nlq1qag+Xn4vy2/4d4sjWqSmFT+wM4uL+L5f0ADGg/K/apWzRsuFEdnkYTdPqPyw+2b7
         3usTNUVNalS4vvwK4K4+ejn/VyWebaIjxNtTCglsoB5qDV8Gi5hUjx55EsYbyVhNhWBR
         sbEg==
X-Gm-Message-State: AC+VfDw2jv9ETPx3ZfPxNzxalBr69nHpgFN9t53LoNLvbA8wUYZTRo+7
        M9N07U01TDmbbcsU+CEt6VM=
X-Google-Smtp-Source: ACHHUZ4VwUAu/lJSJclKMyIZv6BDA2DMIqFhQKT35CWFRTV9rMKcgywoAR1yJllCApfjY6ku0HIn4A==
X-Received: by 2002:a05:6a20:840b:b0:10b:bad9:1d31 with SMTP id c11-20020a056a20840b00b0010bbad91d31mr7640795pzd.26.1685307051550;
        Sun, 28 May 2023 13:50:51 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b0063d44634d8csm5537085pfm.71.2023.05.28.13.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 13:50:51 -0700 (PDT)
Message-ID: <d2e12e08-3a5f-2f5b-e3d1-2c1ea39d716b@acm.org>
Date:   Sun, 28 May 2023 13:50:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-5-hch@lst.de> <20230524055327.GA19543@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230524055327.GA19543@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 22:53, Christoph Hellwig wrote:
> I turns out this causes some kind of hang I haven't been able to
> debug yet in blktests' hotplug test.   Can you drop this and the
> subsequent patches for now?

Hi Christoph,

Are you perhaps referring to test block/027? It passes in my test-VM
with Jens' for-next branch and the following blktests config file:

TEST_DEVS=(/dev/vdb)

It seems to me that the entire patch series is still present on Jens'
for-next branch (commit 05ab4411bd69b809aa62c774866ce0b9be072418)?

Thanks,

Bart.


