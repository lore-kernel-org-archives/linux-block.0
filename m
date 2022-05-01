Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE2C433F5
	for <linux-block@archiver.kernel.org>; Sun,  1 May 2022 04:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiEAEN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 May 2022 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiEAEN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 May 2022 00:13:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7B5FF2F
        for <linux-block@vger.kernel.org>; Sat, 30 Apr 2022 21:10:01 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24149rwF027582;
        Sun, 1 May 2022 13:09:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sun, 01 May 2022 13:09:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24149lf2027552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 1 May 2022 13:09:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <050bd5a3-e2ef-0d67-7083-e34bc65f1f2d@I-love.SAKURA.ne.jp>
Date:   Sun, 1 May 2022 13:09:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] aoe: Avoid flush_scheduled_work() usage
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <9d1759e0-2f93-d49f-48b3-12b8d47e95cd@I-love.SAKURA.ne.jp>
 <abb37616-eec9-2794-e21e-7c623085d987@I-love.SAKURA.ne.jp>
In-Reply-To: <abb37616-eec9-2794-e21e-7c623085d987@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any questions?

On 2022/04/19 8:31, Tetsuo Handa wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_wq with local aoe_wq.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v2:
>   Fix link error, reported by kernel test robot <lkp@intel.com>
> 
>  drivers/block/aoe/aoe.h     |  2 ++
>  drivers/block/aoe/aoeblk.c  |  2 +-
>  drivers/block/aoe/aoecmd.c  |  2 +-
>  drivers/block/aoe/aoedev.c  |  4 ++--
>  drivers/block/aoe/aoemain.c | 10 +++++++++-
>  5 files changed, 15 insertions(+), 5 deletions(-)
