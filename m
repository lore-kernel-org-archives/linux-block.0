Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69332C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D7E2177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nRGHQAqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfA2BBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:01:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35808 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfA2BBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:01:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so8838461pfi.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C0Hdz9UtmZH0WvoT85ZrUs/X833wS147vWumivzgnos=;
        b=nRGHQAqhkonpol/dBrfQJTlPOwME93vCdqTIFAXjB5x8p+04qfbKE7G9gA+KUXxIc4
         fQPOzUQhukzDXUf7XF+AKm08/uP7t9gju8VaU+gcgVjXfana4aJSNEOQ4WP/8g46j6e2
         x7HrwSS6H7WNiEWy+Dna0lGu7/0CHX/2vQAW9ABiSJcNegOPmt/onwt47YLsMO8ZNDQF
         gYdbvQNQZjW+kwA8fRfzzW7tIaweVgVyZpeGF1h04tVig0+TkwezQcTArKaBJhoFuU7Z
         FKVWAKjb0kNODCE968qtX/A/b5HuvUbo2xHVQDGH+8d07PLLZDHHTfQevPHte1F2593X
         O9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0Hdz9UtmZH0WvoT85ZrUs/X833wS147vWumivzgnos=;
        b=lNH8OEc1Z/xUDF2ihKqlLIHoWXrXsDQlR8wyMZkkirbSSHs8FFOlY8TaiyjRoQKFzk
         wyh7o+4AVwCJfxjLqZOfZ1WvY1ufLQrWvNav2OIYeKl2Ev4RplpGeW11ZwE/ZH4rJvtl
         bfGwKAaFjc910ezb1XKBIGx9N2/2SsBLrGZn37XfS2M4i93gqaREqscaVdQK4GmON89X
         2X6Z8YDEssGDIKrS99mDbObvDuOV3pCvufPpewnaP2cCGbXf1wgyrue1kmTzuESuY3nm
         F7N3oWViNKlgTJVcSG27o+J6nEWUgeRGIxIVd9t/6swP6GxxhTVJlQQh3tiEov9Gu4zp
         0m0A==
X-Gm-Message-State: AJcUukduaqVRRZwsYIqnOEj9cj1fwla1uBYcnbJQOQG9oUeQy0u/H8uJ
        Wb6Kp8kaO8NSmAMx9pv+kfDp7A==
X-Google-Smtp-Source: ALg8bN6/o7nWvuNJQKHLQaXl7wwEdkUUYx3AqJq29hQpR5y25GET4aLceqLey3TBfPrdcUPlbrKm5A==
X-Received: by 2002:a63:7a09:: with SMTP id v9mr21932839pgc.112.1548723680555;
        Mon, 28 Jan 2019 17:01:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z186sm44228658pfz.119.2019.01.28.17.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:01:19 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
 <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk>
 <CAG48ez17NW0GJVRC6dFcHZTgQifFz5og1XCUbXkHKhr6f=j74Q@mail.gmail.com>
 <c20a1250-9f3f-a286-9baf-5b71db0c128f@kernel.dk>
 <51c759f4-7ce5-182b-98e8-2c0e99ca4f9a@kernel.dk>
 <CAG48ez3XGjFZbPiof4u4QGtoumBXXfCsFxOQ_2pGt=MnqqY7ZQ@mail.gmail.com>
 <a89d28dc-d0c4-d84e-b3f2-20d10c6f673e@kernel.dk>
 <CAG48ez2dESJAg80N3+vgSWy_Pb+Est0S-jshhmZD2nnwgpuR3w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ac239ee-85fe-898e-bef8-99328cf7d491@kernel.dk>
Date:   Mon, 28 Jan 2019 18:01:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2dESJAg80N3+vgSWy_Pb+Est0S-jshhmZD2nnwgpuR3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 5:58 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 1:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/28/19 5:34 PM, Jann Horn wrote:
>>> On Tue, Jan 29, 2019 at 1:32 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> On 1/28/19 5:03 PM, Jens Axboe wrote:
>>>>>> But you only do that teardown on ->release, right? And ->release
>>>>>> doesn't have much to do with the process lifetime.
>>>>>
>>>>> Yes, only on ->relase().
>>>>
>>>> OK, so I reworked the files struct to just grab it, then we ensure that
>>>> doesn't go away. For mm, it's a bit more tricky. I think the best
>>>> solution here is to add a fops->flush() and check for the process
>>>> exiting its files. If it does, we quiesce the async contexts and prevent
>>>> further use of that mm. We can't just keep holding a reference to the mm
>>>> like we do with the files.
>>>>
>>>> That should solve both cases.
>>>
>>> You still have to hold a reference on the mm though, I think (for
>>> example, because two tasks might be sharing the fd table without
>>> sharing the mm).
>>
>> Yes good point, except we can't hold a reference to it.
> 
> Why not? kvm_create_vm() does it, too:
> 
>     mmgrab(current->mm);
>     kvm->mm = current->mm;

I missed that helper, was only looking at mmget(). But yeah, that'll do it!

-- 
Jens Axboe

