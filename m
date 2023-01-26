Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B1DC54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 09:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjAZJ33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjAZJ32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 04:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E781F4BC
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 01:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674725306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlpy8oMhkjt4kiolXYLNtGmM2K2CX6szoOfA13GZPeI=;
        b=B7kaUqG0fklbT/E6lhPQuyZI5tGPEHF9NqVmygSGzr+1tA1cSM9BlgDRtDhfyIrTFUizlY
        2lVSSg6JyGEaomCAfIUaMoCQdY6GyQn4WM4zJn4M2sjYEsVMGQaNC+xNysEcfXPFRhtmED
        KMNh98ypluaCGVOk8u3tUBclcbXTcYA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-nzjjwpJHMVWiTOQJqCM3Tw-1; Thu, 26 Jan 2023 04:28:25 -0500
X-MC-Unique: nzjjwpJHMVWiTOQJqCM3Tw-1
Received: by mail-wm1-f69.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso755343wms.4
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 01:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlpy8oMhkjt4kiolXYLNtGmM2K2CX6szoOfA13GZPeI=;
        b=tS22DSAbiUOZKE5vXFTEMjQYHkOAY67Dowoh1L8IIsCfnHNbRxZjigqPliIyVfNLPl
         5rBfrOorqq627AXaavX0AZMDZlvgArhnioJky5+wFuOnKgB0qIqJzAAhApZME8mk2OMD
         +k1EoJ6UU+d+/VnthvPxjzQMPyT9vkPPjFzPk95Ta6ZkExxtZprxhs1o3Pf33+UEUkk6
         6hdi3UzdjoP+TmlW9OphScqjIWce65Bxqq+Oq/QwUd+G/Z2To7FAw6DaAA4aT3HHFwQV
         hlFBpx42CozFxxiPxBgvCkJlHgzIPM13blNb8+wAWFqNgnQy3AbfxreuJxzSDPCdmcTS
         0yKA==
X-Gm-Message-State: AFqh2kq2Vp8rivtO0+m/CkBOqIw1/sF3yJeT/HwaxsfOto2H0Kqkkgqf
        k/J4lKgOXZjm1FDgBuxCvzmH1AWuidgMYGn5DERnFCYcG6h4FQnw3g61zBcjV03Y0NY9FE+7l2S
        XABDC+5Dhuf5IB+/tV/MNOIU=
X-Received: by 2002:a5d:6b09:0:b0:2be:110d:5d59 with SMTP id v9-20020a5d6b09000000b002be110d5d59mr29514204wrw.51.1674725304549;
        Thu, 26 Jan 2023 01:28:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUubeSQ32vzl9stAsN2dulKbFqGtYmFtL06g225jZTpyT/iCMWZw4XveGa5u+qTWONOqnjnw==
X-Received: by 2002:a5d:6b09:0:b0:2be:110d:5d59 with SMTP id v9-20020a5d6b09000000b002be110d5d59mr29514191wrw.51.1674725304256;
        Thu, 26 Jan 2023 01:28:24 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm629228wrd.39.2023.01.26.01.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:28:23 -0800 (PST)
Message-ID: <2f39d449-f760-db73-5da5-9d7016f1350f@redhat.com>
Date:   Thu, 26 Jan 2023 10:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 5/8] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-6-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230125210657.2335748-6-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.01.23 22:06, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> meaning is only set when a page reference has been acquired that needs to
> be released by bio_release_pages().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

