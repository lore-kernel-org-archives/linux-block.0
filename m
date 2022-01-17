Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45457C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 09:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiAQJ7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 04:59:24 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56323 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiAQJ7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 04:59:24 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20H9xLPK032445;
        Mon, 17 Jan 2022 18:59:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 17 Jan 2022 18:59:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20H9xLeW032442
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jan 2022 18:59:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <39926f88-8024-ff1e-efd1-cc273a720a3c@I-love.SAKURA.ne.jp>
Date:   Mon, 17 Jan 2022 18:59:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] brd: remove brd_devices_mutex mutex
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <6b074af7-c165-4fab-b7da-8270a4f6f6cd@i-love.sakura.ne.jp>
In-Reply-To: <6b074af7-c165-4fab-b7da-8270a4f6f6cd@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On 2022/01/06 18:53, Tetsuo Handa wrote:
> If brd_alloc() from brd_probe() is called before brd_alloc() from
> brd_init() is called, module loading will fail with -EEXIST error.
> To close this race, call __register_blkdev() just before leaving
> brd_init().
> 
> Then, we can remove brd_devices_mutex mutex, for brd_device list
> will no longer be accessed concurrently.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
