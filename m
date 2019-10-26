Return-Path: <SRS0=tXSx=YT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FC8CA9EBC
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B1206DD
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mrSQfPJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfJZNOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:14:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38576 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfJZNOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Oct 2019 09:14:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so3580802pfp.5
        for <linux-block@vger.kernel.org>; Sat, 26 Oct 2019 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AxQtgEa5tj+EbXCqDeTJKXnYNU2d023MfboxwSu4Wus=;
        b=mrSQfPJ6Yf76jTzYk+AW3ggj/b1I/3yntXe/QuhzJP1ck4zKa035G841Mg0BVr2PAM
         6KXwVcLC7SrNrb/g3MxkF+04dbD/GVdx7aNcexf3cYcmJeuMhhKn6Qb2TXA4NmBppyTR
         mCwhcdHAOc4x63QnqoivH3G4vC43dmgNE9D7yugJCMtDUU2ncXSl2ckYWWxQzs/cgaM5
         lOAY6eR6xQa6t0IiScGWdroqov9NTR/mTPnR5Z0tMduEZqLgggk8aTTLVGPcKXfTMbV6
         IYdsrO7YLZ3b+CLoN/rhnJJRBqofZmZ9g7vz0YFOXFtSP14ZieFrrBAZZjGUrhREQCji
         FHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AxQtgEa5tj+EbXCqDeTJKXnYNU2d023MfboxwSu4Wus=;
        b=f6bes5c12CKSM/WeBhLCHdg6r1s/ESsdMwRo1FLBgdhT8K7oOvw7ea1IOJivRbKzp8
         aXzNgjUiKHsNPd01HA1cEREfj+fwawdCL8ACv+X1/9zMiXaXIH2xQejjRqIvFzFSH8kA
         ZqncRFP8wH2yI5p8CSQFUXjMht+htUvYhO4km6ZdXfD0iLnbqAULshBWZurgy9ftNC1g
         iIQH5S6jZrHAtIrde/aNM7pCrrdwGzj7ZD24u8DpH4fk35FC4SNrtUjVffB0A9DD/Ruq
         yQXjVgoRWkV9kDnGxkRM0bXwgRhbokyyvCtK5HEJ01T10GhRrQ6dzMK3fSe0fgqpFg0f
         8BxA==
X-Gm-Message-State: APjAAAWMmgYFDma9aaM+cB6CnA8FrzgVtatCQbhyhdxibKE8QJOqHLJG
        JYVzJbqy5u1N+qaOWn5EsZYl0jEyTFw07w==
X-Google-Smtp-Source: APXvYqxZViSyXSroSVm1TO0PnlV4vCyJk+ZZuJm99pJzdcXh6Ml4P16Z/tx/FHyDnIzmDzTPDtbURA==
X-Received: by 2002:a17:90a:3390:: with SMTP id n16mr8468059pjb.53.1572095660482;
        Sat, 26 Oct 2019 06:14:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r81sm6139696pgr.17.2019.10.26.06.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 06:14:19 -0700 (PDT)
Subject: Re: [PATCH] io_uring: support for larger fixed file sets
To:     Jann Horn <jannh@google.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <59f5cab7-4bc4-84cb-b9b0-48f2743eafef@kernel.dk>
 <CAG48ez38KjVn6y2fW-mDNGkJDOMw47cRpkKv25TkHgEvgdaNqw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3250380-ebe5-9bbf-ae0a-7eeb36f83054@kernel.dk>
Date:   Sat, 26 Oct 2019 07:14:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez38KjVn6y2fW-mDNGkJDOMw47cRpkKv25TkHgEvgdaNqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 5:54 PM, Jann Horn wrote:
> On Sat, Oct 26, 2019 at 12:22 AM Jens Axboe <axboe@kernel.dk> wrote:
>> There's been a few requests for supporting more fixed files than 1024.
>> This isn't really tricky to do, we just need to split up the file table
>> into multiple tables and index appropriately.
>>
>> This patch adds support for up to 64K files, which should be enough for
>> everyone.
> 
> What's the reason against vmalloc()? Performance of table reallocation?

Yeah, not that it's a super hot path, but single page allocs are always
going to be faster. And it's not a big deal to manage an index of tables.
I've changed the table shift to 9, which will actually improve the
reliability of the 1024 file case as well now, as every table will just
be a 4096b alloc.

>> +static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
>> +                                             int index)
>> +{
>> +       struct fixed_file_table *table;
>> +
>> +       table = &ctx->file_table[index >> IORING_FILE_TABLE_SHIFT];
>> +       return table->files[index & IORING_FILE_TABLE_MASK];
>> +}
> [...]
>> @@ -2317,12 +2334,15 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
>>                  return 0;
>>
>>          if (flags & IOSQE_FIXED_FILE) {
>> -               if (unlikely(!ctx->user_files ||
>> +               struct file *file;
>> +
>> +               if (unlikely(!ctx->file_table ||
>>                      (unsigned) fd >= ctx->nr_user_files))
>>                          return -EBADF;
> 
> Not a problem with this patch, but: By the way, the array lookup after
> this is a "array index using bounds-checked index" pattern, so
> array_index_nospec() might be appropriate here. See __fcheck_files()
> for comparison.

Yes, I think we should update that separately. I agree, should be
using the nospec indexer.

>> +static int io_sqe_alloc_file_tables(struct io_ring_ctx *ctx, unsigned nr_tables,
>> +                                   unsigned nr_files)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < nr_tables; i++) {
>> +               struct fixed_file_table *table = &ctx->file_table[i];
>> +               unsigned this_files;
>> +
>> +               this_files = nr_files;
>> +               if (this_files > IORING_MAX_FILES_TABLE)
>> +                       this_files = IORING_MAX_FILES_TABLE;
> 
> nr_files and this_files stay the same throughout the loop. I suspect
> that the intent here was something like:
> 
> this_files = min_t(unsigned, nr_files, IORING_MAX_FILES_TABLE);
> nr_files -= this_files;

Yes, I messed up the decrement, always make a mental note to do so,
often forget. I've fixed this up, thanks.

Made a few other cleanups, will send a v2.

-- 
Jens Axboe

