Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48651C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDKRvV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDKRvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:51:21 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8F173C
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:51:20 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id c3so9706490pjg.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235480; x=1683827480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUdKP5AliOCr8O2RG7CbLyfk4UYIJa6h1qJdgnPy7BM=;
        b=DMYkGLn+3m8oAC7PSrMdkmsvVq5tRLk55UuzMAZsPx5HJ99R22jtHU8TYeDHHqIicb
         GX7cihPwnirWQFI5nzN99HOAhjqN9typnp5916ZRZ8HCdiYCSwNuqLjRZcwPrp3N7Zjo
         8mD6bvN8VOcM393n3RmXOZU8q+/quDeUNr9qspEvhNk58s6DQlRP0NpR6DHQn65IZMWS
         H4co/T4N6pa+GcbwNdN/roVIjDnp/eyjc26iBZRgUbn6+ujjiEz/qBuNCGxWuHiRyyVc
         h7AIyThaOLn1tfv1VyrQexj5KX7/E8uu1awK8qxvNig2nqKb1b18/mi50wDe2KMyslab
         46RQ==
X-Gm-Message-State: AAQBX9cbs2Mll0SolvKTF+yLm4udb4admyGQ6+J34E/ByyVLS4t6ZMxU
        dpw2A1xpyeokzTSKLXPF+HE=
X-Google-Smtp-Source: AKy350bK0kQ4oBoCN5Sw1uT7GMAmJzKdsZPjzx924FUnxyEfm5ury0PHDc38NaAcrj7De7tLSOKICA==
X-Received: by 2002:a17:903:3011:b0:1a1:b3bb:cd5b with SMTP id o17-20020a170903301100b001a1b3bbcd5bmr2851772pla.62.1681235479937;
        Tue, 11 Apr 2023 10:51:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm9940980plb.125.2023.04.11.10.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:51:19 -0700 (PDT)
Message-ID: <a2dd00fc-2a74-14dc-8092-fe89f5b811e5@acm.org>
Date:   Tue, 11 Apr 2023 10:51:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/16] blk-mq: remove blk_flush_queue_rq
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-8-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Just call blk_mq_add_to_requeue_list directly from the two callers.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
