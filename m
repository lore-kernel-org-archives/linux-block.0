Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F02FC77B7C
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 07:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjEXHID (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbjEXHH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 03:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1E90
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684912001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjhHjHBMY39aJuSZuOz+uNWhK5sxOn0xoRbBRqqPSZg=;
        b=HNqocnUUPsx81Rii0CrhS2I2Wrgc/kLK8Sd84kTtc7m3+VOkyBzkigH3kGh/FhKpjO218l
        eOz9gaeLENPGsbJKDAAm0RBQo/FMNfmnmi80R9OUBLvRrDcZFK36iBQ/HpbF2WODDsOvW6
        1C/lykFWsZcHiNHrgY4v8g8X7waD7lQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-QvPmOuXIO_WyzqecC3Ydzw-1; Wed, 24 May 2023 03:06:39 -0400
X-MC-Unique: QvPmOuXIO_WyzqecC3Ydzw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f603b8eb61so3796605e9.0
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911999; x=1687503999;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjhHjHBMY39aJuSZuOz+uNWhK5sxOn0xoRbBRqqPSZg=;
        b=GYlVPGv2JSYZB5R5fSOL0QI6qMo/bxyhfv+rZrOGEG/+XraW2m22Ae+q17AU1U4JCE
         7Muroyrk+vUJD3da19R6bAjSjicwlQMc3dw5d+hcTQLEBhSZTp6lECdK1ruu3o13JjsN
         /JS1YKBYBPKoYebmtdA1keBXRzXg3qIlXVpbANKv+narjz/2voTyALP4u5QiBJXMYRuH
         UOzKAQ8D4ThQA4WSvecg3OlnuAjhB96JKUweJp4aubST5wXyphP9MDot9d1KLQHgVm2O
         Pi57pWwrrU88KFiS/SAIkI42S8DAZsDM/iKXRMZbaO5cEafMnc8mio4KCiQLoWn1o5pf
         c3nA==
X-Gm-Message-State: AC+VfDwFZfbfNPkMgj0Fadw5RuQ9DfrqGW9lI2MqFdrjdKaMu8SJaVGG
        3VwlPKGW8qhAMZTNFYbN9PIfi9CQfH6EDkXcgAimAuhxSUN2pUGMucrrGOP5k1rGPETDW+XL/fi
        Mq9ou0QboaEo25/EDCKniYM8=
X-Received: by 2002:a7b:cd01:0:b0:3f1:72ec:4009 with SMTP id f1-20020a7bcd01000000b003f172ec4009mr11268155wmj.9.1684911998685;
        Wed, 24 May 2023 00:06:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7V6VeTW9TIXyu+6RB5cNPwFpMMHuHEbMO29YN09EiaTzY9XRov0K5pXdabLvAWr7aHZwRaiA==
X-Received: by 2002:a7b:cd01:0:b0:3f1:72ec:4009 with SMTP id f1-20020a7bcd01000000b003f172ec4009mr11268140wmj.9.1684911998304;
        Wed, 24 May 2023 00:06:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b003f4e8530696sm1199877wmj.46.2023.05.24.00.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 00:06:37 -0700 (PDT)
Message-ID: <5c4160cc-6aec-f6a6-8bab-b0bf201a037c@redhat.com>
Date:   Wed, 24 May 2023 09:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <ZGxfrOLZ4aN9/MvE@infradead.org>
 <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Extending page pinning into fs/direct-io.c
In-Reply-To: <3068545.1684872971@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23.05.23 22:16, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> But can you please also take care of the legacy direct I/O code?  I'd really
>> hate to leave yet another unfinished transition around.
> 
> I've been poking at it this afternoon, but it doesn't look like it's going to
> be straightforward, unfortunately.  The mm folks have been withdrawing access
> to the pinning API behind the ramparts of the mm/ dir.  Further, the dio code
> will (I think), under some circumstances, arbitrarily insert the zero_page
> into a list of things that are maybe pinned or maybe unpinned, but I can (I
> think) also be given a pinned zero_page from the GUP code if the page tables
> point to one and a DIO-write is requested - so just doing if page == zero_page
> isn't sufficient.
> 
> What I'd like to do is to make the GUP code not take a ref on the zero_page
> if, say, FOLL_DONT_PIN_ZEROPAGE is passed in, and then make the bio cleanup
> code always ignore the zero_page.

We discussed doing that unconditionally in the context of vfio (below), but vfio
decided to add a workaround suitable for stable.

In case of FOLL_PIN it's simple: if we detect the zeropage, don't mess with the
refcount when pinning and don't mess with the refcount when unpinning (esp.
unpin_user_pages). FOLL_GET is a different story but we don't have to mess with
that.

So there shouldn't be need for a FOLL_DONT_PIN_ZEROPAGE, we could just do it
unconditionally.

> 
> Alternatively, I can drop the pin immediately if I get given one on the
> zero_page - it's not going anywhere, after all.

That's what vfio did in

commit 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Mon Aug 29 21:05:40 2022 -0600

     vfio/type1: Unpin zero pages
     
     There's currently a reference count leak on the zero page.  We increment
     the reference via pin_user_pages_remote(), but the page is later handled
     as an invalid/reserved page, therefore it's not accounted against the
     user and not unpinned by our put_pfn().
     
     Introducing special zero page handling in put_pfn() would resolve the
     leak, but without accounting of the zero page, a single user could
     still create enough mappings to generate a reference count overflow.
     
     The zero page is always resident, so for our purposes there's no reason
     to keep it pinned.  Therefore, add a loop to walk pages returned from
     pin_user_pages_remote() and unpin any zero pages.


For vfio that handling no longer required, because FOLL_LONGTERM will never pin
the shared zeropage.

-- 
Thanks,

David / dhildenb

