Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E9C19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiHKOiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHKOiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 10:38:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C38E454
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 07:38:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d20so16639354pfq.5
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bq8Wh0DBxA9ofnc2B4ZWJo4uKOzB9xAeDGowWbZAsis=;
        b=URNVc5r9o1mFF0mYIf+8A1j2TJ3rqj9AxopPpMAE2MYBm2p+SKUbJDbR0h4xAH4vag
         2KVdVrBjaavulPDrGKQqp/8DoEQqpglldqFBhbWBhk+gFUG/f7moT19A4ibj2bwfDUg9
         JNp93jrsYpAW5BCew6/CvHSooFLrV6Paj/VyQDpCQjYOU4r5VPCj2Xmi3NB2qB54QYlN
         Wy70X3pCwqttCOCpYEnj21lYGufGGwF5OrEXEsN1FLle4wnJn5dMj25ft0vmvq6op2XU
         DAtr10kWephsQg2lURjJUiAbNjyo9TghjtwdSlMIpiZ4EhCs9xxNA5CE/NI3bz64JVhV
         4oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bq8Wh0DBxA9ofnc2B4ZWJo4uKOzB9xAeDGowWbZAsis=;
        b=ooT2hvw8YNHkLrFdAyTYrBf1DxTDJkqgDr4lw/NGFx9AtY7BoqyLyp3TZUt6pZsCMt
         eKVQcIUbkCjkfv2hZtNZueFQyPK4JM4uUJS2h7W2NHB7zusoSQssuQBuw0NKjT0U9Y8y
         igwxqXPaV9hp6CY4r744959DQ/5J0s42LRvb4tlcqKYrSsR9//J0dhKye6ZxadYDb+EZ
         DcDLy07syKlKkFqUuCQnnQ5nv7k4sQfPWsTzN01QFTggRfNdLQb7skKL3yCr84u6kgYx
         ddLpo2T1DcKZHs+0otBHnz/18jSQpXqlhs9qLM1q+jprYZteecJZ1htANlIV0Dew3But
         BLOA==
X-Gm-Message-State: ACgBeo0ZlCmZ/07eVse00N4TyfsbHrjPX7xR0NdS1H8q9RF6X1u0vBHY
        /9vg3xhOkZTgYzfqpfdnOSa5eQ==
X-Google-Smtp-Source: AA6agR5ghk48s+57bs2yaHWYiSDnjVUXtjDn9nYHemrBcLJdO2HNFpXKFnzZI/hk2teoa5uAupbqBA==
X-Received: by 2002:a65:6c0c:0:b0:41b:8696:d9d7 with SMTP id y12-20020a656c0c000000b0041b8696d9d7mr27187458pgu.16.1660228696634;
        Thu, 11 Aug 2022 07:38:16 -0700 (PDT)
Received: from ?IPV6:2600:380:766f:10a9:aeaa:ac41:5e56:1dd? ([2600:380:766f:10a9:aeaa:ac41:5e56:1dd])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a4e0100b001f510175984sm3677817pjh.41.2022.08.11.07.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:38:16 -0700 (PDT)
Message-ID: <956b18be-0649-abb7-968d-eb034cc468e3@kernel.dk>
Date:   Thu, 11 Aug 2022 08:38:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YvUMpS5PxgJSykCB@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YvUMpS5PxgJSykCB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/22 8:05 AM, Christoph Hellwig wrote:
> The following changes since commit fa9db655d0e112c108fe838809608caf759bdf5e:
> 
>   Merge tag 'for-5.20/block-2022-08-04' of git://git.kernel.dk/linux-block (2022-08-04 20:00:14 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-08-11

Pulled, thanks.

-- 
Jens Axboe

