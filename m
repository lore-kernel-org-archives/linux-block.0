Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB4C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 19:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6686661050
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 19:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345939AbhIXTz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345937AbhIXTz5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 15:55:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5879F6103D;
        Fri, 24 Sep 2021 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632513263;
        bh=ukP31P3ZCbd3SW/z+kSgzmpssJsR08rh0NSjW1DOuw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v5cJFMY/oHXiaLx/PcI7cSIIO/6F2NxdLW8DrNvjiHhR/MElw6W//OPe7WJU/DGG0
         BnVE3pt774VkHH/X+CJ/WADPXKV8uP6kSqXS3s8z2y7ubybfxQPcCLZdJaWj2Kd1dy
         rHwQK0Lc8z1r0axPSQY52clYcoExli7fIYOFKEvc=
Date:   Fri, 24 Sep 2021 12:54:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v5] zram: Introduce an aged idle interface
Message-Id: <20210924125422.358374d83cdb95db055a4467@linux-foundation.org>
In-Reply-To: <20210924161128.1508015-1-bgeffon@google.com>
References: <20210917210640.214211-1-bgeffon@google.com>
        <20210924161128.1508015-1-bgeffon@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 24 Sep 2021 09:11:28 -0700 Brian Geffon <bgeffon@google.com> wrote:

> This change introduces an aged idle interface to the existing
> idle sysfs file for zram.
> 
> When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
> now also accepts an integer argument. This integer is the
> age (in seconds) of pages to mark as idle. The idle file
> still supports 'all' as it always has. This new approach
> allows for much more control over which pages get marked
> as idle.
> 
>   v4 -> v5:
> 	- Andrew's suggestions to use IS_ENABLED and
> 	  cleanup comment.

Also this?

--- a/drivers/block/zram/zram_drv.c~zram-introduce-an-aged-idle-interface-v5-fix
+++ a/drivers/block/zram/zram_drv.c
@@ -309,9 +309,8 @@ static void mark_idle(struct zram *zram,
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
 				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
-#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+			if (IS_ENABLED(CONFIG_ZRAM_MEMORY_TRACKING))
 				is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
-#endif
 			if (is_idle)
 				zram_set_flag(zram, index, ZRAM_IDLE);
 		}
_

