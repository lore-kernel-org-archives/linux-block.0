Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAC1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Apr 2022 17:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbiDZRdT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiDZRdT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Apr 2022 13:33:19 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2944FDD
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 10:30:10 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id kj18so3095680qvb.6
        for <linux-block@vger.kernel.org>; Tue, 26 Apr 2022 10:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SEwqid2cqU5z1FQfUADU6++wJRZ5uOwQWBCECyhyBEs=;
        b=iGZSEsqboWOhpLWIrGACYhEC+8BkjFhAuKhNadP0DEMG6K4V1Vb7zOBs1xPrPbcXG7
         GflD5gF3K7Zeb0S54A/oRpDKNLaGa2qsKoJCyavAsriWZLsue9ueFUhnEMvdVNayjbzr
         GT0BEdcBtk24Tm45fXPzJQb+DiSH0ewKSpuupbZ8JeqwLHKFD26qyKvplehPrYyemJJb
         jpcevN+roRVseamnY8TkT2W6VV05jWBb/hHY/1Nc19ELQHdn9MQCrydxdML++ArP0ucO
         U+SdkdAIns9tW/QIVKoxZsmLAJvSyGaAUoKT/oJ4iJZc0+mSQNKCE5rYkub5lG1cr9Xj
         zuww==
X-Gm-Message-State: AOAM531mp64+83mgQcef4oecUX7A5nN0lzRaDlMbKzP33N3PJ2hB1cVF
        mASSljDXPH/5d78vKAlD1Aat
X-Google-Smtp-Source: ABdhPJxBM/S+k8uviQRJFWKzy6Mj03NOVNPmwTQC5uQw6kwCRZ4DuQzmHuTyvCw1QEQCb2vGucXO0A==
X-Received: by 2002:a05:6214:2a82:b0:443:a395:cc23 with SMTP id jr2-20020a0562142a8200b00443a395cc23mr16948937qvb.67.1650994209996;
        Tue, 26 Apr 2022 10:30:09 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b0069c8307d9c4sm6688016qkm.18.2022.04.26.10.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 10:30:09 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:30:08 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com,
        tj@kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: Re: block: remove redundant blk-cgroup init from __bio_clone
Message-ID: <YmgsIA9asIxxpRlt@redhat.com>
References: <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
 <YlReKjjWhvTZjfg/@redhat.com>
 <YlRiUVFK+a0DwQhu@redhat.com>
 <YlRmhlL8TtQow0W0@redhat.com>
 <YmQvgdqHlsQVpxR+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmQvgdqHlsQVpxR+@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 23 2022 at 12:55P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> So while I'm still diving into the somewhat invasive changes to
> optimize some of the cloning all we might relaly need for your
> use case should be this:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-clone-no-bdev
> 
> Can you check if this helps you?

Passing NULL will be useful for targets that do call bio_set_dev() but
there are some that inherit the original bdev.  I'll audit all targets
and sort out how best to handle the conditional initialization to
avoid needless work.

This change is useful and a requirement for relevant follow-on DM
changes:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Thanks.
