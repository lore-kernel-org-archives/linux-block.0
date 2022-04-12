Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5592C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 23:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiDLXiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiDLXcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:07 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7099492843
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 15:18:45 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23CMIbrh028703;
        Wed, 13 Apr 2022 07:18:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Wed, 13 Apr 2022 07:18:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23CMIaVq028699
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Apr 2022 07:18:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <55006f3b-9571-9167-eaf0-6a2caec747ad@I-love.SAKURA.ne.jp>
Date:   Wed, 13 Apr 2022 07:18:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] block/rnbd: client: avoid flush_workqueue(system_long_wq)
 usage
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
References: <becb2389-e249-0aa2-7701-2c02155aedf2@I-love.SAKURA.ne.jp>
In-Reply-To: <becb2389-e249-0aa2-7701-2c02155aedf2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/12 22:46, Tetsuo Handa wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> 
> Since system_long_wq is used only inside rnbd_destroy_sessions(),
> let's use list_head than creating a local workqueue for tracking
> work_struct to flush.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Notice: This patch is only compile tested. Please test before applying.
> 
>  drivers/block/rnbd/rnbd-clt.c | 5 ++++-
>  drivers/block/rnbd/rnbd-clt.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index b66e8840b94b..b14e7c15133e 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1730,6 +1730,7 @@ static void rnbd_destroy_sessions(void)
>  {
>  	struct rnbd_clt_session *sess, *sn;
>  	struct rnbd_clt_dev *dev, *tn;
> +	LIST_HEAD(list);
>  
>  	/* Firstly forbid access through sysfs interface */
>  	rnbd_clt_destroy_sysfs_files();
> @@ -1762,11 +1763,13 @@ static void rnbd_destroy_sessions(void)
>  			 */
>  			INIT_WORK(&dev->unmap_on_rmmod_work, unmap_device_work);
>  			queue_work(system_long_wq, &dev->unmap_on_rmmod_work);
> +			list_add_tail(&dev->unmap_on_rmmod_list, &list);
>  		}
>  		rnbd_clt_put_sess(sess);
>  	}
>  	/* Wait for all scheduled unmap works */
> -	flush_workqueue(system_long_wq);
> +	list_for_each_entry(dev, &list, unmap_on_rmmod_list)
> +		flush_work(&dev->unmap_on_rmmod_work);

Since kfree(dev) might be called from unmap_device_work(), this seems unsafe.
We need rnbd_clt_get_dev() before queue_work() and rnbd_clt_put_dev() after flush_work()
in order to make dev->unmap_on_rmmod_list traversal safe...

>  	WARN_ON(!list_empty(&sess_list));
>  }
>  
> diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
> index 2e2e8c4a85c1..a6d704abda61 100644
> --- a/drivers/block/rnbd/rnbd-clt.h
> +++ b/drivers/block/rnbd/rnbd-clt.h
> @@ -136,6 +136,7 @@ struct rnbd_clt_dev {
>  	char			*blk_symlink_name;
>  	refcount_t		refcount;
>  	struct work_struct	unmap_on_rmmod_work;
> +	struct list_head	unmap_on_rmmod_list;
>  };
>  
>  /* rnbd-clt.c */

