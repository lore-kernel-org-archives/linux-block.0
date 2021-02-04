Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30DC433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 03:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6696564F59
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 03:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBDD7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 22:59:42 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:36865 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhBDD7U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 22:59:20 -0500
Received: by mail-pl1-f179.google.com with SMTP id e12so1047271pls.4
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 19:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6mnXGDFAyXxjx1ewHvhzGWWAnHu+QmTpztwBxJMexo=;
        b=k1GGR5HppiSl3LSrZiYjsO/1TEJMncpOwRjN6kJGNPIr85SL3NW+vr9NB/Oj659knl
         5xGYjNNoHXPt+u7Kbw9I4ceZnJdGDf0Lh1zhzdUXSiH6kz3Q100b/+VYVBvH0daZRf2B
         AJE+8+TrLCP1vz2BWcCd2MJ9l33whf4rogTM39EuqlViSFgMbwdl4yvLpUd+GE3pOtSM
         jasyHyqlJnHfyteJn7uqPCK26A6hNxms0iybv8aoH3q/yKAXvMlaZasGzS42gQH9YZ7c
         /SvxT9xOQizgidv9yHtxDoZzBcNTmCwW1bnE/c/2mo4QUTbDCRxiChBqnzAQLvGVB0aZ
         SO4g==
X-Gm-Message-State: AOAM530ZZgtPBL5uppN+yiVXoNrx36El/U3AHJcppL/QWrsFJ+iVz/37
        5zmjtMXTQwRZWqRQcA5/kR4CyEKBmWc=
X-Google-Smtp-Source: ABdhPJyrJTMQRwjdAsLTfX0rJhN/UcEr2K1NlTygwLfIc9ANE08FPi0iTcnB3nBI5kaY+pPjdwp5ww==
X-Received: by 2002:a17:90a:ba87:: with SMTP id t7mr6152129pjr.184.1612411119745;
        Wed, 03 Feb 2021 19:58:39 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:65f0:cf17:ca4c:f4e5? ([2601:647:4000:d7:65f0:cf17:ca4c:f4e5])
        by smtp.gmail.com with ESMTPSA id c3sm3793871pfj.105.2021.02.03.19.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:58:38 -0800 (PST)
Subject: Re: [PATCH blktests 3/3] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20210126044519.6366-1-bvanassche@acm.org>
 <20210126044519.6366-4-bvanassche@acm.org>
 <YBrR5anAHkyL4EVg@relinquished.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3c7d51d1-1470-3dbe-f471-68551d233f4b@acm.org>
Date:   Wed, 3 Feb 2021 19:58:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBrR5anAHkyL4EVg@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/21 8:40 AM, Omar Sandoval wrote:
> On Mon, Jan 25, 2021 at 08:45:19PM -0800, Bart Van Assche wrote:
>> The approach of verifying whether or not an RDMA interface is associated
>> with the rdma_rxe interface by looking up its parent device is deprecated
>> and will be removed soon from the Linux kernel. Hence this patch that uses
>> the rdma link command instead.
>>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Yi Zhang <yi.zhang@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>  common/multipath-over-rdma | 111 +++++++++++--------------------------
>>  tests/srp/rc               |   9 +--
>>  2 files changed, 32 insertions(+), 88 deletions(-)
> 
> I think we need to add _have_program rdma checks to srp and nvmeof-mp,
> right? The first two patches look fine, I'll merge those.

Sure, I will add a _have_program rdma check and repost this patch.

Thanks,

Bart.


