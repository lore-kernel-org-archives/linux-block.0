Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E52C6FD20
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCXRFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCXRFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:05:52 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59730E38F
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:05:51 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id o11so2416740ple.1
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysus1LwuHwKO/DCHDC400RLRHTHIm+hWdYK3fORH++o=;
        b=Z6NNrirbiNB7058u/ZBYjScmFJ1GxaiF5zBYw2N5sri46incW/v4vz+HnoQDeE49Jw
         SyTk6c7iT+xnMwoubXkWuEB6JdxW2UoTUHcx6lJFhuhB8JUG+8fcx9n6rWVrHV9stYNa
         KgyLukQRFw9MUtFLB+3A07YyoXuLLtrhJBr/9xtpgmiifEjtzhDSpO3SwYtn9IZZDyP0
         vpoCR62/duzNuyauvAaPH/Yci3C8E6GwL79Bbz169ctBpcyWWD2zDS7tq9LwnMiACqQN
         5jffUpTLaCDZHldyf1XaDhfO+WalBcTpan9dJcUYz8PuZkM3OpY0NeErI9p+QiCBSXBc
         3d3Q==
X-Gm-Message-State: AAQBX9c4YcLPWpAJEXcRii/mx6Ca5zPcjQ7kO29pRINtbVNhHFEoCB4O
        VHFgJDfQZV/6zXln2HyRiqqy5ENPbJ0=
X-Google-Smtp-Source: AKy350b7skVpM/ScDpNeQfwRZ8x8y2wH/LN9r4YqBlHqDjYpGFqiPyDOHZxKXSQEC0/UFSJQBbjI7g==
X-Received: by 2002:a17:902:d505:b0:1a1:e39c:d4d1 with SMTP id b5-20020a170902d50500b001a1e39cd4d1mr3811598plg.67.1679677550711;
        Fri, 24 Mar 2023 10:05:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2421:e16e:b98f:7e76? ([2620:15c:211:201:2421:e16e:b98f:7e76])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709029b9500b0019b0937003esm14501576plp.150.2023.03.24.10.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 10:05:49 -0700 (PDT)
Message-ID: <80988a60-f340-529a-0931-30689599e724@acm.org>
Date:   Fri, 24 Mar 2023 10:05:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230318062909.GB24880@lst.de>
 <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
 <20230323082756.GD21977@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230323082756.GD21977@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/23 01:27, Christoph Hellwig wrote:
> On Mon, Mar 20, 2023 at 10:22:41AM -0700, Bart Van Assche wrote:
>> * T10 has not yet started with standardizing a zone append operation.
> 
> Time to get it started then!

Hi Christoph,

If someone else wants to work on this that would be great. I do not plan 
to work on this because I do not expect that a SCSI zone append command 
would be standardized by the time we need it. Although there are 
references to T10 drafts in the UFS standard, since a few months JEDEC 
strongly prefers to refer to finalized external standards in its own 
standards. Hence, standardizing zoned storage for UFS would have to wait 
until T10 has published a standard that supports a zone append command. 
INCITS published ZBC-1 in 2016, two years after the first ZBC-1 draft 
was uploaded to the T10 servers. INCITS approved ZBC-2 this month, six 
years after the first ZBC-2 draft was uploaded to the T10 servers. 
Because of the long time it takes to complete new versions of T10 
standards we plan not to wait until T10 has standardized a zone append 
operation.

Thanks,

Bart.

