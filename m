Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE8C38142
	for <linux-block@archiver.kernel.org>; Mon, 23 Jan 2023 13:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjAWNZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 08:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAWNZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 08:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879EA244BA
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674480257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAf3V2MVK33/cJvKp6aHY4bpR+JdJT/jLy/3Pm1O1K0=;
        b=EbxXMhRtRiYzDy2F9fR304N9/g+oOp9PfPHLlQ9jRxzWuF/SbMUbDdFY3iAT5Gen9p/LpN
        kZpG9ti/U+wePKkWACqtbqvFmMxQfrinvB+aphtZT6d6Gbw7ng0SXlzeVIRWKsi1mRx8Zx
        ROqAE1GsUPEiKkGMv6hLOVsu4GRiJyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-16sCC1_oNW-eVPeDStCnJw-1; Mon, 23 Jan 2023 08:24:16 -0500
X-MC-Unique: 16sCC1_oNW-eVPeDStCnJw-1
Received: by mail-wm1-f69.google.com with SMTP id u12-20020a05600c210c00b003da1c092b83so2850652wml.7
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 05:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAf3V2MVK33/cJvKp6aHY4bpR+JdJT/jLy/3Pm1O1K0=;
        b=5qtsp2tv3GPcp/6+zLXGjIUPfV4oMju92CbHzfkj7lGBEn2d3cVCUUaqGwD/TYUYPY
         K4lMaFSURvu88DAknDyOIKuCRbjuKO0I3e58Osou4LbWvCt4o1kWWVMZlqKalDK9Bc7M
         88JlNZ41b5MkEMz8R3MnlrrgaWjTrU4oe1F6Cw7ALKwF0SOaf+E6i55PbuipFC6wOL4+
         5tSjs1i72gfmxIEs67R8EvOwB2Rd8sckFeKEO61UI0kEq2i69wB/LHY0qbjWyxoR/mfb
         mABRzzhn2kVEBZMmj4B8vTxCmJh/XJC1ax69erAHGjp+9jVDby2wsNZFfuV5WEL5Nthk
         dQ0Q==
X-Gm-Message-State: AFqh2krEKm0VuFC6GycJVoH+SGAiKbSB3sNVfyo6+hTFUp7wh9TklQzw
        3ya58cLAoy5XRPUrMDia3Vh1G681ueZezf3Q4VS6Pt7QlXIg5fOLNvlyZ7GFplq3zM8Sr6SAQRK
        PEk6h8UOLiHFN/RMlNlOI2fw=
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr19258701wru.11.1674480255377;
        Mon, 23 Jan 2023 05:24:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvSy/zF5gTuo4Pty91+hnKwsIVtv4UfaZ96iv4w0a9eQ3v+gYxG+33cMyS8lFosJqrFvgcRYQ==
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr19258685wru.11.1674480255115;
        Mon, 23 Jan 2023 05:24:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b002bdcce37d31sm33258092wrw.99.2023.01.23.05.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:24:14 -0800 (PST)
Message-ID: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
Date:   Mon, 23 Jan 2023 14:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3903251.1674479992@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23.01.23 14:19, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure what
>> the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
>> already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which does,
>> unfortunately, no reflect reality yet.
> 
> Yeah - I just came across that.
> 
> Should iov_iter.c then switch entirely to using pin_user_pages(), rather than
> get_user_pages()?  In which case my patches only need keep track of
> pinned/not-pinned and never "got".

That would be the ideal case: whenever intending to access page content, 
use FOLL_PIN instead of FOLL_GET.

The issue that John was trying to sort out was that there are plenty of 
callsites that do a simple put_page() instead of calling 
unpin_user_page(). IIRC, handling that correctly in existing code -- 
what was pinned must be released via unpin_user_page() -- was the 
biggest workitem.

Not sure how that relates to your work here (that's why I was asking): 
if you could avoid FOLL_GET, that would be great :)

-- 
Thanks,

David / dhildenb

