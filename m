Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969DC05027
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 10:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjAZKmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjAZKmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 05:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB4711664
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674729704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSKGSRAw4zApLqZOZxojx5gSJ8OH2ShG8cSG815Lldg=;
        b=Y2nMHQP2QM+h4S7fN3EsURiXO0W8AWg1Iz6xu7EiBAP2owrxooH6uOAl1EEZ6tOYyyFK6/
        n4WRuLt09g2DTXgHCwKjr9GOFGvgctJhunxqZVNCtan0ICPsmfe9IipCZEYJ8N6ohbM4J6
        XpTTtN2Lvc2+7e7LJ4FBrJT3lJpD7L4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-m5cTk62WNJOIARqyM1QVSA-1; Thu, 26 Jan 2023 05:41:43 -0500
X-MC-Unique: m5cTk62WNJOIARqyM1QVSA-1
Received: by mail-wr1-f70.google.com with SMTP id o15-20020a5d684f000000b002be540246e1so208302wrw.22
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSKGSRAw4zApLqZOZxojx5gSJ8OH2ShG8cSG815Lldg=;
        b=balH09gPObn58QrLDyRfgq98itr1nMP+EkYhbYPkvELnVFrxbUS5j/CoJpq2c/GYsI
         Y9kKPXP79Y3AyCv+0p9qyACX5Q0f8lcz3wPXSJgJ/N9HsnD2Ga/zSSMS+iamxdvTzbzb
         0JjNaooqzMKHNA6FUtqOO44OiRfmy1GoT3B6LeV643xoZaTCCyynLncNzSe4P2UpIuc2
         Nw0STQhlVx8x/rvjYshd1ZrWQjN7S3KxtJQnUuXx30d4GUqUsTLzLtsD7sZAa1S8D2lB
         aI9uSLqrUcIDXcRPVxcW2Q1/XxEvGRkzL3SCj9JBa+FBVlJ0EOHpH+6e5igznn4+S5Hz
         GkjA==
X-Gm-Message-State: AFqh2kqsn85MglBHgdC7/yUTCt3+o1WsCTd+vMoyuRCBZa8TDCorjHJa
        lgTstsJa89fOj6i58FWwGcKyQhPUHZcaLgYfppHMoBV6UCCEjJZtA/CoMmxxYndRF5Vc0Gb1vWZ
        mrt01f+9L8HNFGrOSpG4w2H4=
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr33303906wmn.2.1674729702025;
        Thu, 26 Jan 2023 02:41:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWhy4TGOvCPFAbQoLxK9D8awwiSNTdJq0Nz5MUw3B7wix4cF4N7mvyXVyul/6m5yzASpKTpA==
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr33303893wmn.2.1674729701735;
        Thu, 26 Jan 2023 02:41:41 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003d9fb04f658sm4683254wmq.4.2023.01.26.02.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:41:41 -0800 (PST)
Message-ID: <b8082dcd-632b-bf75-061c-143cca6fa70d@redhat.com>
Date:   Thu, 26 Jan 2023 11:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
 <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
 <2638928.1674729230@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] iov_iter: Use __bitwise with the extraction_flags
In-Reply-To: <2638928.1674729230@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.01.23 11:33, David Howells wrote:

> Interestingly, things like __be32 are __bitwise.  I wonder if that actually
> makes sense or if it was just convenient so stop people doing arithmetic on
> them.  I guess doing AND/OR/XOR on them isn't a problem provided both
> arguments are appropriately byte-swapped.

I recall that __be32 and friends were one of the early users of 
__bitwise in the kernel. And the reason IIRC was exactly that: detect 
when no proper conversion was performed using static code analysis 
(Sparse). While some operations might make sense, the abuse is much more 
likely.


LGTM, thanks!

-- 
Thanks,

David / dhildenb

