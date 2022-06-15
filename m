Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B18C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 19:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbiFOTmL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiFOTmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 15:42:10 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32696546BE
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 12:42:10 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2964176pjh.4
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 12:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3NqAuSuAhMU2jzHiHgM42wFy/6GCEjhoHDwGhHDYaSE=;
        b=b+7ulBfeW00h/AaDILmAClVEVsh+rvmX/QMBHAlzKLnmWr+BWssGOTi0AHzRryx1Q1
         QajFGZLfmBBI7atldtnXB/0CckmeBFEiZNjT8+cKp4G/P9BpDPaQvtHHGlPKB1qqeu/U
         2g1o9355Kkp/Oz5/AaHI3fvs6UDzZKN5NF2HUKC6lZRLDgmIE5SJbEpNVL/Wbt+yMU7T
         Tk9/C+txFr49U5EB8xMhoRG692y0X2H7zsVMbdCqAiXgpY8tkWy0eVR4vLcmHZ9ycbvp
         KjR1b6vJZGoffL4UH+tVKHr/yWYRZX38dMO3jJM2AbAsgDD2j6B/U+xp1emjdayav4Qf
         rKOA==
X-Gm-Message-State: AJIora+NvWCc5Qch7JpovdPQBcMAWkYUjl1LuYNs8k4RtQoFAv9sjvjX
        IvtoCfgx4r2W/dkv6xwJLIM=
X-Google-Smtp-Source: AGRyM1u8ysPT+H58vOEis6NuE8BszSqOpbKHt6LNH57toapk1prWwBxOQywWl3LF1izB7ckWV26hKg==
X-Received: by 2002:a17:90a:e601:b0:1e8:ad01:1eaa with SMTP id j1-20020a17090ae60100b001e8ad011eaamr12002726pjy.81.1655322129553;
        Wed, 15 Jun 2022 12:42:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79627000000b0051bce5dc754sm10341763pfg.194.2022.06.15.12.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 12:42:08 -0700 (PDT)
Message-ID: <78ba5207-aa96-bdf7-68d7-a5ec6ed985d7@acm.org>
Date:   Wed, 15 Jun 2022 12:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
 <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
 <20220615054909.GA22044@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615054909.GA22044@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 22:49, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 04:56:52PM -0700, Bart Van Assche wrote:
>> The performance penalty of zone locking is not acceptable for our use case.
>> Does this mean that zone locking needs to be preserved for AHCI but not for
>> UFS?
> 
> It means you use case needs to use zone append, and we need to make sure
> it is added to SCSI assuming your are on SCSI based on your other comments.

Unfortunately I do not know enough about F2FS to comment on whether or 
not making it use REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE is feasible.

Bart.
