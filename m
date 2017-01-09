Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35181 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938564AbdAIU6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 15:58:12 -0500
Date: Mon, 9 Jan 2017 15:58:02 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 12/17] blk-throttle: add interface to configure idle
 time threshold
Message-ID: <20170109205802.GQ12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <d950668d79d27d585faed9fc8747ed806d4e1031.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d950668d79d27d585faed9fc8747ed806d4e1031.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Dec 15, 2016 at 12:33:03PM -0800, Shaohua Li wrote:
> @@ -180,6 +180,8 @@ struct throtl_data
>  	unsigned int limit_index;
>  	bool limit_valid[LIMIT_CNT];
>  
> +	u64 dft_idle_ttime_threshold;

BTW, wouldn't idle_time be a better name for these?  Currently, it's
"idle thinktime" and I'm not sure what that means.

Thanks.

-- 
tejun
