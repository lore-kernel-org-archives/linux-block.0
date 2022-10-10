Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C4C4332F
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 06:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJJGnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJJGnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 02:43:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623164DB4A
        for <linux-block@vger.kernel.org>; Sun,  9 Oct 2022 23:43:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E60CC2198A;
        Mon, 10 Oct 2022 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665384193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ3ztFcICB2ExxiQTSGMWrF5z1fsQDeZ62RdRBFtHwg=;
        b=SnCLH/jb54/jVBqN4q4VAttcLurcu9FZFZSOyXz17ysOfCk17zUDAOQH2FFt1C0dQ3Bp0v
        7DtltwBDB2+xFLJGpIfAh53mChWQx4nhvqZKpo3a9YytpfWHRaLKUPUAoFfwJUleB8e4uH
        Z0tMWidEBm/G8J4lC7BXiULZqAmVg5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665384193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ3ztFcICB2ExxiQTSGMWrF5z1fsQDeZ62RdRBFtHwg=;
        b=r3Y4JlS6tV80GsuloANhX0T66fSEjR4K5Wq6SIs8fSbC3UioiiYxUGsJK5fdW6RWuTBWTz
        Ptb2m9NruBvPk8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D004613479;
        Mon, 10 Oct 2022 06:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XiWJMgG/Q2OvQQAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 10 Oct 2022 06:43:13 +0000
Date:   Mon, 10 Oct 2022 08:43:13 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] block: fix leaking minors of hidden disks
Message-ID: <20221010064313.3xxk6lrk32okyjva@carbon.lan>
References: <20221007193825.4058951-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007193825.4058951-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 07, 2022 at 12:38:25PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The major/minor of a hidden gendisk is not propagated to the block
> device. This is required to suppress it from being visible. For these
> disks, we need to handle freeing the dynamic minor directly when it's
> released since bdev_free_inode() won't be able to.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Thanks for the quick fix!

Tested-by: Daniel Wagner <dwagner@suse.de>

# ls -l /dev/nvme*
crw------- 1 root root  10, 124 Oct 10 08:39 /dev/nvme-fabrics
crw------- 1 root root 243,   0 Oct 10 08:38 /dev/nvme0
brw-rw---- 1 root disk 259,   0 Oct 10 08:38 /dev/nvme0n1
crw------- 1 root root 243,   2 Oct 10 08:41 /dev/nvme2
brw-rw---- 1 root disk 259,   2 Oct 10 08:41 /dev/nvme2n1
brw-rw---- 1 root disk 259,   3 Oct 10 08:41 /dev/nvme2n1p1
brw-rw---- 1 root disk 259,   5 Oct 10 08:41 /dev/nvme2n2
brw-rw---- 1 root disk 259,   7 Oct 10 08:41 /dev/nvme2n3
brw-rw---- 1 root disk 259,   9 Oct 10 08:41 /dev/nvme2n4
crw------- 1 root root 243,   3 Oct 10 08:41 /dev/nvme3
crw------- 1 root root 243,   4 Oct 10 08:41 /dev/nvme4
crw------- 1 root root 243,   5 Oct 10 08:41 /dev/nvme5
# nvme disconnect-all
# nvme connect-all
# ls -l /dev/nvme*
crw------- 1 root root  10, 124 Oct 10 08:39 /dev/nvme-fabrics
crw------- 1 root root 243,   0 Oct 10 08:38 /dev/nvme0
brw-rw---- 1 root disk 259,   0 Oct 10 08:38 /dev/nvme0n1
crw------- 1 root root 243,   2 Oct 10 08:41 /dev/nvme2
brw-rw---- 1 root disk 259,   2 Oct 10 08:41 /dev/nvme2n1
brw-rw---- 1 root disk 259,   3 Oct 10 08:41 /dev/nvme2n1p1
brw-rw---- 1 root disk 259,   5 Oct 10 08:41 /dev/nvme2n2
brw-rw---- 1 root disk 259,   7 Oct 10 08:41 /dev/nvme2n3
brw-rw---- 1 root disk 259,   9 Oct 10 08:41 /dev/nvme2n4
crw------- 1 root root 243,   3 Oct 10 08:41 /dev/nvme3
crw------- 1 root root 243,   4 Oct 10 08:41 /dev/nvme4
crw------- 1 root root 243,   5 Oct 10 08:41 /dev/nvme5

