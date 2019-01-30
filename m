Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47182C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A61218A4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MfaGYnKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfA3Pd4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:33:56 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38020 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfA3Pd4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:33:56 -0500
Received: by mail-it1-f195.google.com with SMTP id z20so11088248itc.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jo0rz6J3zLmsPx45ZO1ccCSp6EZ7f1pLsxp9HSzIqc=;
        b=MfaGYnKRjfphevmre3Nq33onA28lGOneyl0wYwTeZSGnIv88SIGsUThoaZWbAuHt8/
         01OcPU0i2RrNQk8SkgN912kbb3ToQEdKFuS11lR5Dk3DVVfVBO6pi8H+f6dfJE0tnezs
         VnXoKFGrMT6JUcFyLpsKjJrpJybvXxACOjiJ4WYpRWZvdKTc08gyL6ZMf2ZDarj9OMWf
         W+PkdlM3Bj9voDkAtEN/oIOm+HdyM535+i08Kb40gqn7NcI9p0XXjoe2F5D3Ii2Bd9PS
         eLlugAQyE3A2f861X29I2J64gqjfQNyEPC5y3/WUTs9VsJqVqmWy7YBZHoYlGTZhQThy
         DWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jo0rz6J3zLmsPx45ZO1ccCSp6EZ7f1pLsxp9HSzIqc=;
        b=H50nVoWPp9j3+siIjjSHSu0O4vG6BlGd2GzY8SR+r1EVMVkg7VwoAKYz7388rNh2sg
         EmLV9GXRjLjUwTTTcuiu0QYvafLoFjgN8/jYIb2nSnpjJg6pwoxYvBazLu3YOH9YXo3y
         bsdTlEuNi9SU3if7K5o2+/U1drmDSvwMLvzYVm0MulWe0h9nBhFu7+GEgie6l5sbeeIL
         rYuBiGwnEYwShg93CLWC6ke2W43IkdXPLWwjVMdzXwy4RQe/8ylysU36iWAAXJUhDxaZ
         jprEYCItWD5ui3lOOq/K5sG/6DPoPuU1TYvoR6bcXlyXnntTAzghFgMBiDviLI6eugl8
         ANZg==
X-Gm-Message-State: AJcUukdeQn/tIkwPtbvoE20TB1GZ9SJeUmi2Dtq2V70iSIZiqUtlqfpO
        bQSYGDJvPDNj963IeboQ9yOx1g==
X-Google-Smtp-Source: ALg8bN4+yUap8MGXLfRbh2AYkG7U070ArGmVAwCkyeyoftgJwzMKqnSY1SafTz87RYLthGiwcZk/lw==
X-Received: by 2002:a24:b951:: with SMTP id k17mr14707178iti.147.1548862435156;
        Wed, 30 Jan 2019 07:33:55 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e10sm807963ioa.65.2019.01.30.07.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 07:33:53 -0800 (PST)
Subject: Re: [PATCH 09/18] io_uring: use fget/fput_many() for file references
From:   Jens Axboe <axboe@kernel.dk>
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-10-axboe@kernel.dk>
 <CAG48ez3_1mY1Fb91Q3H-S2+4OiMsV5F9v78JX+YMjWqLteHpzw@mail.gmail.com>
 <bceb5e2b-9634-1296-a2a9-ed521f0e31d4@kernel.dk>
Message-ID: <c0fd9a4c-e2ce-fa17-da95-a32b688f0ae0@kernel.dk>
Date:   Wed, 30 Jan 2019 08:33:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bceb5e2b-9634-1296-a2a9-ed521f0e31d4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:44 PM, Jens Axboe wrote:
> On 1/29/19 4:31 PM, Jann Horn wrote:
>> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>>> Add a separate io_submit_state structure, to cache some of the things
>>> we need for IO submission.
>>>
>>> One such example is file reference batching. io_submit_state. We get as
>>> many references as the number of sqes we are submitting, and drop
>>> unused ones if we end up switching files. The assumption here is that
>>> we're usually only dealing with one fd, and if there are multiple,
>>> hopefuly they are at least somewhat ordered. Could trivially be extended
>>> to cover multiple fds, if needed.
>>>
>>> On the completion side we do the same thing, except this is trivially
>>> done just locally in io_iopoll_reap().
>> [...]
>>> +static void io_file_put(struct io_submit_state *state, struct file *file)
>>> +{
>>> +       if (!state) {
>>> +               fput(file);
>>> +       } else if (state->file) {
>>> +               int diff = state->has_refs - state->used_refs;
>>> +
>>> +               if (diff)
>>> +                       fput_many(state->file, diff);
>>> +               state->file = NULL;
>>> +       }
>>> +}
>>
>> Hmm, this function confuses me.
>> The state==NULL path works as I'd expect, it calls fput() on the file.
>> But if `state!=NULL && state->file==NULL`, it does nothing, it never
>> uses `file`.
>> And if `state->file!=NULL`, it drops the excess bias on the file's
>> refcount, but it doesn't drop the current reference - and again
>> without even looking at `file`.
>>
>> So when io_prep_rw() uses io_file_get() to grab a reference on a file
>> it hasn't seen before, it will acquire `ios_left` references and
>> actually use one of them; then if it goes through the out_fput error
>> path, it goes through the path for `state->file!=NULL`, drops
>> `ios_left-1` references (leaving the refcount elevated by 1), and
>> forgets about the file?
> 
> I'll take a look, it's not impossible there's an off-by-one there.

Fixed it!

-- 
Jens Axboe

