Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF963C636D6
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 22:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjA3WLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjA3WLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 17:11:45 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8BA3802F
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 14:11:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e2so2301890iot.11
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 14:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDmWTfugN+KPnRJSF8VFqZVl7659BFN6n85PK3By/Nc=;
        b=nlmOc4WiFbAADi0988MPCHfj5QF4EnG9I8vaKRc2e6p1wgBDvQN8K85rsfHPq3bnzz
         +5Wpk2M14PHX4sLLXYbWPiNqjt5hNOjGnF0A0G7FcIUQhsUE7yp4WCS9ksaGv4X6PXuS
         TGw+Pnf5qwEw6KIrYBzOEok93sqvMiIvEBShjP1ZhXRg902LS2o4ZW1MHKIYzN43uKWR
         ETbp6zE6TY3BdA52DLjHc0etLXeq+J7Q1N22iMvAvtAOqF+xuRz7R9/ChivDlPnSg4mX
         p+bXJIJ59idbqVY+PP5h9kLZRWy8uR/o4OByjm8W/b8sF63cFmEMRB8lJRzLh4Hoh5SH
         6+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDmWTfugN+KPnRJSF8VFqZVl7659BFN6n85PK3By/Nc=;
        b=qmXkfOMjE8/bwbsnCs+s7I5S6qaUy2+rC/JgnlICFTwn12SsyKSJHNIZ8RPSUwtf9z
         B1vyDNw+nGATx/Dl/Qb706BNPw/ttG3DjzZBY7HfIv5WCohDB6C67riWv91kaihoElGD
         d6xcN7Xh73LIaSJSJ+rDidUr+S9m9a+LBQvtolcUC2oaTkZn+6S6NLCHPvJo5Q8JlNFe
         0yN090jmZggt5/LVLgZVY0fYobQhbYyFd0LGejWpd76C0B5uV+e6R9sIKJdVtgeazsDm
         t1oSP+UtRf6WTJyu4trVJzcXv94wCgTDY0a28XR6xdxHzWB8Sndx0KriuqgfIEaSVBFQ
         UexA==
X-Gm-Message-State: AO0yUKUSsrYlY4LTcUp2v0PVEYXR/HlcdRD0kn0QCnnAznyI2R0oG//v
        aLTdYgNlWlHbndwJLKbIB0tgkg==
X-Google-Smtp-Source: AK7set9lGPWLFsiulveNFHus1v4u4pnnWzF0DBa0qziScPlEkynj8aHMSJd2IdwJIecjeXz0X86ddw==
X-Received: by 2002:a05:6602:88f:b0:719:6a2:99d8 with SMTP id f15-20020a056602088f00b0071906a299d8mr1396318ioz.0.1675116701027;
        Mon, 30 Jan 2023 14:11:41 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m4-20020a056638224400b003a958f51423sm5018787jas.167.2023.01.30.14.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 14:11:40 -0800 (PST)
Message-ID: <088e40fd-3fc7-77dd-a3de-0a2b097d3717@kernel.dk>
Date:   Mon, 30 Jan 2023 15:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/23 3:02?PM, John Hubbard wrote:
> On 1/30/23 13:57, Jens Axboe wrote:
>>> This does cause about a 2.7% regression for me, using O_DIRECT on a raw
>>> block device. Looking at a perf diff, here's the top:
>>>
>>>                 +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
>>>                 +2.22%  [kernel.vmlinux]  [k] iov_iter_extract_pages
>>>
>>> and these two are gone:
>>>
>>>       2.14%             [kernel.vmlinux]  [k] __iov_iter_get_pages_alloc
>>>       1.53%             [kernel.vmlinux]  [k] iov_iter_get_pages
>>>
>>> rest is mostly in the noise, but mod_node_page_state() sticks out like
>>> a sore thumb. They seem to be caused by the node stat accounting done
>>> in gup.c for FOLL_PIN.
>>
>> Confirmed just disabling the node_stat bits in mm/gup.c and now the
>> performance is back to the same levels as before.
>>
>> An almost 3% regression is a bit hard to swallow...
> 
> This is something that we say when adding pin_user_pages_fast(),
> yes. I doubt that I can quickly find the email thread, but we
> measured it and weren't immediately able to come up with a way
> to make it faster.
> 
> At this point, it's a good time to consider if there is any
> way to speed it up. But I wanted to confirm that you're absolutely
> right: the measurement sounds about right, and that's also the
> hotspot that we say, too.

From spending all of 5 minutes on this, it must be due to exceeding the
pcp stat_threashold, as we then end up doing two atomic_long_adds().
Looking at proc, looks like it's 108. And with this test, then we're
hitting that slow path ~80k/second. Uhm...

-- 
Jens Axboe

