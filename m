Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA89C433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 02:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F8261056
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 02:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbhIDCuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:50:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52866 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhIDCuV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 22:50:21 -0400
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1842n8gH062510;
        Sat, 4 Sep 2021 11:49:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 04 Sep 2021 11:49:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1842n7mM062505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Sep 2021 11:49:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
Date:   Sat, 4 Sep 2021 11:49:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210904013932.3182778-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/04 10:39, Luis Chamberlain wrote:
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 45df6cbccf12..81a4738910a8 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1144,10 +1144,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
>  {
>  	struct block_device *bdev;
>  	struct inode *inode;
> +	int ret;
>  
>  	inode = ilookup(blockdev_superblock, dev);
>  	if (!inode) {
> -		blk_request_module(dev);
> +		ret = blk_request_module(dev);
> +		if (ret)
> +			return NULL;

Since e.g. loop_add() from loop_probe() returns -EEXIST when /dev/loop$num already
exists (e.g. raced with ioctl(LOOP_CTL_ADD)), isn't unconditionally failing an over-failing?

>  		inode = ilookup(blockdev_superblock, dev);
>  		if (!inode)
>  			return NULL;

By the way, Jens, will you pick up
https://lkml.kernel.org/r/adb1e792-fc0e-ee81-7ea0-0906fc36419d@i-love.sakura.ne.jp
before these "add error handling" changes?

