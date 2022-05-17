Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 06:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiEQGMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 02:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiEQGMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 02:12:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F7443EFD;
        Mon, 16 May 2022 23:12:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B87E68AFE; Tue, 17 May 2022 08:12:38 +0200 (CEST)
Date:   Tue, 17 May 2022 08:12:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH] blkcg: rewind seq_file if no stats
Message-ID: <20220517061238.GB4789@lst.de>
References: <CACGdZYLMW2KHVebfyJZVn9G=15N+Jt4+8oF5gq3wdDTOcXbk9A@mail.gmail.com> <20220513174030.1307720-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513174030.1307720-1-khazhy@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 13, 2022 at 10:40:30AM -0700, Khazhismel Kumykov wrote:
> Restores the previous behavior of only displaying devices for which we
> have statistics (and removes the current, broken, behavior of printing
> devname with no newline if no statistics)
> 
> In lieu of get_seq_buf + seq_commit, provide a way to "undo" writes if
> we use seq_printf

I have to say I much prefer the simpler fix from Wolfgang.  But
if we want to go down this route it needs to split into a patch
for the seq_file infrastruture and a separate one for the blk-cgroup
code.
