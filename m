Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9529C7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDKSSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDKSS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:18:27 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D324C37
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:18:24 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so11775519pjo.4
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237103; x=1683829103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS65+jamzKSIInYBGdb/Al+BBw1pve5IdPxvGHGhnvo=;
        b=co0psv862PcqZtbLt47u++qiu7LDj9jEsoGMa5bJgpor+PkvZG6mCjds8rGKpVxqpk
         oDGot/6svFnNzQeRTOBbRRLbL6T5Dw4NUS43KLt+EFK3uUQn/x/JJp1xRoHSlRlQ4BWD
         WdCG4DeLW4GQsoQ48FBjfKsgVvEcxPILURJ1q2T/PTffAxZGjZEWc1Xwn+M7P9GtmWun
         shR0I2/MjRNXM8FSj/8gr5w1AAPMDK5CNy9oASp1/C64gpnsjkr4jNYMsBE8hCNKCH6d
         W3Jlxp5XwOnUxdrPKp9Va9z/98qCLoIbA7P8jMRCK1JDn8pbKt2mdU5UhBWkXNZXiy81
         ++XQ==
X-Gm-Message-State: AAQBX9ezUmCRLk8+3QsQMtZFd5OQ1uJX3Nfhy8i/krjzooVSz3BX6XEJ
        yy0xT5b6GzTxdy1FxoYGyFY=
X-Google-Smtp-Source: AKy350YvR0Kg0p7HwU7/LcRuTUs7xImOW5imTCGl+0yD8mJS4TJ9KybN4w9LKiy/23VTgbWRWqZPOA==
X-Received: by 2002:a05:6a20:6055:b0:dd:ff4f:b856 with SMTP id s21-20020a056a20605500b000ddff4fb856mr18181892pza.26.1681237103440;
        Tue, 11 Apr 2023 11:18:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b00593e4e6516csm10127034pfm.124.2023.04.11.11.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:18:22 -0700 (PDT)
Message-ID: <a7496606-c2b2-a0a0-137a-6a26bd2beade@acm.org>
Date:   Tue, 11 Apr 2023 11:18:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/16] blk-mq: fold __blk_mq_insert_req_list into
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Remove this very small helper and fold it into the only caller.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
