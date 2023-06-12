Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E58C7EE25
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 03:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFLDaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjFLDai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jun 2023 23:30:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40BF5;
        Sun, 11 Jun 2023 20:30:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB39068BFE; Mon, 12 Jun 2023 05:30:23 +0200 (CEST)
Date:   Mon, 12 Jun 2023 05:30:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, dsterba@suse.com, hch@lst.de,
        konishi.ryusuke@gmail.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Subject: Re: [syzbot] [nilfs?] general protection fault in
 nilfs_clear_dirty_page
Message-ID: <20230612033023.GA16241@lst.de>
References: <000000000000da4f6b05eb9bf593@google.com> <000000000000c0951105fde12435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c0951105fde12435@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 11, 2023 at 02:18:29PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 4a445b7b6178d88956192c0202463063f52e8667
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sat Aug 13 08:06:53 2022 +0000
> 
>     btrfs: don't merge pages into bio if their page offset is not contiguous

I can't see how that btrfs commit would affect nilfs2..

