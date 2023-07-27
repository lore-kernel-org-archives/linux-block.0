Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B3C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 01:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjG0BD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0BD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 21:03:26 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C79A1BC1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 18:03:25 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6687466137bso376769b3a.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 18:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690419805; x=1691024605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqjxyiI6qShi5Vt5FP0iFEDvw0jixw/cgz0KCSDD87o=;
        b=GHVfZVi2jt6oxcdARvmydpLQJAZIMsFU7Dl3sI7R72PBds/qgS0k1L8oEm++uM2/Dg
         vG3jwTBcRK2qZrt0GmjHZkyL8JKASyBZ/+ULn7cpVa51K3TWyMVw02PjFJs+prNtBokJ
         eheCQOtuaYQ0TN7wViX1i2t99mSzVZDK8AmFlpydZ3NfRnBeKgMs3cJJirRPRfnRigld
         P+5qVhbKVsG/BvbgusPXYpFklo+kJJZHON8SKLYx4OajAFlg7xxM/8I7qLjSGf7xKWq8
         CDMKzj3ZwdgirXT48n2BV2Xg6hAhtA4/0AXAPMStPWb1wOEmVz0XcCnxXTqziGqOzll6
         nZYA==
X-Gm-Message-State: ABy/qLZ9tNDlaQFlQ813FPQrRLQFOICEM/kkwc6FoQCB3jXIQqPAvZ4j
        5M7uf3EBcJp7lrGGxTRt6/M=
X-Google-Smtp-Source: APBJJlHB5iPsc66gpNcIQI9RpFQ05k0X5oXK8zHCIcaPft7CC9OG6cwDFBai3MuiIYapMBEq19WEDw==
X-Received: by 2002:a05:6a20:b70a:b0:134:409f:41f4 with SMTP id fg10-20020a056a20b70a00b00134409f41f4mr2651591pzb.24.1690419804870;
        Wed, 26 Jul 2023 18:03:24 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:8a41:caaa:de57:fc15:500c? ([2601:642:4c05:8a41:caaa:de57:fc15:500c])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b0067aea93af40sm223804pfo.2.2023.07.26.18.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 18:03:24 -0700 (PDT)
Message-ID: <8f2000c0-e9fb-0c7b-5dfa-6807230688a0@acm.org>
Date:   Wed, 26 Jul 2023 18:03:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/7] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-6-bvanassche@acm.org>
 <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 17:33, Damien Le Moal wrote:
>  From all this, and given that for (3) REQ_NO_ZONE_WRITE_LOCK is set
> unconditionally, it now seems to me that this request flag is useless...
> Thoughts ?

Hi Damien,

Thanks for having taken a close look at this patch series.

The flag REQ_NO_ZONE_WRITE_LOCK was introduced based on earlier review
feedback. Removing that flag again would help me because that would
allow me to develop a test for the blktest suite that submits I/O
directly to the block device instead of an F2FS filesystem. I like
F2FS but it's probably good to minimize the number of layers when
writing blktest tests.

Thanks,

Bart.

