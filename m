Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4847EC77B75
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKSQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjDKSQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:16:32 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB849E1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:16:31 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-635df3bd6e9so3552735b3a.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236991; x=1683828991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52lBxynScGNI7uHHI1EohSt5yBgJhJ12twwJdxsqCp8=;
        b=bmyC9MXT7kNrdXbNnk6V2VLylfYryivhBHrVo61sBYBWa8SUA0vdZFl/xeVUIvTnVO
         LEeWuFNHosIX1XbvJpS0ipctOAoUAJj2ksYt030xrqQRApUqX7sszwHqgMBYrHK1LSkD
         ybzYl5PziKOcnSfGRvc9ym3YoofcSe6TP3diiBocv5SrbNleGKC2jpZaFwjEuW3wm15x
         Kv3X3TzRr961wn0TpjD5bfe01ggttEzeyD9Hf/33vVi4v0Uuft9o8/vPhp9GFprnMrXP
         cq42A7XSspi4shpYGPpLs6PmrJDT/l0+l3NqtTOkJAqDgyEKf92Xgdy4PlihlPn8/8au
         lhxQ==
X-Gm-Message-State: AAQBX9f8rwoEvpbhoru6ABJ9mjCepYv6sUGc+2PepapF90pcd1dLjq8t
        USRR/2qr3J59Vpi2s8fL10WV7jnw1s4=
X-Google-Smtp-Source: AKy350a346bFKE6OWcIuSDnz4HmPl/a3yLDe+G571Gkd6pIs8fizVrkXeogqHEuzIRh9CghSHPqiLQ==
X-Received: by 2002:aa7:8383:0:b0:635:d9e1:8e1e with SMTP id u3-20020aa78383000000b00635d9e18e1emr26578pfm.11.1681236990929;
        Tue, 11 Apr 2023 11:16:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79110000000b0056d7cc80ea4sm10202857pfh.110.2023.04.11.11.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:16:30 -0700 (PDT)
Message-ID: <c5f73293-c804-9513-d68d-3d0dca8a9e7f@acm.org>
Date:   Tue, 11 Apr 2023 11:16:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 15/16] blk-mq: pass a flags argument to
 blk_mq_request_bypass_insert
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-16-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Replace the two boolean arguments with the same flags that are already
> passed to blk_mq_insert_request.  Also add the currently unused
> BLK_MQ_INSERT_ASYNC support so that the flags support is complete.

Hmm ... which two boolean arguments? This patch only converts a single 
boolean argument of blk_mq_request_bypass_insert() into an unsigned integer.

Additionally, I don't see any reference to BLK_MQ_INSERT_ASYNC in this 
patch?

Once the patch description is made more clear, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
