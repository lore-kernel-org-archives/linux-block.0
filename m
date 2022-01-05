Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A2C433EF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 06:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiAEGKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:10:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57990 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiAEGKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 01:10:50 -0500
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2056AN3t086119;
        Wed, 5 Jan 2022 15:10:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 05 Jan 2022 15:10:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2056ANLa086116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Jan 2022 15:10:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <2b29ac47-ed8f-3b50-f47c-c080fb83cbd5@i-love.sakura.ne.jp>
Date:   Wed, 5 Jan 2022 15:10:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] make autoclear operation synchronous again
Content-Language: en-US
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>, ltp@lists.linux.it
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
 <20211229172902.GC27693@lst.de>
 <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
 <20220105060201.GA2261405@janakin.usersys.redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20220105060201.GA2261405@janakin.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/05 15:02, Jan Stancek wrote:
> On Thu, Dec 30, 2021 at 07:52:34PM +0900, Tetsuo Handa wrote:
>> OK. Two patches shown below. Are these look reasonable?
>>
>>
>>
>>> From 1409a49181efcc474fbae2cf4e60cbc37adf34aa Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Thu, 30 Dec 2021 18:41:05 +0900
>> Subject: [PATCH 1/2] loop: Revert "loop: make autoclear operation asynchronous"
>>
> 
> Thanks, the revert fixes failures we saw recently in LTP tests,
> which do mount/umount in close succession:
> 
> # for i in `seq 1 2`;do mount -t iso9660 -o loop /root/isofs.iso /mnt/isofs; umount /mnt/isofs/; done
> mount: /mnt/isofs: WARNING: source write-protected, mounted read-only.
> mount: /mnt/isofs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
> umount: /mnt/isofs/: not mounted.
> 

I'm waiting for Jens to come back to
https://lkml.kernel.org/r/c205dcd2-db55-a35c-e2ef-20193b5ac0da@i-love.sakura.ne.jp .
