Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A5FC74A5B
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 14:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCUOgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCUOgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 10:36:17 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5A4DE15
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 07:36:16 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id le6so16196230plb.12
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 07:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUlT/dJTRo3GxEV5nPmrm2O49IN/XkbUEFIGPkNpKzI=;
        b=Y6wW0eoKBMyCurJ9Wjz2lvy2H5c+CBElwpcQRLLJhTNWZoTTrVBg+wYnCkan4MaSSr
         aV3ElY67eK9e9UekUGEH1IDClVGA9L+x280ZM2aJu1tHFYZAt9VmOpcNDeWj6oVU7vXk
         LpVWMuzLczqnGiTVlxQ3GTuA2Oj1JnW7Fdg/y0Gu5YYvoN25oJvx/O69tpPyiA9ppUqN
         H5RCZkbX6wqrps7bosX7CDPyDmcBpatIv/8v7reJdbPVLMnQkMJoUHI0jCZREXdkGyB6
         0Cz1mYFW3aFQPeRnpaXnRyy+XFmPCN6bRV4fbt3NW+1Swz5LyfOUZZ666QgoMZGlQ2/Q
         0jcw==
X-Gm-Message-State: AO0yUKWgFeWPd3dqh5/WCQA4AGQ1wpNbeu2sx0JB5VVS+gQQ/jGr8TkN
        vHQng4dT9m5vfvXRRiayCn2SFKSwx6A=
X-Google-Smtp-Source: AK7set9Dq3/T+goE9Ju3waEGDrw+6v9WIfkSow8RCTwn6jO6E5OTpRTCNAhPxd9wE/e8FFbG4wI6Tw==
X-Received: by 2002:a17:902:e381:b0:19a:945d:e31 with SMTP id g1-20020a170902e38100b0019a945d0e31mr1984786ple.13.1679409374819;
        Tue, 21 Mar 2023 07:36:14 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b0019f11caf11asm8852368plb.166.2023.03.21.07.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:36:14 -0700 (PDT)
Message-ID: <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
Date:   Tue, 21 Mar 2023 07:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230321055537.GA18035@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/23 22:55, Christoph Hellwig wrote:
> On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
>> The use case I'm looking at is Android devices with UFS storage. UFS is
>> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a
>> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the
>> queue depth to one.
> 
> The queue depth (per zone) is limited for regular writes to, for the
> same reason that the zone append emulations limits them.  You seem
> to be very aware of that too as you've tried various methods to lift
> that limit, none of which seems to ultimatively work.

Hi Christoph,

The UFSHCI specification is very clear about the requirement that UFS 
host controllers must process SCSI commands in order if host software 
sets one bit at a time in the UFSHCI 3.0 doorbell register: "For Task 
Management Requests and Transfer Requests, software may issue multiple 
commands at a time, and may issue new commands before previous commands 
have completed. When software sets the corresponding doorbell register, 
the Task Management Requests and Transfer Requests automatically get a 
time stamp with their issue time. The commands within a command list 
(Task Management List or Transfer Request List) shall be processed in
the order of their time stamps, starting from the oldest time stamp. In 
the case multiple commands from the same list have the same time stamp, 
they shall be processed in the order of their command list index,
starting from the lowest index."

Damien and Jens agree about introducing an additional hardware queue for 
preserving the order of zoned writes as one can see here: 
https://lore.kernel.org/linux-block/ed255a4a-a0da-a962-2da4-13321d0a75c5@kernel.dk/

In our tests pipelining zoned writes (REQ_OP_WRITE) works fine as long 
as the UFS error handler is not activated. After the UFS error handler 
has been scheduled and before the SCSI host state is changed into 
SHOST_RECOVERY, the UFS host controller driver responds with 
SCSI_MLQUEUE_HOST_BUSY. I'm still working on a solution for the 
reordering caused by this mechanism.

Thanks,

Bart.
