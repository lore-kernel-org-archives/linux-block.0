Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C5C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiA1JxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:53:07 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54676 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiA1JxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 04:53:07 -0500
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20S9qkaE099752;
        Fri, 28 Jan 2022 18:52:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 28 Jan 2022 18:52:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20S9qk1b099748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Jan 2022 18:52:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <93fc7ab0-ec8d-ae9f-0f07-93c4c8e06975@I-love.SAKURA.ne.jp>
Date:   Fri, 28 Jan 2022 18:52:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: yet another approach to fix loop autoclear for xfstets xfs/049
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20220126155040.1190842-1-hch@lst.de>
 <7bebf860-2415-7eb6-55a1-47dc4439d9e9@I-love.SAKURA.ne.jp>
 <20220128070803.GA2381@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220128070803.GA2381@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/28 16:08, Christoph Hellwig wrote:
> Yes.  To completely remove it we'd need something like:
> 
>  - remove lo_refcnt and rely on bd_openers on the whole device bdev
>  - add a block layer flag to temporarily disable a gendisk and fail
>    all opens for it.
> 
> For now I'd really like to just fix the regression, though.

lo_open() does not need to use lo->lo_mutex. For now just deferring
lo_open()/lo_release() to task work context will fix the regression.

