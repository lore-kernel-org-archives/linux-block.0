Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C508C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFPSgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiFPSgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 14:36:09 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B67517FC
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 11:36:07 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id x138so2190825pfc.12
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 11:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LqkNOtOWACeQyVeMnUVbj8d66vhCpghKihp0RSKTVP0=;
        b=49KFwAQuklJo2wbXIBtKgoxwlIuhC+xV9jprVbr6uHXvga9luPzlUIswohuh2W+XOq
         9zvc5FNfvSps7m8M655wk4eSC44y2Thq85AZ/vpEu5WKzzqFvS32UaLQ/uIDUdFrS2g1
         0kh9vBaKi9h9/y0daMiRO5AMC5mxAFH0di9g6achKbZRVoOckqQ7iO1+e9VHXX5DX3ki
         GMf2A2SnN7zYI6lsaChSCcKwq7zkP8h2OxUPolOXCCLs7d/evnzzj0UMAnnzGjnCYP93
         FyhvHjnBPOcB1P0JgFlEbPJUPz9pNDV3s4CtPKRfqd8AYsKncIZV3CxNJUBikM2C7sGR
         8Tvg==
X-Gm-Message-State: AJIora+UyiBJLG+tZ26D49FpXPHqjslT/ts2h2vEjLN/4FXCWn+cfvld
        l/NRGszmCWLwX+5JXz0HlDc=
X-Google-Smtp-Source: AGRyM1tTWwUYTq0F2Zi+QP1tXmj29AervucjyH1nC1BqvyNbCZ8v0ptmYp1wzDWdSebpek3pNjrgxQ==
X-Received: by 2002:a63:5304:0:b0:3fb:92eb:8e90 with SMTP id h4-20020a635304000000b003fb92eb8e90mr5701047pgb.36.1655404567076;
        Thu, 16 Jun 2022 11:36:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:55f1:e134:5606:bb89? ([2620:15c:211:201:55f1:e134:5606:bb89])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b0051ba2c0ff24sm2140663pfh.144.2022.06.16.11.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 11:36:06 -0700 (PDT)
Message-ID: <8c3a5d60-281e-a7c7-57d0-f5fe1db5a17c@acm.org>
Date:   Thu, 16 Jun 2022 11:36:04 -0700
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

Using ZONE APPEND instead of SCSI WRITE commands would have the 
following consequences:
* Data of a single file might be stored out-of-order on the storage medium.
* A translation table would have to be stored on the storage medium with 
one entry per ZONE APPEND command with the LBAs of where the ZONE APPEND 
commands wrote their data. I think that translation table can be 
considered as another L2P table. One of our motivations to switch to 
zoned storage is to get rid of nested L2P tables.

Both aspects above would have a negative impact on sequential read 
performance. Hence our preference to use WRITE commands for zoned 
storage instead of ZONE APPEND commands.

Thanks,

Bart.
