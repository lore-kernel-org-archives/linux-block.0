Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFAC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEQRNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjEQRNp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:13:45 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9C26B6
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:13:44 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1aaebed5bd6so8491305ad.1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684343624; x=1686935624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGmTcj4ykc79Twt9vli6YhP3YckglO6BZN5orHIct+s=;
        b=ibsFjH8WhmuweqQbEAO/kkCaNVMVuRjsOD9KGfkBXVEi4d36sRrtqeLKI0RbGMD1/n
         rahn6skJccRw+3zPw10R84x4tSyeO4Oa/+1Xr0xkMeRO9yo4U8EOXmv0TK/dM7bobtj4
         CdK6fCEKvyIA+7ROGuHGM7IMMM6+oBX3x0GtP+Z+53wRFanM9+orR/5corK14gPr89Gs
         NN4msiUbjROAXdRc6md4s/vK5aHZAxLusIevooI3kIgXccIXzylI3PqFqpzKYsXAl4ze
         x/u6+f+Xox+PMJuT2gMrx5dFGiCEfkQmcn78VtqU3SStK5vLZ824OQ0JawVSxCe7jRfJ
         wHEw==
X-Gm-Message-State: AC+VfDw6jeSXlA9PlFyC20+oJfi+lb5JJmrf6LMyxINSYL9QtZHjrD5x
        YTC+dnqv+G+sqKKeQMZBm58=
X-Google-Smtp-Source: ACHHUZ7iUBhvaPvx/LOwWqrn2qqpMBiR5YJJ+B9SBRrCrP/cphrzsubcD4znzQtkmnfkTeQ+jF0Tkw==
X-Received: by 2002:a17:902:c115:b0:1a0:4ebd:15d5 with SMTP id 21-20020a170902c11500b001a04ebd15d5mr42182391pli.67.1684343623660;
        Wed, 17 May 2023 10:13:43 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902c40200b001ae365072ccsm3777007plk.122.2023.05.17.10.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 10:13:43 -0700 (PDT)
Message-ID: <ebc44c14-eea8-7ef9-d28d-9002e4caf5ca@acm.org>
Date:   Wed, 17 May 2023 10:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 11/11] block: mq-deadline: Fix handling of at-head
 zoned writes
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-12-bvanassche@acm.org>
 <4a037c7b-ba78-0db1-936b-85e112df00fa@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4a037c7b-ba78-0db1-936b-85e112df00fa@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:47, Hannes Reinecke wrote:
> Similar concern here; we'll have to traverse the entire tree here.
> But if that's of no concern...

Hi Hannes,

If I measure IOPS for a null_blk device instance then I see the 
following performance results for a single CPU core:
* No I/O scheduler:                       690 K IOPS.
* mq-deadline, without this patch series: 147 K IOPS.
* mq-deadline, with this patch series:    146 K IOPS.

In other words, the performance impact of this patch series on the 
mq-deadline scheduler is small.

Thanks,

Bart.
