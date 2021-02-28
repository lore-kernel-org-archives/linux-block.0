Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D15C433E0
	for <linux-block@archiver.kernel.org>; Sun, 28 Feb 2021 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB0C64E99
	for <linux-block@archiver.kernel.org>; Sun, 28 Feb 2021 14:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhB1OrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Feb 2021 09:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhB1OrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 09:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614523544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R023yFe8B5O0z64rNys/vsZPbPqTd9qKQKNZegYoTYc=;
        b=cPw2Jtvnyfvg0IpEye2VvKpUNq88Pyh0hXDewATWytKF6E8pLWXawLDVx0NHQQ1Qfp7Dqo
        EgLnSJvsEfd8P0Nd4d2CJSIiuv3ISswvZ5MLLrB46cg7IimUzM/4lbx6GZE+bl5NCZeSgM
        fNrJv0qAtlN+yCUiOZYHdF5hQ7v9nkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-94ZTiDi5NOmiIfFoJebugw-1; Sun, 28 Feb 2021 09:45:39 -0500
X-MC-Unique: 94ZTiDi5NOmiIfFoJebugw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87FAD8030C2;
        Sun, 28 Feb 2021 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A8475D9CC;
        Sun, 28 Feb 2021 14:45:35 +0000 (UTC)
Subject: Re: [PATCH blktests 3/3] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20210126044519.6366-1-bvanassche@acm.org>
 <20210126044519.6366-4-bvanassche@acm.org>
 <YBrR5anAHkyL4EVg@relinquished.localdomain>
 <3c7d51d1-1470-3dbe-f471-68551d233f4b@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <bb4bb982-245c-d9bd-f335-7b2b7d6a3560@redhat.com>
Date:   Sun, 28 Feb 2021 22:45:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3c7d51d1-1470-3dbe-f471-68551d233f4b@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Bart

Currently blktests was broken on latest kernel, could you resend this 
updated patch. :)

Thanks
Yi

On 2/4/21 11:58 AM, Bart Van Assche wrote:
> On 2/3/21 8:40 AM, Omar Sandoval wrote:
>> On Mon, Jan 25, 2021 at 08:45:19PM -0800, Bart Van Assche wrote:
>>> The approach of verifying whether or not an RDMA interface is associated
>>> with the rdma_rxe interface by looking up its parent device is deprecated
>>> and will be removed soon from the Linux kernel. Hence this patch that uses
>>> the rdma link command instead.
>>>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Cc: Yi Zhang <yi.zhang@redhat.com>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>   common/multipath-over-rdma | 111 +++++++++++--------------------------
>>>   tests/srp/rc               |   9 +--
>>>   2 files changed, 32 insertions(+), 88 deletions(-)
>> I think we need to add _have_program rdma checks to srp and nvmeof-mp,
>> right? The first two patches look fine, I'll merge those.
> Sure, I will add a _have_program rdma check and repost this patch.
>
> Thanks,
>
> Bart.
>
>

