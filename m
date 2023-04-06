Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C74EC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjDFUaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDFUaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 16:30:24 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E449CC
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 13:30:22 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6260d3c3f34so38960b3a.3
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 13:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813022; x=1683405022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzCu1U6yyshO6Fqmdl3WadDSkpE7kVPzKo9dtQqUdY4=;
        b=EJcKSYTs1uVN0VOrl1SGAU40RIOTvxva1mvZwrNLybWkHxK1+jGdkgjyq/ap2Ae75k
         mUn56F7Ht06ly6hw3mrZJAy1X/yeYUr+YzNjk1RT0II9iN9GZdIL2L0sWxL7oowHLJtK
         NIelTBKFTdJOuPsMIFr8/p9hMsR0aWSCPRGsJXhc24NsGkNNRym5KziROP3d8iRBGcpX
         SOWyjf45w0G29HXF7/IXWzKFsIJJvNDLPMr+XmumsgUXRnZTdsVW7vdr4mu7nLOId6Zs
         NSwsLcahvei84WYC/BEVRWy3VdhOFRsxahLFd6GmwnfGF2t4CxWRklEYLSCFCn9jStfV
         8SuA==
X-Gm-Message-State: AAQBX9eUw3/eXvMX7VkGmAR6hfgsl9C5Fdr6cFswLYKMSYnXS4ij6HOD
        ZH8TahkNFtnH3lMxyJGtT8s=
X-Google-Smtp-Source: AKy350aeiZkltHPzdQtciw6MpoWD50Tt++DEK3HdONaclfrtoY2sRX0f6XLcnCA+8FLvX97X1P9hzw==
X-Received: by 2002:a62:1850:0:b0:625:e3be:a3c5 with SMTP id 77-20020a621850000000b00625e3bea3c5mr100837pfy.28.1680813021849;
        Thu, 06 Apr 2023 13:30:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8af7:e62e:d5b6:a90? ([2620:15c:211:201:8af7:e62e:d5b6:a90])
        by smtp.gmail.com with ESMTPSA id u11-20020a63234b000000b00513b40f2c89sm1485478pgm.43.2023.04.06.13.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:30:20 -0700 (PDT)
Message-ID: <8e88b22e-fdf2-5182-02fe-9876e8148947@acm.org>
Date:   Thu, 6 Apr 2023 13:30:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
 <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
 <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
 <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
 <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org>
 <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
 <20230326234552.GC20017@lst.de>
 <7b668546-addb-9a47-b6f0-4f2422617ead@acm.org>
 <20230327234311.GA19281@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230327234311.GA19281@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/23 16:43, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 02:06:09PM -0700, Bart Van Assche wrote:
>> Hence, the number of extents
>> for large files increases and performance when reading large files reduces.
>> To me comparing the performance of these two approaches sounds like a good
>> topic for a research paper. I'm not sure that REQ_OP_ZONE_APPEND is better
>> for all zoned storage workloads than REQ_OP_WRITE.
> 
> For REQ_OP_WRITE you absolutely must avoid reordering, so you need to
> globally serialize.  If you can come up with a workload where your write
> based approach is fast, please show it!

When using REQ_OP_ZONE_APPEND, a global lock or atomics are necessary in 
the space allocator to prevent attempts to write more data into a zone 
than what fits into a zone.

When using REQ_OP_WRITE, only serialization of the code that assigns 
LBAs is required. The writes themselves do not have to be serialized if 
these won't be reordered.

My point is that it is nontrivial to compare filesystem designs based on 
REQ_OP_WRITE versus REQ_OP_ZONE_APPEND and hence that zoned writes 
implemented with REQ_OP_WRITE should remain supported.

Bart.
