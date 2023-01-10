Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F187C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjAJQYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbjAJQYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 11:24:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9E73E04;
        Tue, 10 Jan 2023 08:24:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3363333D84;
        Tue, 10 Jan 2023 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673367876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/5pDvEAH6ziY1DIANvMSCuLk/bLD0B7fvx7KbhcUkA=;
        b=juc7gNyxPdrxpjyRom5zMdxhfaprj9rnRosS1A35qlC/Qhp5Il7NEMhJ9PpDC7YAW3Sc08
        RVVEcKk+UMx9ECodrCSpxeoACzIOUnOEU9W7e/z7EBTBJI8t5K/i0HXaPcAYY3OFUBOQRv
        +nS6CY6I4OCvkxAtPRq1Fac5O+dU40I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673367876;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/5pDvEAH6ziY1DIANvMSCuLk/bLD0B7fvx7KbhcUkA=;
        b=P29X1PbKWbwEh5FvGpKgC/w12mnwrTRRG0r3i6mQZfCdmZIFEi4Hy7zgE1b5Ln/gnE4zdB
        zhZo++lYIJ2zdKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 161C01358A;
        Tue, 10 Jan 2023 16:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W2twBESRvWN8IQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 10 Jan 2023 16:24:36 +0000
Message-ID: <d3b707e6-3f17-6e8a-739a-bde53a5a9e99@suse.de>
Date:   Tue, 10 Jan 2023 17:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 5/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
 <20230110131503.251712-6-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230110131503.251712-6-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 14:15, Damien Le Moal wrote:
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
> Given that the WRITE MULTI FUA EXT command is marked as obsolete in the
> ATA specification since ACS-3 (published in 2013), remove the
> ATA_CMD_WRITE_MULTI_FUA_EXT command from the ata_rw_cmds array.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   drivers/ata/libata-core.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

