Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E06C4338F
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7506260232
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhHQKSz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:18:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54874 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhHQKSz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 06:18:55 -0400
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17HAI8C7041403;
        Tue, 17 Aug 2021 19:18:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Tue, 17 Aug 2021 19:18:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17HAI8V2041399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Aug 2021 19:18:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <20210816073313.GA27275@lst.de> <20210817081045.3609-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3cf9d371-50e4-76a0-4024-64eca22befdf@i-love.sakura.ne.jp>
Date:   Tue, 17 Aug 2021 19:18:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817081045.3609-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/17 17:10, Hillf Danton wrote:
> See if it is safe to kfree(lo) after removing it from idr, with the
> deadlock dissolved.

It is not safe to call loop_remove() after idr_remove(). Please see HIDDEN_LOOP_DEVICE magic
in "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex".

> 
> --- x/drivers/block/loop.c
> +++ y/drivers/block/loop.c
> @@ -2459,7 +2459,9 @@ static int loop_control_remove(int idx)
>  	mutex_unlock(&lo->lo_mutex);
>  
>  	idr_remove(&loop_index_idr, lo->lo_number);
> +	mutex_unlock(&loop_ctl_mutex);
>  	loop_remove(lo);
> +	return 0;
>  out_unlock_ctrl:
>  	mutex_unlock(&loop_ctl_mutex);
>  	return ret;
> --
> 

"[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex" can be a further
improvement after "[PATCH v3] block: genhd: don't call probe function with major_names_lock held".

I really would like to apply "[PATCH v3] block: genhd: don't call probe function with major_names_lock held" first.
