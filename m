Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B252C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjDKSL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjDKSLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:11:55 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE93E5B
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:11:54 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso11894052pjs.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236714; x=1683828714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPsYurmYFEja73gODgI6WxMCSj1ywc8QJh/C6g/vf90=;
        b=h2VLy/TH9KGmX8B0A2aeaxq8Qme1uoSGb6ukPcW9J0AJC0P7knyPitLVt5o7JZpJXp
         X5RxRx1x1D4OaAAnjk7CgQkSCG2yKzRO5mlT2oNAEwrJRDmm8RXe4mWk38APiUiEwsjL
         RefGNO4Av4/Nx3tt4urlvL3aIwvNcC5CSM9BJUdrDXusDhc7uyW8Bi12j0ijKavrToWH
         ifLRyzBmt23zcPS4oNaQnIPlLRplg5nBlg+agF0yuyYtP1w5zegM/AJDYuVy42UXJbJs
         r4SgaEnl+kwAHSFN4V+uIt7ZkyhLDuniyAPpCXKRo4TEJvjQxrVJINh6OYu6+dYcS71U
         d6HA==
X-Gm-Message-State: AAQBX9e1vJkVoUxQlaveRgjFep2ylJSvfZf3+iNOEvPp2Z5tc5AgOEoL
        B0Qo+1VyJAEWvwWea+1NVYg=
X-Google-Smtp-Source: AKy350bxJQeEMz2FDmBY4lvZJIzR/4ayaWZwwk0xCNhBfl3hdvvQhLYEwyOq6nGC4P5egP8I8492Gw==
X-Received: by 2002:a17:902:e889:b0:19a:a815:2858 with SMTP id w9-20020a170902e88900b0019aa8152858mr21096495plg.51.1681236714009;
        Tue, 11 Apr 2023 11:11:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b001a043e84bf0sm9944038plp.209.2023.04.11.11.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:11:53 -0700 (PDT)
Message-ID: <17f6f705-fb78-f6e3-3427-eae801fc06af@acm.org>
Date:   Tue, 11 Apr 2023 11:11:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 14/16] blk-mq: pass a flags argument to
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-15-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Replace the at_head bool with a flags argument that so far only contains
> a single BLK_MQ_INSERT_AT_HEAD value.  This makes it much easier to grep
> for head insertations into the blk-mq dispatch queues.

insertations -> insertions

> +#define BLK_MQ_INSERT_AT_HEAD		(1U << 0)

Has it been considered to introduce a new bitwise type for this flag? 
That would allow sparse to detect accidental conversions from bool into 
flag and vice versa.

Thanks,

Bart.

