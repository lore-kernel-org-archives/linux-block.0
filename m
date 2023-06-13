Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D9EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 15:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbjFMPsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbjFMPsW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 11:48:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7919F
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 08:48:21 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so3739185ab.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686671300; x=1689263300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSrctI8rg8I7twHK6Nil4YKzI1pYE/l9OdmquxynZq4=;
        b=1IxMrX8EdCYYXT8z4R8g5xqadrCypUsYWgg41u3N/dlybwXZJu7zAUDrBeN4GL449o
         +8RfTGMi6r5QikoO/a1XC8JEDxdc4ILd/eIp3FOAFEcyMBjAKLVIAkG6aaCp1B/0GAh5
         h4DCxWuoSl72Xf9hJ3tYHUmZxuCN11luuhQkBuupPRWrUiybaDDE83+lfAmhfszwQVZC
         tYqtRCdXcBg8+M/hPoMUyTQcoGw2bipRmg3f7WRV2QYo7ekDRaCHO+HWJdf5M1zAQKRy
         wsaurWEurnvuCie8fqVMgUxsHgVftMVS9XSbnCorlXIG/gNuD/libC/nNCKEBg/dxtq/
         JoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686671300; x=1689263300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSrctI8rg8I7twHK6Nil4YKzI1pYE/l9OdmquxynZq4=;
        b=OhnQXVY6XL5g1AweqpmQmVZE6P4pk8rt/BxLL3TQHfuBcJFrhDrtCMErCMmW9IHUG9
         dou2wAUROHIttrys3aihGfosRcHSZdoaJtnymChQNH6Jih4LRww8C1uuhw8kcc9kkEjK
         btczJqh53VjmHz1vSssc96ZgxbGgTp4dwx+3nkFxbAKvWTFAkGxtKDq4tFjGgh7PoaWw
         iPnAHVmPX/nPEzoPRlUciG0spSdDaFBZZzZuU6DApRO+0OKyLGjOJ+viLarCzgdd+hAb
         HTrOuOY2dsTq3DHN0o69JMdZKZIGxNCyrs9lpSzk1bDgUnphTJG2O+gYcYOvGaxm239A
         kFlQ==
X-Gm-Message-State: AC+VfDxgBVnY52M1/lTXYUt83wXnOyCwqCWW7Q6JVs8DRMdjxSoVK+e9
        y54655cLvN84O0U7V1s1g+E4fg==
X-Google-Smtp-Source: ACHHUZ5StGBwUyOjFSA4oiFTpuXR+sgEyx4jlxweuyIJg1gEkVnyybc/DjDXsTvbpm397ZVPBanKkQ==
X-Received: by 2002:a05:6602:1789:b0:777:b456:abbe with SMTP id y9-20020a056602178900b00777b456abbemr7180557iox.0.1686671300719;
        Tue, 13 Jun 2023 08:48:20 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h24-20020a02cd38000000b004145ebbf193sm3468444jaq.51.2023.06.13.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 08:48:20 -0700 (PDT)
Message-ID: <491da795-e9e0-1d84-558b-df09063228cb@kernel.dk>
Date:   Tue, 13 Jun 2023 09:48:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] block: Fix dio_bio_alloc() to set BIO_PAGE_PINNED
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
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
References: <545463.1686601473@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <545463.1686601473@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/23 2:24 PM, David Howells wrote:
>     
> Fix dio_bio_alloc() to set BIO_PAGE_PINNED, not BIO_PAGE_REFFED, so that
> the bio code unpins the pinned pages rather than putting a ref on them.
> 
> The issue was causing:
> 
>         WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio
> 
> This can be caused by creating a file on a loopback UDF filesystem, opening
> it O_DIRECT and making two writes to it from the same source buffer.

What is this against?

-- 
Jens Axboe


