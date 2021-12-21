Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1DAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 11:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhLULla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:41:30 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52817 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhLULla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 06:41:30 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BLBfJAi008153;
        Tue, 21 Dec 2021 20:41:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Tue, 21 Dec 2021 20:41:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BLBfIPe008150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Dec 2021 20:41:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <e5a62dee-a420-f9c4-f33d-e154cf4b0d9e@i-love.sakura.ne.jp>
Date:   Tue, 21 Dec 2021 20:41:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
 <20211216161806.GA31879@lst.de> <20211216161928.GB31879@lst.de>
 <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
 <Yb+Pbz1pCNEs4xw3@bombadil.infradead.org>
 <11adfb69-9ce6-c1f6-7b0d-c435e1856412@i-love.sakura.ne.jp>
 <YcDWjrTgNG8/vkmJ@bombadil.infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <YcDWjrTgNG8/vkmJ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/21 4:16, Luis Chamberlain wrote:
> The kobject_alive() tells us if at least the device_add() had the
> kobject_add() complete.


Testing with error injection

@@ -3284,6 +3284,9 @@ int device_add(struct device *dev)
        if (!dev)
                goto done;

+       if (!strcmp(current->comm, "a.out"))
+               goto done;
+
        if (!dev->p) {
                error = device_private_init(dev);
                if (error)

told me that kref count is 1 when reaching the out_disk_release_events label.
Thus,

	if (!kobject_alive(&ddev->kobj))

seems wrong.

Christoph proposed deferring disk_alloc_events(). If it is safe to defer
disk_alloc_events(), that can be a fix. But I don't know if there is a path
which can invoke disk event functions (e.g. disk_block_events() from
blkdev_get_by_dev()) between device_add() and disk_alloc_events().
I didn't find a path, but at least the device file and some of sysfs files
are already visible before disk_alloc_events() is called...
