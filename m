Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7AEC77B73
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 09:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjEBJLG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 May 2023 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjEBJLE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 05:11:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F554496
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 02:11:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8381F8BD;
        Tue,  2 May 2023 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683018661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhfQUabPeraOi8HjxnQNP6ba5yXQODn9ISjAjoBhk4w=;
        b=yBEdYzf0PNEoWvXcbmoC4aj10OoPUVsdfostte0eD69nkJNy6cvlzvteZZg9AH4JT2HSx+
        Ofcv8fg1/q9N2hQiAQxcEPp6US6hiM28MyV8pmnFkl8ZlanydhM9j8G21WVkhii3tb54kc
        IF9lXHguLrogFU1LGmiVJwSudjuqBfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683018661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhfQUabPeraOi8HjxnQNP6ba5yXQODn9ISjAjoBhk4w=;
        b=bCyY4cQCqQwSfNlmHMKMm274MGw+2PFrneiuCK3EjlMnb20eHgM/GbQ/5TrC2uG9Gx1RoU
        MII3r/pdmK3vl6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21945134FB;
        Tue,  2 May 2023 09:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NdHuB6XTUGSKSwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 02 May 2023 09:11:01 +0000
Message-ID: <3b2d04b8-e7ac-81a1-1751-f63403713a27@suse.de>
Date:   Tue, 2 May 2023 11:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC] block: dio: immediately fail when count < logical block
 size
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org
Cc:     kbusch@kernel.org, willy@infradead.org, p.raghav@samsung.com,
        da.gomez@samsung.com
References: <20230502090018.169275-1-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230502090018.169275-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/23 11:00, Luis Chamberlain wrote:
> When using direct IO of say 4k on a 32k physical block size device
> we crash. The amount of data requested must match the minimum IO supported
> by the device but instead we take it for a ride right now and try to fail
> later after checking alignments.
> 
> Use the logical block size to ensure the data passed on matches our minimum
> supported.
> 
> Without this we end up in a crash below:
> 
> kernel BUG at lib/iov_iter.c:999!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 4 PID: 949 Comm: fio Not tainted 6.3.0-large-block-20230426-dirty #28
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5        04/01/2014                                                                              [   43.513057] RIP: 0010:iov_iter_revert.part.0+0x16e/0x170
> Code: f9 40 a2 63 af 74 07 03 56 08 89 d8 29 d0 89 45 08 44 89 6d 20 <etc>
> RSP: 0018:ffffaa52006cfc60 EFLAGS: 00010246
> RAX: 0000000000000016 RBX: 0000000000000016 RCX: 0000000000000000
> RDX: 0000000000000004 RSI: 0000000000000006 RDI: ffffaa52006cfd08
> RBP: ffffaa52006cfd08 R08: 0000000000000000 R09: ffffaa52006cfb40
> R10: 0000000000000003 R11: ffffffffafcc21e8 R12: 0000000000004000
> R13: 0000000000003fea R14: ffff9de3d7565e00 R15: ffff9de3c1f68600
> FS:  00007f8bfe726c40(0000) GS:ffff9de43bd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8bf5eadd68 CR3: 0000000102c76001 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   blkdev_direct_write+0xf0/0x160
>   blkdev_write_iter+0x11b/0x230
>   io_write+0x10c/0x420
>   ? kmem_cache_alloc_bulk+0x2a1/0x410
>   ? fget+0x79/0xb0
>   io_issue_sqe+0x60/0x3b0
>   ? io_prep_rw+0x5a/0x190
>   io_submit_sqes+0x1e6/0x640
>   __do_sys_io_uring_enter+0x54c/0xb90
>   ? handle_mm_fault+0x9a/0x340
>   ? preempt_count_add+0x47/0xa0
>   ? up_read+0x37/0x70
>   ? do_user_addr_fault+0x27c/0x780
>   do_syscall_64+0x37/0x90
>   entry_SYSCALL_64_after_hw
> 
> The issue is we end up calling iov_iter_revert() at the end of
> blkdev_direct_write() due to the writes not being valid and
> being unaligned. We can fail twice, for on __blkdev_direct_IO_simple()
> and later on __blkdev_direct_IO_async().

Something is askew with that reasoning.
If the above were true, we would also crash if we were attempting a 512 
byte direct I/O write on a 4k drive.
And I'm reasonably sure that we don't.

So where's the difference?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)

