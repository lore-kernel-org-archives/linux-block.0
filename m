Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006CC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 14:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKBOZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKBOZZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 10:25:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276728E1F;
        Wed,  2 Nov 2022 07:25:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 041CD2277E;
        Wed,  2 Nov 2022 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667399122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDO8d9C0xrqxcVyDYMjTT0BBIsLXgVXb3D/cd+fl+4Q=;
        b=wDhrh4CzTA2OvyrNtPI+G8echvDSRH7VxF8KLLvphrX+NwW3rxz8Dyp+oLVbC1hQAj4U3t
        Ab/su++oyHePhtI3cIf+G7CKtGLaiRXMQwuOADBVjDiok3kx+N8PKyuVqLuYt3FH7GHE4E
        RHjGwVPHOIVE7ez8AqjHM6jNSBDYOLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667399122;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDO8d9C0xrqxcVyDYMjTT0BBIsLXgVXb3D/cd+fl+4Q=;
        b=PTiqifmqczMIeUkNb11IrOeBxKjtF2d5UU4Roh2EIseJ1qANT0n1YQaVt/5j6zAykiF67L
        ym6ji1wyzZJuZvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D777C13AE0;
        Wed,  2 Nov 2022 14:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vOu0MtF9YmNsWQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Nov 2022 14:25:21 +0000
Message-ID: <6dc6661e-5ef2-1ae7-357d-c8108918d222@suse.de>
Date:   Wed, 2 Nov 2022 15:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
 <20221031015329.141954-6-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221031015329.141954-6-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/22 02:53, Damien Le Moal wrote:
> If a user issues a write command with the FUA bit set for a device with
> NCQ support disabled (that is, the device queue depth was set to 1), the
> LBA 48 command WRITE DMA FUA EXT must be used. However,
> ata_build_rw_tf() ignores this and first tests if LBA 28 can be used
> based on the write command sector and number of blocks. That is, for
> small FUA writes at low LBAs, ata_rwcmd_protocol() will cause the write
> to fail.
> 
> Fix this by preventing the use of LBA 28 for any FUA write request.
> 
> Given that the WRITE MULTI FUA EXT command is marked as obsolete iin the
> ATA specification since ACS-3 (published in 2013), remove the
> ATA_CMD_WRITE_MULTI_FUA_EXT command from the ata_rw_cmds array.
> 
> Finally, since the block layer should never issue a FUA read
> request, warn in ata_build_rw_tf() if we see such request.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/ata/libata-core.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

