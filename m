Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2EC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC0VGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0VGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 17:06:13 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D2C4
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 14:06:12 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so10399524pjb.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 14:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp4i1bljYVAIAYrdKsrqkK0En6mhe6ajoIRnr70mTfI=;
        b=mQHSLY6+twjQ9X6qA1FhCZmPS3CB/xOTqhF4+ZT8gv02HhzG4Mrjs1a3jVitKU8G9y
         rwl79F6MPxZEGOILUVLZZ6dje+i3VD41jw/FQ6U3cI9pK7hRWJl2X4GbtlnaKdLmBVUQ
         DfcKXObSd2WXVq9n9ZcJq/FsdaaY8WN5EyV3usD+wV7w1dqtewDtwO7+otJWd5N8lZlV
         zuMPWpoUdTWsThhtpqQz13nHWWDjcLIYLnnV9QMw1ShtdgbEccqnZg9Dd5/Lr/B7dc9J
         n8tXErYQJbGKhyYkqZNGgdnAjRqmlYWVbqjaG60RUBMFoUsVgEJD2qnAi0AGNVTlQVIu
         CNQA==
X-Gm-Message-State: AAQBX9ciRVsu1VneBw9884fPNLRItO0R5BfVJ+EHNkNwBSBCVK8bRJWR
        XU8gmNnJ0hmb0P7N8bMZ08M=
X-Google-Smtp-Source: AKy350bZbc8ADH3Z4Mf+O4B2OmRcw2VEviFCVCHddsj8VJCLRtJw0LO13JNs78VVBPzgcv9EZJtbFw==
X-Received: by 2002:a17:902:c404:b0:19d:611:2815 with SMTP id k4-20020a170902c40400b0019d06112815mr16382558plk.42.1679951171960;
        Mon, 27 Mar 2023 14:06:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:798e:a3a0:ddc2:c946? ([2620:15c:211:201:798e:a3a0:ddc2:c946])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902aa4b00b001a1fe42a141sm8867195plr.115.2023.03.27.14.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:06:11 -0700 (PDT)
Message-ID: <7b668546-addb-9a47-b6f0-4f2422617ead@acm.org>
Date:   Mon, 27 Mar 2023 14:06:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
 <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
 <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
 <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
 <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org>
 <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
 <20230326234552.GC20017@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230326234552.GC20017@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/23 16:45, Christoph Hellwig wrote:
> Exactly.  That's why ZONE_APPEND is the only really viable high-level
> interface.

Using REQ_OP_ZONE_APPEND may lead to reordering - data being written on 
the storage medium in another order than the order in which the 
REQ_OP_ZONE_APPEND commands were submitted. Hence, the number of extents 
for large files increases and performance when reading large files 
reduces. To me comparing the performance of these two approaches sounds 
like a good topic for a research paper. I'm not sure that 
REQ_OP_ZONE_APPEND is better for all zoned storage workloads than 
REQ_OP_WRITE.

Thanks,

Bart.
