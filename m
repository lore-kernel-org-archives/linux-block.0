Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AF3C05027
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 09:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjAZJxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjAZJxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 04:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796965DC0E
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 01:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674726744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWZYDHaST13TpclKR0o87AcgsReRxfEYg2kbamKtxjw=;
        b=AtBDEYboMRa0IlO4EH28yBvnQGsUIUTQoTs2hN/Uy0d9iJ7Pt3HggE1zisyha075+2Sc0O
        P8Ou6lr6apXxOSmVCk8bAevxMSL7ynwO5sEVG5BGz8mEESpAy43SB6r4XqBbW1BY21xev2
        0LuEBwWUW8WpiLrB1e7UiYizMb+x90I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-MGdZ9LSZNy2zwjdItYqDPg-1; Thu, 26 Jan 2023 04:52:23 -0500
X-MC-Unique: MGdZ9LSZNy2zwjdItYqDPg-1
Received: by mail-wm1-f70.google.com with SMTP id o22-20020a05600c511600b003db02b921f1so2567902wms.8
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 01:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWZYDHaST13TpclKR0o87AcgsReRxfEYg2kbamKtxjw=;
        b=5wzlqNVbByyyNNSbHa8updVCh934cYaJuy0CWMkHbMrIJ1O08jfudfWraz7Cg3k1yz
         JpWxw1a2ZWecOHO1FJB/ACBZcDGvrEh4l/asiMtk5HVOg6lbgiyeRDxX/EeWikm0VQKo
         5J3pEjhde88xZayR5DfrqJ62wndsV3fM/etxzlgcNdqDwqa+tAVWseSWJNzpkhBcMlL9
         Lo2J5xzl4HTbxzYE4k08UMaQ4xWlO7tbjygelpuTfw+c9xL38+R9zBlHxofx8WX4HmFS
         VAiQ3Tfp+6uTKlUvfqwtmhm3v6hK54UzYu6pVq/s9r0rC3iRtP7hXNWPBPW6ZHCTXLrY
         NQpg==
X-Gm-Message-State: AFqh2kphsjuXeCyc/0lRex3RQiM0GASjfEtddzRkMHyFwxusvHo/aSnM
        X/dXwqIdkCbyKqAfMcI4iO6XeBh6nWT+s45P7IhEotTnO6XTYATdO2FjuUCuNLzWUaBdbU0SX5J
        gaW12l3J6k6yhkp+NAvd1DN4=
X-Received: by 2002:a5d:6e42:0:b0:2bd:fcd3:44c7 with SMTP id j2-20020a5d6e42000000b002bdfcd344c7mr29558730wrz.29.1674726742082;
        Thu, 26 Jan 2023 01:52:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt6POr1Th+z4xBilbq6MD55kPKMFdkWNrVBw8NH64BJ/rotUwhIVj/VoLFHThktbZr6ujT1Dg==
X-Received: by 2002:a5d:6e42:0:b0:2bd:fcd3:44c7 with SMTP id j2-20020a5d6e42000000b002bdfcd344c7mr29558712wrz.29.1674726741832;
        Thu, 26 Jan 2023 01:52:21 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002bfb1de74absm839299wrj.114.2023.01.26.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:52:21 -0800 (PST)
Message-ID: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
Date:   Thu, 26 Jan 2023 10:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 1/8] iov_iter: Define flags to qualify page
 extraction.
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
References: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2613249.1674726566@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.01.23 10:49, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Just a note that the usage of new __bitwise types instead of "unsigned" is
>> encouraged for flags.
>>
>> See rmap_t in include/linux/rmap.h as an example.
> 
> Hmmm...  rmap_t really ought to be unsigned int.

Not sure if that particularly matters here in practice, ... anyhow

$ git grep "typedef int" | grep __bitwise | wc -l
27
$ git grep "typedef unsigned" | grep __bitwise | wc -l
23

So chose what you prefer ;)


-- 
Thanks,

David / dhildenb

