Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA0C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1920855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sa26W7bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfAQVRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:17:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50569 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfAQVRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:17:09 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so3756675iti.0
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pw+v7EhjpTqDPHVtrl88tsrhCZ87xWX/hhIqge9wmy4=;
        b=Sa26W7bHL05zpDg9ApLsxgHRMK6Nnb/0iqDWEwvf+NlmL+QJn3SGhZm9qeiLF+gLn8
         YkiUJX4QiXr0OnpNkfRUC9OwCNd0xdAZcalUIprAs+nOU7zWADXJUi2nbhrr+IxUXo4c
         DnhEHyJ9hYEn2lMZZz/BStla7Hmg3dYzQx8NStcfr+t7CVkTimDwj7g1IMuGCYOga5WJ
         yHhO1yhVUV1FFpDr2PQbj3378lYq9XAoSk6Epvw/FH+pU0ydq22GmeFZXGqGa5rUayTa
         FbqYovHhDzNa6s+zSn02kSSZEsQxQVAXid/D1GKiTIVWHkeF+HD8TowBZg3EiyDUNg4n
         ws+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pw+v7EhjpTqDPHVtrl88tsrhCZ87xWX/hhIqge9wmy4=;
        b=oOF2YjG/17rwQRk1g3SXdmwwJfJ0vNGKho3u4N0iEg+lTY1kLVchCztHIU3YkVuSFx
         JT6R2aLnR2XVe8GAmWGZXSCLfh/J/2fw6UaZ7LWG4J7/y+YHA2TYRxqydwga48MyXvkI
         UTxy2ti1QGE1XfIr49l3wBYvj1JkvTWlUI5pCEKCOoTbba/IWHRTp/fD+rsBgEj5h0Mx
         hdF3sEe3V1hjLlfzdeWP9Uy56CL5cOPhh3PKMqca2gD80deUAYQrSbG/YrjuM2cdScjR
         1aq7QC/SBcXI0GCXkmWws9HwL25RBVdkuF5ebwnfyWUGfEVNruMYIV+JBl4+Fly6e3ic
         x8XQ==
X-Gm-Message-State: AJcUukej34tCwAfR/RS/Mv3ZRVCmi1P5XIImg13aa8n3ePzQBrSMezyl
        NH9hQmf1ZBccS09yGC9QTPjW7sxcycte3g==
X-Google-Smtp-Source: ALg8bN7liKCAGbkrD5qNGSm/OcNBj7fVwYBBCyw9tnmKwS88Sa6ezYN0WOxiBleLQiAWWwTJhpxE+w==
X-Received: by 2002:a24:70d2:: with SMTP id f201mr9208483itc.127.1547759828255;
        Thu, 17 Jan 2019 13:17:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k64sm1249449itb.7.2019.01.17.13.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:17:07 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
 <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
 <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
 <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
 <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
 <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
 <3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk>
 <x49y37j6lqi.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c86dbb69-1937-5a0d-11ff-98d933f6581a@kernel.dk>
Date:   Thu, 17 Jan 2019 14:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49y37j6lqi.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 2:02 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>>>>>>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>>>>>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>>>>>>> passing random entries number? (or even better: decreasing entries 
>>>>>>>> number,
>>>>>>>> in order to consume all pages orders with min number of loops).
> ...
>>>> One concern here is that, at least looking at my boxes, the default
>>>> setting for RLIMIT_MEMLOCK is really low. I'd hate for everyone to run
>>>> into issues using io_uring just because it seems to require root,
>>>> because the memlock limit is so low.
>>>>
>>>> That's much less of a concern with the fixed buffers, since it's a more
>>>> esoteric part of it. But everyone should be able to setup a few io_uring
>>>> queues and use them without having to worry about failing due to an
>>>> absurdly low RLIMIT_MEMLOCK.
>>>>
>>>> Comments?
>>>
>>> Yeah, the default is 64k here.  We should probably up that.  I'd say we
>>> either tackle the ridiculously low rlimits, or I guess we just go the
>>> aio route and add a sysctl.  :-\  I'll see what's involved in the
>>> former.
>>
>> After giving it a bit of thought, let's go the rlimit route. It is cleaner,
>> and I don't want a sysctl knob for this either. 64k will enable anyone to
>> set up at least one decently sized ring.
> 
> OK.  Note that the MLOCK_LIMIT size has been dictated by gpg's
> requirements:
> 
> commit f947ff8af30f75cb9cf0e966caf8f4809ad1b92e
> Author: Rik van Riel <riel@redhat.com>
> Date:   Sun Aug 22 23:06:58 2004 -0700
> 
>     [PATCH] increase per-user mlock limit default to 32k
> 
>     Since various gnupg users have indicated that gpg wants to mlock 32kB of
>     memory, I created the patch below that increases the default mlock ulimit
>     to 32kB.
> 
> and then
> 
> commit 0833422274ff00729a603b020fac297e69a03e40
> Author: Kurt Garloff <garloff@suse.de>
> Date:   Wed Oct 29 14:00:48 2008 -0700
> 
>     mm: increase the default mlock limit from 32k to 64k
> 
> ...
>     However, newer gpg2 needs 64k in various circumstances and otherwise
>     fails miserably, see bnc#329675.
> 
> So all we need to do is modify gpg2 so that is requires more locked
> memory, and we're golden!  ;-)

Haha, that's some nice digging there!

Yes, we could bump it, but with the default, we can get a 512 sized
ring per user, that's 13 pages (rounded up). Probably good enough to
get things off the ground?

-- 
Jens Axboe

