Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C12C636CD
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 22:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjA3WPq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjA3WPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 17:15:45 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1E28D39
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 14:15:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id l7so2616724ioa.7
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpRPgXbzyPldfryxFZ4ysKITNhIghKFBROqanj/f/Sk=;
        b=Rimt7EyQJHAERbMyCMmnlRKfnzUd6ivIuLZcpvfDAKKf1XtrAzyKZgGyH4SsI1VCFl
         y71zP0cpkkZADufU3KMqa/2ZG7kemElm2dlXFsHsQwBCYQdp9/LMEKIABfWkxUUL24fs
         nOyHaogacUTLL2qE3KxiNjWzUgstTBfVOGGxj1ot6sSbvHczG4x2gEc06S02JBVFQqw/
         Zk3AjJ6WbeoqERAzuBWIbsxeQKQs2RwDjQsb6pWpRLl6lHoMSOdPV/+Xz+yX9n9BFKuA
         +q6AWSjEehghz28No7wOXPpAhkJQIqEVkeiyYYwlAzeLcE2jfwoVSl+BSXAQkNUkoEnX
         jnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpRPgXbzyPldfryxFZ4ysKITNhIghKFBROqanj/f/Sk=;
        b=aygXZCz+WTEPbV74NbXbMUtOT3AwLP7AtKEg6/RK9RBTF2q/0HzxCi0doEWJjmNBs2
         rZ7R5rRudYD3f8arzEZfSzmCDcHq5a5ZKfKI4//YFz29sgVmtrBcSNx4nob6z+o8AdfL
         8iUbIjK53MmxkhyCWqiX7UmjTh6yglYShYyhynDICzJ1CID2tYplHq2vuvaZMhe3FND3
         8ySxTcjOeIrIL7INV/kGJGPZewUvzwujRDAUV0Mev+3l36K5Zd9L+oIjUL0ydlRsY5Dt
         WYnOnKxGUt11f4hCd5dJe78IxvhCiG4ON8Hw7d4KNGJRW2xgr6GGo2NTPlQdv0u5091Y
         OzdQ==
X-Gm-Message-State: AO0yUKXWB1tZBwcAo/123D7bUdkIe/F2nzGtsBgEEnEp1y5I9svkADza
        1NLVN6Sctg/UT6+cZtFE3s4aIQ==
X-Google-Smtp-Source: AK7set/tqTtKUOkSBhdUWbUnjfzdSsFonAnOVZ3meWLdw53puoZxOKpLq8oYEyvusW9O1BKkg3hUeQ==
X-Received: by 2002:a5d:9d11:0:b0:718:2fa2:6648 with SMTP id j17-20020a5d9d11000000b007182fa26648mr1422084ioj.2.1675116944142;
        Mon, 30 Jan 2023 14:15:44 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q22-20020a5d8516000000b0071db3975335sm1082375ion.12.2023.01.30.14.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 14:15:43 -0800 (PST)
Message-ID: <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
Date:   Mon, 30 Jan 2023 15:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3520518.1675116740@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/23 3:12 PM, David Howells wrote:
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> This is something that we say when adding pin_user_pages_fast(),
>> yes. I doubt that I can quickly find the email thread, but we
>> measured it and weren't immediately able to come up with a way
>> to make it faster.
> 
> percpu counters maybe - add them up at the point of viewing?

They are percpu, see my last email. But for every 108 changes (on
my system), they will do two atomic_long_adds(). So not very
useful for anything but low frequency modifications.

-- 
Jens Axboe


