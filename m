Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C96C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Apr 2022 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiDXLyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Apr 2022 07:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiDXLyv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Apr 2022 07:54:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085821FCE2
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 04:51:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F18F5210EC;
        Sun, 24 Apr 2022 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650801107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USPNxEkcOpoL3X/RXR29AnqbP3sBG8Fv2yfeizLVbhU=;
        b=Oq2+6+oNZVpGBAd6XnF0w2RJadOmvUIQ5/i/XI/htkscmKhpU1P4qUt+dbSOw2Ked75JFd
        Ar4NP8nyEgIpqKyHcMFwkq621iGdZzInbOghGXN4u7kcubGZAtw4ccsx2sHZQM/qTGSUrX
        TRyrU3yhsQAb1bX3L5s2EUMdwx25jKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650801107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USPNxEkcOpoL3X/RXR29AnqbP3sBG8Fv2yfeizLVbhU=;
        b=s1qQZ+vG4NvGSm/dCy7hd4lkQ+e76YQ6iP0vSK9j7dMKmuxqB2Di+9HqSsmz6NB6lfQo9U
        HRSv+m0CRyZlIXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B539C13780;
        Sun, 24 Apr 2022 11:51:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yopyH9M5ZWKRRAAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 24 Apr 2022 11:51:47 +0000
Message-ID: <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
Date:   Sun, 24 Apr 2022 13:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de> <YmUX/Q9o08rOSTaQ@T590>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YmUX/Q9o08rOSTaQ@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/22 11:28, Ming Lei wrote:
> On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
>> On 4/23/22 16:39, Ming Lei wrote:
>>> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
>>> created when adding disk, and removed when releasing request queue.
>>>
>>> There is small window between releasing disk and releasing request
>>> queue, and during the period, one disk with same name may be created
>>> and added, so debugfs_create_dir() may complain with "Directory XXXXX
>>> with parent 'block' already present!"
>>>
>>> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
>>> and the dir name is named with q->id from beginning, and switched to
>>> disk name when adding disk, and finally changed to q->id in disk_release().
>>>
>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>>> Cc: yukuai (C) <yukuai3@huawei.com>
>>> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-core.c  | 4 ++++
>>>    block/blk-sysfs.c | 4 ++--
>>>    block/genhd.c     | 8 ++++++++
>>>    3 files changed, 14 insertions(+), 2 deletions(-)
>>>
>> Errm.
>>
>> Isn't this superfluous now that Jens merged Yu Kuais patch?
> 
> Jens has dropped Yu Kuai's patch which caused kernel panic.
> 
Right.
But still, this patch looks really odd.
How is userspace supposed to use the directories prior to the renaming?

And as you already have identified the places where we can safely create 
(and remove) the debugfs directories, why can't we move the call to 
create and remove the debugfs directories to those locations and do away 
with the renaming?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
