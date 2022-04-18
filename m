Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 09:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiDRJmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiDRJmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 05:42:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9AC1658F
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 02:39:29 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23I9dReG045714;
        Mon, 18 Apr 2022 18:39:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Mon, 18 Apr 2022 18:39:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23I9dRbP045710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Apr 2022 18:39:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1a792f29-e698-6468-cc8c-b2f0fcea3d9b@I-love.SAKURA.ne.jp>
Date:   Mon, 18 Apr 2022 18:39:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: yet another approach to fix the loop lock order inversions v6
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
References: <20220330052917.2566582-1-hch@lst.de>
 <20220404074235.GA1046@lst.de>
 <499de381-c81e-4bd0-b5f7-1ee6be45821d@I-love.SAKURA.ne.jp>
In-Reply-To: <499de381-c81e-4bd0-b5f7-1ee6be45821d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/04/04 18:39, Tetsuo Handa wrote:
> On 2022/04/04 16:42, Christoph Hellwig wrote:
>> Any more comments?  It would be good to settle this saga for 5.18.
> 
> 5 hours ago I added this series to my tree so that we can immediately
> send to linux.git via linux-block.git#5.18 if nothing wrong happens.
> 
> https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/99499a2b0ff01d8a5c0a06132ab33aaed4433b89

This series was tested for 2 weeks using linux-next.git and got no problem report.

I think we can send this series to 5.18.
