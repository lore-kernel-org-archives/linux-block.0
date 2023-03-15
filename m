Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB83C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 19:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjCOTAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjCOS7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 14:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C35F214
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678906749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pRuFXv24zO9iZj6MhHQgS7pRqlQAfg3F2hO5yqQOu0=;
        b=OkA6u5+WAin8q0Gt3IK3KSVLwSI9TF/+CuGIi507S9m8bg4RtY4T9Oe6fnXtEnmyd8XFOQ
        ds5ym7r0rlIubsGoPnz+Jmfqhg/46k3S08J5a0QTXhV1bMb0t2Dv+bN2+CyOUVlUh7d6Ml
        aCx7MG3nk17jh1S2NyU4Y+b1aL8LpWI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-NsH8wk-uPe-WZI5Dp4EGTw-1; Wed, 15 Mar 2023 14:59:08 -0400
X-MC-Unique: NsH8wk-uPe-WZI5Dp4EGTw-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c501200b003ed24740ea4so1402225wmr.3
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 11:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906747;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pRuFXv24zO9iZj6MhHQgS7pRqlQAfg3F2hO5yqQOu0=;
        b=w9OqSF/eQBhN88pYuW64SO7vXHHeTBMxblT1vKAU2bi6NS+jaoVeVTISA81Cu+Qd5k
         a9x9soLUd5D0X2XDj3ekEw/eDPqJzMvLgzoIV+tvOBwI+95Xc9IDUx4zl4wL3JuQBCHk
         yEeKMRNr9ftheh7fxENrOtX597uzYCi0S0ACSIrw6GTP5rEY4tFuAUs4acfh8p8zuGF6
         t8+gUcoVu/xvAF/0KTCC94vJml/QCCwe/mILq3j2QOvyDEZFFf7rPc6RiGQJ5oK2HZGZ
         /XdgP7tNmsQUYQ8wY50jHnZ/3+GQppQQJwhs66lWS+RUXINUzldj5GRtGyn2W/4QSh3l
         Reow==
X-Gm-Message-State: AO0yUKWMT3Md5f81hlLjaYVby9C0XeXeQknidxPj9M+zKc00bOxNnpL6
        xB2xTmMKQFQuuk0XRopkbaSMbizicHXF2a1DgHbiyEj7GHkbk6faHtg3g0hpe7nlmZWk/rGMosU
        cxkL8OUEv7idS2QM9Uk1KBps=
X-Received: by 2002:a5d:452b:0:b0:2cf:ec84:b63a with SMTP id j11-20020a5d452b000000b002cfec84b63amr2499460wra.43.1678906746989;
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set/id0A51e2uD6Xav4KlpzhQfvsr1WBJ6M12HWKP+dMN7x79MowOlKwVntfM4m25nbOzwjbzYQ==
X-Received: by 2002:a5d:452b:0:b0:2cf:ec84:b63a with SMTP id j11-20020a5d452b000000b002cfec84b63amr2499453wra.43.1678906746804;
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d45ca000000b002ca864b807csm5451460wrs.0.2023.03.15.11.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
Message-ID: <0064f021-ac21-8bbc-5156-90328da61b8f@redhat.com>
Date:   Wed, 15 Mar 2023 19:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v19 02/15] splice: Make do_splice_to() generic and export
 it
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
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315163549.295454-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.03.23 17:35, David Howells wrote:
> Rename do_splice_to() to vfs_splice_read() and export it so that it can be
> used as a helper when calling down to a lower layer filesystem as it
> performs all the necessary checks[1].
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/CAJfpeguGksS3sCigmRi9hJdUec8qtM9f+_9jC1rJhsXT+dV01w@mail.gmail.com/ [1]
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

