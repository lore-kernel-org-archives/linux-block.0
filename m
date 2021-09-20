Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD8AC43217
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839BF61157
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbhIUCRe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhIUBvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFFC0386C0
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:09:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u18so18981670pgf.0
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOcqHHbkBDFlbtFdYBTqX2Q9Srh+sNAiutBC+Z8jfD0=;
        b=64MjeUkX5fnk7DBE/PjIi6uxragircvWmGgL8etQwvZ1l5WJ6TUfHYN8QzBi0QMGhg
         xqZyEl5Dpd2r5u1pSCCPkp0tDmdB6Bcffd1QK+VuxzeKViBhh2y7xkhFg8WiHhfETtlz
         JoSJhSEr2l9GFYgEtlLxCWUqyCPnqPKzXnAfF8SJEOeFKjb7+MDIADmh8d2PWgm7mtL9
         wLEi+1HHWrNx2K1TAAfZMH1Xro++PpHG48OZ7W9JCrU49xYLK1PXpVeULNgHdT7PPtMR
         A7NQNf3IDYSO1p1jogUxQVzP/eBQjVSETWV1KYu8bi7sgDLqo/8Oe2LwPZDHAj/PO6ZO
         /gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOcqHHbkBDFlbtFdYBTqX2Q9Srh+sNAiutBC+Z8jfD0=;
        b=RqbcyKrcuKDCQWjnq/zAxJGENfH3G3Z7t86KN0Fmszs/YFpPlgCO1+TArgN8+15aGa
         JmZPQdnOyWvX76gjlQOiHzRqXylDyMPE6VeeLEh8x5ZsMXd3CWlWCNaFosVoLkel+RKX
         QtHOBLNq2Lk9OJIjIERu+VV8tHniOJk053xIrBq2NcR6ULny5jUAFoteksRfp63bXemj
         vX2axDDg5VL6f3joN++bfhtgQRmmbqzEMVD4CyW0mMawErtDNs6U+luji9apNmfNTpuL
         X0rpXVLvDg/GyJOHmZV6UBYGF8IfyRA7o3zpy0/yr93+tGRanjlSIo1eCFh0cSxfQmjB
         5HuQ==
X-Gm-Message-State: AOAM5334C2VNGKeFGlIa0TaFrWnFB3YT8RBLTmymzdA5pzBt94d2cY4Z
        ZhDZ9u+jcpFCuyZQEybDc0UjNd6mjGMLm21csgMc3A==
X-Google-Smtp-Source: ABdhPJxI9Od05DZ0snqOmMgrhp1sI5Y9wYEd+2t40IS3lfIxNj4bseBagecZBBXGVcs2qjrSGmhbjS2ZMrrrLLbeAEo=
X-Received: by 2002:aa7:9d84:0:b0:447:c2f4:4a39 with SMTP id
 f4-20020aa79d84000000b00447c2f44a39mr6015200pfq.86.1632179364747; Mon, 20 Sep
 2021 16:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072726.1159572-1-hch@lst.de> <20210920072726.1159572-2-hch@lst.de>
In-Reply-To: <20210920072726.1159572-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 16:09:13 -0700
Message-ID: <CAPcyv4hVR9J6M+0-KcnmNeRywvF4CobyEtKA9repq9ivtKy77Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvdimm/pmem: fix creating the dax group
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 12:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The recent block layer refactoring broke the way how the pmem driver
> abused device_add_disk.  Fix this by properly passing the attribute groups
> to device_add_disk.
>
> Fixes: 52b85909f85d ("block: fold register_disk into device_add_disk")

This also fixes the the way the pmem driver abused device_add_disk(),
so perhaps add:

Fixes: fef912bf860e ("block: genhd: add 'groups' argument to device_add_disk")

...as well. It's not a stable fix as this is only a cosmetic fixup
until the most recent refactoring turned it into a bug.

Either way, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
