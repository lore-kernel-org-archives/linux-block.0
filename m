Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE0C88CB4
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 18:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjFLSQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFLSQg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 14:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC251E69
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686593750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5DZgHucTuBubeLhV3T9WqifJUJkPozlNW7FILd0G0A=;
        b=SdMkpigAwcDPvpXRDF1hefiFaEFLM4muavi5Df9ud3sniZbDgcL9eYEL4yiSwTJ0Jj6lro
        Xp23KPuck3yMknTx6dhjrIkqgiSHEP5HgXbpevNXTLSIfcPxPMw9an06rElpvgP3LWK884
        ea0mf2rIGJ6/trgDNAlwwq22C5omNO8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-dh9ceS7nN16QJLQWLYZZow-1; Mon, 12 Jun 2023 14:15:47 -0400
X-MC-Unique: dh9ceS7nN16QJLQWLYZZow-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30c6060eb32so6977943f8f.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593746; x=1689185746;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5DZgHucTuBubeLhV3T9WqifJUJkPozlNW7FILd0G0A=;
        b=f5w1d6DThwJbWU7+ya++g7SF2WgIG91qTQeWk1FJCOEMOx9OgckoCFJWQdQlUcAzZF
         nJrkDlRbpJiw5n2fjhsgh0TVfQGDHP3P1BkLkTJCtJAN4RvRC2yQbcDppEBCi05z8p6r
         QlxlIEcotPlqHAXT+XQz/leFeEPiP6RkzWms0I8i+CrkyG1BPV4y8/i44KUo/wmLfFo9
         08x0HlESKxcgxQFPv3DefmOzJ05qyu8JvBDGaU1L1JvvjImgE4XhwE5lQ++yz8HE7brA
         2CvQ7AZVe2q0C8LDUbHaNWkVtpoBsGgj01dvpFe8BBxy+w35eF4c/f0sKiUTsIQmjyb7
         G7+A==
X-Gm-Message-State: AC+VfDwTk7/lfqTLifcgpFdDxJQyqzD22r1Cn0SfwveuYegSjSF2l0UT
        /3GD8CNG7GQRPuhu+qv95kX5FQfsTliVrFhMaALXXy+h1OZXnjUM3DeYVY9U2wS4aW5q8UhJlSQ
        atPP7n+V8co0UtULtOY0Otvk=
X-Received: by 2002:a5d:6b8c:0:b0:30a:c35d:25d3 with SMTP id n12-20020a5d6b8c000000b0030ac35d25d3mr6431410wrx.52.1686593746407;
        Mon, 12 Jun 2023 11:15:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vSJr5Y6QIGD0ooXcXeEUw4NT/u47qGHunnQVuPOGrua/j9c7bMtcp+N6ji7WfRrnO5DpVNA==
X-Received: by 2002:a5d:6b8c:0:b0:30a:c35d:25d3 with SMTP id n12-20020a5d6b8c000000b0030ac35d25d3mr6431395wrx.52.1686593746063;
        Mon, 12 Jun 2023 11:15:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d4d4a000000b0030fc079b7f3sm4262655wru.73.2023.06.12.11.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:15:45 -0700 (PDT)
Message-ID: <f50b438f-90bc-36b1-c943-18d7a4b3f441@redhat.com>
Date:   Mon, 12 Jun 2023 20:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix dio_bio_alloc() to set BIO_PAGE_PINNED
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
References: <431929.1686588681@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <431929.1686588681@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.06.23 18:51, David Howells wrote:
>      
> Fix dio_bio_alloc() to set BIO_PAGE_PINNED, not BIO_PAGE_REFFED, so that
> the bio code unpins the pinned pages rather than putting a ref on them.
> 
> The issue was causing:
> 
>          WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio
> 
> This can be caused by creating a file on a loopback UDF filesystem, opening
> it O_DIRECT and making two writes to it from the same source buffer.
> 
> Fixes: 1ccf164ec866 ("block: Use iov_iter_extract_pages() and page pinning in direct-io.c")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306120931.a9606b88-oliver.sang@intel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Kara <jack@suse.cz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Jason Gunthorpe <jgg@nvidia.com>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: Hillf Danton <hdanton@sina.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   fs/direct-io.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 14049204cac8..04e810826ee8 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -415,7 +415,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>   	else
>   		bio->bi_end_io = dio_bio_end_io;
>   	/* for now require references for all pages */

Does the comment still hold?

> -	bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (dio->need_unpin)
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
>   	sdio->bio = bio;
>   	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
>   }
> 

-- 
Cheers,

David / dhildenb

