Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2395C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B3161104
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 16:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhDZQss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDZQsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 12:48:47 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB81C061574
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 09:48:06 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c3so968123ils.5
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puGzBLwZv++5HHjd7fY19pEjsXMx9goCdL3lunTxYdQ=;
        b=J3hDuQRym59MuVErqE8iq0UtDP+T7SI07BCrWQ3p4KTcFE2Q29lkGYxa/J88Mu8034
         YgIZto9R9JjsVvzVbYma7W6GsD5vm7L4lZzmUi94q8y4d5jgVXGVtRr0Uo2itlDt7JrN
         gWDgQ5bUQwl5tPSCG2L2lY+85ia/nVgHRYK/M5SMoMEPLngjOzRWl4pa09GZk+QDgpBe
         i8cNUQ/4NVngRynvEnqgGPCaGI0CzNMoF0QTyQT8XJ1sxBEFSFOvuyk/FViLzXEpfH8V
         NBZpWe9YD+xElbx9cot5VbAuh83JCr3xV9okQpnHN5FLGA0voaSdWnSpqS/gEmBcytIf
         KstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puGzBLwZv++5HHjd7fY19pEjsXMx9goCdL3lunTxYdQ=;
        b=MTwkh2q2GbEvY6EAM3B15laUS4v7BQPGeW/dQ/D1iYrh4SB5MH4Yht7tfKR+8/dQR4
         F516dJlaP3aTE4ZIi1V3Ufff2sjREWzEUPwBbX/8iDgJEDhUELE9N26hA7Fpnf75YZ4v
         t9FZyJ6h8dRY1wwi7EFV2JjVuGq+9A8ZBFCbdct7pyZd/8iGWLoaKunVpCHZNVwMHoow
         UNyvW4CGrK9NjO2RajaQxOs7pBcDXMSi9gkMplLbmZWD1QWW2S8aEyU6TYazvmKrEagC
         u8tZG1ejXrpOn3PGHAqG48JSuKQ7IH4zTbfNBYxYezGr9GhkEX94LzAqhPTd+5FYFt/n
         GZnA==
X-Gm-Message-State: AOAM530NMK5cHj1a3SGrm+E38AyX2wCqrEjbJPeumk3k3+UQWETjA2jA
        vu2HgwMZIjLdaFXXR6dpIB1Wtg==
X-Google-Smtp-Source: ABdhPJyz84UTTivuvf7p9WHBWJPdNtTnBqQ9MVSQ0iwDxMl87Xhp7DRqTHJVVCrqyJShe3XjXtWP/Q==
X-Received: by 2002:a92:d3c4:: with SMTP id c4mr13648591ilh.50.1619455685329;
        Mon, 26 Apr 2021 09:48:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m8sm182147ilc.13.2021.04.26.09.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:48:04 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210426134821.2191160-1-hch@lst.de>
 <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
 <20210426150638.GA24618@lst.de>
 <6b7e3ba0-aa09-b86d-8ea1-dc2e78c7529e@kernel.dk>
 <20210426161503.GA30994@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c77394a-c6fc-8f58-302e-8e997adc8620@kernel.dk>
Date:   Mon, 26 Apr 2021 10:48:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426161503.GA30994@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 10:15 AM, Christoph Hellwig wrote:
> On Mon, Apr 26, 2021 at 09:12:09AM -0600, Jens Axboe wrote:
>> Here's the series. It's not super clean (yet), but basically allows
>> users like io_uring to setup a bio cache, and pass that in through
>> iocb->ki_bi_cache. With that, we can recycle them instead of going
>> through free+alloc continually. If you look at profiles for high iops,
>> we're spending more time than desired doing just that.
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-bio-cache
> 
> So where do you spend the cycles?  The do not memset the whole bio
> optimization is pretty obvious and is someting we should do independent
> of the allocator.

memset is just a small optimization on top. If we look at current
profiles, the alloc+free looks something ala:

+    2.71%  io_uring  [kernel.vmlinux]  [k] bio_alloc_bioset
+    2.03%  io_uring  [kernel.vmlinux]  [k] kmem_cache_alloc

and

+    2.82%  io_uring  [kernel.vmlinux]  [k] __slab_free
+    1.73%  io_uring  [kernel.vmlinux]  [k] kmem_cache_free
     0.36%  io_uring  [kernel.vmlinux]  [k] mempool_free_slab
     0.27%  io_uring  [kernel.vmlinux]  [k] mempool_free

Which is a substantial amount of cycles that is needed just to
repeatedly use the same set of bios for doing IO. Using the caching
patchset, all of the above are completely eliminated, and the only thing
we dynamically allocate is a request which is a lot cheaper (ends up
being 1-2% for either kernel).

> The other thing that sucks is the mempool implementation, as it forces
> each allocation and free to do an indirect call.  I think it might be
> worth to try to frontend it with a normal slab cache and only fall back
> to the mempool if that fails.

Also minor I believe, but yes it'll eat cycles too. FWIW, the testing
above is done without RETPOLINE.

-- 
Jens Axboe

