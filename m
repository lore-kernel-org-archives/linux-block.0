Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE21DC433EF
	for <linux-block@archiver.kernel.org>; Sun,  6 Feb 2022 07:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiBFHo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Feb 2022 02:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBFHo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Feb 2022 02:44:27 -0500
X-Greylist: delayed 2026 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 23:44:25 PST
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F61C06173B
        for <linux-block@vger.kernel.org>; Sat,  5 Feb 2022 23:44:25 -0800 (PST)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2167A9uQ075642;
        Sun, 6 Feb 2022 16:10:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sun, 06 Feb 2022 16:10:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2167A8G9075629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 6 Feb 2022 16:10:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a72c59c6-298b-e4ba-b1f5-2275afab49a1@I-love.SAKURA.ne.jp>
Date:   Sun, 6 Feb 2022 16:10:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-6-hch@lst.de>
 <397e50c7-ae46-8834-1632-7bac1ad7df99@I-love.SAKURA.ne.jp>
 <10d156e7-4347-4ccd-51f4-ea5febd1b1ee@I-love.SAKURA.ne.jp>
In-Reply-To: <10d156e7-4347-4ccd-51f4-ea5febd1b1ee@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/02/05 9:28, Tetsuo Handa wrote:
> Ping?
> 
> I sent https://lkml.kernel.org/r/20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp
> based on ideas from your series.
> 

I tested my latest series and found that there are two problems.



One is that there still is disk->open_mutex => loop_validate_mutex =>
lo->lo_mutex chain. We would need to consider something like
https://lkml.kernel.org/r/fffda32f-848a-712b-f50e-8a6d7d086039@i-love.sakura.ne.jp
if we go with avoiding lo->lo_mutex while holding disk->open_mutex.



The other is that my latest series which does not hold lo->lo_mutex from
lo_open() causes occasional I/O error (due to

	if (lo->lo_state != Lo_bound)
		return BLK_STS_IOERR;

check in loop_queue_rq()) when systemd-udevd opens a loop device and
reads from it before loop_configure() updates lo->lo_state to Lo_bound.
(And I think the same problem exists for your series because we assumed
that we need to care about only loop_control_remove().)

If we want to avoid I/O error, open() of a loop device (currently lo_open())
needs to wait for loop_configure() to complete, by waiting for lo->lo_mutex
to be released. But this implies that we can't avoid lo->lo_mutex while holding
disk->open_mutex. Use of task work context (my previous series which is intended
for waiting for __loop_clr_fd() to complete) will allow waiting for lo->lo_mutex
without holding disk->open_mutex, but we want to avoid task work context if
possible...

[ 3069.404881] loop184: detected capacity change from 0 to 2048
[ 3069.452117] loop185: detected capacity change from 0 to 2048
[ 3069.457155] I/O error, dev loop185, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 3069.465309] loop186: detected capacity change from 0 to 2048
[ 3069.506238] loop187: detected capacity change from 0 to 2048
[ 3069.525483] loop188: detected capacity change from 0 to 2048
[ 3069.551447] loop189: detected capacity change from 0 to 2048
[ 3069.576062] loop190: detected capacity change from 0 to 2048
[ 3069.592206] loop191: detected capacity change from 0 to 2048
[ 3069.681413] loop192: detected capacity change from 0 to 2048
[ 3069.911000] loop193: detected capacity change from 0 to 2048
[ 3070.049889] loop194: detected capacity change from 0 to 2048
[ 3070.063847] loop195: detected capacity change from 0 to 2048
[ 3070.168926] loop196: detected capacity change from 0 to 2048
[ 3070.242869] loop197: detected capacity change from 0 to 2048
[ 3070.383477] loop198: detected capacity change from 0 to 2048
[ 3070.439035] loop199: detected capacity change from 0 to 2048
[ 3070.464548] loop200: detected capacity change from 0 to 2048
[ 3070.501891] loop201: detected capacity change from 0 to 2048
[ 3070.513600] loop202: detected capacity change from 0 to 2048
[ 3070.523923] I/O error, dev loop202, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 3070.531281] I/O error, dev loop202, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 3070.541353] Buffer I/O error on dev loop202, logical block 0, async page read
[ 3070.684234] loop203: detected capacity change from 0 to 2048
[ 3070.705911] loop204: detected capacity change from 0 to 2048
[ 3070.716153] loop205: detected capacity change from 0 to 2048
[ 3070.735178] loop206: detected capacity change from 0 to 2048
[ 3070.833832] loop207: detected capacity change from 0 to 2048
[ 3070.835086] I/O error, dev loop207, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 3070.851433] loop208: detected capacity change from 0 to 2048
[ 3070.873609] loop209: detected capacity change from 0 to 2048
[ 3070.890193] loop210: detected capacity change from 0 to 2048

