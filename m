Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F9C433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 10:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiA0Kbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:31:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55763 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiA0Kbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 05:31:46 -0500
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20RAVR9S002426;
        Thu, 27 Jan 2022 19:31:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 27 Jan 2022 19:31:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20RAVRsj002421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Jan 2022 19:31:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60b17284-8baf-a0a4-c27c-3f8f1e21b93c@I-love.SAKURA.ne.jp>
Date:   Thu, 27 Jan 2022 19:31:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-6-hch@lst.de>
 <20220127102848.eyzf5wwbssbvgkim@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220127102848.eyzf5wwbssbvgkim@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/27 19:28, Jan Kara wrote:
> So this also relies on disk->open_mutex for correctness. Otherwise a race
> like:
> 
> Thread1			Thread2
> lo_open()
>   if (atomic_inc_return(&lo->lo_refcnt) > 1)
>   mutex_lock_killable(&lo->lo_mutex);
> 			lo_open()
> 			if (atomic_inc_return(&lo->lo_refcnt) > 1)
> 			  return 0;
>   ..
> 
> can result in Thread2 using the loop device before Thread1 actually did the
> "first open" checks. So perhaps one common comment for lo_open + lo_release
> explaining the locking?

Please see https://lkml.kernel.org/r/7bebf860-2415-7eb6-55a1-47dc4439d9e9@I-love.SAKURA.ne.jp .
