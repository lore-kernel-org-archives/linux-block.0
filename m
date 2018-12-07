Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E33C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 11:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A2F20868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 11:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A2F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLGLO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:14:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:41566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbeLGLO3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 06:14:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D733ABE7;
        Fri,  7 Dec 2018 11:14:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8D95E1E0D9D; Fri,  7 Dec 2018 12:14:26 +0100 (CET)
Date:   Fri, 7 Dec 2018 12:14:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] Fix sync. in inode_has_no_xattr()
Message-ID: <20181207111426.GG13008@quack2.suse.cz>
References: <13eaa1c6-def5-afad-89eb-6f149db90684@tu-dortmund.de>
 <20181205153254.GD30615@quack2.suse.cz>
 <c4f0d66f-7cad-c3b4-79a6-ced14b9c7cc8@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f0d66f-7cad-c3b4-79a6-ced14b9c7cc8@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 07-12-18 11:24:47, Alexander Lochmann wrote:
> Am 05.12.18 um 16:32 schrieb Jan Kara:
> > 
> > Thinking more about this I'm not sure if this is actually the right
> > solution. Because for example the write(2) can set S_NOSEC flag wrongly
> > when it would race with chmod adding SUID bit. So probably we rather need
> > to acquire i_rwsem in blkdev_write_iter() if file does not have S_NOSEC set
> > (we don't want to acquire it unconditionally as that would heavily impact
> > scalability of block device writes).
> > 
> > 								Honza
> > 
> Trying to implement your suggestion, I'm not sure which inode to use:
> In blkdev_write_iter() there is the "bd_inode = bdev_file_inode(file)".
> file_remove_privs() uses "inode = file_inode(file)" as a parameter for
> inode_has_no_xattr().
> So, do file->f_mapping->host and f->f_inode refer to the identical inode?

Ah, that's a good question and I forgot to warn you. Sorry for that and my
respect for noticing this yourself :). For block devices f->f_inode refers
to the device inode in the filesystem (i.e., where xattrs are attached to,
permissions are stored, etc.).  file->f_mapping->host refers to the inode
carrying data - this split is needed so that if there are more instances of
device inode in the system for the same block device, they see data
coherently. So you need to use file_inode(file) for the locking. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
