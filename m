Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6448C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 07:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiDYH51 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiDYH4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 03:56:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC50F1
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 00:53:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01B401F37D;
        Mon, 25 Apr 2022 07:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650873198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQsEvunmO4hqsAglI17eoXVu4EIZ9ysi78lm6lyZo7g=;
        b=LG7Lr7Ko1X+udRac0yuVqE8t7+y+WPBr8LTdD/OBHm9VbVXp0chsZ50V2d0olI6ZUp55Xd
        vxsjPZET/L1RRUnxdWWG87srHvHiNsXiHF9KurMNS2w9g1U2B+YWQdVaF12YvGG1P+36SJ
        rN1nKTY0WRjzlwBJduJlf/wCvBMPcKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650873198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQsEvunmO4hqsAglI17eoXVu4EIZ9ysi78lm6lyZo7g=;
        b=ThiliDc03pQeRYpHPB01bKx9TBw7ksVRdyaglcTbr9ob5MBuG2jMN5kZBLwBI30RST8Mtm
        JyrjFtiWHg/g5XCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9AFE13AED;
        Mon, 25 Apr 2022 07:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mdrcNG1TZmI6bAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 25 Apr 2022 07:53:17 +0000
Message-ID: <81a5337f-f9f4-9d6f-4a3d-8e5fedf79c6f@suse.de>
Date:   Mon, 25 Apr 2022 09:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de> <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de> <YmU86/YZ18CtbLgb@T590>
 <YmVUl8m0Kak4JeKa@kroah.com> <YmX5O0dzHs09aFbh@T590>
 <YmYtVnC3QzfukbSu@kroah.com> <20220425074842.GA9787@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220425074842.GA9787@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/22 09:48, Christoph Hellwig wrote:
> On Mon, Apr 25, 2022 at 07:10:46AM +0200, Greg Kroah-Hartman wrote:
>>> But what is wrong with the test? Isn't it reasonable to keep debugfs dir
>>> when blktrace is collecting log?
>>
>> How can you collect something from a device that is gone?
>>
>>> After debugfs dir is removed, blktrace may not collect intact log, and
>>> people may complain it is one kernel regression.
>>
>> What exactly breaks?  The device is removed, why should a trace continue
>> to give you data?
> 
> This is a good question.  All but one of the block device drivers
> really only have a concept of a block "queue" that is attached to a
> live block device.  In that case the awnser is simple and obvious.
> 
> But SCSI allocates these queues before the block device, and they can
> outlive it, because SCSI is a layered architecture where the "upper level"
> drivers like sd and st are only bound to the queue based on information
> returned from it, and the queue can outlive unbinding these drivers
> (which is a bit pointless but possible due to full device model
> integration).
> 
> So there might be some uses cases to keep on tracing.  I don't think they
> are very valid, though, because if you really want to trace that raw
> queue you can do it using the /dev/sg node.
> 
Which is thinking, too.
While it might be that some I/O can arrive during shutdown, it is 
_quite_ questionable whether one may want to trace it.
And if so whether blktrace/debugfs is the correct way to do it, as it's 
certainly not performance critical, and there are other things at play 
during shutdown having a much larger impact on the overall timing (rcu 
grace periods, lock contention, you name it).

So I'd say we should go for least complexity here, and allow tracing 
only if the device is in a sane state.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
