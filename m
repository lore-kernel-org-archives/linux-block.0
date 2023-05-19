Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB33C77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 14:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjESOmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjESOmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 10:42:17 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AAD116
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 07:41:34 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6238417112aso14301116d6.2
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 07:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507293; x=1687099293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruzCCcFqzef6NacZHTXOwoNZcEE4fN80jkfDGRuHqfY=;
        b=ek+s1Nj8/xihiIlaGcbNmEPDMGDvwBNH5T5OetIlMMpVMFA29i7qQNvy2XFkclraJp
         x9o+JkCL4a16CFyw+Xy1TYo8LokZSOytjn0l3zUJwgAvzYwC9xPxvXeXon1G7i145Zyh
         POQndI5jINYjZr6Cid4AM54P7jTJ9Ikdu6I3rjvieJiznWkP1rJFlnWQJhWPes01vg0O
         ILuofvarZTD/NQS/smb4xNa9OMcRvtU4nKgCnCxeDaE39BUdMWOwf8K2AU+UDAMvBZbF
         fz8Swsxt2SiWhMgEe1iJMTCHpsiqUbkShAbOLy6CHXfdalDnVLmZAuNJBL4U/SWqBOff
         M3hw==
X-Gm-Message-State: AC+VfDzYZfXQYo9zxUeguQrXq6xmmIhdkALSg6ZH+5wJijhtOnk6s+im
        6n5AdcCW1xgYruPp3jK3IhYW
X-Google-Smtp-Source: ACHHUZ7qTfS72Mnvokou1gCiu8aMJLDGwXNKH9h+hze9P3ooxLjSWNKQoFEuFuJJeWOz7sBi4VE6LQ==
X-Received: by 2002:ad4:5d4e:0:b0:5ef:1e0a:1b07 with SMTP id jk14-20020ad45d4e000000b005ef1e0a1b07mr5299722qvb.40.1684507293525;
        Fri, 19 May 2023 07:41:33 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id qd17-20020ad44811000000b005ddd27e2c0asm1358298qvb.36.2023.05.19.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:41:33 -0700 (PDT)
Date:   Fri, 19 May 2023 10:41:31 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZGeKm+jcBxzkMXQs@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGb2Xi6O3i2pLam8@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19 2023 at 12:09P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> FYI, I really don't think this primitive is a good idea.  In the
> concept of non-overwritable storage (NAND, SMR drives) the entire
> concept of a one-shoot 'provisioning' that will guarantee later writes
> are always possible is simply bogus.

Valid point for sure, such storage shouldn't advertise support (and
will return -EOPNOTSUPP).

But the primitive still has utility for other classes of storage.
