Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiK3Nxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiK3Nxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 08:53:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CED4A9DE
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 05:53:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FEB221B04;
        Wed, 30 Nov 2022 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669816425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SVREfA82fl2axC2I3XuakVKh9BWTXyKpdYBjc03UD7o=;
        b=Qi8luJV6AvxT3XiYq+QpPTIHBUe2cd/ZJQfk8cKFOi/V1BypznrS/115mCYApni3t7E0vE
        TNqeLlYtoEpaAuOCRwzPmaDzcSaNBjsH9yeVw+g2rjvlkDaTxM9TT564y01YdHVIaFTqVi
        Hh/w3BgKEWlP6tZsSDq1J9fIu/Jrr74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669816425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SVREfA82fl2axC2I3XuakVKh9BWTXyKpdYBjc03UD7o=;
        b=quIGzdy9EXJxjzKoX2n/BH6+bXDjMT0WPogWm+4VwhOr3TgBMKbDv+H2nhEFOZP96dS3zD
        EThJRiEJlO+WCHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 220AB13A70;
        Wed, 30 Nov 2022 13:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RoBICGlgh2N8bAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Nov 2022 13:53:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C339A0710; Wed, 30 Nov 2022 14:53:44 +0100 (CET)
Date:   Wed, 30 Nov 2022 14:53:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Partitions created under RAID devices
Message-ID: <20221130135344.2ul4cyfstfs3znxg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

One of our customers has found out that commit 10c70d95c0f2 ("block: remove
the bd_openers checks in blk_drop_partitions") broke distro installation on
their machines. The problem with their setup is following: They have two
disks in RAID1 setup with 1.0 metadata (so RAID metadata is at the end). The
resulting RAID device is partitioned. Now when RAID device is assembled,
mdadm takes care to remove partitions of the underlying devices. So before
commit 10c70d95c0f2 /proc/partitions output looks like:

...
   8       16    1048576 sdb
   8        0    1048576 sda
   9        0    1048512 md0
 259        0    1047471 md0p1

After commit 10c70d95c0f2 the situation is the same until someone calls
BLKRRPART. Then partitions on sda and sdb are recreated because of missing
bd_openers check:

...
   8       16    1048576 sdb
   8       17    1048576 sdb1
   8        0    1048576 sda
   8        1    1048576 sda1
   9        0    1048512 md0
 259        0     838656 md0p1

This breaks installation because the partitioning code in the installer
does not count with this situation, tries to do something (call wipefs)
with the sda1 partition and gets an error.

As I've studied history behind partition rescanning I understand it is
difficult to please everybody :). But creating partitions under assembled
RAID device looks wrong to me. So I was wondering - couldn't
disk_scan_partitions() just refuse to operate on the device if there's
another exclusive opener (it will be a bit painful to do the check but it
is doable)? That will fix this problem with RAID and should
not be prone to races with udev or similar problems causing troubles in the
past. What do people think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
