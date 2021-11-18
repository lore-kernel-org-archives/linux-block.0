Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B41FC433FE
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AF061181
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 14:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhKROSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:18:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65067 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhKROSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 09:18:20 -0500
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AIEFAIN035187;
        Thu, 18 Nov 2021 23:15:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Thu, 18 Nov 2021 23:15:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AIEF9YL035183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Nov 2021 23:15:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c685d6dc-3918-6ee5-df59-f2d814635228@I-love.SAKURA.ne.jp>
Date:   Thu, 18 Nov 2021 23:15:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] loop: mask loop_control_ioctl parameter only as minor
Content-Language: en-US
To:     wangyangbo <yangbonis@icloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211118023640.32559-1-yangbonis@icloud.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20211118023640.32559-1-yangbonis@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/18 11:36, wangyangbo wrote:
> @@ -2170,11 +2170,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  {
>  	switch (cmd) {
>  	case LOOP_CTL_ADD:
> -		return loop_add(parm);
> +		return loop_add(MINOR(parm));

Better to return -EINVAL or something if out of minor range?

>  	case LOOP_CTL_REMOVE:
> -		return loop_control_remove(parm);
> +		return loop_control_remove(MINOR(parm));

This is bad, for this change makes

	if (idx < 0) {
		pr_warn("deleting an unspecified loop device is not supported.\n");
		return -EINVAL;
	}

dead code by masking the argument to 0-1048575 range.

>  	case LOOP_CTL_GET_FREE:
> -		return loop_control_get_free(parm);
> +		return loop_control_get_free(MINOR(parm));

This is pointless, for the passed argument is not used.
By the way, didn't someone already propose removal of this argument?

>  	default:
>  		return -ENOSYS;
>  	}
> 

