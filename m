Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD1EC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 21:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBED2077B
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 21:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KDIeTaBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCLVwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:52:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39013 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfCLVwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 17:52:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id i20so2791266pfo.6
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zSoUjrLRttRSx/vhalKq4LZdMfL3ZtMjg4gN7AEDgGg=;
        b=KDIeTaBTumB2vDoQ+pMgAJCRDKanP7VNphSFr+FtKFnAs21l021UgEIXfMyEleP2L4
         5chL/PBUYajA/CtaD+ueA3ccNlPAO/PHdhtbep6txCAz53guYT1se0g4TydJS/Otk14P
         jYigZugvMbd+2KN7cB6UCVXBlMFA1+k1OkqM79VQLUc2KttBSeqMImv5XKY8gyEXNikk
         7K1xK/XluhNW7IX2Q8CB75La8msOWSzsnSLl2v93gDlkIrJKKlV+9eyR9OVj9wLpzkLJ
         rer0EB6+tVySnMQgpC8rYSVhadJmaeqFFg090pBgams1OP7bzmVWuZZtw9onmiYalcej
         8UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSoUjrLRttRSx/vhalKq4LZdMfL3ZtMjg4gN7AEDgGg=;
        b=nUckGnWxmP4JDH8szogISz0CfBi4zeuSRwt+Zt1SvSv0dtTUG+tUmoFPqtmQJz+tBJ
         3XSIIyNYkLw4X/1Rb9z6YtOAaRcFU8WvzYvh89upR/kodvbCJ12viVAnqjhaIiwCCaUf
         HaM9E7ddiEYrth/oqGb/3oV/vhrFpvtGi9VO6M2Z1S8ZQrUXGgqNN5Mf8b/Ppoi0IcyS
         eD0Uol8gFAQsWSG6hKZ9LFHXAd6hLUrRNhR1CDv2wJo331xwfKNAJGLygVfs5dzQNM2X
         W/kRmff63OVW/Qw3Y0wtZNvQF/7/9GbYie4Erz5DfrndRsS5D2kXEQrfpbT+9M7CnRyR
         JTlA==
X-Gm-Message-State: APjAAAXdslu1gzj2YuJZjkZZg2BofACr4y4o2L1kkaqdBM3zcIFpSkUz
        soBlnsUPpgOcRp+CUYxQHIh42g==
X-Google-Smtp-Source: APXvYqztbFbIVcCE4IEaExcdQYICOoWjiTE81XrWl6wXkyVn6s2Nl2et0yNKdjGJCsTUCMBmCaS1yg==
X-Received: by 2002:a63:1723:: with SMTP id x35mr19387713pgl.364.1552427532526;
        Tue, 12 Mar 2019 14:52:12 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id h3sm10926492pgv.38.2019.03.12.14.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 14:52:11 -0700 (PDT)
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
 <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
 <CAHk-=whu3uojbKwdtaq8vwGfsvSpVUPfhvJPv+LMR=6kNT0XgA@mail.gmail.com>
 <CAHk-=wh36F+2iXMz1dxGxVebfFYtqypGXRchqttJuJ_=A9ctZw@mail.gmail.com>
 <6cc0763f-8a48-c61a-b831-4326345aa68c@kernel.dk>
 <CAHk-=wjF5Pbuo-cOUzCESA4mrrQXA26OsYDvnXr3+W8ve9a=MA@mail.gmail.com>
 <ac1db664-b02e-3cae-28b8-4ce1d216e6c9@kernel.dk>
 <CAHk-=wj+7Jp_w+vZ1SyekQq3VGJXrfg=VY9ug+QktxhNdA8Tnw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5140396c-416e-4656-7279-0f8535141f75@kernel.dk>
Date:   Tue, 12 Mar 2019 15:52:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj+7Jp_w+vZ1SyekQq3VGJXrfg=VY9ug+QktxhNdA8Tnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/19 10:41 PM, Linus Torvalds wrote:
> On Fri, Mar 8, 2019 at 8:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> If all else fails, it's also trivial to yank the poll command support for
>> now, which would kill the io_req refs.
> 
> No, it really wouldn't.
> 
> The poll() code thinks it needs the refs, and the poll code is right -
> but the refs are just badly done and there's a ref leak in a special
> case and just generally ugly code.
> 
> The read/write code thinks it _doesn't_ need the refs, and the
> read-write code is *WRONG*. It actually does need them.
> 
> So what the fs/aio.c and now fs/io_ring.c code *thinks* it can do is:
> 
>  - I'm submitting IO
> 
>  - I'm not touching the iocb after submission
> 
>  - so I'm done with the iocb, and all I need to do is to say that if
> the IO submission succeeded, then the completion of the IO will free
> the iocb.
> 
> That sounds simple, but it is *WRONG*.
> 
> Here's roughly what happens for the write code on the submission side:
> 
>   call_write_iter(file, req, &iter)
>     file->f_op->write_iter(kio, iter);
>       filesystem_file_write_iter()
>         inode_lock(inode);
>         __generic_file_write_iter(iocb, from);
>         inode_unlock(inode);
>         if (ret > 0)
>                 ret = generic_write_sync(iocb, ret);
> 
> and guess what? The IO completion might for example happen *while*
> __generic_file_write_iter() is running, which might be calling
> generic_file_direct_write(), and the IO might just effectively finish
> immediately.
> 
> What happens then? The iocb is released as part of IO completion, and
> now that whole *submission* side that is still accessing the inode,
> still accessing the file, and still even accessing the "iocb" (for
> that "write_sync" case) is all touching something that may not exist
> any more, because it's all been released!
> 
> See what's going on?
> 
> The thing is, the *submission* path absolutely has to keep a reference
> to the iocb until the submission is fully and entirely done. So read
> and write need to have that ref on the iocb too, and one ref is given
> to the actual IO part, while another ref is held by the submission
> side.
> 
> So it's really not "poll does ref handling wrong, nobody else needs it".
> 
> No, poll at least _tries_ to do ref handling, and admittedly gets it
> slightly wrong, but at least it gets a B for _effort_.
> 
> The read/write paths don't even try. They get an F. They think they
> don't need a ref at all, and they are very much mistaken.
> 
> So this is why the io_get_req() function simply should never return
> that "ref 0" io_kiocb. It should always be initialized with a
> ref-count of 2: one for the submission side (which should do a final
> io_put() after it has finished submission, so that the iocb and the
> file and the inode are guaranteed to stay around for the _whole_ IO
> callchain), and one for the actual IO side (which should do it as part
> of io_complete).
> 
> This is why Al's branch has that whole series that starts off with
> that "pin iocb through aio" commit that does that
> 
> -   refcount_set(&req->ki_refcnt, 0);
> +   refcount_set(&req->ki_refcnt, 2);
> 
> in aio_get_req(), and then works at keeping the iocb around until it's
> been fully submitted. And then Al fixes all the small details that
> I've glossed over above because aio_poll() had various ugly cases, and
> cleans things up a bit.

The bit I was missing was sync completion combined with the iocb
being used in the not after submission, but during that part.

I've reworked the references to follow the above proposed scheme, one
for submission and one for completion.

I've also ported Al's race fix for the poll implementation. Will throw
it all into some testing.

Thanks Linus!

-- 
Jens Axboe

