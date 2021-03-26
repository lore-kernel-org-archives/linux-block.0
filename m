Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A27C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 03:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0235661A42
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 03:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCZDqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:46:39 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:33734 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCZDqX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 23:46:23 -0400
Received: by mail-pj1-f49.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4967864pjb.0;
        Thu, 25 Mar 2021 20:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TArOxHPj0bJACvUlOiR8PlgnUcYFgFhDZ1MX0k/594=;
        b=TDQ6kTU1gfoisXrFt8qin4eh9VNJtolVs5BbeByCV+TFJ58CB2XMNbugiVK4fh7cEn
         rEvKM22zV9jXK8gSh0y6QJXDDOQPjG7zrzoU+W2Jk/vWGrYzVJATO9qF1A0f+Zk2Dn5x
         vfI+BfWI2hivDSMC+hDBbtx7uN5OoaFGW9ZbqKdNDSjkYBpe4otir0IAyeOH+uS7o+T2
         bfafCkKOD2QsjWhhX3K5LHc2PDKlagXfZTUfZct3dRIOpFH5z4/KzrSLYWYFcdKnZRfC
         jVEzA5XPTd5nMoFqrnoxx3+KiUqlDmoyVdZJtw5QWh5qq3SeBuFenWcVAdx50sC3/328
         E1kA==
X-Gm-Message-State: AOAM531fsgC7uW0qAVJVGLyHqOZEQPmh1d3kT2rczKoMhSGjq8WE/rG3
        t7WIFeefolcak7MRxSrVr2w3mIw9XcI=
X-Google-Smtp-Source: ABdhPJyRv/Pm3fR3WvYhmdhuNQDv0f6qQhkgiFAl4zjmlV5vIsgRLzjR0eoLO8pYda0H9T5ighzQUQ==
X-Received: by 2002:a17:902:ce88:b029:e6:3a3c:2f65 with SMTP id f8-20020a170902ce88b02900e63a3c2f65mr13255324plg.66.1616730383199;
        Thu, 25 Mar 2021 20:46:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c5af:7b7c:edac:ee67? ([2601:647:4000:d7:c5af:7b7c:edac:ee67])
        by smtp.gmail.com with ESMTPSA id x2sm7002459pgb.89.2021.03.25.20.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 20:46:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] ensure bios aren't split in middle of crypto data
 unit
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
References: <20210325212609.492188-1-satyat@google.com>
 <e0248d93-e880-6a6d-92d6-dfcfb6f9d661@acm.org> <YF07bqQ1NvPxPNrh@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4694766c-8d95-1ad3-cb0c-d1ba8b7fe7ad@acm.org>
Date:   Thu, 25 Mar 2021 20:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YF07bqQ1NvPxPNrh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/21 6:39 PM, Satya Tangirala wrote:
> On Thu, Mar 25, 2021 at 02:51:31PM -0700, Bart Van Assche wrote:
>> Are you sure that the block layer core splits bios at logical block
>> boundaries? Commit 9cc5169cd478 ("block: Improve physical block
>> alignment of split bios") should have changed the behavior from
>> splitting at logical block boundaries into splitting at physical block
>> boundaries.
>
> Ah, what I really meant with that sentence was "Currently, if a bio is
> split, the size of the resulting bio is guaranteed to be aligned to a
> the lbs. The endpoint of the bio might also be aligned to a physical
> block boundary (which 9cc5169cd478 tries to achieve if possible), but
> the bio's size (and hence also its endpoint since the start of the bio
> is always lbs aligned) is *at least* lbs aligned". Does that sound
> accurate?
That sounds better to me :-)

>> Without having looked at this patch series, can the same
>> effect be achieved by reporting the crypto data unit size as the
>> physical block size?
>
> That would've been awesome, but I don't think we can do that :(
> 1) There isn't only one crypto data unit size. A device can support,
>    and upper layers are free to use, many different data unit sizes.
> 2) IIUC 9cc5169cd478 (or more accurately get_max_io_size() since the
>    function has been changed slightly since your original patch)
>    doesn't align the size of the bio to the pbs - it only aligns the
>    endpoint of the bio to the pbs (and it may actually not even do
>    that if it turns out to not be possible). Is that right? If so,
>    that means that if the startpoint of the bio isn't pbs aligned, the
>    size of the bio won't be pbs aligned either.

Hmm ... if the start of a bio is not aligned to the physical block size
I don't think that the block layer can do anything about the start of
the bio. Anyway, I have taken a quick look at this patch series and the
patch series looks pretty clean to me. I will let Christoph review this
patch series since he already reviewed the previous version of this series.

Bart.
