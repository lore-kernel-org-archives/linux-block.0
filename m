Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C35C636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 17:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBMRFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 12:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBMRE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 12:04:58 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C741E9F0
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 09:04:56 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id n2so5433110ili.11
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vgCGFkrQwcp/7jPx+PdVEy8B0KpHLcBmVE/3aSXGL0=;
        b=0Up9q+rtS4ekW744Yp+SKLSPhEYbbmzoeNX7HtHa6nB/W3vmkqNHtEjDtXJnxq268p
         WwPoBNu0h/3N7pYDeeiy5Rgw91FcAzGMhvGRuJVzbf54Hoo81DtAyDQWk1TfI6YA3Tnv
         CGAF8rkvn3JdTC4ugT0/wu1gifN8sOG9SlmYwbA+UNj0MsrHkP25N3/Vw7/SZkI3Wwau
         vETaQjDeorwX5qhpWyGB9iLf0CGF3n66W9/RbGTlzHoLulQhZV3beSSR/r0juaCcqhBz
         Q/RRTm8NcqdnG2+EVjBu2QDVXbDqyxXvckxMl5aWKTnf7jVx/n/sGkDaRWKOqLIb5zez
         uOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vgCGFkrQwcp/7jPx+PdVEy8B0KpHLcBmVE/3aSXGL0=;
        b=pey9cOerYISPKEBls5QuKL5pdRlpkwEOdpzu3tM6GyW/Il90VdnJ/BkDwSHZB66mjm
         AmOInznbQCKWhnYOeFfZx1SqGMJ7Yz+A5sSyxvQSX+eusKxhov/e4YQH+C7afEupr7lq
         SyIW9b3ieX5ECQQjPqxR9+0CBOlmtCO0meRzFfDBr+Lz+uBWx3bUCdzY5yGv7zW6C1OD
         FJn9qDBkjzxi8emQmwx4ktoExd9Wbv3JxNR1brAzq0mSQ8ntzkX0rZ+wMuZqy1VG9w8B
         ZABSF/x3ADyzZeFDnqpb34IHYPX6EpsqpProy1wK+Ktpa4ZeyqPf8TVU3LEVsAn376CX
         wmIQ==
X-Gm-Message-State: AO0yUKUtb2qzbEkL4aI/v/+xotqMGEZkT2pslc1wwXhslwa/t6Di7X7R
        yPxeBGdbFROm3iMIRIIt9ksDhroksC1zxU9L
X-Google-Smtp-Source: AK7set9Hc8PI/3Vz78e4+P2zWBzi6x265jfVpLGfmkLl7P2VS/PPl73lyILaUovAKnyd2uibp/VWOw==
X-Received: by 2002:a05:6e02:1d84:b0:315:39ce:abd2 with SMTP id h4-20020a056e021d8400b0031539ceabd2mr4774352ila.3.1676307895839;
        Mon, 13 Feb 2023 09:04:55 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y13-20020a056e02118d00b0031537da6ba3sm1530437ili.87.2023.02.13.09.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:04:54 -0800 (PST)
Message-ID: <1f716ecb-3f27-af5f-66b4-ac4dae52cf23@kernel.dk>
Date:   Mon, 13 Feb 2023 10:04:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 0/4] iov_iter: Adjust styling/location of new splice
 functions
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230213153301.2338806-1-dhowells@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230213153301.2338806-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/13/23 8:32 AM, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> Here are patches to make some changes that Christoph requested[1] to the
> new generic file splice functions that I implemented[2].  Apart from one
> functional change, they just altering the styling and move one of the
> functions to a different file:
> 
>  (1) Rename the main functions:
> 
> 	generic_file_buffered_splice_read() -> filemap_splice_read()
> 	generic_file_direct_splice_read()   -> direct_splice_read()
> 
>  (2) Abstract out the calculation of the location of the head pipe buffer
>      into a helper function in linux/pipe_fs_i.h.
> 
>  (3) Use init_sync_kiocb() in filemap_splice_read().
> 
>      This is where the functional change is.  Some kiocb fields are then
>      filled in where they were set to 0 before, including setting ki_flags
>      from f_iocb_flags.  I've filtered out IOCB_NOWAIT as the function is
>      supposed to be synchronous.
> 
>  (4) Move filemap_splice_read() to mm/filemap.c.  filemap_get_pages() can
>      then be made static again.
> 
> I've pushed the patches here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract-3
> 
> I've also updated worked the changes into the commits on my iov-extract
> branch if that would be preferable, though that means Jens would need to
> update his for-6.3/iov-extract again.

Honestly, it's getting tight on timing at this point, and there's also
a crash report from today:

https://lore.kernel.org/linux-block/Y+pdHFFTk1TTEBsO@makrotopia.org/

I think we'd be better off folding in this series and then potentially
pushing this series to 6.4 rather than 6.3.

-- 
Jens Axboe


