Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B59C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 15:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMPs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBMPs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 10:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1671D91A
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk9ZB85N8qJ1vK9VuqUk4MadsaC7d3r9I0xTkyZcACk=;
        b=UeEYGBil+Apbm0zbuz2CHbBedyVMABRMkzAxsFAdoTL+KgjflTNRaQ0WfxDSAgJo0wZ8/p
        F8ApaTq30+CHo5JkSR9E7zAkdv53doULHHYnVUwIgTrJa4Vrw8+HnbWCNnLVi4jJ9eITi8
        nI8hToldV7f9/v4bSUheDZIgSzfLRzQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-MOK3w3_VNKGPJQbSO7eeqw-1; Mon, 13 Feb 2023 10:47:32 -0500
X-MC-Unique: MOK3w3_VNKGPJQbSO7eeqw-1
Received: by mail-wm1-f72.google.com with SMTP id bi16-20020a05600c3d9000b003dfeeaa8143so6337578wmb.6
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 07:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk9ZB85N8qJ1vK9VuqUk4MadsaC7d3r9I0xTkyZcACk=;
        b=UR73lEzeLCmYBZWpgtfdV+1MfyrBhGeARPJXy9Kv4V+CEN7e+lA+pxqrY8NdAXOCS8
         LoYJl45Yuabf48XlYmsxcLm5dgHN+9FtbMxo6wVzjyMVZjloHBcK47mL5R5yF4O+xdm8
         SEMGUCPD+rfguxy4LPdT9OHa0QKVOJSbHu1IrRCq6c4vA/ZG97X0D+ApcGnDBjgsVSr6
         YsvjIiHe1NJc9RJqKokLmwjAV/dbiWaDk7s2hfe5oPWqiyT873a0QyuDpE2lC7EAt+PP
         68zLsNq/XUM1J8ZzcutVBM0/L+dpqB4kc92Cu22sjFk15MO4+/T1FKwjBZQCsHq65wBW
         bsvQ==
X-Gm-Message-State: AO0yUKX3qeRuu4gybtaCUAhIimWANR5AQhhMb6tyTXMRD5mrBGoEcoEU
        rNGkDMpabolX96ri+HSIPfR56Elpl2pL4g6q6LSJEx+lgXva1jLTyeVP7U7sFHo6r3qSnJwtoho
        p5uwv2hw+Rvdp/h9lWDAtyBE=
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18794836wrs.39.1676303249980;
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9kzLbhn6FVuDM3325N5rlxLs5gU4rYjW2jekddTSwamP6u7flJXRTM1zAOMwya96tpyHAZIg==
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18794818wrs.39.1676303249742;
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b002bff574a250sm10959411wrp.2.2023.02.13.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
Message-ID: <5f3d8009-7579-32e9-ab24-347f71fa5ce6@redhat.com>
Date:   Mon, 13 Feb 2023 16:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] splice: Rename new splice functions
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
 <20230213153301.2338806-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.02.23 16:32, David Howells wrote:
> Rename generic_file_buffered_splice_read() to filemap_splice_read().
> 
> Rename generic_file_direct_splice_read() to direct_splice_read().
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

