Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60FC636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 07:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBHHnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBHHnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 02:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1110AA1
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 23:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675842157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TiosNo5/qsUkYzGriev1vKkzzYlpnll47B7QUAeV90k=;
        b=QFnyTbeJ7hXrsgSLoP8uUuzPVMqYA1gVgBALb96nnaIxQYm1/KuziRwVRPOPim+D/G6ETi
        gHPOuvrwRJxCYdhpm9j4OgJXFh7cuwRhkrV0idy50cGGri8P9IKhzj6W1a4lwT6hgdNTPN
        AXJAkbjcGgfMa0i6G/P9Be7O0r3Q44g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-Sd4BwYQ-NE24cG2giZz-7A-1; Wed, 08 Feb 2023 02:42:33 -0500
X-MC-Unique: Sd4BwYQ-NE24cG2giZz-7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 622CA85A588;
        Wed,  8 Feb 2023 07:42:33 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 317FC35453;
        Wed,  8 Feb 2023 07:42:30 +0000 (UTC)
Date:   Wed, 8 Feb 2023 15:42:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] blktests: add test to cover umount one deleted disk
Message-ID: <Y+NSYGJBoM8Oixa5@T590>
References: <20230208010235.553252-1-ming.lei@redhat.com>
 <20230208073911.x4iwd4iq5i34xnrr@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208073911.x4iwd4iq5i34xnrr@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 08, 2023 at 07:39:11AM +0000, Shinichiro Kawasaki wrote:
> On Feb 08, 2023 / 09:02, Ming Lei wrote:
> > disk can be disappear any time because of error handling, when
> > it is usually being mounted. Make sure umount can be done successfully
> > after disk deleting is done from error handling.
> 
> Thanks, this patch looks good to me. The commit title needs some edit to have
> the prefix "block/032: ". I will do the edit when I apply the patch. I will
> wait a few more days in case anyone has comments.

OK, thanks!

> 
> Just from my curiosity, did we have any failure that this test case catches?

https://lore.kernel.org/linux-block/20230208063552.GA15030@lst.de/T/#u

Thanks,
Ming

