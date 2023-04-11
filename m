Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EAC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDKRtJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjDKRtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:49:07 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CB0559A
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:49:03 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-244922a6b71so768675a91.3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235343; x=1683827343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ790QHpuBhyxw1A9UHzrUJ7pekhOOUQjD9gFu2jTEI=;
        b=pg+zzYohlMg9zTUEphXBjyN4nwTwAqTwFdp1sMt25HWX6/kvGz64gNRGUTNn4guM6R
         Sb2b9QxUeHahzQaKK4q0P6k7wiTU0eFBXzisWJ1RtGbgjsH+VZyF5jPp16Muo4+UsGqK
         WTNU2ku3kwgt7zpfjxDxoIJOzQm41Axx1DiDHgh/5sisfFXPdiSW7O+mUHlCR1XTWekE
         mrIxcHOfowwdwUbcc+406YFfFwPFyZm2MZ/xYq8XpqOUDv5gd0yztZRHsLv8lI6NGFvv
         SWCtbgLRxmagq38rsqRyM7B2LyGo6Gh3kRe73OpmwH1mkpqKao/MWYqPVJ6awydIFRFW
         BPTg==
X-Gm-Message-State: AAQBX9frL9Z7RaWBbx8gSkAOeNPHncTgM7sqHuaIHXlHMOwjQNNy5pFz
        i4p43+yZTBi8cZMxbCzRAEg=
X-Google-Smtp-Source: AKy350aVdVz1veglgMU4AbrPEUlgsIbuUJHWFe3pSaYhq2UabcebJNSiWaz1QKnCRgffyynoN1VM4Q==
X-Received: by 2002:aa7:96d3:0:b0:627:e577:4331 with SMTP id h19-20020aa796d3000000b00627e5774331mr16674208pfq.1.1681235343081;
        Tue, 11 Apr 2023 10:49:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79210000000b0062e032b61a8sm10100899pfo.63.2023.04.11.10.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:49:02 -0700 (PDT)
Message-ID: <2f85f3d2-d519-b8f0-94ce-bfbb110eb037@acm.org>
Date:   Tue, 11 Apr 2023 10:49:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/16] blk-mq: fold __blk_mq_insert_request into
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> There is no good point in keeping the __blk_mq_insert_request around
> for two function calls and a singler caller.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
