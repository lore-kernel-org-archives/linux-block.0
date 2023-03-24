Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B397C6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCXQze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCXQzd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 12:55:33 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F5A9
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 09:55:32 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id kq3so2334768plb.13
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 09:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrKKSeTGMdKV9dT+NL68lNabCLwz9c78Qunu6n1e+U0=;
        b=0DDU/1Rq7ewoWJqYdo0BL7ZQQauHdWlvs080vQ8ogcLqoyZWApl308PHLEH9kYROPJ
         oxmxI4VmnMmlGMpXp9AvhqaCLjM+jKpwStBZmzxc9aWuTPoOY+3taCuGlXSi2CMD1E+Q
         thTDz04QQHwvlnlvFJk2K7SeiEjgNXu333jmQJ5dGktE6Husv0nOLxp5m5HENDYys/K3
         ETSERHfsEUtw0VZxH+bfKbiH0LNzpYNwYyAKjtrUZqm3f/NTjoQ88RrmR8aJerQO11gX
         RcopLBlgPoDikd4sMSqewcFo/xKW6l0BuL2L2Emz6n02HJOGJwOvt8ZL9djRwfe3WKrQ
         rZPg==
X-Gm-Message-State: AAQBX9eCuD7l+WyP+Ylq2ZsQDcjVpay2R/yzUOntQyXkY/ZD8uSCrGNA
        SEqaToXMv1sIuNOJs7Q7x2s=
X-Google-Smtp-Source: AKy350Zzp5ur8uXRA1oe3zq6BVJahL3sLkX7yzkYgI0mC85l6CASFAYE+pSTZsf1Tq1VdYLGtLdNOg==
X-Received: by 2002:a17:903:64b:b0:19e:7889:f9fb with SMTP id kh11-20020a170903064b00b0019e7889f9fbmr2520781plb.68.1679676932189;
        Fri, 24 Mar 2023 09:55:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2421:e16e:b98f:7e76? ([2620:15c:211:201:2421:e16e:b98f:7e76])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902900300b001a060007fcbsm14416355plp.213.2023.03.24.09.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:55:31 -0700 (PDT)
Message-ID: <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
Date:   Fri, 24 Mar 2023 09:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
 <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/23 15:53, Damien Le Moal wrote:
> On 3/24/23 01:27, Bart Van Assche wrote:
>> On 3/23/23 03:28, Damien Le Moal wrote:
>>> For the zone append emulation, the write locking is done by sd.c and the upper
>>> layer does not restrict to one append per zone. So we actually could envision a
>>> UFS version of the sd write locking calls that is optimized for the device
>>> capabilities and we can keep a common upper layer (which is preferable in my
>>> opinion).
>>
>> I see a blk_req_zone_write_trylock() call in
>> sd_zbc_prepare_zone_append() and a blk_req_zone_write_unlock() call in
>> sd_zbc_complete() for REQ_OP_ZONE_APPEND operations. Does this mean that
>> the sd_zbc.c code restricts the queue depth to one per zone for
>> REQ_OP_ZONE_APPEND operations?
> 
> Yes, since the append becomes a regular write and HBAs are often happy to
> reorder these commands, even for SMR, we need the locking.
> 
> But if I understand your use case correctly, given that UFS gives guarantees on
> the command dispatching order, you could probably relax this locking for zone
> append requests. But you cannot for regular writes as the locking is up in the
> block layer and needed to avoid block layer level reordering.

Hi Damien,

I don't think that we can achieve QD > 1 even if we would switch to
REQ_OP_ZONE_APPEND. A SCSI LLD is allowed to respond with 
SCSI_MLQUEUE_HOST_BUSY if the SCSI core asks it to queue a command. This 
may lead to reordering and hence may cause UNALIGNED WRITE COMMAND 
errors. We want to avoid these errors.

Thanks,

Bart.
