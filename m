Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D5C10F1B
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 08:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiL0IBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 03:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiL0IBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 03:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDBB68
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672128047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97LIxnN4PCGSE36SMmcMGpP0wZp33vPoT9z5hI4s2oE=;
        b=Ii7yF7zTnEPj7FYMVj5kF+q6Ju0LY/sDXiWNApRkKKZEjL88WlqH91/2oYzact4YzGZnsy
        sGETDmdhzvEiP5rW5+w94Hijdp8xyZ9RxJeEL6OsKyw1bFOg/SsPtCT1KqC8TlHxSpuQ8f
        wMSN07tDVQkuEKkFB9QTOYqnB1FKpCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-v8ZS7GyXNEmQRSUwiJCpMA-1; Tue, 27 Dec 2022 03:00:45 -0500
X-MC-Unique: v8ZS7GyXNEmQRSUwiJCpMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D8C01C02D25
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 08:00:45 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7B01492B00;
        Tue, 27 Dec 2022 08:00:42 +0000 (UTC)
Date:   Tue, 27 Dec 2022 16:00:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changhui Zhong <czhong@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000058
Message-ID: <Y6qmJT7H14Dfhn5y@T590>
References: <CAGVVp+WS5aHiF2Odc-C+fO56qKyV7vPsPRz35v9eWsPJDNj=ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+WS5aHiF2Odc-C+fO56qKyV7vPsPRz35v9eWsPJDNj=ng@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Changhui,

On Mon, Dec 26, 2022 at 11:11:44AM +0800, Changhui Zhong wrote:
> Hello,
> Below issue was triggered with ( v6.0.15-996-g988abd970566), pls help check it

There isn't commit 988abd970566 in linux-6.0.y, so I guess the above
build must integrate other patches not in 6.0.y

From the source code in cki build[1], looks commit 80bd4a7aab4c ("blk-mq: move
the srcu_struct used for quiescing to the tagset") is included, but
commit 8537380bb988 ("blk-mq: skip non-mq queues in blk_mq_quiesce_queue")
is missed, that is why this panic is triggered.

BTW, if possible, I'd suggest to share kernel tree being tested in cki test
if non official kernel is tested.


[1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/731863135/build%20aarch64/3522994262/artifacts/kernel-stable-queue-redhat_731863135_aarch64.tar.gz


thanks,
Ming

