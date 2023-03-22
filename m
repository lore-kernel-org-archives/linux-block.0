Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F0C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 09:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCVJKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVJKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 05:10:05 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD25D88E
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 02:09:43 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id h17so16192806wrt.8
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 02:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476140; x=1682068140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h40FAMHEonffoTpqkkXO45XN1zo3tuXeo1DoCo/mEwc=;
        b=HQ5w//uVJu39wEU3wF89jK6F/o9LWuAB9ToZnf43HShKgWLy7ZbmEg4aBXRMwPmzen
         LhQamAK/vU+/xKaPwvOw9shnrb5KsOYdJ1Gys3+Pug5ZfLqpKhphatTtcm6O9PqpYGm9
         YP9aPQrKjLev4RCMP0ChbXF4Yuv7EWszg4FmoursYrvvPKKpGWDu1Fv2pSQI8zURHdXF
         L/QwKIhwuo6waZR5z8e0URUWHR1LkhGgM/HDSJ1vn3L7xPyc+3Dz2WXIiTKqlKQmI63f
         HiNIsEH1UxmrqC6Sj60V0CIXo4sYR+gDVsuGvECHOON5e0M7Sj/OCSKzoI4KlTlYJ52R
         VWsA==
X-Gm-Message-State: AO0yUKVPQnKxPdyhuo0T0wJjS86zX/7H2LxDL9yLfsb8bW3Y4MF3UyD2
        mO2w8BwC/NlXjjphihVpAuo=
X-Google-Smtp-Source: AK7set8yMc8Me6Dj5dRzONNSWjCH9IM/yeOPp6k6riRkNytCNO9czTUZ8n67OBTyVX8oetA5tjpFjA==
X-Received: by 2002:adf:edc8:0:b0:2cf:f30f:c916 with SMTP id v8-20020adfedc8000000b002cff30fc916mr3768351wro.4.1679476139983;
        Wed, 22 Mar 2023 02:08:59 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm13317443wrt.110.2023.03.22.02.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:08:59 -0700 (PDT)
Message-ID: <3f95e5b2-234f-2121-1296-43c2efbcfc8b@grimberg.me>
Date:   Wed, 22 Mar 2023 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com> <20230322082336.GB22782@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322082336.GB22782@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This should go in unrelated to the rest of the series.
