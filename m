Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E155C433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 06:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiCHGnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 01:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244625AbiCHGnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 01:43:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36ABC23
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 22:42:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 890AE1F397;
        Tue,  8 Mar 2022 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646721761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WK7ukneFM2l8669YONZms60+1UDSKRoIGv7y6dHaewg=;
        b=a3maRkt5YXPX4kgRsyRQj4z/KQwNLayCCUHdWu+tTpXvqBrBeuz/zdZyMelPShhZGdHZMA
        AQM+XjYvTf0MGGoC6VZNMPjvqV/bbSEPb5eMYVWe/T0HgDIoPGmJ6F1CHnjIifldreE/gn
        HI6U0rGN/i06Z8zOfeJeRa/KrpvMisQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646721761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WK7ukneFM2l8669YONZms60+1UDSKRoIGv7y6dHaewg=;
        b=K0HG0BcR9unmhkVgcCucUEptK7O8BNAyr1bu4FHX3xN7aD+6/+LYSXpNyYdvr+GWUqlQIs
        5psLd9d7na/f5gBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58DE513C1D;
        Tue,  8 Mar 2022 06:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Y2CEuH6JmLEYgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 08 Mar 2022 06:42:41 +0000
Message-ID: <4f035ae3-6bc9-ce89-abd4-50c82f2b237d@suse.de>
Date:   Tue, 8 Mar 2022 07:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: emit disk ro uevent in device_add_disk()
Content-Language: en-US
To:     Uday Shankar <ushankar@purestorage.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20220303175219.272938-1-ushankar@purestorage.com>
 <6f24cfc9-09b9-67bc-d15b-d3aff238d923@suse.de>
 <20220307205451.GA1765432@dev-ushankar.dev.purestorage.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220307205451.GA1765432@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 21:54, Uday Shankar wrote:
> On Mon, Mar 07, 2022 at 07:39:39AM +0100, Hannes Reinecke wrote:
>> Why not add the 'DISK_RO=1' setting directly to the 'add' event?
>> That would be the logical thing to do, no?
> I agree, and initially had a patch that did just this. However, for SCSI
> disks the DISK_RO property is only ever announced via change uevents,
> and applications such as dm-multipath may not pick up on DISK_RO if it
> shows up in an add uevent instead. This patch maintains compatibility
> with SCSI in that sense.
> 

Most rules relating to storage devices test for both, 'add' _and_ 
'change' as DM devices are only usable after a 'change' event.
In particular multipath has been coded with that in mind, so I don't see 
any issues with just adding the RO setting to the 'add' event.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
