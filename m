Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C10C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 18:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCOS7U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCOS7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 14:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666DF7BA30
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678906705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kwq97ii9j4Uobk/QWp3tFh+rm8HJDcqt7MfCwBpcIz0=;
        b=BNEVfVUVoSfhJ4nvHsmcnSzy8MK6LYZobJeA/wv7xwwKIuuhLllVerLewR+6Hx16EKQIdT
        sPWlYhfULn0E9aQKqLwhl6Yp3EBTf0oH6lMsLopV1IVQBdD2iHDUPvzi59yh/9Ivyilc6v
        XTAxfBT7gZ4rOx4Ls8Q8YZ2Ul0+mvYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-EybIwnRVNUKPlAyLMx1U0w-1; Wed, 15 Mar 2023 14:58:24 -0400
X-MC-Unique: EybIwnRVNUKPlAyLMx1U0w-1
Received: by mail-wm1-f70.google.com with SMTP id o42-20020a05600c512a00b003ed26fa6ebdso1103710wms.7
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 11:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906703;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kwq97ii9j4Uobk/QWp3tFh+rm8HJDcqt7MfCwBpcIz0=;
        b=DKfd2r0keAm278NIU/6pr+0qAgCtOK7hs88IkqYp8yb0lsOzh2d1VYyJkxMBkiYxYS
         tkmKTivfOamxwu30ygP4jc36lGpeDBhH0XJ2UKmn1v2FA6Lh+FYomo13itK5aBsxj9U9
         yPZnbYxoNLmTJ+rftyEy0huA31YL87/+xUruoiZUg4XzZlyXVSzfqPJjHACIMlhSCqN2
         wLOqi9Hv1PvOnlcXH++DAe1bXVl9FiuWd3XIemd9/+Fe6h5nuFIHopDervDhHtc8jfUv
         TDQlR7QwbQJoBp2XAsyNuSVcUqkP6791NyBv3M41HcNqomQkaG7lB0zhnWobQUREiUE8
         u44Q==
X-Gm-Message-State: AO0yUKUFvpjHsLA6w3vjvU68io/w1MwxgunkLb9sNwmGo/WGmXn93XI7
        Hry+L2Ec88bZVaDmNSANjLORnyfo4tmd0qToqx8fiIOsc5TbNQQuNYvYuPLoKUtdmy31dgJR/83
        5fs+CHPYVfG+dxlY+ANk17VI=
X-Received: by 2002:a05:600c:3591:b0:3e2:1dac:b071 with SMTP id p17-20020a05600c359100b003e21dacb071mr15684816wmq.13.1678906703229;
        Wed, 15 Mar 2023 11:58:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set9wHxtbJeJaGu+TUflUL+yBb+lhiGSDGexB3h7ZOMkBv9oBaMw6khZUH1IgPgUBcAEXtdGuIg==
X-Received: by 2002:a05:600c:3591:b0:3e2:1dac:b071 with SMTP id p17-20020a05600c359100b003e21dacb071mr15684794wmq.13.1678906702944;
        Wed, 15 Mar 2023 11:58:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc31a000000b003eb596cbc54sm2862421wmj.0.2023.03.15.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:58:22 -0700 (PDT)
Message-ID: <c1006976-8166-ca52-33db-d2eda8d8792e@redhat.com>
Date:   Wed, 15 Mar 2023 19:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v19 01/15] splice: Clean up direct_splice_read() a bit
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315163549.295454-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.03.23 17:35, David Howells wrote:
> Do a couple of cleanups to direct_splice_read():
> 
>   (1) Cast to struct page **, not void *.
> 
>   (2) Simplify the calculation of the number of pages to keep/reclaim in
>       direct_splice_read().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

