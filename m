Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88605C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428292146D
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cweyXf1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428292146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeKUNFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:05:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKUNFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 08:05:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so539497wrw.5
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 18:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sk2CFN5O5Ch/J95osY6dZFZVKeAJlbK7XzoMKGAmoX4=;
        b=cweyXf1iIdatIKqKAQqrMFxGkMrX+SQV+K53Hyl8sqbFIwJ5zWL5CTWU8SNjLMgBbT
         KUHolX7HbK/IFBgMwGTXnaeWRrz6AptDhNhQ5qbxdCY53ZF3AE1lZ4elDtBSpVCACJm4
         228BsQM0j8xpjQds3LvOjkYRQZZBU0J1sbQVJe5blVFovQIAMPRWVDWyX8s2c/dvM+T0
         3X9/GVleTb+xQhA++pT0cMiTKKJSuVzL4Wi9tHjHJ2LcD3i8a0gr2eVscj7D2UgB7y3m
         tLFi4dKDLh72PAok5zYhi9IPiBExc7pG7SqCKBXTje4fWVjresGM7muaLRvncms3v7b6
         YXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sk2CFN5O5Ch/J95osY6dZFZVKeAJlbK7XzoMKGAmoX4=;
        b=nHCJJ+g9YaRB2gDUBst1b/lwbuqy1Ii+nM/6jYVwlrfsdQQnlyFtedU82imy251r1W
         E+7ljnHNbilVDQuFsBk5mhEpMzI8R/p1e81aG6ZxsG5A9ZFQUS/CKAxdo/AN/oR5ljSy
         6iL5VjgyQhkBCLrWfQgDnsXej5pkdVdPM5zCRprruEG37KPDU6vd6eWIDgX9ijjerQpL
         c7Tt+YGPIYxjMG3Oh0HTI9HaCeAy31v6Wr1x9GwPTL4uuaMazr2WHhQShJ2S/RCvkZU4
         tCJMUqsxjX/jaQ1zOApA83zAuxlPSLcW51FLJaZ8YnK0R9Ik059wMcfGMQrfiZNZ5kwk
         CeSA==
X-Gm-Message-State: AA+aEWb7jI5HFU/37rDDlDlraW4ijBhe2nFBAsDrx7RfL8tPBi36SAJ7
        7dEfALSf0289o3UzOV0BD3p9AqZpAEh5g2hW0qk=
X-Google-Smtp-Source: AFSGD/WuE1Zx/Euvkl1uNRYykureiBem7mCdrja6XFpoVQTwtw86Qe2gd7PgCLzEVylEJTCruCqqnb7F1xPfm2XY35I=
X-Received: by 2002:adf:ce02:: with SMTP id p2mr4327427wrn.185.1542767568559;
 Tue, 20 Nov 2018 18:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20181115040017.4920-1-ming.lei@redhat.com>
In-Reply-To: <20181115040017.4920-1-ming.lei@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 21 Nov 2018 10:32:36 +0800
Message-ID: <CACVXFVNurs9rKRcmWEaKF8A6smi+_ePybfVL7EdaXHEbUhvPtQ@mail.gmail.com>
Subject: Re: [PATCH] block/025: test discard sector alignement and sector size overflow
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:01 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> This test covers the following two issues:
>
> 1) discard sector need to be aligned with logical block size
>
> 2) make sure 'sector_t' instead of 'unsigned int' is used when comparing
> with discard sector size
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/025     | 37 +++++++++++++++++++++++++++++++++++++
>  tests/block/025.out |  2 ++
>  2 files changed, 39 insertions(+)
>  create mode 100755 tests/block/025
>  create mode 100644 tests/block/025.out
>
> diff --git a/tests/block/025 b/tests/block/025
> new file mode 100755
> index 000000000000..32b632431793
> --- /dev/null
> +++ b/tests/block/025
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
> +#
> +# Check two corener cases of BLKDISCARD.
> +#
> +# 1) test if discard bio's sector is algined with logical size, fixed by
> +#    1adfc5e4136f ("block: make sure discard bio is aligned with logical block size")
> +# 2) test 32 bit overflow when comparing discard sector size. Fixed by
> +#    4800bf7bc8c72 ("block: fix 32 bit overflow in __blkdev_issue_discard()")
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="check sector alignment and sector size overflow of BLKDISCARD"
> +
> +requires() {
> +       _have_scsi_debug
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +
> +       rm -f "$FULL"
> +
> +       # Create virtual device with unmap_zeroes_data support
> +       if ! _init_scsi_debug virtual_gb=2049 sector_size=4096 lbpws10=1 dev_size_mb=512; then
> +               return 1
> +       fi
> +
> +       local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
> +       blkdiscard "$dev"
> +
> +       _exit_scsi_debug
> +
> +       echo "Test complete"
> +}
> diff --git a/tests/block/025.out b/tests/block/025.out
> new file mode 100644
> index 000000000000..fd9a6d5f70de
> --- /dev/null
> +++ b/tests/block/025.out
> @@ -0,0 +1,2 @@
> +Running block/025
> +Test complete
> --
> 2.9.5
>

Gentle ping...

thanks,
Ming Lei
