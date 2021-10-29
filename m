Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CCFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3378610E5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhJ2KVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:21:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhJ2KVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 06:21:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A12E31FD53;
        Fri, 29 Oct 2021 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635502750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hg+9Z9+RCyC/8NTPxf+T0VYEw1NVtczTXmjXXS1EJH4=;
        b=mwzgkBxT1MJPsYzB4fodOvrnl1wV4vdThqGP7+rmRxMKbhDS91EnuHlZDMNBjhN9qEybyw
        AoGvkVRlpieMzv9jaazhJQF/bqvMTZNgcIvmncDFZW1t55gfAmqHo3qp/1Q/ZETLAlEGL2
        6lmM4PguHD+eBOr0gJOQvIZZPqpBgnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635502750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hg+9Z9+RCyC/8NTPxf+T0VYEw1NVtczTXmjXXS1EJH4=;
        b=kNPgJstfwerL2PRdFEYVNzt5yIuQipNsQPHR+Z4uEgYalxZve/4ZVF4+EwfgmzvM+Z8pAX
        fO2p5lDyiz4rnxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A5A113B8D;
        Fri, 29 Oct 2021 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0GcbIZ7Ke2HkRQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 29 Oct 2021 10:19:10 +0000
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.16
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YXqzb6dj0DCrIbGY@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9684ed24-532d-952a-a478-5388a9da1bbc@suse.de>
Date:   Fri, 29 Oct 2021 12:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YXqzb6dj0DCrIbGY@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 4:27 PM, Christoph Hellwig wrote:
> The following changes since commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17:
> 
>   block: ataflop: more blk-mq refactoring fixes (2021-10-25 07:54:32 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-28
> 
> for you to fetch changes up to d156cfcafbd0eae4224ea007d95ebda467eb0c46:
> 
>   nvmet: use flex_array_size and struct_size (2021-10-27 08:06:41 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 5.16
> 
>  - support the current discovery subsystem entry (Hannes Reinecke)
>  - use flex_array_size and struct_size (Len Baker)
> 
> ----------------------------------------------------------------
> Hannes Reinecke (3):
>       nvme: add new discovery log page entry definitions
>       nvmet: switch check for subsystem type
>       nvmet: register discovery subsystem as 'current'
> 
> Len Baker (1):
>       nvmet: use flex_array_size and struct_size
> 
>  drivers/nvme/host/multipath.c   |  2 +-
>  drivers/nvme/target/admin-cmd.c |  2 +-
>  drivers/nvme/target/core.c      |  1 +
>  drivers/nvme/target/discovery.c | 17 +++++++++++------
>  drivers/nvme/target/nvmet.h     |  2 +-
>  include/linux/nvme.h            | 19 ++++++++++++++++---
>  6 files changed, 31 insertions(+), 12 deletions(-)
> 
This one hangs at boot for me:

[  220.294358] Code: ef e8 61 25 3e 00 3b 05 3f c1 5d 01 89 c5 73 24 48
63 c5 49 8b 7d 00 48 03 3c c5 c0 0a 20 82 66 90 8b 47 08 a8 01 74 0a f3
90 <8b> 57 08 83 e2 01 75 f6 eb c7 48 83 c4 48 5b 5d 41 5c 41 5d 41 5e
[  220.297931] RSP: 0018:ffffc900011ebd20 EFLAGS: 00000202
[  220.299181] RAX: 0000000000000011 RBX: 0000000000000001 RCX:
0000000000000000
[  220.300656] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff88827fc32d40
[  220.302126] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[  220.303603] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff88827fdec040
[  220.305052] R13: ffff88827fdec040 R14: 0000000000000000 R15:
0000000000000006
[  220.306509] FS:  0000000000000000(0000) GS:ffff88827fdc0000(0000)
knlGS:0000000000000000
[  220.308074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  220.309338] CR2: 00005644f553dcd8 CR3: 000000010392e000 CR4:
0000000000350ee0
[  220.310777] Call Trace:
[  220.311655]  ? __flush_tlb_all+0x30/0x30
[  220.312686]  on_each_cpu_cond_mask+0x1e/0x20
[  220.313776]  __purge_vmap_area_lazy+0xbc/0x6d0
[  220.314887]  ? __cond_resched+0x15/0x40
[  220.315921]  ? vunmap_range_noflush+0x3fc/0x4b0
[  220.317024]  ? cpumask_next+0x1f/0x30
[  220.318002]  ? purge_fragmented_blocks_allcpus+0x51/0x1d0
[  220.319235]  _vm_unmap_aliases.part.50+0xdf/0x110
[  220.320356]  __vunmap+0x11d/0x250
[  220.321301]  do_free_init+0x26/0x50
[  220.322266]  process_one_work+0x231/0x420
[  220.323304]  ? process_one_work+0x420/0x420
[  220.324352]  worker_thread+0x2d/0x3f0
[  220.325346]  ? process_one_work+0x420/0x420
[  220.326400]  kthread+0x11a/0x140
[  220.327362]  ? set_kthread_struct+0x40/0x40
[  220.328413]  ret_from_fork+0x22/0x30

Known issue?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
