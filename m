Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C55BCA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A112084B
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jdj5uHCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfJUO0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:26:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40495 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfJUO0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 10:26:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so2573948pgt.7
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ywxgAzIVVqF10tpSd2tL/Swx2phHTUX5X7DLFpOzlg4=;
        b=Jdj5uHChgKaIrJ8tfnsm/2wd2rzBVeHV7a/AbVYj2W/VN1cXnGHILY3Q1XcXwDrWP1
         HqgWVgRSAlNBM/iPtZFZnTugQiKacm6Gb5Y+cJwtqjFl2GbpO84BgPaNke/jFqamGMXB
         AVIh/07n716UDEnLf6xQs5CDthQTYeeLqu2uiSJsPnuDorrOg/opTMm97PQB5fvL54WD
         DZ6BU9bZn5o9s35Pq28K0wv20E4wV3tsLx4u/GfcrdP+E2MXaBQFBKksb1E90CbwUj8r
         y0mct0WqSwS3oIHac6tt0yJD6RQgcWcA8FSyb55jzKeQBarVgM+VGFbJFJatsGxJI+fI
         AAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ywxgAzIVVqF10tpSd2tL/Swx2phHTUX5X7DLFpOzlg4=;
        b=aTl2ruw/BF+oorHa9YHXiZCZkqRfJu7blYqJW5C94BHC9ITn43uqPobyAWBE0U4Lns
         v6Vi3xoVrCKb7HC+D8Vaamn4u3AGQYwwHL6rHS9Vy1PHMYLn9c3JGuj155QN1M+jSv9+
         5Te7gI4TzD6JwcLyBaTYok3EGZgScRw0FJnCOCSsvDYBcgct6vCG0/v4eBTnpeTscO2D
         OERVwbwAeIHhnmSfGagTj3FRlY5XpvUxJin5afr7zfbcS2EgYgHVw2aOAPkGDIuYBKV7
         YtR9mrw28l3bM9dsddj6vODVu23SytKnQ9LKUe9TSmvIl/JSguBx1l6VFrzT1MiEXh1C
         r1fQ==
X-Gm-Message-State: APjAAAWl83mh1uxfRgxNKWtjout7PuSug+CNLSBcmtALZiJ3I5/X3DFh
        +2biMQ3b7wfT1Rdz2YfDVzcc8Q==
X-Google-Smtp-Source: APXvYqyyth2uzkrjOCuNHlv1fu3I2pZj4VYcICtApFf4bXhb44KBUThOLPNRwfwCCiCDdnQiLsBhqQ==
X-Received: by 2002:a63:5d06:: with SMTP id r6mr26118573pgb.216.1571668001079;
        Mon, 21 Oct 2019 07:26:41 -0700 (PDT)
Received: from [192.168.1.182] ([192.40.64.15])
        by smtp.gmail.com with ESMTPSA id p9sm15655893pfn.115.2019.10.21.07.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:26:40 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix up O_NONBLOCK handling for sockets
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hrvoje Zeba <zeba.hrvoje@gmail.com>
References: <f999615b-205c-49b7-b272-c4e42e45e09d@kernel.dk>
 <BCC87FC4-164D-4A28-9C84-24FCC7969AD8@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3775a8f-99bc-2940-22e8-a202fba464d3@kernel.dk>
Date:   Mon, 21 Oct 2019 08:26:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BCC87FC4-164D-4A28-9C84-24FCC7969AD8@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/19 6:23 PM, Jackie Liu wrote:
> 
> 
>> 2019年10月17日 23:24，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> We've got two issues with the non-regular file handling for non-blocking
>> IO:
>>
>> 1) We don't want to re-do a short read in full for a non-regular file,
>>    as we can't just read the data again.
>> 2) For non-regular files that don't support non-blocking IO attempts,
>>    we need to punt to async context even if the file is opened as
>>    non-blocking. Otherwise the caller always gets -EAGAIN.
>>
>> Add two new request flags to handle these cases. One is just a cache
>> of the inode S_ISREG() status, the other tells io_uring that we always
>> need to punt this request to async context, even if REQ_F_NOWAIT is set.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>> fs/io_uring.c | 55 +++++++++++++++++++++++++++++++++++----------------
>> 1 file changed, 38 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index d2cb277da2f4..a4ee5436cb61 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -322,6 +322,8 @@ struct io_kiocb {
>> #define REQ_F_FAIL_LINK		256	/* fail rest of links */
>> #define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
>> #define REQ_F_TIMEOUT		1024	/* timeout request */
>> +#define REQ_F_ISREG		2048	/* regular file */
>> +#define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
>> 	u64			user_data;
>> 	u32			result;
>> 	u32			sequence;
>> @@ -914,26 +916,26 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
>> 	return ret;
>> }
>>
>> -static void kiocb_end_write(struct kiocb *kiocb)
>> +static void kiocb_end_write(struct io_kiocb *req)
>> {
>> -	if (kiocb->ki_flags & IOCB_WRITE) {
>> -		struct inode *inode = file_inode(kiocb->ki_filp);
>> +	/*
>> +	 * Tell lockdep we inherited freeze protection from submission
>> +	 * thread.
>> +	 */
>> +	if (req->flags & REQ_F_ISREG) {
>> +		struct inode *inode = file_inode(req->file);
>>
>> -		/*
>> -		 * Tell lockdep we inherited freeze protection from submission
>> -		 * thread.
>> -		 */
>> -		if (S_ISREG(inode->i_mode))
>> -			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
>> -		file_end_write(kiocb->ki_filp);
>> +		__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
>> 	}
>> +	file_end_write(req->file);
>> }
>>
>> static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>> {
>> 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>>
>> -	kiocb_end_write(kiocb);
>> +	if (kiocb->ki_flags & IOCB_WRITE)
>> +		kiocb_end_write(req);
>>
>> 	if ((req->flags & REQ_F_LINK) && res != req->result)
>> 		req->flags |= REQ_F_FAIL_LINK;
>> @@ -945,7 +947,8 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
>> {
>> 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>>
>> -	kiocb_end_write(kiocb);
>> +	if (kiocb->ki_flags & IOCB_WRITE)
>> +		kiocb_end_write(req);
>>
>> 	if ((req->flags & REQ_F_LINK) && res != req->result)
>> 		req->flags |= REQ_F_FAIL_LINK;
>> @@ -1059,8 +1062,17 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
>> 	if (!req->file)
>> 		return -EBADF;
>>
>> -	if (force_nonblock && !io_file_supports_async(req->file))
>> +	if (S_ISREG(file_inode(req->file)->i_mode))
>> +		req->flags |= REQ_F_ISREG;
>> +
>> +	/*
>> +	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
>> +	 * we know to async punt it even if it was opened O_NONBLOCK
>> +	 */
>> +	if (force_nonblock && !io_file_supports_async(req->file)) {
>> 		force_nonblock = false;
>> +		req->flags |= REQ_F_MUST_PUNT;
>> +	}
> 
> Hello Jens. that is your new version.
> 
> +	/*
> +	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
> +	 * we know to async punt it even if it was opened O_NONBLOCK
> +	 */
> +	if (force_nonblock && !io_file_supports_async(req->file)) {
> +		req->flags |= REQ_F_MUST_PUNT;
> +		return -EAGAIN;
> +	}
> 
> So, if req->file don't support async, we always return EAGAIN immediately.

Right

>> 	kiocb->ki_pos = READ_ONCE(sqe->off);
>> 	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
>> @@ -1081,7 +1093,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
>> 		return ret;
>>
>> 	/* don't allow async punt if RWF_NOWAIT was requested */
>> -	if (kiocb->ki_flags & IOCB_NOWAIT)
>> +	if ((kiocb->ki_flags & IOCB_NOWAIT) ||
>> +	    (req->file->f_flags & O_NONBLOCK))
> 
> I think if we return -EAGAIN immediately, and using the work queue to execute this context,
> this is unnecessary.
> 
>> 		req->flags |= REQ_F_NOWAIT;
>>
>> 	if (force_nonblock)
>> @@ -1382,7 +1395,9 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
>> 		 * need async punt anyway, so it's more efficient to do it
>> 		 * here.
>> 		 */
>> -		if (force_nonblock && ret2 > 0 && ret2 < read_size)
>> +		if (force_nonblock && !(req->flags & REQ_F_NOWAIT) &&
>> +		    (req->flags & REQ_F_ISREG) &&
>> +		    ret2 > 0 && ret2 < read_size)
>> 			ret2 = -EAGAIN;
> 
> This is also unnecessary because force_nonblock is always false.

I totally agree, with the above direct return change, these aren't
strictly necessary. But I kept them to be on the safe side.

-- 
Jens Axboe

