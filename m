Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AECC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 07:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810FC60F42
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 07:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbhH0Hre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:47:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57141 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244395AbhH0Hrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 03:47:33 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17R7kgqY019278;
        Fri, 27 Aug 2021 16:46:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Fri, 27 Aug 2021 16:46:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17R7kgWQ019198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Aug 2021 16:46:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: sort out the lock order in the loop driver v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210826133810.3700-1-hch@lst.de>
 <b34196f3-c407-1d8a-175c-485c4bf0b5d8@i-love.sakura.ne.jp>
 <20210827064049.GA23112@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <67aa49f1-c3d4-205f-fd08-0bc0dbcd3689@i-love.sakura.ne.jp>
Date:   Fri, 27 Aug 2021 16:46:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827064049.GA23112@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/27 15:40, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 09:30:12AM +0900, Tetsuo Handa wrote:
>> Again crashed in 3 seconds. We can't accept this series.
> 
> Would you gladly point to the reproducer?
> 

You can reach dashboard at https://syzkaller.appspot.com/bug?extid=$hashid where
$hashid is Reporter's mail address <syzbot+$hashid@syzkaller.appspotmail.com> .
For this bug report, the dashboard is https://syzkaller.appspot.com/bug?extid=f61766d5763f9e7a118f .
Then, please find C repro column within the dashboard page. For this bug report, the C reproducer is
https://syzkaller.appspot.com/text?tag=ReproC&x=13d20adc300000 .
