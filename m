Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B883C433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiJZMvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiJZMvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:51:01 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE35B11E
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:50:58 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id v1so26130879wrt.11
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KrPFs4IfAGxr3tmo+EUs72l07RV7PvTD5tZZwdkHCzkFqGMO89aqVauDxc5Gj1byDw
         GkcxceMFQnPiEaBdNOv4yPuIo2lB9/LHLfDSzPl3oPxC/i4HfYwS8tMnptUVK7mi947l
         u+WfAxn2mOZJPwGZryKRbA5RtB6UkpgtqyuS+IHqvLWuduVs0RYnNgMm53SkRUB7d9lD
         VCoMuKvP3tmPB+gxdPwl+Aq04cKsbYMbe1rMBCK0sEhkvIn3Wn969z4tXGgQzEkCI+0p
         /1Ounb03hutafhjsfLDI/EtqUsT+A4+8QNZCCx94Pr+fxzigpLiaFaiGDrEM5g8ZWVP7
         72YQ==
X-Gm-Message-State: ACrzQf2Jvwav6fhLgjomcNvr+1l4DMkN7CcsXz5vKXdR4ylA5u18Ch0i
        a/YbwcS6XMlkZguBzsJFCB8=
X-Google-Smtp-Source: AMsMyM7j8g5gDApICIiyw1GG+VZ7Ev7hCn0g5R6rwI4IFKu5jTHbwMyG0z8s60fQO5/jPbfTL1DZnw==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr29024888wrn.251.1666788657578;
        Wed, 26 Oct 2022 05:50:57 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c421500b003c6b70a4d69sm1675224wmh.42.2022.10.26.05.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:50:55 -0700 (PDT)
Message-ID: <fbd7ea75-bae6-b597-b77b-fb7df88dad8a@grimberg.me>
Date:   Wed, 26 Oct 2022 15:50:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/17] nvme: remove the NVME_NS_DEAD check in
 nvme_remove_invalid_namespaces
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-7-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
