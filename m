Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FA3EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 14:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGTOwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjGTOwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 10:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA62713
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689864694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkiNNvhZXBOhwappo5DsNfWFblN13jxPHvb5/iriC0Y=;
        b=VocUckPowaQyB9yrnL79v6fwLPnFNx4VQiVbf1dzJRob3jMWqtemnaB7O5Oe+pcpHidqoq
        Ees2sRGi/r8AVZhPD/kJmMYOorJCli1BhQZKSr1DRU2JMInwQOBelIYpwk3Vab2a5O2fpd
        Tu4LKrs1KvAoGdOEQWA3+PopAMMX6SQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-7hz3kwGiPiKOA4fhkmnQgQ-1; Thu, 20 Jul 2023 10:51:33 -0400
X-MC-Unique: 7hz3kwGiPiKOA4fhkmnQgQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e664d2f8so11053696d6.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864692; x=1690469492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkiNNvhZXBOhwappo5DsNfWFblN13jxPHvb5/iriC0Y=;
        b=Ecp+QOJhqIr0PgOnGl7NOhPIuFHIDBkpAtdwbFaBh1DyXivHl1MqxpLT+4UQ6cJh7L
         FCJnLLbfN8lp3Kr3bCLcPZUwX4LHPS7JpGUi2d0YSSnLdCsIMp2Mnfk/893Iimo3vLch
         fOc+G5sFeGKonHhBcNMDaVXzZeFP6ScdLQnNwn0AxnHlbmLdp0BpT4eApqZCRjB+FaKv
         +xCm6tnAddthRjzxRlSJPcMvpdNVH9qejHWc+/jUtdyvI+zwMtCSuhuyOWQW2WPUvRXy
         y1CRt6pWmbFcn7l+0nQ5MZTSiMixKBXbkqvWVETvPBx/HszVUxN6BmYpcn6FC8rIeTq7
         BVKQ==
X-Gm-Message-State: ABy/qLa/FR0IcsSthLixkS6AvAp249agKsX+R74m5plwOP1Xj6rg8H40
        K4ogRgJImgt3DHus7excfEBzQV7dj191qAafnqQCelt3VlQPPDO67NFTKyKnjgxG47Dpb3Fl965
        tWmyGgnt16UU5TlbGm5xjcFhZkl5y+VgfIA==
X-Received: by 2002:a0c:e012:0:b0:63c:c041:ef7c with SMTP id j18-20020a0ce012000000b0063cc041ef7cmr4998993qvk.16.1689864692600;
        Thu, 20 Jul 2023 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG9WiVjMAJC0jyp6FJ1iLPNYyic/lNvrnvPP6HMAfS4d7vXSpGs/eQms+dzXXL9v8chg2XyA==
X-Received: by 2002:a0c:e012:0:b0:63c:c041:ef7c with SMTP id j18-20020a0ce012000000b0063cc041ef7cmr4998979qvk.16.1689864692339;
        Thu, 20 Jul 2023 07:51:32 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id u4-20020a0cf1c4000000b006375f9fd170sm429007qvl.34.2023.07.20.07.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:51:31 -0700 (PDT)
Message-ID: <251d9862-e335-243e-d65a-c5538b4df253@redhat.com>
Date:   Thu, 20 Jul 2023 09:51:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: allow building a kernel without buffer_heads
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>
References: <20230720140452.63817-1-hch@lst.de>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20230720140452.63817-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/23 9:04 AM, Christoph Hellwig wrote:
> Hi all,
> 
> This series allows to build a kernel without buffer_heads, which I
> think is useful to show where the dependencies are, and maybe also
> for some very much limited environments, where people just needs
> xfs and/or btrfs and some of the read-only block based file systems.
> 
> It first switches buffered writes (but not writeback) for block devices
> to use iomap unconditionally, but still using buffer_heads, and then
> adds a CONFIG_BUFFER_HEAD selected by all file systems that need it
> (which is most block based file systems), makes the buffer_head support
> in iomap optional, and adds an alternative implementation of the block
> device address_operations using iomap.  This latter implementation
> will also be useful to support block size > PAGE_SIZE for block device
> nodes as buffer_heads won't work very well for that.
> 
> Note that for now the md software raid drivers is also disabled as it has
> some (rather questionable) buffer_head usage in the unconditionally built
> bitmap code.  I have a series pending to make the bitmap code conditional
> and deprecated it, but it hasn't been merged yet.
> 
> Changes since v1:
>   - drop the already merged prep patches
>   - depend on FS_IOMAP not IOMAP
>   - pick a better new name for block_page_mkwrite_return
> 
Hi Christoph,

Gfs2 still uses buffer_heads to manage the metadata being pushed through 
its journals. We've been reducing our dependency on them but eliminating 
them altogether is a large and daunting task. We can still work toward 
that goal, but it will take time.

Bob Peterson

