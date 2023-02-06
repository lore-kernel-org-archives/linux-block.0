Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD82CC636D3
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBFRy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFRy0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 12:54:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB683F5
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 09:54:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D05B607E0;
        Mon,  6 Feb 2023 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675706064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xzF2afO86qSNErmVs8ySntfnGamT4Qjdj1L7c0XzoX0=;
        b=ArtLyGvIst9wEJPMHO7+6sqwOrbM6R9BD6RptXhBZH89F2kl0xItUqTLMODx+ipAWmbV2U
        PRhfqRh8JmXDa1WLNyF7YBHX4vExYSMw8Ueiv4qLAQ4jQe6+7KgZCYVgwDVGbLzPzBK7Y5
        9CGa+e++SctbrAYTmq+ohBsO/PLxopw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675706064;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xzF2afO86qSNErmVs8ySntfnGamT4Qjdj1L7c0XzoX0=;
        b=kFpbADQsIMZJsWxVkQnX12YT+EHuZApwBugrh5XdWQ1rGthxallFXfRd2vEia4+dLsVwA8
        LxM1JRpFXYnnffCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C24CC138E8;
        Mon,  6 Feb 2023 17:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I9zOLc8+4WMWOwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 06 Feb 2023 17:54:23 +0000
Message-ID: <889dfe23-2e9e-c787-8c20-32f2c40509b5@suse.de>
Date:   Mon, 6 Feb 2023 18:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
To:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org
Cc:     Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <Y+EWCwqSisu3l0Sz@T590>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <Y+EWCwqSisu3l0Sz@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/23 16:00, Ming Lei wrote:
> Hello,
> 
> So far UBLK is only used for implementing virtual block device from
> userspace, such as loop, nbd, qcow2, ...[1].
> 
> It could be useful for UBLK to cover real storage hardware too:
> 
> - for fast prototype or performance evaluation
> 
> - some network storages are attached to host, such as iscsi and nvme-tcp,
> the current UBLK interface doesn't support such devices, since it needs
> all LUNs/Namespaces to share host resources(such as tag)
> 
> - SPDK has supported user space driver for real hardware
> 
> So propose to extend UBLK for supporting real hardware device:
> 
> 1) extend UBLK ABI interface to support disks attached to host, such
> as SCSI Luns/NVME Namespaces
> 
> 2) the followings are related with operating hardware from userspace,
> so userspace driver has to be trusted, and root is required, and
> can't support unprivileged UBLK device
> 
> 3) how to operating hardware memory space
> - unbind kernel driver and rebind with uio/vfio
> - map PCI BAR into userspace[2], then userspace can operate hardware
> with mapped user address via MMIO
> 
> 4) DMA
> - DMA requires physical memory address, UBLK driver actually has
> block request pages, so can we export request SG list(each segment
> physical address, offset, len) into userspace? If the max_segments
> limit is not too big(<=64), the needed buffer for holding SG list
> can be small enough.
> 
> - small amount of physical memory for using as DMA descriptor can be
> pre-allocated from userspace, and ask kernel to pin pages, then still
> return physical address to userspace for programming DMA
> 
> - this way is still zero copy
> 
> 5) notification from hardware: interrupt or polling
> - SPDK applies userspace polling, this way is doable, but
> eat CPU, so it is only one choice
> 
> - io_uring command has been proved as very efficient, if io_uring
> command is applied(similar way with UBLK for forwarding blk io
> command from kernel to userspace) to uio/vfio for delivering interrupt,
> which should be efficient too, given batching processes are done after
> the io_uring command is completed
> 
> - or it could be flexible by hybrid interrupt & polling, given
> userspace single pthread/queue implementation can retrieve all
> kinds of inflight IO info in very cheap way, and maybe it is likely
> to apply some ML model to learn & predict when IO will be completed
> 
> 6) others?
> 
> 
Good idea.
I'd love to have this discussion.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

