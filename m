Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F4C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 08:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKUIOW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKUIOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 03:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6127FCB
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669018401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXlYy9pZM0dbFzL7qiPQerpcjHoHper9o+KpvlsD6jg=;
        b=Vwa1kOERxQgiyfrevjFJtXVm3wjDU4vPXXtfokKnU1Omh2qDirZs+b5VVNCLKFhsMZmkKg
        23anqydOcMTZa+S68D4FDSkRS4BXIFAH9TjrTqgvxEi1wg7LnePjaC8mnYclPQQncJdHUi
        vxBWgVb6+lJ1bNtq1lHbIUeV5Q0dqPQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-1i1GLF9IOWKBtLsYoPD4aQ-1; Mon, 21 Nov 2022 03:13:20 -0500
X-MC-Unique: 1i1GLF9IOWKBtLsYoPD4aQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD59E38012C8;
        Mon, 21 Nov 2022 08:13:19 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEEAA2027061;
        Mon, 21 Nov 2022 08:13:15 +0000 (UTC)
Date:   Mon, 21 Nov 2022 16:13:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Reordering of ublk IO requests
Message-ID: <Y3szFl5VcD/MNDu5@T590>
References: <87fseh92aa.fsf@wdc.com>
 <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590>
 <8735ag8ueg.fsf@wdc.com>
 <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com>
 <Y3d+78qMOusdYUAG@T590>
 <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
 <Y3swtrdPaI5lGMpj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3swtrdPaI5lGMpj@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 21, 2022 at 12:03:02AM -0800, Christoph Hellwig wrote:
> I've been wading through this thread a bit, and while I can't follow
> everything due some pretty bad reply trimming I'm really really
> confused by this whole discussion.
> 
> Every single storage system, be that hard drives, SSDs, file systems
> or what else much preferres sequential write.  Any code that turns
> perfectly sequential writes into reverse sequential writes is a massive
> performance bug, zoned or not.
> 
> So totally independent of zone device support in ublk this needs to be
> fixed ASAP.

I will send one fix soon.

BTW, blk-mq has such similar issue, which is reported for while, but
not addressed yet.

https://lore.kernel.org/linux-nvme/CAHex0coMNvFa1TPzK+5mZHsiie4d1Jd0Z8ejcZk1Vi1_4F7eRg@mail.gmail.com/T/#mbcb9b52ff61aed6fdd1b6630c6e62e55a4ed898f


Thanks,
Ming

