Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7E8EED615
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 15:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjIOPoo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjIOPoS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 11:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2BE6E66
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694792609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HjRpUexdgJAehf7Qv6azxAmOLDK2cUSsvpp8na9Sbw=;
        b=ZXy+ivzxK2EkOAunbC5FBqgeuhhNxsjErtQzR9xRpkYYliR13ZQJqT9jPAbAvEkyUljA90
        z4n1h8ZV8lIDzIwZx7gKWZVQ2L1QyC0yM0S6MyF0kWJ1owXXXllTKRZ6ilVzJtbmMNURVE
        TeoVHZUOR8EwyELlT34Izw1E9ZGas5A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-o3_pQrC9MUC2ryXEhhziUQ-1; Fri, 15 Sep 2023 11:43:24 -0400
X-MC-Unique: o3_pQrC9MUC2ryXEhhziUQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5009121067cso2733454e87.2
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792603; x=1695397403;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HjRpUexdgJAehf7Qv6azxAmOLDK2cUSsvpp8na9Sbw=;
        b=sM9RncIAlGe7GhFFWoo9QSfxMt2Tlh2zQfrsUSnyTrV5nrv5+xDyH8UppgKwKZH9UM
         +AkEKb+WgfMeROb+0Agh0K47TGt9FEr3NnBMEX3ttl4KxWSXvdlGZ59Jjx+Vg6iYfIAE
         HNcVbUBGSda+jVVPeHa4DDJo5nsqPmD3XfQUJBlnvuDj7LQIm0xIl3dh9I89AWMmTUQ2
         4TgvvxV5+4sugmyC1wOURGBCWDDdt0t3eacQkDvkiJXnzLfxNb1kIZJo1kdBd+MxO8hE
         D27rPVsU1Hq/8gQdtcSkKhTarmFvu8Arqe8b5TZTiM+ZuRXJiHZ2Db3Vo4deeW2eN+Qg
         YD+w==
X-Gm-Message-State: AOJu0Ywy+N4GAD1YFEx750FD9GDVuOYpFKAmXhUYTsduHm4PeUgSHH90
        laOiMxJAEI5rNJQ1aPnt+186PWPKIBsUdY1fJr3vdpckH7se1zQQgmlOqO8q2o/s31pxAkeeDIY
        x30vOWAk5O8MmcMPCpz0u0IQ=
X-Received: by 2002:a05:6512:2528:b0:4fd:f84f:83c1 with SMTP id be40-20020a056512252800b004fdf84f83c1mr1921022lfb.64.1694792603012;
        Fri, 15 Sep 2023 08:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUlzqnI9IhxadefzLCHSEYLKXLnj68ovmQNeMXOp3JfxSWFhttFec7rrRBDh3udFZ2SJb/Tg==
X-Received: by 2002:a05:6512:2528:b0:4fd:f84f:83c1 with SMTP id be40-20020a056512252800b004fdf84f83c1mr1920990lfb.64.1694792602530;
        Fri, 15 Sep 2023 08:43:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70? (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de. [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
        by smtp.gmail.com with ESMTPSA id x25-20020ac24899000000b004fb738796casm685274lfc.40.2023.09.15.08.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:43:22 -0700 (PDT)
Message-ID: <15b067d7-8f95-d409-64be-d22359f0942a@redhat.com>
Date:   Fri, 15 Sep 2023 17:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
 <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
 <ZQR5nq7mKBJKEFHL@casper.infradead.org>
 <a5c37d6e-ca0f-65cf-a264-d1220d3c3c6d@redhat.com>
 <ZQR7CyddIQQAs3yb@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQR7CyddIQQAs3yb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.09.23 17:40, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 05:36:27PM +0200, David Hildenbrand wrote:
>> On 15.09.23 17:34, Matthew Wilcox wrote:
>>> No, it can't.  This patchset triggers only on write, not on read or page
>>> fault, and it's conservative, so it will only allocate folios which are
>>> entirely covered by the write.  IOW this is memory we must allocate in
>>> order to satisfy the write; we're just allocating it in larger chunks
>>> when we can.
>>
>> Oh, good! I was assuming you would eventually over-allocate on the write
>> path.
> 
> We might!  But that would be a different patchset, and it would be
> subject to its own discussion.
> 
> Something else I've been wondering about is possibly reallocating the
> pages on a write.  This would apply to both normal files and shmem.
> If you read in a file one byte at a time, then overwrite a big chunk of
> it with a large single write, that seems like a good signal that maybe
> we should manage that part of the file as a single large chunk instead
> of individual pages.  Maybe.
> 
> Lots of things for people who are obsessed with performance to play
> with ;-)

:) Absolutely. ... because if nobody will be consuming that written 
memory any time soon, it might also be the wrong place for a large/huge 
folio.

-- 
Cheers,

David / dhildenb

