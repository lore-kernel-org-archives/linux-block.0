Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE664C433F5
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 15:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiAMPri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:47:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47654 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiAMPrh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 10:47:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B5DC1F3CD;
        Thu, 13 Jan 2022 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642088856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=tuADTLT4KlmQGRFiFRwWkhr8g0fsZXyfY0BNVq8KCqc=;
        b=lLj/BHXvz5/VQjOGPfL9pnTFryJLBrCxPCSQbsd1IQokWzfq+jTHqCLL7ONsvauV2ACFds
        55z6EgrrogpHQGFQDbnHpmmQJ1vA+uspynsi6YGBTK6YkfonAdQ3nbJVv2XaxaaCb81I+H
        hho53hi+THsrQVukXfRw/BBu/M6ZPYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642088856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=tuADTLT4KlmQGRFiFRwWkhr8g0fsZXyfY0BNVq8KCqc=;
        b=w5/bzTB8dOBeLfbqv/YkU81XDWMwUWM6ZBSeTwJoVgboPLfEzCioC11jp9fNFEQEB8tkZT
        kjnqD3ivWDr+2aCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3D47BA3B83;
        Thu, 13 Jan 2022 15:47:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB91AA05E2; Thu, 13 Jan 2022 16:47:35 +0100 (CET)
Date:   Thu, 13 Jan 2022 16:47:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Racy loop device reuse logic
Message-ID: <20220113154735.hdzi4cqsz5jt6asp@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Tetsuo has been doing some changes to the loop device shutdown in the
kernel and that broke LTP that is doing essentially the following loop:

while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

And this loop is broken because of a subtle interaction with systemd-udev
that also opens the loop device. The race seems to be in mount(8) handling
itself and the altered kernel timing makes it happen. It look like:

bash					systemd-udev
  mount -o loop,ro isofs.iso isofs/
    /dev/loop0 is created and bound to isofs.iso, autoclear is set for
    loop0
  					opens /dev/loop0
  umount isofs/
  loop0 still lives because systemd-udev still has device open
  mount -o loop,ro isofs.iso isofs/
    gets to mnt_context_setup_loopdev()
      loopcxt_find_overlap()
      sees loop0 is still valid and with proper parameters
      reuse = true;
					close /dev/loop0
					  last fd closed => loop0 is
					    cleaned up
      loopcxt_get_fd()
        opens loop0 but it is no longer the device we wanted!
    calls mount(2) which fails because we cannot read from the loop device

It seems to me that mnt_context_setup_loopdev() should actually recheck
that loop device parameters still match what we need after opening
/dev/loop0 (if LOOP_GET_STATUS ioctl succeeds on the fd, you are guaranteed
the loop device is in that state and will not be torn down under your
hands). What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
