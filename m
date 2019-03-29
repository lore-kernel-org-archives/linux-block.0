Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A270C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399A12184C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 15:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O3pIxEhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfC2PDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:03:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33191 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfC2PDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 11:03:50 -0400
Received: by mail-io1-f65.google.com with SMTP id b6so2022347iog.0
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/NEXPBxL7e2zGgdVoA8ScW8cprmh/X7zrBJXjbUqpYs=;
        b=O3pIxEhBn64YIEVWrShBWDfULsYzaIhT7Ny0PAqsfxFUbjy9Mz5cbBL6P+haQMiOSt
         RJymWwS0h+Szp8A+zNp0lqgcHgyj/UDmuC8OZ/ZhDPxvXA4TH+LpXKz0brQijGC6+Fm3
         o/wB9Aw1VBXp/tJ86K8X4q9bVrrqQi849Pq75Qj7/J833HP6ipcH1287qaxqeyb9z8FO
         ZqCumZpUDjr06TbqxwZOhIw/rRgNE06oNiNi2pTuSNlKundK3bPv66qNc4Ux6C/PdG9D
         +gutLdpoNAozaoFpgrQrTUk5werl+R/ARjSd2uQfzD4EMfeRLFerusXFH6dHIZ5PdGLq
         rJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/NEXPBxL7e2zGgdVoA8ScW8cprmh/X7zrBJXjbUqpYs=;
        b=N11QuPurKczxhp+s78F8KBiT6b+ZcP+YTqUlxigksA22hQ07qfaynOBNbz2fIuNGuv
         bWm9c8RdjOIHAxGamERJ3v6051NQcwdWdjTetT2ahtQr3A9cbcyxi09L2zHzCNh0pkq6
         4UXGrGFG+cq9zF73xYz4IqoRoUhiqnQ7AdbqELhhIFPkcRr2NKIgwlg/teR/YWyrgZC1
         MPrmTiwgByHW7szGpS6nTEbVtxcwWNSdM0FLz6jnCTMehYgVoqKWqfUuIo0h/f9bP7tr
         x+ahg18vT5nfWbRAGLWu6l0OhigglI++khLVqKal2o5ExnoKroMORIe40mB6GDxsFjsC
         zA0w==
X-Gm-Message-State: APjAAAVQpivDlIDGP9Y2JwqNx5FtVAzRwXdhIgBYjWlnLCulfRGFGB/s
        TuJF0oXHRHM2TqkDnL4ncqn3pg==
X-Google-Smtp-Source: APXvYqzC3F0wGVz+DbQGf2cm2yij/TmBChcDZjgynxOKpR6ky9+ddzyiBL0YXkvbGeA+M6BWLc+lnA==
X-Received: by 2002:a5e:c901:: with SMTP id z1mr34686316iol.304.1553871830135;
        Fri, 29 Mar 2019 08:03:50 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e72sm898827iof.13.2019.03.29.08.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:03:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     Bob Liu <bob.liu@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> <yq1ftr5rbq1.fsf@oracle.com>
 <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk> <yq1bm1trb4y.fsf@oracle.com>
 <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk> <yq17echrax1.fsf@oracle.com>
 <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
 <c9adb48c-7b6e-2017-9480-aa2342b3523b@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7599b239-46f4-9799-a87a-3ca3891d4a08@kernel.dk>
Date:   Fri, 29 Mar 2019 09:03:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c9adb48c-7b6e-2017-9480-aa2342b3523b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 9:00 AM, Bob Liu wrote:
> On 3/29/19 10:52 PM, Jens Axboe wrote:
>> On 3/29/19 8:51 AM, Martin K. Petersen wrote:
>>>
>>> Jens,
>>>
>>>> The integrity stuff still has that nasty pointer in there. It'd be
>>>> nice to get rid of that as well, and hide it all in a parent container
>>>> of the bio.
>>>
>>> That's fine with me. We really didn't have that option a decade ago.
>>
>> Right, but now we do. Hence trying to nudge things in that direction,
>> instead of adding another pointer to struct bio for a new use case. I'd
>> much rather go that route, instead of unionizing with another pointer
>> that should be going away instead.
>>
> 
> No problem, will update in next version.
> Let me wait a while for feedback about the verify callback.
> Thank you!

I think you're still missing my point. If you go the bio_set and
container-of-bio route, then you can do whatever you want. You will not
need a callback in the bio, you will just have a private end_io function
for that particular bio that does the verification.

-- 
Jens Axboe

