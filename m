Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C6C0015E
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjGMIc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjGMIcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 04:32:10 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9161B3
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 01:23:12 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so367573276.1
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689236590; x=1691828590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dmUvvFe5/0RHDgOhcRqf73PLJ/xjj5ik+Mt9yz3hpVE=;
        b=JDjaxMNSCA2W0kv8QauUN8XGyZ37DEvH44KOJRlwppaz0znXSKXj+Qgcfdoq6EAXa4
         QLkRvTydaY6wacC+a5/60no89snaYyzToT1xWjTLc9LdU7NsY3GHXvY2cCCnfGeapMG1
         aMoKt4kFsQP6UvZTkEyJjIwLLv24UVO93sHO0jRGTEbFW4ml+l9mibdrohZQ3pRngmGk
         Jx8r492MtUrOHqZIyPIcLUM0bOzdBGX6yhtJHVq+Cc03uvzn6pBKDC3g9wfenQU//yC+
         7XObtu+QiwlXokKBOMBV0b8cKzrU5TCYy1nS0wrB9j8opf3aXU4c51q7yt9bxbJ1ZJBp
         ZS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236590; x=1691828590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmUvvFe5/0RHDgOhcRqf73PLJ/xjj5ik+Mt9yz3hpVE=;
        b=ecPd2sWNMryKUC9g6wTd5rkM9t2mP48wdPQZH035MLIkpwedSepVIIIs8m9znz4A/U
         b4BJNsL/Os1s83tujxvywVroZQTUNp1lH1uXSa2yeF49NAlVTlDHyYWv3HC8v5Hb2bd/
         HcDIcm8R9DyH7aReKoDuWEO8itb+CEeWGYC2zUFAHA+5/nRpggk4PZp3bSGr8ljpZD7I
         MDgH133yU6FNKVdU/vhjHUvm0OvYxpDVbD/yQMR3Wn3Egib+PGiXFNfQOZ0eKyWVTrGM
         Y+siuihuyYjnJNWksV947n9GU2MNmgnVWc9XUP7qzUan8JlVP3Qu56jYEsj33xnWoaM4
         moYA==
X-Gm-Message-State: ABy/qLYOV58+tiNEuAyLB5gzi52cKP7QdUceyrxNzf4hMYMULey99MgA
        I/9TPcecwjWSCVoyqH/8dK7wLbH+9Q/U93wd2y4=
X-Google-Smtp-Source: APBJJlEbHvkCZjLi15/lidg5v2R1Yh9AOdIR1j8W6aRCyJXeU1xYrlBOnMGufB+qGA9cE/p+Bndff1yvmURZvndbsdI=
X-Received: by 2002:a25:d1c1:0:b0:c1a:b0e2:e930 with SMTP id
 i184-20020a25d1c1000000b00c1ab0e2e930mr945563ybg.3.1689236590340; Thu, 13 Jul
 2023 01:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZJL3+E5P+Yw5jDKy@infradead.org> <20230625022633.2753877-1-houtao@huaweicloud.com>
 <CAM9Jb+hrspvxXi87buwkUmhHczaC6qian36OxcMkXx=6pseOrQ@mail.gmail.com>
In-Reply-To: <CAM9Jb+hrspvxXi87buwkUmhHczaC6qian36OxcMkXx=6pseOrQ@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 13 Jul 2023 10:23:01 +0200
Message-ID: <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org, houtao1@huawei.com,
        Vishal Verma <vishal.l.verma@intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+Cc Vishal,

> > Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> With 6.3+ stable Cc, Feel free to add:

Hi Dan, Vishal,

Do you have any suggestion on this patch? Or can we queue this please?

Hi Hou,

Could you please send a new version with Cc stable or as per any
suggestions from maintainers.

Thanks,
Pankaj
