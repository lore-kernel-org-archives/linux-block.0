Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A08C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhLTIXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 03:23:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53790 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbhLTIXb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 03:23:31 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BK8NDdj032132;
        Mon, 20 Dec 2021 17:23:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 20 Dec 2021 17:23:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BK8ND8O032126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Dec 2021 17:23:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <11adfb69-9ce6-c1f6-7b0d-c435e1856412@i-love.sakura.ne.jp>
Date:   Mon, 20 Dec 2021 17:23:08 +0900
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <Yb+Pbz1pCNEs4xw3@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/20 5:00, Luis Chamberlain wrote:
> On Fri, Dec 17, 2021 at 07:37:43PM +0900, Tetsuo Handa wrote:
>> I think we can apply this patch as-is...
> 
> Unfortunately I don't think so, don't we end up still with a race
> in between the first part of device_add() and the kobject_add()
> which adds the kobject to generic layer and in return enables the
> disk_release() call for the disk? I count 5 error paths in between
> including kobject_add() which can fail as well.

I can't catch which path you are talking about.
Will you explain more details using call trace (or line numbers in
https://elixir.bootlin.com/linux/v5.16-rc6/source/block/genhd.c#L397 ) ?

> 
> If correct then something like the following may be needed:
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 3c139a1b6f04..08ab7ce63e57 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -539,9 +539,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  out_device_del:
>  	device_del(ddev);
>  out_disk_release_events:
> -	disk_release_events(disk);
> +	if (!kobject_alive(&ddev->kobj))
> +		disk_release_events(disk);
>  out_free_ext_minor:
> -	if (disk->major == BLOCK_EXT_MAJOR)
> +	if (!kobject_alive(&ddev->kobj) && disk->major == BLOCK_EXT_MAJOR)

How can kobject_alive() matter?

The minor id which was stored into disk->first_minor is allocated by
https://elixir.bootlin.com/linux/v5.16-rc6/source/block/genhd.c#L432 ,
and that minor id is copied to bdev->bd_dev (which
https://elixir.bootlin.com/linux/v5.16-rc6/source/block/bdev.c#L415 will
release) by
https://elixir.bootlin.com/linux/v5.16-rc6/source/block/genhd.c#L511 ,
doesn't it?

Unless there is a location (except genhd.c#L511) which copies that minor id
to bdev->bd_dev (which bdev.c#L415 will release), it is correct to
unconditionally undo allocation by genhd.c#L432 at genhd.c#L546 .

Will you explain what path you are talking about?

