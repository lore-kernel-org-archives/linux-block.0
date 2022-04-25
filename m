Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4DDC433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 09:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiDYJjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241528AbiDYJiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 05:38:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE727FC1
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 02:32:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1664F210EC;
        Mon, 25 Apr 2022 09:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650879136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ch4wkDrCRtpYceCYwZ1TRWD3mA8uwpmXHf0EkEGXbwg=;
        b=C9P7mqItDKWzOQ08ZOXow/U3izhXG+/eaCQtlDXEQIZCT/upiFY7VF/RacIRt7typ2PdDd
        pLlPWfN0W1Q1bQ44cGriWKFJNbD1J1XXeseYnNgx3oqdIzdcyhoKivVcHRhjX9HnBUZJV+
        b+OAqgPaLIIQMNqvDzDAkapvnT1hT34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650879136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ch4wkDrCRtpYceCYwZ1TRWD3mA8uwpmXHf0EkEGXbwg=;
        b=qfozWM9NYVmlMtWpHRNm2JT4wJ+7yw/sslReXqxc/3k4YwG0nBnFYNasXWI5yXFCaulGxc
        6ceRNYtfCEMvUpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F005213AE1;
        Mon, 25 Apr 2022 09:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M4AlOp9qZmJ1GwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 09:32:15 +0000
Message-ID: <186f4002-0359-95e7-889f-af065210cd74@suse.de>
Date:   Mon, 25 Apr 2022 11:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de> <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de> <YmU86/YZ18CtbLgb@T590>
 <YmVUl8m0Kak4JeKa@kroah.com> <YmX5O0dzHs09aFbh@T590>
 <YmYtVnC3QzfukbSu@kroah.com> <YmZk2GN1/Z8a0v7O@T590>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
In-Reply-To: <YmZk2GN1/Z8a0v7O@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/22 11:07, Ming Lei wrote:
> On Mon, Apr 25, 2022 at 07:10:46AM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Apr 25, 2022 at 09:28:27AM +0800, Ming Lei wrote:
>>> On Sun, Apr 24, 2022 at 03:45:59PM +0200, Greg Kroah-Hartman wrote:
>>>> On Sun, Apr 24, 2022 at 08:04:59PM +0800, Ming Lei wrote:
>>>>> On Sun, Apr 24, 2022 at 01:51:45PM +0200, Hannes Reinecke wrote:
>>>>>> On 4/24/22 11:28, Ming Lei wrote:
>>>>>>> On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
>>>>>>>> On 4/23/22 16:39, Ming Lei wrote:
>>>>>>>>> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
>>>>>>>>> created when adding disk, and removed when releasing request queue.
>>>>>>>>>
>>>>>>>>> There is small window between releasing disk and releasing request
>>>>>>>>> queue, and during the period, one disk with same name may be created
>>>>>>>>> and added, so debugfs_create_dir() may complain with "Directory XXXXX
>>>>>>>>> with parent 'block' already present!"
>>>>>>>>>
>>>>>>>>> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
>>>>>>>>> and the dir name is named with q->id from beginning, and switched to
>>>>>>>>> disk name when adding disk, and finally changed to q->id in disk_release().
>>>>>>>>>
>>>>>>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>>>>>>>>> Cc: yukuai (C) <yukuai3@huawei.com>
>>>>>>>>> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>>>>> ---
>>>>>>>>>     block/blk-core.c  | 4 ++++
>>>>>>>>>     block/blk-sysfs.c | 4 ++--
>>>>>>>>>     block/genhd.c     | 8 ++++++++
>>>>>>>>>     3 files changed, 14 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>> Errm.
>>>>>>>>
>>>>>>>> Isn't this superfluous now that Jens merged Yu Kuais patch?
>>>>>>>
>>>>>>> Jens has dropped Yu Kuai's patch which caused kernel panic.
>>>>>>>
>>>>>> Right.
>>>>>> But still, this patch looks really odd.
>>>>>> How is userspace supposed to use the directories prior to the renaming?
>>>>>
>>>>> That doesn't make any difference for current uses, but we may extend it
>>>>> to support debugfs for non-blk request queue in future by exporting q->id
>>>>> somewhere. Even though now the interested q->id can be figured out
>>>>> easily by very simple ebpf trace prog.
>>>>>
>>>>>>
>>>>>> And as you already have identified the places where we can safely create
>>>>>> (and remove) the debugfs directories, why can't we move the call to create
>>>>>> and remove the debugfs directories to those locations and do away with the
>>>>>> renaming?
>>>>>
>>>>> First it needs more change to fix the kernel panic.
>>>>>
>>>>> Second removing debugfs dir in del_gendisk will break blktests block/002.
>>>>
>>>> Then fix the test?  debugfs interactions that cause kernel bugs should
>>>> be ok to change the functionality of.  Remember, this is for
>>>> debugging...
>>>
>>> But what is wrong with the test? Isn't it reasonable to keep debugfs dir
>>> when blktrace is collecting log?
>>
>> How can you collect something from a device that is gone?
> 
> Here the 'gone' may be just in logical/soft viewpoint, such as, one disk
> is removed by sysfs, and the driver still may send sync cache command
> to make sure the cache inside drive is flushed, such as scsi's
> SYNCHRONIZE_CACHE.
> 
And that is my argument: what does this buy us?
Is is relevant (for blktrace) to have the SYNCHRONIZE_CACHE to be 
present in the logs?
 From my POV, blktrace is there to analyze I/O flow; device shutdown is 
not really relevant for that as the results of that operation depend on 
other factors which won't show up in blktrace at all.

So we're not losing much by (maybe) missing shutdown commands in 
blktrace; if needs be device shutdown can be traced by other means.

I'd rather keep the code simple, and not having an operation in the core 
block layer which requires quite some explanation.
_And_ relies on the current ordering; if things change here it'll be 
really hard to figure out if that workaround is still required or might 
be obsoleted by the change.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
