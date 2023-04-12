Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F94C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 10:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDLK0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDLK0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 06:26:06 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7510C3
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 03:26:05 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x11so6837704vsq.2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681295164; x=1683887164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=;
        b=DM3bChJapodBr2WHktIVXkF4wESvZSLuZZn2zwhzSHR/k6aeEsuyuFmPaLw5+pOEUH
         38OFPm/u+VF2r1UB6keKE0knkwIJ5ONc5nihQRbRBi4ys6eO9dD/BwWOhpwU1lnUAsoQ
         QWbjR57oIsH1xb7GH369h+6pXCS185B8PYydBy/JDB17T1tWZ9hNiiHN1LHHjEY6+0Hy
         0Q0+E9O5D0VcLEepEGChzSMZ6z/f/v+YVqLuO6Miuh3vJuk84aN1Hki0sQx6NJbLdCmQ
         Jrb3ja03hDHyBjgR4WXtGsDSxFNmfB6ohsQgcmFwlzfyCv/HuWB142U0UN9sAYewWI/8
         2Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681295164; x=1683887164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5vg+YiNoxs31Tbnrbv2vsVS/DbOkcWGxusmaV9cfKk=;
        b=j2xYcFBJN1XmeQIXihMoQ7zcC94HqCwp2PdOIvQYMRcRvTho7BYD3ZvKTwNBoBTtRa
         Q6D4hesFyabYEsSlSQhcWsp9MNrJiG8BDh0VPRBFkA+iNLxNtMWnUr3uFsBbEtILgf9P
         d/W1tIJefP49HLQ0QLNQRgL7q6afCIsOosm0S0A6Kv0IwMpAcCrMUW/cVrYAaFM2J4cP
         ryJgDvLC+n+tAB1ur+B4uT+O10fQEmexo2bpObICDXO07bqBvA5pK782KQEePWnGcsGb
         NrBnuKQ8DjjAysGzO/qf7NBt3VYXdgfrH6Avwer5z47MPwGjF4ph781Ox07NKc4x9i0p
         2i3Q==
X-Gm-Message-State: AAQBX9fI4Fqb40V/NTHjtG0xHvl9HJhbGeebKHjR2Bg6ZwAvuHBqHcaM
        wwzyU4pL7WZ/Ix6Wrar822GdyIm132EEd9OfNMT7tA==
X-Google-Smtp-Source: AKy350Y0FPXWa3mLhpuSfB2wOlCNyI4G0X8q0GPeu0ZGyUt76BO9Zf7I0z0F2H0jq5JCqvcQzrzp/+A3FO8XMIP0FFg=
X-Received: by 2002:a67:cc0f:0:b0:42c:74a1:424f with SMTP id
 q15-20020a67cc0f000000b0042c74a1424fmr3659466vsl.1.1681295164459; Wed, 12 Apr
 2023 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230407200551.12660-1-michael.christie@oracle.com> <20230412093617.285177-1-naresh.kamboju@linaro.org>
In-Reply-To: <20230412093617.285177-1-naresh.kamboju@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Apr 2023 15:55:53 +0530
Message-ID: <CA+G9fYv2nEBe=kJK4veunkvXD9GvqyaPFQ7rUbMD1S4+0nUS3Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Use block pr_ops in LIO
To:     michael.christie@oracle.com
Cc:     axboe@kernel.dk, bvanassche@acm.org, chaitanyak@nvidia.com,
        dm-devel@redhat.com, hch@lst.de,
        james.bottomley@hansenpartnership.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        snitzer@kernel.org, target-devel@vger.kernel.org, vbabka@suse.cz,
        mgorman@techsingularity.net, halbuer@sra.uni-hannover.de,
        keescook@chromium.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        mkoutny@suse.com, roman.gushchin@linux.dev, ryan.roberts@arm.com,
        shy828301@gmail.com, yuzhao@google.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 12 Apr 2023 at 15:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> [sorry for the adding you in CC]
>
> While running LTP controllers test suite on this patch set applied on top of
> the next-20230406 and the following kernel panic noticed on qemu-i386.

Also noticed on qemu-x86_64.

Crash log link,
------------------
- https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171908/suite/log-parser-test/test/check-kernel-panic/log
- https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-block_20230404140835_25166-1-sergei_shtepa_veeam_com/testrun/16171908/suite/log-parser-test/tests/

lore link,
https://lore.kernel.org/linux-block/20230407200551.12660-1-michael.christie@oracle.com/


--
Linaro LKFT
https://lkft.linaro.org
