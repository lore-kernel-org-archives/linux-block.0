Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C18DC636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 15:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBMPxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjBMPxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 10:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886531A964
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Fo7Ui1Nc8CjqUmKnBCjrLYrDjQgnmDeMH/tn21pLD0=;
        b=f7GEJ6S5eYq1l7fH8Bxqjd3tgHWNVFosB06aBXtFpgacyS1nD/nkAaCnf85D0Fc37zsd6G
        9Fd7eu+Y0R/ksV6+V13uQmCMhSUKNcMI29w3yK71/xbDoYHCt6GVMIIGxgJfHE2dNgc1Bk
        N2zGUaLXtgN6AeW1U5Bk20zc88jFQ08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-9BT_DnMjONGs9oLXbK2WUg-1; Mon, 13 Feb 2023 10:52:11 -0500
X-MC-Unique: 9BT_DnMjONGs9oLXbK2WUg-1
Received: by mail-wm1-f69.google.com with SMTP id j20-20020a05600c1c1400b003dc5dd44c0cso6341983wms.8
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Fo7Ui1Nc8CjqUmKnBCjrLYrDjQgnmDeMH/tn21pLD0=;
        b=Nj0KU4ocp4EU8Iu+b77yo0sIp0BxwnZY2In8k0yxMEVyWVNe/BD13V/nBaztHPOhu3
         sVXwRVybM0LpTFAqL8AJZ2X4vFqpP7YmwWbSEp+ZV46gHyUETCXllEugGhKiLF/OZ//2
         BrCscqxPnMmFxUX2wdZ7pHqnhr9ssg8D1HrN+3PsQ417e1MZhO06WVB7pt79uGaybfXF
         gDo1bD91GTzcPA8Qjq4XBkB0U3YwY+rGBDimutRPWakbulkqZhMFFJBzcHugZL249WZF
         LxDQyTbXEa/GDhDLL1+JKqkOMV0+9I8ncTvRWMJ7fIEhntrEkRQGlb7P1bbMep/t5Qpw
         1J0A==
X-Gm-Message-State: AO0yUKXz9dxpstwfMziWTjLAEcHtAJfKZ3Riw19HbLEglaG/kgOv/lU9
        TbZut38GeZpKxZ1xL3nfWu5VLQEA8PJ3AS4dhWf5G60A/Zzc8q8fG5Z16exxaAaXChNYFpnHJyd
        mA94vBR/smYMM7sOoqWAQGaY=
X-Received: by 2002:a05:600c:a694:b0:3dc:3f51:c697 with SMTP id ip20-20020a05600ca69400b003dc3f51c697mr4749405wmb.18.1676303530496;
        Mon, 13 Feb 2023 07:52:10 -0800 (PST)
X-Google-Smtp-Source: AK7set85F8cOZT0KFiY3fzKK40YD+oF9Z8F3gJ2/6lI42oq0mDsItl98By9DcQ1LzKg2GlhbwaDS0g==
X-Received: by 2002:a05:600c:a694:b0:3dc:3f51:c697 with SMTP id ip20-20020a05600ca69400b003dc3f51c697mr4749394wmb.18.1676303530262;
        Mon, 13 Feb 2023 07:52:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003cffd3c3d6csm13712133wmp.12.2023.02.13.07.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:52:09 -0800 (PST)
Message-ID: <f7a1bcad-f11c-26ab-debd-57b445a479a1@redhat.com>
Date:   Mon, 13 Feb 2023 16:52:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 4/4] splice: Move filemap_read_splice() to mm/filemap.c
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230213153301.2338806-1-dhowells@redhat.com>
 <20230213153301.2338806-5-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-5-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.02.23 16:33, David Howells wrote:
> Move filemap_read_splice() to mm/filemap.c and make filemap_get_pages()
> static again.
> 
> Requested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

