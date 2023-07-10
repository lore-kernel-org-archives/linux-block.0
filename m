Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA75EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 15:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGJPZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGJPZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B7F2
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689002688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCZAC1J2F4Ug/n/AdrHDbXj+KJVCjsLZESfeaexbk/U=;
        b=HxN/z+Sjf5pMpTCo8RuRlzxAmWuAd1L2l9NZPP3XONqaRRkr3nz9w2BME9Yq6495jJ7WEi
        vRTkYW/84e0/JOJQt641BLM7YohSPHuddvBg5jSMVgVAvYFH9EdNCMrUH7lB8SLdwLRk7L
        2OilC586q3a2kYTFruuStwD814go78I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-AvI_Ov2nOcqjIJsV9PwAFQ-1; Mon, 10 Jul 2023 11:24:47 -0400
X-MC-Unique: AvI_Ov2nOcqjIJsV9PwAFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E3B28F80FE;
        Mon, 10 Jul 2023 15:24:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE84640C206F;
        Mon, 10 Jul 2023 15:24:45 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id DC73F30C0457; Mon, 10 Jul 2023 15:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D83C03FB76;
        Mon, 10 Jul 2023 17:24:45 +0200 (CEST)
Date:   Mon, 10 Jul 2023 17:24:45 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Li Nan <linan666@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 3/4] brd: enable discard
In-Reply-To: <ace0451f-b979-be13-cf47-a8cb3656c72e@huaweicloud.com>
Message-ID: <4b6788d2-c6e1-948-22d-dbb7cbba657d@redhat.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com> <ace0451f-b979-be13-cf47-a8cb3656c72e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Mon, 10 Jul 2023, Li Nan wrote:

> Hi, Mikulas
> 
> The lack of discard in ramdisk can cause some issues related to dm. see:
> https://lore.kernel.org/all/20220228141354.1091687-1-luomeng12@huawei.com/
> 
> I noticed that your patch series has already supported discard for brd. But
> this patch series has not been applied to mainline at present, may I ask if
> you still plan to continue working on it?
> 
> -- 
> Thanks,
> Nan

Hi

I got no response from ramdisk maintainer Jens Axboe. We should ask him, 
whether he doesn't want discard on ramdisk at all or whether he wants it.

Mikulas

