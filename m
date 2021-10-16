Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC01C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6098061164
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 13:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhJPN17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 09:27:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54009 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhJPN16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 09:27:58 -0400
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19GDPela063723;
        Sat, 16 Oct 2021 22:25:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sat, 16 Oct 2021 22:25:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19GDPdvA063720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 16 Oct 2021 22:25:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] ataflop: unlock ataflop_probe_lock at atari_floppy_init()
Message-ID: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
Date:   Sat, 16 Oct 2021 22:25:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit bf9c0538e485b591 ("ataflop: use a separate gendisk for each media
format") introduced ataflop_probe_lock mutex, but forgot to unlock the
mutex when atari_floppy_init() (i.e. module loading) succeeded. If
ataflop_probe() is called, it will deadlock on ataflop_probe_lock mutex.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: bf9c0538e485b591 ("ataflop: use a separate gendisk for each media format")
---
To m68k users

  This patch suggests that nobody is testing this module using a real hardware.
  Can somebody test this module?
  Is current m68k hardware still supporting Atari floppy?
  If Atari floppy is no longer supported, do we still need this module?

To Christoph Hellwig and Luis Chamberlain

  If we move __register_blkdev() in atari_floppy_init() to the end of
  atari_floppy_init() and move unregister_blkdev() in atari_floppy_exit() to
  the beginning of atari_floppy_exit(), we can remove unregister_blkdev() from
  atari_floppy_init(), and I think we can also remove ataflop_probe_lock mutex
  because probe function and __exit function are serialized by major_names_lock
  mutex.

 drivers/block/ataflop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..39b42cb8d173 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2072,7 +2072,8 @@ static int __init atari_floppy_init (void)
 	       UseTrackbuffer ? "" : "no ");
 	config_types();
 
-	return 0;
+	ret = 0;
+	goto out_unlock;
 
 err:
 	while (--i >= 0) {
-- 
2.18.4

