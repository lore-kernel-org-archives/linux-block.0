Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B12C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBMPts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBMPtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 10:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55A61A643
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sUpm4OM8C3gUXzYRuakEx3dra1Fn9qudKJHgMzZ+HE=;
        b=E3xlwO221Xn30jhhOd1duhBtOm12k1EaSiFyxNlbQwYShYXqtYTHMiqQdLWk/ZbPEskssj
        136tIlizUUq3FmvNvjeV1NgcoQx5ByzUDreMwd7CsBGcndxOsWko8OZVSxXowf3272Wq4k
        +5IdoOMs4WOLjIzwnzySuv2xt3XwxUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-VCdczOP8Mn-aemZmUwRq8A-1; Mon, 13 Feb 2023 10:48:46 -0500
X-MC-Unique: VCdczOP8Mn-aemZmUwRq8A-1
Received: by mail-wm1-f70.google.com with SMTP id m3-20020a05600c3b0300b003dfdc6021bcso6341041wms.3
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sUpm4OM8C3gUXzYRuakEx3dra1Fn9qudKJHgMzZ+HE=;
        b=wP7DPMDhBBLl6lkeKxOAUWBmSVqmHdObSPC1fem2BUs9TxRLnoEha0tMUR+DT4CORP
         kQ2sp3wccdfxaZar38bOXVCugvdWwV60VylZp48z1sA/j/Oak1hAjlLdDgrDcylHVfuH
         Zy+u4vOoIFox0+gHlJ/seMDnOWbDEBgrz4i+fNo7WtqTDoVwNLKZNIC5z2qbdc1B5VN4
         UGTyJV/0B3qbiDmXXy6c9w96ILkX5z5f8ebNfKautp6QGJLEeqqJGRksNzYqRTBgFRoq
         IoTbdFqqk/5RcDpX708b3NavYSJY/f3x2W4PVatHgLayIvRawtVYzQFXm9XLBEtsumGJ
         iZlA==
X-Gm-Message-State: AO0yUKXQ30q8i7kwrPFFJVD0iO/ZBEPVynFgLUDKwMa5kDZ2BZu7704K
        REnz7RUk7hacT3dxaQlpsmIkw7BAnZnprl4Q2RWxYw/AgIfiV+bpZBEwgF4SyoAGouOipGk56Wu
        tlgtsgmQ583fn6FEU/7oJeZg=
X-Received: by 2002:a5d:6e06:0:b0:2c3:e4eb:3c12 with SMTP id h6-20020a5d6e06000000b002c3e4eb3c12mr19179603wrz.64.1676303325548;
        Mon, 13 Feb 2023 07:48:45 -0800 (PST)
X-Google-Smtp-Source: AK7set8PhYzgJ6stajpIQWACA5seKzBS2Et14vSbRKWgVli14Fv6m1xvKOhu8wS5pXGt1KWXHAEmJA==
X-Received: by 2002:a5d:6e06:0:b0:2c3:e4eb:3c12 with SMTP id h6-20020a5d6e06000000b002c3e4eb3c12mr19179579wrz.64.1676303325265;
        Mon, 13 Feb 2023 07:48:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b002c55efa9cbesm1321826wrr.39.2023.02.13.07.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:48:44 -0800 (PST)
Message-ID: <463118d9-8db2-7d21-ead5-cb35c10cf3e2@redhat.com>
Date:   Mon, 13 Feb 2023 16:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] splice: Provide pipe_head_buf() helper
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
 <20230213153301.2338806-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.02.23 16:32, David Howells wrote:
> Provide a helper, pipe_head_buf(), to get the current head buffer from a
> pipe.  Implement this as a wrapper around a more general function,
> pipe_buf(), that gets a specified buffer.
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

