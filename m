Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9DC05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 09:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBNJKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 04:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjBNJJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 04:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3B11EB3
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 01:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676365667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXhjJZ2GdnHCbU45RiKd1H4tJiPK57eePtUK3Fm9rk4=;
        b=gDgLeUj7SZrZ3qootVx5MFq+Mn1gcNqbJIFNXC9NGLJDM3gltyigUxKelNj9hmsF9vgPXp
        7LNoqjqO06U1qn/QgD6fJWBsaMKqznpzzhUm0TOoFxtzKrzOPObGyBtVWe2Ri9pipzG+lV
        IbP0eK5nIalpuxe5MwtxT1WxF2NfuHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-sCU8rQjfNNGYjqvjLJ0d-Q-1; Tue, 14 Feb 2023 04:07:44 -0500
X-MC-Unique: sCU8rQjfNNGYjqvjLJ0d-Q-1
Received: by mail-wm1-f70.google.com with SMTP id t18-20020a05600c451200b003e1f2de4b2bso1353490wmo.6
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 01:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXhjJZ2GdnHCbU45RiKd1H4tJiPK57eePtUK3Fm9rk4=;
        b=29gUGyRZL8J7Tk3zIwGnGoOEUhLlUwKPy065WD/BR5XAXuUq8bnLxP+SBiA8y8qkXX
         xQCmpTsYda9JD0ws4qQl/5rcgrJ2D5PgDfmjbkDRvht2O8QPgz9FvGmlGQJMB/e9YUeZ
         y/at8bBsEAthYYw/K7vPR2Q0OMIS8bnTFBqXi8BEn+Yf1iv6cX+iM0/e3MeUErjnlRGc
         v3hWc3QTuUaoVA/YyCp+oSH8TmzwkF36QyMANPwY/PcFVVVXdz2HSY84ZyPs5UfPab3u
         6n8qYuIpW3APxWjNKMFarx8O4nubgD2UNKFrhOgBaqXfmXJqZ2NqT3pHGqwkNUE9jQJh
         aGqQ==
X-Gm-Message-State: AO0yUKVfWkYvIDUAE8N3RzoYTVM3LmSYF3Wu/AKeNRnlYHaGE0JMkSMb
        Ns4/lixiy3wJTvgDqSUOkA33RftGtYtxi/D7cPv/AwBMcJ8vcwtfQ17ZrtKy5RDYdDoocd9WXQ2
        fabvej3fohCpnj4ItEt2/qdw=
X-Received: by 2002:a5d:46d2:0:b0:2c5:4b93:1f4 with SMTP id g18-20020a5d46d2000000b002c54b9301f4mr1673345wrs.58.1676365663047;
        Tue, 14 Feb 2023 01:07:43 -0800 (PST)
X-Google-Smtp-Source: AK7set9tKSS15UUZyB55NrmYIY9oMjNB9gXG+WnOns1nL3MBlxyjxsKbgGdScR9/PpTqD72Icq0ULQ==
X-Received: by 2002:a5d:46d2:0:b0:2c5:4b93:1f4 with SMTP id g18-20020a5d46d2000000b002c54b9301f4mr1673316wrs.58.1676365662594;
        Tue, 14 Feb 2023 01:07:42 -0800 (PST)
Received: from [192.168.3.108] (p5b0c60e7.dip0.t-ipconnect.de. [91.12.96.231])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b002c569acab1esm265077wro.73.2023.02.14.01.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:07:42 -0800 (PST)
Message-ID: <75d74adc-7f18-d0df-e092-10bca4f05f2a@redhat.com>
Date:   Tue, 14 Feb 2023 10:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/5] iov_iter: Adjust styling/location of new splice
 functions
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230214083710.2547248-1-dhowells@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214083710.2547248-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14.02.23 09:37, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> Here are patches to make some changes that Christoph requested[1] to the
> new generic file splice functions that I implemented[2].  Apart from one
> functional change, they just altering the styling and move one of the
> functions to a different file:
> 
>   (1) Rename the main functions:
> 
> 	generic_file_buffered_splice_read() -> filemap_splice_read()
> 	generic_file_direct_splice_read()   -> direct_splice_read()
> 
>   (2) Abstract out the calculation of the location of the head pipe buffer
>       into a helper function in linux/pipe_fs_i.h.
> 
>   (3) Use init_sync_kiocb() in filemap_splice_read().
> 
>       This is where the functional change is.  Some kiocb fields are then
>       filled in where they were set to 0 before, including setting ki_flags
>       from f_iocb_flags.
> 
>   (4) Move filemap_splice_read() to mm/filemap.c.  filemap_get_pages() can
>       then be made static again.
> 
>   (5) Fix splice-read for a number of filesystems that don't provide a
>       ->read_folio() op and for which filemap_get_pages() cannot be used.
> 
> I've pushed the patches here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract-3
> 
> I've also updated worked the changes into the commits on my iov-extract
> branch if that would be preferable, though that means Jens would need to
> update his for-6.3/iov-extract again.
> 
> David
> 
> Link: https://lore.kernel.org/r/Y+n0n2UE8BQa/OwW@infradead.org/ [1]
> Link: https://lore.kernel.org/r/20230207171305.3716974-1-dhowells@redhat.com/ [2]
> 
> Changes
> =======
> ver #3)
>   - Fix filesystems/drivers that don't have ->read_folio().
> 
> ver #2)
>   - Don't attempt to filter IOCB_* flags in filemap_splice_read().
> 
> Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.com/ # v1
>

You ignored my RB's :(

.. but unrelated, what's the plan with this now? As Jens mentioned, it 
might be better to wait for 6.4 for the full series, in which case 
folding this series into the other series would be better.

-- 
Thanks,

David / dhildenb

