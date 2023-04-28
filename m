Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D572FC77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjD1UEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjD1UEE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 16:04:04 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F722683
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 13:04:03 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64115eef620so15131741b3a.1
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 13:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682712243; x=1685304243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gjKs7VYc5wKDEcyn6vejda4uV3UzRMorLT0a9VF3Lc=;
        b=ROGxS6Nskjhplv+4zxxCelNihQs+v8LwXaaBV14LvfHjpY11ttTJk4j0BomOnTfoW9
         U9YftNPkOBZ1trWUTBxPkm1rBLAHjh2sUsR00cqINquhJTfCE7eK7hafrT2oXB4j0E33
         p10J8R2X0qWZ7xucigCtCdmpOrQvnIHmecvxrL1iV3RY+46IlVCTYH2jPCluSWu1BdAt
         JYhU3Ee8Sb34zp+CpyuNqjs0GdoY4gyiGvDDwMJvgVV7MnTcwI7tpZA4u/XUqk++rdXu
         wM8Emjj8daNfzEDTihvgqtqIFvcJEQjI7Rxm0O7P9OBW8frLMEPILrPqJvA9KOBMkv8p
         JDkQ==
X-Gm-Message-State: AC+VfDy00nprXQsHEvu38UlhhKboX5BuGbd+pqpG8LKX2aHm7FsBHgGy
        /I4QHcF+TwUqK8OXkYREAS58Fl071OY=
X-Google-Smtp-Source: ACHHUZ5oCajD+yXWDZm6tpolBRl61vfJZqgB7ACcqtooKnn06kPqwbiUVRXGc1L/JIgnjZNawVmGAw==
X-Received: by 2002:a17:90a:6e08:b0:246:b9e3:aab5 with SMTP id b8-20020a17090a6e0800b00246b9e3aab5mr8049144pjk.21.1682712243120;
        Fri, 28 Apr 2023 13:04:03 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id gv17-20020a17090b11d100b00246b0faa6b1sm13302655pjb.5.2023.04.28.13.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 13:04:02 -0700 (PDT)
Message-ID: <393d9f71-da77-a1fe-5b63-d8afa92dad90@acm.org>
Date:   Fri, 28 Apr 2023 13:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 7/9] block: mq-deadline: Track the dispatch position
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230424203329.2369688-1-bvanassche@acm.org>
 <20230424203329.2369688-8-bvanassche@acm.org> <20230428055005.GH8549@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230428055005.GH8549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/23 22:50, Christoph Hellwig wrote:
> On Mon, Apr 24, 2023 at 01:33:27PM -0700, Bart Van Assche wrote:
>> Track the position (sector_t) of the most recently dispatched request
>> instead of tracking a pointer to the next request to dispatch. This
>> patch simplifies the code for inserting and removing a request from the
>> red-black tree.
> 
> Can you explain what the simplification is?  As of this patch the
> code looks more complicated to me..

How about changing the patch description into the following text?

"Track the position (sector_t) of the most recently dispatched request
instead of tracking a pointer to the next request to dispatch. This
patch is the basis for patch "Handle requeued requests correctly".
Without this patch it would me significantly more complicated to start
searching for a zoned write from the start of a zone."

Thanks,

Bart.
