Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB05CC38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 00:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ3Aez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Oct 2022 20:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Aey (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2022 20:34:54 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6547D14087;
        Sat, 29 Oct 2022 17:34:52 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id g62so7794268pfb.10;
        Sat, 29 Oct 2022 17:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEMUfMLVSAfkGsHTinQJUfZYW8AsZ7QM6NJJDNbHCFM=;
        b=u733/S3o/qAxFlyEsjh1SXIrz43CKEg/x7N2m6DPZIVITZzt0uRys1blSOXWMcHhkz
         or7bufDjtJaDAFF0Dwqsq+2qGxZPoZuSeEWlCE0eRMgJ+A6dMyeExai7kBDQDzpRzUgA
         9hh/NyXpk3R5aWsWmW4o9vmBiE6ULOfSFB4uwlrSH1pztXOAxrmuctDXQNZcfeyXHnKL
         G86mX4xlVVVBcQpzIalI1rcisTQ75fZ7BJBkv3v783kHlKZK7JB8QaKt/DU2osiMU/n7
         uImhb7HFlUA1MDObR+yY2vKnbGe+gGhiC9bcRNT8CRqjjn+Q9O1NltPghcLVCWkJCQw9
         a43Q==
X-Gm-Message-State: ACrzQf2jKP8wNOuzJWF+EW2VOa6J5kwLXfpvuIsA8VqkxezluB3rgAUA
        7xfR3gOlR/yIxNvmBheIyio=
X-Google-Smtp-Source: AMsMyM6sHfWrHEaUlQIPjYDTfJMPVJPxvAM9Yf6JqXOKgiz5SbTEiH7twtGhwinB1J0PRVDvvmqL+g==
X-Received: by 2002:a63:6f8a:0:b0:439:36bc:89f9 with SMTP id k132-20020a636f8a000000b0043936bc89f9mr5945904pgc.100.1667090091847;
        Sat, 29 Oct 2022 17:34:51 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b0015e8d4eb26esm1825034plg.184.2022.10.29.17.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 17:34:51 -0700 (PDT)
Message-ID: <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
Date:   Sat, 29 Oct 2022 17:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Content-Language: en-US
To:     Jinlong Chen <nickyc975@zju.edu.cn>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/22 03:02, Jinlong Chen wrote:
> Calling blk_freeze_queue results in a redundant call to
> blk_freeze_queue_start as it has been called in blk_queue_start_drain.
> 
> Replace blk_freeze_queue with blk_mq_freeze_queue_wait to avoid the
> redundant call.

blk_mq_destroy_queue() has more callers than blk_queue_start_drain() so 
the above description is at least misleading.

Additionally, the word "cleanup" from the patch series title indicates 
that no patch in this series changes the behavior of the code. This 
patch involves a behavior change.

I think this patch introduces a hang for every caller of 
blk_mq_destroy_queue() other than blk_queue_start_drain().

Bart.
