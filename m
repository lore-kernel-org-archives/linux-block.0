Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A6C2D0CA
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E1724656
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 02:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qjTVa0N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfLMCiN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 21:38:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39525 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfLMCiN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 21:38:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so579925plk.6
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 18:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4scFI8M+g9PTLR+e26189HjvpHoNJL6OUB3WWn43TTQ=;
        b=qjTVa0N/ZMz0ZP1HRdYj5F9tVeZXEpV5beAt/HIMRZV0ke70G888SVNLe8n2CqtK/b
         W1au4KrarFy/xeIxBvYyV6TCNUiMFEG/sXZEkdzYlZSsXTTRCUXx8oWH2tAss6U1/DTO
         lweQ0A05IqAgyy9i3WJ5jrWYqQ2HRKS7/hhkMINAqflcnbPnLsKO55ixEe1oicLvOtUP
         hFAAaGVhheKNvMwAnYoE5IKU0g6xtIcp9DhmjGcVd7GYH6HpxAqCvy9BrfgGqd1AGJgg
         /iGLhXxatd7tdJGWZB+FPAYMw2oYLDDARaPyk8mNOoEpmy3gG2hq1YbcVGqdWeXhgzWn
         mpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4scFI8M+g9PTLR+e26189HjvpHoNJL6OUB3WWn43TTQ=;
        b=OQZG/c8+jJcoxjAWf1hKo/Jy1v4tIDzwB0vER5wVER2abtVcmJfBlGBWvxIW3Upll5
         t8FXHLMpt7xihhukvMt9bcB0jAZwOWDG0//uRm0vYOFOI/dzfnHL8ixE0ogPCuZ48PCp
         N5pTcLsvEwvGqbsg3VppbglxYpjYGcLqUg3SFRhObAv6DXh49uSPqmEDiWuI53668wex
         JaLIo2C2EPm31byKefGWNLqHNbNG9pJYsZlg4TNcho4Kp3DRI1GcTN6Z8kVOFGSTgkOM
         QyhfHR3g+GS1Tjs2/Np1CgPSnye1w7GAKGG3K6TM4GU5SxXnmLdKj9JRVcmbuZzbqj4A
         +dLQ==
X-Gm-Message-State: APjAAAW7cAW9fouOALruin7SVv4H44RZzPqvj/QCOHXClBcGKkXNCbyT
        FU2qOQFSxG1JeDoOHpfX4J/Z4g==
X-Google-Smtp-Source: APXvYqz1GvxyPK9ZrfzTBwbI2Oerm3UbAWwDcnkUW70xAMp7XM2g/3kbkfo2c/FV+RCKyMu3aF9YHw==
X-Received: by 2002:a17:90a:974a:: with SMTP id i10mr14260859pjw.0.1576204691121;
        Thu, 12 Dec 2019 18:38:11 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m71sm9787730pje.0.2019.12.12.18.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 18:38:10 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191212190133.18473-1-axboe@kernel.dk>
 <20191212190133.18473-6-axboe@kernel.dk> <20191213022634.GA99868@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05d7c9c0-cf60-1610-edf9-4c3998ee5c18@kernel.dk>
Date:   Thu, 12 Dec 2019 19:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213022634.GA99868@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/19 7:26 PM, Darrick J. Wong wrote:
> On Thu, Dec 12, 2019 at 12:01:33PM -0700, Jens Axboe wrote:
>> This adds support for RWF_UNCACHED for file systems using iomap to
>> perform buffered writes. We use the generic infrastructure for this,
>> by tracking pages we created and calling write_drop_cached_pages()
>> to issue writeback and prune those pages.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
>>  fs/iomap/buffered-io.c | 23 +++++++++++++++++++----
>>  include/linux/iomap.h  |  5 +++++
>>  3 files changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
>> index e76148db03b8..11b6812f7b37 100644
>> --- a/fs/iomap/apply.c
>> +++ b/fs/iomap/apply.c
>> @@ -92,5 +92,29 @@ iomap_apply(struct iomap_data *data, const struct iomap_ops *ops,
>>  				     data->flags, &iomap);
>>  	}
>>  
>> +	if (written && (data->flags & IOMAP_UNCACHED)) {
> 
> Hmmm... why is a chunk of buffered write(?) code landing in the iomap
> apply function?

I'm going to say that Dave suggested it ;-)

> The #define for IOMAP_UNCACHED doesn't have a comment, so I don't know
> what this is supposed to mean.  Judging from the one place it gets set
> in the buffered write function I gather that this is how you implement
> the "write through page cache and immediately unmap the page if it
> wasn't there before" behavior?
> 
> So based on that, I think you want ...
> 
> if IOMAP_WRITE && _UNCACHED && !_DIRECT && written > 0:
> 	flush and invalidate

Looking at the comments, I did think it was just for writes, but it
looks generic. I'll take the blame for that, we should only call into
that sync-and-invalidate code for buffered writes. I'll make that
change.

> Since direct writes are never going to create page cache, right?

If they do, it's handled separately.

> And in that case, why not put this at the end of iomap_write_actor?
> 
> (Sorry if this came up in the earlier discussions, I've been busy this
> week and still have a long way to go for catching up...)

It did come up, the idea is to do it for the full range, not per chunk.
Does that help?

>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 30f40145a9e9..30bb248e1d0d 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -48,12 +48,16 @@ struct vm_fault;
>>   *
>>   * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
>>   * buffer heads for this mapping.
>> + *
>> + * IOMAP_F_PAGE_CREATE indicates that pages had to be allocated to satisfy
>> + * this operation.
>>   */
>>  #define IOMAP_F_NEW		0x01
>>  #define IOMAP_F_DIRTY		0x02
>>  #define IOMAP_F_SHARED		0x04
>>  #define IOMAP_F_MERGED		0x08
>>  #define IOMAP_F_BUFFER_HEAD	0x10
>> +#define IOMAP_F_PAGE_CREATE	0x20
> 
> I think these new flags need an update to the _STRINGS arrays in
> fs/iomap/trace.h.

I'll add that.

>>  /*
>>   * Flags set by the core iomap code during operations:
>> @@ -121,6 +125,7 @@ struct iomap_page_ops {
>>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>> +#define IOMAP_UNCACHED		(1 << 6)
> 
> No comment?

Definitely, I'll add a comment.

Thanks for taking a look! I'll incorporate your suggestions.

-- 
Jens Axboe

