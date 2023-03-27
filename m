Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85817C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 21:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjC0VUp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC0VUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 17:20:44 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46DC173A
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 14:20:39 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id y19so6008910pgk.5
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 14:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtKtvF7i9MVGscb1YlpGSXffk/VCGeWlwHYgp9dF3I8=;
        b=zzaKYnmStrEdCrhQFZSZtoZs87y27ehCuNedGDdtq0RROBZtBH+XUSGth3vhCbDPn+
         SY8V5mh8o9Ddzgq5LwMVYbNTRlmGmTv4UM0TMEMK/Rbi6ewN+Uunydkumqe4Le71Rsiy
         XcLt5N8aycnz2ajO1SfwfJWfMzxH4ZM4aTw/8pxkmfY1P8YsbMFf71P+d0L6k10onuBP
         FZI7YQjj9JIOmo7RZE5Tyh/8ESjufJgLpWWu6sg4q8qFC950WmRe7ov4NeJJAoH30Kka
         quFP0CJLu6QJY79kvpyxSjlZ2i3/RlviMuAowViS+zUWfTskWuMMnW6dQVlfChQhb+Iv
         pglw==
X-Gm-Message-State: AAQBX9c/Qkpfb+DNiVp1XCrRDul2JuDcLQYB1BLpMCYvCRWKbdo22mLx
        /aZNyX0QjR0/NChlHjyL8h8=
X-Google-Smtp-Source: AKy350Y2dSr6+Gu66gKohfowypj9BO77ZnmbjzJuIdPRmqOw0FybXB93gxEBsLn1IhLXXcEmlX51XA==
X-Received: by 2002:aa7:9728:0:b0:626:17b8:8586 with SMTP id k8-20020aa79728000000b0062617b88586mr13362592pfg.30.1679952038963;
        Mon, 27 Mar 2023 14:20:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:798e:a3a0:ddc2:c946? ([2620:15c:211:201:798e:a3a0:ddc2:c946])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78085000000b006254794d5b2sm7876989pff.94.2023.03.27.14.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:20:38 -0700 (PDT)
Message-ID: <2a5e0494-faae-bdb3-379b-582df5777cfb@acm.org>
Date:   Mon, 27 Mar 2023 14:20:36 -0700
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
 <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org>
 <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com>
 <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org>
 <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/23 18:45, Damien Le Moal wrote:
> On 3/26/23 01:31, Bart Van Assche wrote:
>> Although the above sounds interesting to me, I think the following two
>> scenarios are not handled by the above approach and can lead to reordering:
>> * The SCSI device reporting a unit attention.
>> * The SCSI device responding with the SCSI status "BUSY". The UFS
>> standard explicitly allows this. From the UFS standard: "If the unit is
>> not ready to accept a new command (e.g., still processing previous
>> command) a STATUS response of BUSY will be returned."
> 
> Yes, that likely would be an issue for regular writes, but likely not for zone
> append emulation using regular writes though, since a "busy" return for a ZA
> emulated regular write can be resent later with a different aligned write location.

Hi Damien,

If a SCSI device responds with status "BUSY" or a unit attention for a 
zone append operation, all pending REQ_OP_ZONE_APPEND operations that 
have already been translated into WRITE commands will fail because of a 
write pointer mismatch. I'm wondering whether the following would be 
sufficient to support multiple pending REQ_OP_ZONE_APPEND operations 
when translating these into SCSI WRITE commands:
* If a zoned write operation is not executed (SAM_STAT_BUSY,
   SAM_STAT_CHECK_CONDITION, ...), change the host state to
   SHOST_RECOVERY to prevent that pending zone append operations fail
   because of a write pointer mismatch.
* After all pending SCSI commands have failed, completed or timed out,
   resubmit these commands. For REQ_OP_ZONE_APPEND, this may result in a
   new LBA being selected when translating these into WRITE commands.
* Retry commands that fail with UNALIGNED WRITE COMMAND until the retry
   count is exhausted.
* Increase the retry count for REQ_OP_ZONE_APPEND operations such that
   the above retry mechanism neither causes an infinite loop nor failures
   because the device responds with SAM_STAT_BUSY or a unit attention.

Thanks,

Bart.


