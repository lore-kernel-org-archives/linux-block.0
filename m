Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3EC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686CB2084C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686CB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeLEPc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:32:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:59434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbeLEPc5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 10:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34658B005;
        Wed,  5 Dec 2018 15:32:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 724871E0DBB; Wed,  5 Dec 2018 16:32:54 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:32:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] Fix sync. in inode_has_no_xattr()
Message-ID: <20181205153254.GD30615@quack2.suse.cz>
References: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 05-12-18 12:45:06, Alexander Lochmann wrote:
> 
> inode.i_flags might be altered without proper
> synchronisation when the inode belongs to devtmpfs.
> The following stacktrace shows how to get there:
> 13: entry_SYSENTER_32:460
> 12: do_fast_syscall_32:410
> 11: _static_cpu_has:146
> 10: do_syscall_32_irqs_on:322
> 09: SyS_pwrite64:636
> 08: SYSC_pwrite64:650
> 07: fdput:38
> 06: vfs_write:560
> 05: __vfs_write:512
> 04: new_sync_write:500
> 03: blkdev_write_iter:1977
> 02: __generic_file_write_iter:2897
> 01: file_remove_privs:1818
> 00: inode_has_no_xattr:3163
> 
> Found by LockDoc (Alexander Lochmann, Horst Schirmeier and Olaf
> Spinczyk)
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
...
> +/*
> + * blkdev_write_iter() can call this without i_rwsem, need to be
> + * careful with i_flags update.
> + */
>  static inline void inode_has_no_xattr(struct inode *inode)
>  {
>  	if (!is_sxid(inode->i_mode) && (inode->i_sb->s_flags & SB_NOSEC))
> -		inode->i_flags |= S_NOSEC;
> +		inode_set_flags(inode, S_NOSEC, S_NOSEC);
>  }

Thinking more about this I'm not sure if this is actually the right
solution. Because for example the write(2) can set S_NOSEC flag wrongly
when it would race with chmod adding SUID bit. So probably we rather need
to acquire i_rwsem in blkdev_write_iter() if file does not have S_NOSEC set
(we don't want to acquire it unconditionally as that would heavily impact
scalability of block device writes).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
