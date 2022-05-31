Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F48C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbiEaGuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 02:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiEaGud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 02:50:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B8770931
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 23:50:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 761D01F964;
        Tue, 31 May 2022 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653979830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pi4MFS6Npz02kcQKnbkNRZXYyPXCKSUZWSNaXHS0PM=;
        b=SNC3ZwtqXHPgZL1bCionqrkcBqNpN4dUhWbxkULqZ3tJauH0fp+3edf2lfSKFYmvowj++/
        fWAwSNUhcaLo/xNktWCn+122bkcqPN2u7v2lOVwMCcpuQOsS4QonDzrLiYUgSH1u7HZ3Hn
        oAeZJbZyKqSwOn0nIhV/9iFqz8oov/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653979830;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pi4MFS6Npz02kcQKnbkNRZXYyPXCKSUZWSNaXHS0PM=;
        b=Q1HEnfUq7oBAmF94h/cm9hSPHjuFdvVIsMWppfGz23iZ2Zew5w0S/z2AHARe5hIbHP96PJ
        kXxJ8AjAyBgz/nDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56C16132F9;
        Tue, 31 May 2022 06:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GmoKFLa6lWLpPwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 31 May 2022 06:50:30 +0000
Message-ID: <860f4b61-3fae-a3b3-a335-1a87dc170cdc@suse.de>
Date:   Tue, 31 May 2022 08:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] block: remove per-disk debugfs files in
 blk_unregister_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20220530134548.3108185-1-hch@lst.de>
 <20220530134548.3108185-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220530134548.3108185-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/22 15:45, Christoph Hellwig wrote:
> The block debugfs files are created in blk_register_queue, which is
> called by add_disk and use a naming scheme based on the disk_name.
> After del_gendisk returns that name can be reused and thus we must not
> leave these debugfs files around, otherwise the kernel is unhappy
> and spews messages like:
> 
>      Directory XXXXX with parent 'block' already present!
> 
> and the newly created devices will not have working debugfs files.
> 
> Move the unregistration to blk_unregister_queue instead (which matches
> the sysfs unregistration) to make sure the debugfs life time rules match
> those of the disk name.
> 
> As part of the move also make sure the whole debugfs unregistration is
> inside a single debugfs_mutex critical section.
> 
> Note that this breaks blktests block/002, which checks that the debugfs
> directory has not been removed while blktests is running, but that
> particular check should simply be removed from the test case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-debugfs.c |  8 --------
>   block/blk-mq-debugfs.h |  5 -----
>   block/blk-sysfs.c      | 16 ++++++++--------
>   block/genhd.c          |  4 ----
>   4 files changed, 8 insertions(+), 25 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
