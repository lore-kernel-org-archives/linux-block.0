Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05832C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 06:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiBVG54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 01:57:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiBVG5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 01:57:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC144FDFA8
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 22:57:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CCFE21102;
        Tue, 22 Feb 2022 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645513048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Uv/gXzimeG5tzww9tyWVKIdQlMDKWDlox4149tCLvM=;
        b=eeB73vuMIoCcRWXWzOrXUKxwz9PncWTfO6T5EMF11kK0P0myhXu9sdaBT/lwVNiu3V15a1
        hHM3TlOSyHc/jgVbWKwuUcqm+RGozJ87oGlICaA68/r9Zo1Qu1xfKU0rWPoYXvN9oLxxcp
        PuHiQ55KoYpKOqfrmskwIy2SVFUCT1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645513048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Uv/gXzimeG5tzww9tyWVKIdQlMDKWDlox4149tCLvM=;
        b=OnM9sDKh7K6hBwy6fxImyUuFQSaLmGcHi+kVSR2gw11c/wJ/PhkxFpdNp9yTuUduuCDMMi
        wDq0tuswBIDjq5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5462C13BB7;
        Tue, 22 Feb 2022 06:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ER1EliJFGKbGgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 22 Feb 2022 06:57:28 +0000
Message-ID: <986caf55-65d1-0755-383b-73834ec04967@suse.de>
Date:   Tue, 22 Feb 2022 07:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <87tucsf0sr.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
> I'd like to discuss an interface to implement user space block devices,
> while avoiding local network NBD solutions.  There has been reiterated
> interest in the topic, both from researchers [1] and from the community,
> including a proposed session in LSFMM2018 [2] (though I don't think it
> happened).
> 
> I've been working on top of the Google iblock implementation to find
> something upstreamable and would like to present my design and gather
> feedback on some points, in particular zero-copy and overall user space
> interface.
> 
> The design I'm pending towards uses special fds opened by the driver to
> transfer data to/from the block driver, preferably through direct
> splicing as much as possible, to keep data only in kernel space.  This
> is because, in my use case, the driver usually only manipulates
> metadata, while data is forwarded directly through the network, or
> similar. It would be neat if we can leverage the existing
> splice/copy_file_range syscalls such that we don't ever need to bring
> disk data to user space, if we can avoid it.  I've also experimented
> with regular pipes, But I found no way around keeping a lot of pipes
> opened, one for each possible command 'slot'.
> 
> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> 
Actually, I'd rather have something like an 'inverse io_uring', where an 
application creates a memory region separated into several 'ring' for 
submission and completion.
Then the kernel could write/map the incoming data onto the rings, and 
application can read from there.
Maybe it'll be worthwhile to look at virtio here.

But in either case, using fds or pipes for commands doesn't really 
scale, as the number of fds is inherently limited. And using fds 
restricts you to serial processing (as you can read only sequentially 
from a fd); with mmap() you'll get a greater flexibility and the option 
of parallel processing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
