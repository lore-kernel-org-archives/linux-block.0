Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B44C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA16F20830
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pWd2SDf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfCYQFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:05:17 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38527 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfCYQFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:05:17 -0400
Received: by mail-it1-f194.google.com with SMTP id m18so14757567ita.3
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BQUNCSAofUrXcapHTGtEWUOMPLMDS65NPRZZzD1acm4=;
        b=pWd2SDf+Z94TAZkhkcYjxxdoO3GmXX1GDvmq9tkQA1qlLWMIFfmGREPOP+SC8UPOdc
         60JQ3qNL+E+I5Z6BvVOaE3Ns89CtAcX9kdz0VV0l+HoaPdK2b1RIarT5o0P0OCe6Sdf6
         4DzBpg6y09DSbJT8HodK25IR6LVbPVOMzdrRXqVpt5J8Wg8UjoracE2k8QviDK4tla9I
         JLct7tCCwsUEaGl7UZhFiLwWV0k1qa93gZQS5Gyiayh1ZEu1+xFu7P7DZaqg2Sy1uC8E
         oVuRwuiQWgZn4sZ9nUn0TwVDbGgJEvvFWlUWq/z7JmBRuxGRjuBnDj1qm/bseOuKBXrR
         vu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQUNCSAofUrXcapHTGtEWUOMPLMDS65NPRZZzD1acm4=;
        b=YLq2sLYIe+mf7N4JwCpJU9dQegeOHEn6Mknvw7OomFwMXqplkuUw9yuKY1aG29DmIH
         lDnlN81Xgl8qrH1eUqsXlWXA1q2zTuIag1/XV8oLYpQ22hSbd9UvrtV5NVd601aXNUVs
         gWoRlKqo+uPcsUN6FbRYWXNPJGxKsNRPG2GvrHGV7JNFsy9mvrzlZH+ZbF2aFp9kB1dP
         iEb65VcOeB2dY6k5vCRtMw7ZDBdplveqmq2ChCicl1TFP95g9jaaj8hwxp0LpfTFCbqq
         GE4pZ8hKXmNrXO/jR4c0Q/qMi30H3gsUzJ9AZ/QpKtFLvIvOZRqiJjYTGIPNr3xdiYeP
         k8Sg==
X-Gm-Message-State: APjAAAWFV+Tp6LvmADuYD/NVbvhrMsfKoDy1bjfY8u4G1Q9WfQH6XxmO
        KcdrL+bT3XXESayErRYx5wvkxdEs6YQl4g==
X-Google-Smtp-Source: APXvYqyw3CcBkYiLALl8+ZHJqdOkyyqw4ytPnIshS3n6KdT1IxHIXn8ezK+M5EhytDIf5WlQ3hXdEg==
X-Received: by 2002:a24:1052:: with SMTP id 79mr9997664ity.158.1553529915602;
        Mon, 25 Mar 2019 09:05:15 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm4437949ita.33.2019.03.25.09.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:05:14 -0700 (PDT)
Subject: Re: io_uring: -EAGAIN on write path in case of O_DIRECT
To:     Roman Penyaev <rpenyaev@suse.de>, linux-block@vger.kernel.org
References: <bda877db6c5bcd62885e79f0bed7ca57@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8bf5922-6c68-f16e-55d2-7050e44d3f34@kernel.dk>
Date:   Mon, 25 Mar 2019 10:05:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bda877db6c5bcd62885e79f0bed7ca57@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 4:16 AM, Roman Penyaev wrote:
> Hi Jens,
> 
> I gave a try to use io_uring and stumbled upon -EAGAIN on write path
> in direct mode if page cache is already populated or has been populated
> in-between by some buffered read. I'am talking about
> generic_file_direct_write() call, which checks filemap_range_has_page()
> on IOCB_NOWAIT path.
> 
> To proceed further with tests I simply did the same thing, like you did
> in io_read(), and in case of -EAGAIN async worker does the rest.  So the
> following chunk works well:
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6aaa30580a2b..ccb656168ae4 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1022,6 +1022,8 @@ static int io_write(struct io_kiocb *req, const 
> struct sqe_submit *s,
> 
>          ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
>          if (!ret) {
> +               ssize_t ret2;
> +
>                  /*
>                   * Open-code file_start_write here to grab freeze 
> protection,
>                   * which will be released by another thread in
> @@ -1036,7 +1038,19 @@ static int io_write(struct io_kiocb *req, const 
> struct sqe_submit *s,
>                                                  SB_FREEZE_WRITE);
>                  }
>                  kiocb->ki_flags |= IOCB_WRITE;
> -               io_rw_done(kiocb, call_write_iter(file, kiocb, &iter));
> +
> +               ret2 = call_write_iter(file, kiocb, &iter);
> +               if (!force_nonblock || ret2 != -EAGAIN) {
> +                       io_rw_done(kiocb, ret2);
> +               } else {
> +                       /*
> +                        * If ->needs_lock is true, we're already in 
> async
> +                        * context.
> +                        */
> +                       if (!s->needs_lock)
> +                               io_async_list_note(WRITE, req, 
> iov_count);
> +                       ret = -EAGAIN;
> +               }
> 
> 
> Does it make sense?

Yeah it makes sense, we need to punt that to async as well if we hit
EAGAIN at that point. Can you send a signed-off-by patch?

-- 
Jens Axboe

