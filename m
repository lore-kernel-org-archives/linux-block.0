Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E7C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 06:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiDEGkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiDEGkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 02:40:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0F1FCD2
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 23:38:45 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2356chwA054393;
        Tue, 5 Apr 2022 15:38:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Tue, 05 Apr 2022 15:38:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2356cgFx054383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Apr 2022 15:38:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2e052daf-214d-6921-1765-3b4974cea7cc@I-love.SAKURA.ne.jp>
Date:   Tue, 5 Apr 2022 15:38:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: yet another approach to fix the loop lock order inversions v6
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
References: <20220330052917.2566582-1-hch@lst.de>
 <20220404074235.GA1046@lst.de>
 <499de381-c81e-4bd0-b5f7-1ee6be45821d@I-love.SAKURA.ne.jp>
 <20220405062838.GA24373@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220405062838.GA24373@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/05 15:28, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 06:39:31PM +0900, Tetsuo Handa wrote:
>> Two bugs which Jan has found in /bin/mount might not be yet fixed in
>> versions developers/users are using. Thus, let's wait for a while
>> before committing to linux.git.
> 
> Jan, which loop bugs might be relevant here?

Since async __loop_clr_fd() was reverted, these bugs should
no longer be relevant. But different bugs might be found with
this series. Thus, let's stay careful for a while...
