Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07FC25B4E
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 13:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjAXNgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjAXNgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 08:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26C9ED2
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674567316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+49GU/bWvRMCUzhe+Y9CTW+q6X2/aURqYv1fh7nN+o=;
        b=NMf3u8KD27IEk3MQ0Z0SGHnY1KfSwyL7aw/7TLmUrWUR6WhMN0hWKArMWWkCgfWBsaSh7Y
        k0z5ii9wbNdo/z3c4ev9n51IiAFaltsyRdPRZZ0D3AeCoGsBVocF8z+dOCicxhgYecBgKq
        fyOHZcC9d1mdRUpysVu2A2cAFU38XSs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-eFUOoKeWPpKP3lyal3cgXA-1; Tue, 24 Jan 2023 08:35:14 -0500
X-MC-Unique: eFUOoKeWPpKP3lyal3cgXA-1
Received: by mail-wr1-f69.google.com with SMTP id e29-20020adf9bdd000000b002bb0d0ea681so2623718wrc.20
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 05:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+49GU/bWvRMCUzhe+Y9CTW+q6X2/aURqYv1fh7nN+o=;
        b=gHAGp32Yr2tLxBLdy0IlcJf5pQuYpMNdtU/EIcI0KIo01uThU22U6OUjbKk5ZY/Gdm
         rwjtABVe2x+PD8g/4z0yVh/Ndz36pspOMEVz4W/XilqX11M8bVjMmC74SyRAboF0183T
         Hcv/SGoCqQ7niz4icfg2fslBJ6dwjqer4Lj82ZVC9Xfo6+92881h/qKmydwSgRnnQ2Sw
         iR2Ui+O2zk9zJAFSSf4aeqojVixSFKkjiyRA/s+mx1tt5NzuPnrOTSu+8AvaAbxDBpAq
         gbrEIXyilmmsM5viSI1RabPDx0eaLIoyhZldSpj+E+wWaQGEhzPNm5fC4QRZJQPhLEVm
         1dng==
X-Gm-Message-State: AO0yUKVTRGfzOtU0QHcnLry3CEuQAPa1we+Zr/5IkbMc+xMU79g3FkYk
        anP1DOBBcsKDXGjikp6k8kOqoHvuTu8RTRB0bIH/pSADrKuLjgcumB0/ONuQpwgmrZg+Qwvbe/z
        DkjQF286QRC39v5PsLEp6HFg=
X-Received: by 2002:adf:cd81:0:b0:2bf:b1a1:efd1 with SMTP id q1-20020adfcd81000000b002bfb1a1efd1mr1835787wrj.1.1674567313539;
        Tue, 24 Jan 2023 05:35:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/1xONmKmEswh8jWkK0YJc1PVGI0yGZMBR0M8Flc4oZo8a+s4iuTABU8VTpp7zxi7od0H5P3g==
X-Received: by 2002:adf:cd81:0:b0:2bf:b1a1:efd1 with SMTP id q1-20020adfcd81000000b002bfb1a1efd1mr1835768wrj.1.1674567313259;
        Tue, 24 Jan 2023 05:35:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d690e000000b002bdd96d88b4sm1861572wru.75.2023.01.24.05.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:35:12 -0800 (PST)
Message-ID: <c253e119-d5d9-df22-e885-60b153ae5bf7@redhat.com>
Date:   Tue, 24 Jan 2023 14:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123173007.325544-1-dhowells@redhat.com>
 <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
 <Y8/aSZBVVF7NpDQ0@infradead.org>
 <0c043cfb-2cdb-8363-2423-d1510006fc06@redhat.com>
 <Y8/eAEfzOICZ+PSo@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y8/eAEfzOICZ+PSo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24.01.23 14:32, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 02:22:36PM +0100, David Hildenbrand wrote:
>>> Note that while these series coverts the two most commonly used
>>> O_DIRECT implementations, there are various others ones that do not
>>> pin the pages yet.
>>
>> Thanks for the info ... I assume these are then for other filesystems,
>> right? (such that we could adjust the tests to exercise these as well)
> 
> Yes.  There's the fs/direct-io.c code still used by a few block based
> file systems, and then all the not block based file systems as well
> (e.g. NFS, cifs).
> 
>> ... do we have a list (or is it easy to make one)? :)
> 
> fs/direct-io.c is easy, just grep for blockdev_direct_IO.
> 
> The others are more complicated to find, but a grep for
> iov_iter_get_pages2 and iov_iter_get_pages_alloc2 in fs/ should be a
> good approximation.

Right, iov_iter_get_pages2() includes vmsplice() that still needs love. 
Thanks!

-- 
Thanks,

David / dhildenb

