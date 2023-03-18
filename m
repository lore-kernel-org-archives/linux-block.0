Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255BC74A5B
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 00:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCRAJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCRAJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 20:09:30 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5F274A1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 17:09:24 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id c4so4106445pfl.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 17:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679098164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/kPSjDmBINfRHRzYX90pU/fC70zdTA9vIq954kOoZE=;
        b=NzoGLjeRypNjHrHEBE9lUHy8hBb7CdMdqtqfyi9L3SxaIxYF6+R9Ihn9TWqYMPPNqE
         YzoQskyiAt2JcccOOFOXlaJZM+pUqHwQPayuuBUcozwCq/IFleLvbPyxDr/wwCu09trF
         2pcYBihpTxbu+B4ILI0B+m20a/ZMONnAYSbcaT7O3IsfcCiRK/ykyqp1tJCU89nS0IYd
         bPLJAY5/9a6Zks/FPAlB/+wt44P4lNrNMSLlFaJHNq76/KDsIjU//GJoDZ7JdtM0XgU0
         UCiB0syiKOMiFbDmOCZbBBw7ShhTunp8XDtcJrRrY7fQBRW080W5SlwosQdh9qWWkd9q
         hCYg==
X-Gm-Message-State: AO0yUKWa4v8a/T8SoFU8uG+KPANxz3lCKDsvKfxTEfOEGYlAulYr0oBV
        pn65dWppZL16uBevaW4lib0=
X-Google-Smtp-Source: AK7set+iHiMx37HmQVF9ICCuuj/9Z5U+jXgKgEQJbhjboOA0G7UMIJZv1hRK9XKQX4aI4Rx/z2kLhQ==
X-Received: by 2002:a62:6105:0:b0:626:237c:bcfe with SMTP id v5-20020a626105000000b00626237cbcfemr3911637pfb.8.1679098164146;
        Fri, 17 Mar 2023 17:09:24 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b005a90f2cce30sm2083230pfo.49.2023.03.17.17.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 17:09:23 -0700 (PDT)
Message-ID: <cc9e00f6-9106-e701-4e50-f87c5796b0e7@acm.org>
Date:   Fri, 17 Mar 2023 17:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] block: Support splitting REQ_OP_ZONE_APPEND bios
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <20230317195036.1743712-1-bvanassche@acm.org>
 <9987139a-f423-3d2e-5abd-877b3d147134@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9987139a-f423-3d2e-5abd-877b3d147134@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/23 15:39, Damien Le Moal wrote:
> On 3/18/23 04:50, Bart Van Assche wrote:
>> Make it easier for filesystems to submit zone append bios that exceed
>> the block device limits by adding support for REQ_OP_ZONE_APPEND in
>> bio_split(). See also commit 0512a75b98f8 ("block: Introduce
>> REQ_OP_ZONE_APPEND").
>>
>> This patch is a bug fix for commit d5e4377d5051 because that commit
>> introduces a call to bio_split() for zone append bios without adding
>> support for splitting REQ_OP_ZONE_APPEND bios in bio_split().
>>
>> Untested.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Keith Busch <kbusch@kernel.org>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Nack. This will break zonefs.
> zonefs uses zone append commands for sync writes. If zonefs does not have
> guarantees that a single write is processed with a single command, the user data
> can get corrupted because of the possible reordering of zone append commands.

Hi Damien,

It is not clear to me how this would break zonefs? Is my understanding 
correct that the size of bios built by zonefs is such that bio_split() 
won't split these?

Thanks,

Bart.
