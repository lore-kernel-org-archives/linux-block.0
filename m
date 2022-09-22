Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B54C6FA86
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiIVOoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiIVOoE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F37EFD2
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663857843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2A8ib/cugNV2ErbC2kQ1gu2unsdhUUMjY2O8jgaTH4=;
        b=WeuRyATR50H5n0LgL3ausFVHzRN/yuCFx0TswGcEmaCr1MJYfvJCWKYLv+S8aUNwo1aNbI
        0JP5nYgGGYBYVOs5yPb6I51gc93bhuyOQ7tqPRwgO5VWcKB5y/KwmqWsbbVxc6sGYBsJcx
        bc+79GA+psboIugfDg/RQbWbQz0rS+k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-GSnU-Xg7P8iFXyK11uZfhA-1; Thu, 22 Sep 2022 10:44:01 -0400
X-MC-Unique: GSnU-Xg7P8iFXyK11uZfhA-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso4165806wma.4
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=p2A8ib/cugNV2ErbC2kQ1gu2unsdhUUMjY2O8jgaTH4=;
        b=ca5Js1sKj+qNL0OMAmWDK0PsVrpJgbYgydQienQE2IRfV153OqxGSHz6YQfp91bbwg
         hCqWNG3tydka8aK9KUiFUKlPV/ClfVu4vluIOu4dl0RQb+B1wQfv8SfRkO6h9vamJSW9
         IdwiVpRx36pm0Vb/LHEvh+S7nQXoAfXXEJDlEppqOTliU++vDO/Th8udcjbj//ojcy3Q
         mFV+W6/usokfwuiZ/jWajVFPvkmLlYyBk/cozah+iJuOTqeFn+vQmX9XJV9ECNA0zxLP
         S/BCGsrO6PAnAfOEochBNgr6erC5RDr2hp80U8nqLunYQ9RL0QY1JfumOwK4ONn5EJs3
         ng4Q==
X-Gm-Message-State: ACrzQf0oj7obQueAcOyy+9bKC4xWeoeIWLrvap8qECaG6gRBHg94DOTB
        nDswtxWLBLX2PzG6yUmmzZfeU3vDu1qkehkRyVndd/XQN4cypgBDgkpgFobhl0IPNlmbIslwACU
        Kj3fDKwX4FbhaEkZyM33qDyw=
X-Received: by 2002:a05:600c:2f9a:b0:3b4:9bd5:1472 with SMTP id t26-20020a05600c2f9a00b003b49bd51472mr9645499wmn.171.1663857839393;
        Thu, 22 Sep 2022 07:43:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5o4VzvITb4v+qMFBul+jkICLZk4bPuQBJUlc1tPdug69EqbcVtIdL50GRz0adhdxK+x9p6Zg==
X-Received: by 2002:a05:600c:2f9a:b0:3b4:9bd5:1472 with SMTP id t26-20020a05600c2f9a00b003b49bd51472mr9645473wmn.171.1663857839149;
        Thu, 22 Sep 2022 07:43:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:2200:d595:cc20:2e3a:fc5f? (p200300cbc7082200d595cc202e3afc5f.dip0.t-ipconnect.de. [2003:cb:c708:2200:d595:cc20:2e3a:fc5f])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003a5f3f5883dsm6298293wmo.17.2022.09.22.07.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:43:58 -0700 (PDT)
Message-ID: <c100fcd6-60fb-6650-fdac-7cc3a3bbc464@redhat.com>
Date:   Thu, 22 Sep 2022 16:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org> <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org> <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3> <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3> <YyPXqfyf37CUbOf0@ZenIV>
 <YylJU+BKw5R8u7dw@ZenIV> <Yyxy4HFMhpbU/wLu@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yyxy4HFMhpbU/wLu@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.09.22 16:36, Christoph Hellwig wrote:
> On Tue, Sep 20, 2022 at 06:02:11AM +0100, Al Viro wrote:
>> nvme target: nvme read requests end up with somebody allocating and filling
>> sglist, followed by reading from file into it (using ITER_BVEC).  Then the
>> pages are sent out, presumably
> 
> Yes.
> 
>> .  I would be very surprised if it turned out
>> to be anything other than anon pages allocated by the driver, but I'd like
>> to see that confirmed by nvme folks.  Probably doesn't need pinning.
> 
> They are anon pages allocated by the driver using sgl_alloc().

I assume they are not anon pages as in "PageAnon()", but simply not 
pagecache pages, correct?

-- 
Thanks,

David / dhildenb

