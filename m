Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70816C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 13:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEE2085B
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 13:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IENDPbkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfAaNsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:48:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35756 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaNsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 08:48:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1513084plo.2
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VM0cXRNuqSreJfTeFgTD3YeDP0DaGT9tpHcnxfiobek=;
        b=IENDPbkjAfePgAQ+WpjwNUc9DqBh4Dj+DD4mmO+7R/udj3COr3xlBhP/Yee8e5NI4A
         BdkpHgR6FSFgrNXysuS1CxcfQxQTwi7aU8UkEU/+3TzicJBBtUBwhR7I8K5ePfaEK9NC
         gQI80Km5qCRc87zjQguV58uUTeT0tfM7QwxyxVzcpPlLGOJHO9qT6Vz8Au0IleENbG5p
         ChC/+b871IR5pb66oNG7grsuImGDKed/4V+K3CZ5G6q+pB9wZz9L9MW8cu61XCDBtbXG
         Y560S2Bepsp3pAijZXCueFFJhdcY8XrrUtDynOERtVnm5TxeJnwtJgt8VaHlhNVNuURh
         t9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VM0cXRNuqSreJfTeFgTD3YeDP0DaGT9tpHcnxfiobek=;
        b=LbEZWgGbp4hOle78HssH9a4ZjbRPqAtcdxseqMZtGtZ02k5bQE+PYKesVvMOrMmMl4
         HKFnH1MsVlAEm+/VTEGZuvIlW1vV/OReybhqyEXLDQX6pTim/QXqSYo7gX5ny/oJE780
         2qfRTdy4byF7gglKoogJUyrtQk0bL8bmQ/XoeqifJLuex7sSnxpCR8VHJCsm3cWccplD
         ZbuZUHNqQeO3bULHdJWiNRAJnzHcAscQOp+j+JdwB1e4JOJvMt26FuZmw/PEw4T5QMNy
         w92PuYI7Freju21JVyYgHfk7DJ8FuuxF4oSXzEui976CitHU9ekIvzCqPhSOEQWlrpU0
         m9vQ==
X-Gm-Message-State: AJcUukeNW/z+b+6ZNHmkQlzZ4l+Z15eusnfXkR1tjZ5J2xTdsMEFcbbJ
        e98fjkT97WhyT9jA1fb3tknVznJcddA=
X-Google-Smtp-Source: ALg8bN7lCMIizjvCYXnRWMwtp/XOswsWuGAKVvuG4mqDOz8TenzAxc792szU4P3HhokAoYW0CL0oWw==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr35757607pld.184.1548942490959;
        Thu, 31 Jan 2019 05:48:10 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x28sm9719850pge.66.2019.01.31.05.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:48:09 -0800 (PST)
Subject: Re: [PATCH] blk-throttle: limit bios to fix amount of pages entering
 writeback prematurely
To:     Jan Kara <jack@suse.cz>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org
References: <20181228115148.26474-1-xiaoguang.wang@linux.alibaba.com>
 <9d722c67-dfae-2ee4-74ef-504164fed0bf@linux.alibaba.com>
 <20190131092625.GB19222@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa2083f1-058b-c365-338d-a9513d0f8ead@kernel.dk>
Date:   Thu, 31 Jan 2019 06:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131092625.GB19222@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/19 2:26 AM, Jan Kara wrote:
> Hi!
> 
> On Thu 31-01-19 10:03:34, Xiaoguang Wang wrote:
>>> Currently in blk_throtl_bio(), if one bio exceeds its throtl_grp's bps
>>> or iops limit, this bio will be queued throtl_grp's throtl_service_queue,
>>> then obviously mm subsys will submit more pages, even underlying device
>>> can not handle these io requests, also this will make large amount of pages
>>> entering writeback prematurely, later if some process writes some of these
>>> pages, it will wait for long time.
>>>
>>> I have done some tests: one process does buffered writes on a 1GB file,
>>> and make this process's blkcg max bps limit be 10MB/s, I observe this:
>>> 	#cat /proc/meminfo  | grep -i back
>>> 	Writeback:        900024 kB
>>> 	WritebackTmp:          0 kB
>>>
>>> I think this Writeback value is just too big, indeed many bios have been
>>> queued in throtl_grp's throtl_service_queue, if one process try to write
>>> the last bio's page in this queue, it will call wait_on_page_writeback(page),
>>> which must wait the previous bios to finish and will take long time, we
>>> have also see 120s hung task warning in our server.
>>>
>>> To fix this issue, we can simply limit throtl_service_queue's max queued
>>> bios, currently we limit it to throtl_grp's bps_limit or iops limit, if it
>>> still exteeds, we just sleep for a while.
>> Ping :)
>>
>> The fix method in this patch is not good, I had written a new patch that
>> uses wait queue, but do you think this is a blk-throttle design issue and
>> needs fixing? thanks.
> 
> Well, essentially this is a priority inversion issue where low-priority
> process submits writes and higher priority process blocks on those, isn't
> it? I think the blk-wbt throttling was meant to address these issues by
> throttling the process already when submitting bios (i.e. something similar
> to what you propose in your patch). I'll defer to Jens as a maintainer
> whether he wants to redirect users to blk-wbt or whether improving
> blk-throttle to avoid similar issues is desirable. Jens?

I think that blk-throttle usage should be phased out and we can
hopefully remove it at some point. I also don't think that there's a
large use base of it, which is good, but does seem active on the Alibaba
front. 


-- 
Jens Axboe

