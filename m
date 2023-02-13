Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A87C636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjBMPvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMPvk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 10:51:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0519F1C301
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DRobMP9lFTyOx+d42PXwNgf2chEzLFnyo1NLv/1B+k=;
        b=RoqkZ6XOQOttG2/+6w3bb8ec0ermHzWFUZOYtZSN/D2+R+23Z3hdfw3JFajfnduyz0jZTq
        iZk/eRtcq91cX8Uu0khZlsP91m1e5CHtKIil9gsoyTCDrSowwqUlPtrQvirXAr882SqAq4
        O9dqSe/YD2UUYjpQjF/8kvyguv2ASF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-OQhbcckFNoaWPxYkPfmwwA-1; Mon, 13 Feb 2023 10:50:49 -0500
X-MC-Unique: OQhbcckFNoaWPxYkPfmwwA-1
Received: by mail-wm1-f69.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so9345528wms.4
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DRobMP9lFTyOx+d42PXwNgf2chEzLFnyo1NLv/1B+k=;
        b=zJWzJwatuXtfCu67jYqp2DeaWhF4ZrdSZmUhN0Tgtx/+4acvD8mE8lis4gU/ZTDAH8
         pgzbGynjn8RrH4WihzoLaC4HAUPJHw/F/BM8ZlGgowZ/3X6tqgAXbXss1Rb9sAeNqKv3
         eOiVnQVlSbE4wbRxxE7X+Z+0wfHttp0I/ZeGoZdWVmn+hT6xf1H0TKQbX8XBmrRX5ExN
         YIkh0UfkpxfTrV0oxqLMOCAqQbscV7DYLeSVGrJLgl8tJ7mSsy2vXFW+JrguEqVegkhU
         XHi8qiEkQP8yc2vkKLGxgiOPhn2Sc4sKAEpJkucfeVRm3F84R2UI5TbyA+oUpAfoHB4D
         BIjQ==
X-Gm-Message-State: AO0yUKVc8+qdWjvzeLE3khmzIXH/GtOm44N6HtZVvkF6STqcPrrTFeUA
        luscURbFXO84JSgnzJuUBbJMz7yuSie8sQsTV8E/qt/CSNkjojugb+2r0iBZJ8M2YOSFWlyGG1v
        SLwIAbe0ifoS23pURSqhsphc=
X-Received: by 2002:adf:f20f:0:b0:2c5:4f48:cbb2 with SMTP id p15-20020adff20f000000b002c54f48cbb2mr6716143wro.51.1676303448320;
        Mon, 13 Feb 2023 07:50:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/7z1HvwRarE22I8DRgZXVSpvDKauYENM9qNJSPZT8aqTzhz5RxouJn81sKN7pWwJL2Ogwlmg==
X-Received: by 2002:adf:f20f:0:b0:2c5:4f48:cbb2 with SMTP id p15-20020adff20f000000b002c54f48cbb2mr6716117wro.51.1676303448102;
        Mon, 13 Feb 2023 07:50:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600011c400b002c556f36116sm3691159wrx.66.2023.02.13.07.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:50:47 -0800 (PST)
Message-ID: <3b0e92b5-4b9c-d3aa-8f30-074d538bb82d@redhat.com>
Date:   Mon, 13 Feb 2023 16:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/4] splice: Use init_sync_kiocb() in
 filemap_splice_read()
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
 <20230213153301.2338806-4-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-4-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.02.23 16:33, David Howells wrote:
> Use init_sync_kiocb() in filemap_splice_read() rather than open coding it.
> 
> Requested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
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

