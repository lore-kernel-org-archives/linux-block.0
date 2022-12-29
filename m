Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B1C4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 18:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiL2STK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 13:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiL2SSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 13:18:22 -0500
X-Greylist: delayed 1338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Dec 2022 10:18:19 PST
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CDEB4B;
        Thu, 29 Dec 2022 10:18:19 -0800 (PST)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1pAx8B-0000ej-Fz; Thu, 29 Dec 2022 18:55:51 +0100
Message-ID: <d8fdcff9-9d73-07d8-107a-244e27db9c0a@maciej.szmigiero.name>
Date:   Thu, 29 Dec 2022 18:55:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 0/7] Improve libata support for FUA
Content-Language: en-US, pl-PL
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8.11.2022 06:55, Damien Le Moal wrote:
> These patches cleanup and improve libata support for ATA devices
> supporting the FUA feature.
> 
> The first patch modifies the block layer to prevent the use of REQ_FUA
> with read requests. This is necessary as the block layer code expect
> REQ_FUA to be used with write requests (the flush machinery cannot
> enforce access to the media for FUA read commands) and FUA is not
> supported with ATA devices when NCQ is not enabled (device queue depth
> set to 1).
> 
> Patch 2 and 3 are libata cleanup preparatory patches. Patch 4 cleans up
> the detection for FUA support. Patch 5 fixes building a taskfile for FUA
> write requests. Patch 6 prevents the use of FUA with known bad drives.
> 
> Finally, patch 7 enables FUA support by default in libata for devices
> supporting this features.
> 
> Changes from v5:
>   - Removed WARN for FUA reads in patch 5.
>   - Added reviewed-by tags.
> 
> Changes from v4:
>   - Changed patch 1 to the one suggested by Christoph.
>   - Added Hannes review tag.
> 
> Changes from v3:
>   - Added patch 1 to prevent any block device user from issuing a
>     REQ_FUA read.
>   - Changed patch 5 to remove the check for REQ_FUA read and also remove
>     support for ATA_CMD_WRITE_MULTI_FUA_EXT as this command is obsolete
>     in recent ACS specifications.
> 
> Changes from v2:
>   - Added patch 1 and 2 as preparatory patches
>   - Added patch 4 to fix FUA writes handling for the non-ncq case. Note
>     that it is possible that the drives blacklisted in patch 5 are
>     actually OK since the code back in 2012 had the issue with the wrong
>     use of LBA 28 commands for FUA writes.
> 
> Changes from v1:
>   - Removed Maciej's patch 2. Instead, blacklist drives which are known
>     to have a buggy FUA support.
> 
> Christoph Hellwig (1):
>    block: add a sanity check for non-write flush/fua bios
> 
> Damien Le Moal (6):
>    ata: libata: Introduce ata_ncq_supported()
>    ata: libata: Rename and cleanup ata_rwcmd_protocol()
>    ata: libata: cleanup fua support detection
>    ata: libata: Fix FUA handling in ata_build_rw_tf()
>    ata: libata: blacklist FUA support for known buggy drives
>    ata: libata: Enable fua support by default
> 

Now that 6.2-rc1 is out can this patch set be merged?

Thanks,
Maciej

