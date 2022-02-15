Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15195C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 08:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiBOID3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:03:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiBOID1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 03:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AEF32655A
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 00:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644912196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9YaZfqN6BUu1lLQrPqS8085w4T7ttKInsV1SoDz5f3M=;
        b=Sgx01Ob8u5ldRcDrqugf1H47Ar/w00pm+NZz3ZGiY9bYxyfdMKCruApqbKCyJ+1KmunfYy
        1IJbrjEQ7q13HyN/hrMJP6JfHcH2u6GcVv39ZH3Q01ZHeONJXk1Zr5MEtr7N7yrsu7g40a
        r/iV31l1lI1VI5ofm1ZcydB9bToPiXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-4o5wRq4TNTSkk9xNM9xTXQ-1; Tue, 15 Feb 2022 03:03:13 -0500
X-MC-Unique: 4o5wRq4TNTSkk9xNM9xTXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057361091DA2;
        Tue, 15 Feb 2022 08:03:12 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97FF266E08;
        Tue, 15 Feb 2022 08:02:54 +0000 (UTC)
Date:   Tue, 15 Feb 2022 16:02:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 5/7] block: throttle split bio in case of iops limit
Message-ID: <YgteKdPv/EMDKi/4@T590>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-6-ming.lei@redhat.com>
 <Ygq6GanKSLlTixqe@slm.duckdns.org>
 <Ygr9evnWSjcCjYkd@T590>
 <YgtRVl7oLR4mqf3c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgtRVl7oLR4mqf3c@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 14, 2022 at 11:08:06PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 15, 2022 at 09:10:18AM +0800, Ming Lei wrote:
> > The big problem is that rq-qos is only hooked for request based queue,
> > and we need to support cgroup/throttle for bio base queue.
> 
> Which bio based driver do we care about?

dm/md is usually the upper layer block device for mounting FS, and
userspace just setup bio throttle on these dm/md device, so we can't
break userspace by removing io throttle for dm/md and other bio based
devices.

Thanks,
Ming

