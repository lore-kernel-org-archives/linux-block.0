Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C652C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DB2146E
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nDJhT3nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLRBBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:01:15 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:47075 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLRBBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 20:01:15 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so140009ioi.13
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 17:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l51ovf6TabVI8oChqhDH+dZcflpyeuAOEVPSt0f8ifo=;
        b=nDJhT3nzDnhTK094f++qLqr+sIQOzE7VQUHFGp7V36Eoe5VqOYRCDLqPqu5DzpXnlK
         Sq3jVu5D6aiKXy90xVueO0M3FsaCOgwXhsdOfcxhEC+rC4fR1KgWuoXvWowDdcM0P39f
         R/SxWfRuJ/TSSU2x82JiKTX5c75OhzRD2MH+aqHVhKKgaaBQc38O1WknymyluFssA2Gz
         wU7exWibwJJCsyhCsa6y40u4Hq0IIe1gTf+J4QcrxBUqs8T4ElijdyksA417Jaq/zlJO
         i86iic9/BdWPYuVQsS94e0luBWTiWjhqlruICyNtrQ6xA9PmD10ZZvCUmcoL1FEEvMCo
         1VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l51ovf6TabVI8oChqhDH+dZcflpyeuAOEVPSt0f8ifo=;
        b=YxZl1V6znrj4SNbnMXmRBqNPKG1MgNzUWnQgKFGW2rWBd//zh8H4H6S0B+34rCMqEy
         LWQB2jcs2pEk6V8HXCh6BecZXeNeL9/Qx/l+5uTnT9xRhCl+0neEJwQkdr5EynP1rAZ/
         6+GR5TbyiSG5CBF2AVlNfoArGGFHG+ySi+e/Ou4tMUGl+Z/r57ppThubvqCbjzj/MXcM
         +vkQdkRdjPL4Tjx57QikMnCCmCM2XqmjSdVYRKrOyQmNKudvYZW1T06VYofydtknZZ7e
         pMRfBeZOqXQkwHZ9O8zB+mTAJ+k/3xeJbKTbpkC3DzEyiFV/N9smRxgHYSPcF8vec/T8
         nX6g==
X-Gm-Message-State: APjAAAUcIMl2k55B44zzYhD+r0n/q2buwX9I/+IiYRr8YSV+eyzuHgZk
        b5FB489jKcbCrFPifhXGFJ/n4Q==
X-Google-Smtp-Source: APXvYqyhXsEQgu5Xoq+wFwil+fKeqYsSYpbG86ZsWm+57i0OFyPNHMXX9V1cq/Vx/zpAD626S1ExdQ==
X-Received: by 2002:a05:6602:114:: with SMTP id s20mr604114iot.131.1576630873814;
        Tue, 17 Dec 2019 17:01:13 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 141sm135869ile.44.2019.12.17.17.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:01:13 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
 <20191212223403.GH19213@dread.disaster.area>
 <df334467-9c1a-2f03-654f-58b002ea5ae4@kernel.dk>
 <39af5a4d-7539-5746-ac3e-e2d6bd2209e3@kernel.dk>
 <20191216041748.GL19213@dread.disaster.area>
 <a30113f7-2d5a-3adf-19c4-fe49e8ef1ae8@kernel.dk>
 <20191218004933.GR19213@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b74ac021-c32a-85f4-2c03-16140851935c@kernel.dk>
Date:   Tue, 17 Dec 2019 18:01:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218004933.GR19213@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 5:49 PM, Dave Chinner wrote:
> On Tue, Dec 17, 2019 at 07:31:51AM -0700, Jens Axboe wrote:
>> On 12/15/19 9:17 PM, Dave Chinner wrote:
>>> On Thu, Dec 12, 2019 at 05:57:57PM -0700, Jens Axboe wrote:
>>>> On 12/12/19 5:54 PM, Jens Axboe wrote:
>>>>> On 12/12/19 3:34 PM, Dave Chinner wrote:
>>>>>> Just a thought on further optimisation for this for XFS.
>>>>>> IOMAP_UNCACHED is being passed into the filesystem ->iomap_begin
>>>>>> methods by iomap_apply().  Hence the filesystems know that it is
>>>>>> an uncached IO that is being done, and we can tailor allocation
>>>>>> strategies to suit the fact that the data is going to be written
>>>>>> immediately.
>>>>>>
>>>>>> In this case, XFS needs to treat it the same way it treats direct
>>>>>> IO. That is, we do immediate unwritten extent allocation rather than
>>>>>> delayed allocation. This will reduce the allocation overhead and
>>>>>> will optimise for immediate IO locality rather than optimise for
>>>>>> delayed allocation.
>>>>>>
>>>>>> This should just be a relatively simple change to
>>>>>> xfs_file_iomap_begin() along the lines of:
>>>>>>
>>>>>> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
>>>>>> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>>>>>> +	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
>>>>>> +	    !(flags & (IOMAP_DIRECT | IOMAP_UNCACHED)) &&
>>>>>> +	    !IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>>>>>> 		/* Reserve delalloc blocks for regular writeback. */
>>>>>> 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
>>>>>> 				iomap);
>>>>>> 	}
>>>>>>
>>>>>> so that it avoids delayed allocation for uncached IO...
>>>>>
>>>>> That's very handy! Thanks, I'll add that to the next version. Just out
>>>>> of curiosity, would you prefer this as a separate patch, or just bundle
>>>>> it with the iomap buffered RWF_UNCACHED patch? I'm assuming the latter,
>>>>> and I'll just mention it in the changelog.
>>>>
>>>> OK, since it's in XFS, it'd be a separate patch.
>>>
>>> *nod*
>>>
>>>> The code you quote seems
>>>> to be something out-of-tree?
>>>
>>> Ah, I quoted the code in the 5.4 release branch, not the 5.5-rc1
>>> tree. I'd forgotten that the xfs_file_iomap_begin() got massively
>>> refactored in the 5.5 merge and I hadn't updated my cscope trees. SO
>>> I'm guessing you want to go looking for the
>>> xfs_buffered_write_iomap_begin() and add another case to this
>>> initial branch:
>>>
>>>         /* we can't use delayed allocations when using extent size hints */
>>>         if (xfs_get_extsz_hint(ip))
>>>                 return xfs_direct_write_iomap_begin(inode, offset, count,
>>>                                 flags, iomap, srcmap);
>>>
>>> To make the buffered write IO go down the direct IO allocation path...
>>
>> Makes it even simpler! Something like this:
>>
>>
>> commit 1783722cd4b7088a3c004462c7ae610b8e42b720
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Tue Dec 17 07:30:04 2019 -0700
>>
>>     xfs: don't do delayed allocations for uncached buffered writes
>>     
>>     This data is going to be written immediately, so don't bother trying
>>     to do delayed allocation for it.
>>     
>>     Suggested-by: Dave Chinner <david@fromorbit.com>
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 28e2d1f37267..d0cd4a05d59f 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -847,8 +847,11 @@ xfs_buffered_write_iomap_begin(
>>  	int			allocfork = XFS_DATA_FORK;
>>  	int			error = 0;
>>  
>> -	/* we can't use delayed allocations when using extent size hints */
>> -	if (xfs_get_extsz_hint(ip))
>> +	/*
>> +	 * Don't do delayed allocations when using extent size hints, or
>> +	 * if we were asked to do uncached buffered writes.
>> +	 */
>> +	if (xfs_get_extsz_hint(ip) || (flags & IOMAP_UNCACHED))
>>  		return xfs_direct_write_iomap_begin(inode, offset, count,
>>  				flags, iomap, srcmap);
>>  
> 
> Yup, that's pretty much what I was thinking. :)

Perfect, thanks for checking!

-- 
Jens Axboe

