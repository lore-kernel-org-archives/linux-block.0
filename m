Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07307C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbiCPIpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiCPIpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:45:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1B34BAB
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:44:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15B2268AFE; Wed, 16 Mar 2022 09:44:30 +0100 (CET)
Date:   Wed, 16 Mar 2022 09:44:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and
 lo_release()
Message-ID: <20220316084429.GA6858@lst.de>
References: <00000000000099c4ca05da07e42f@google.com> <bbdd20da-bccb-2dbb-7c46-be06dcfc26eb@I-love.SAKURA.ne.jp> <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp> <20220314152318.k4cvwe737q5r5juw@quack3.lan> <20220315084458.GA3911@lst.de> <134d1b65-f7c0-b8b3-d6c9-4a5e1d807afd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134d1b65-f7c0-b8b3-d6c9-4a5e1d807afd@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 07:57:25PM +0900, Tetsuo Handa wrote:
> On 2022/03/15 17:44, Christoph Hellwig wrote:
> > On Mon, Mar 14, 2022 at 04:23:18PM +0100, Jan Kara wrote:
> >> Honestly, the anon inode trick makes the code pretty much unreadable. As
> >> far as I remember Christoph was not pricipially against using task_work. He
> >> just wanted the task_work API to be improved so that it is easier to use.
> > 
> > This whole patch is awful.  And no, I don't think task_work_add really has
> > any business here.  We need to properly unwind the mess instead of piling
> > things higher and higher.
> 
> How do you plan to unwind the mess?

Yes.  I'll send another resping of the previous approach we had last
time..
