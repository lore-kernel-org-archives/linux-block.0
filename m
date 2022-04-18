Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4180C3525B
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbiDRNjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbiDRNi4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 09:38:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F2286FA
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 05:58:34 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23ICwWmq085241;
        Mon, 18 Apr 2022 21:58:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 18 Apr 2022 21:58:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23ICwW4V085238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Apr 2022 21:58:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <00df1ba8-b0f7-0217-1931-c658c3e9c0f1@I-love.SAKURA.ne.jp>
Date:   Mon, 18 Apr 2022 21:58:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] block/rnbd-clt: Avoid flush_workqueue(system_long_wq)
 usage
Content-Language: en-US
To:     axboe@kernel.dk
Cc:     hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
References: <20220413123420.66470-1-jinpu.wang@ionos.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220413123420.66470-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/13 21:34, Jack Wang wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> 
> Replace system_long_wq with local rnbd_clt_wq.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> 
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
> ---
> v2: return error as suggested by Tetsuo.
> 

Seems no more comments. Jens, please pick up.
