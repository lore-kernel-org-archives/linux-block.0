Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D9C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 19:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbiA0THs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239096AbiA0THs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 14:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643310467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=OaRzF3xvYhcODcVUOmZQDjADhYKacgp04Z3+AcxkRnM=;
        b=Vq2y686SjzZDiCBtsnfNzRM9MUBhU0lbzr+EVr53Csyr5tmrPT2rwwqpwD40zG65u+iBHj
        4SZiqqEAFw4u7i/pvQuswvk8z42BQu1KLzKyosoa0DriAXEDI8MwJXmUTcDyhRA+cWJwaz
        k2tkAsmKIKCu01K+iy06Og72hY5+l7Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636--Ncm_8jKNbirZRnJygHvhw-1; Thu, 27 Jan 2022 14:07:46 -0500
X-MC-Unique: -Ncm_8jKNbirZRnJygHvhw-1
Received: by mail-qk1-f199.google.com with SMTP id a127-20020a37b185000000b004789e386256so3131992qkf.8
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 11:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OaRzF3xvYhcODcVUOmZQDjADhYKacgp04Z3+AcxkRnM=;
        b=NLtK1CXABjYVNr80FXgx+44DuITUYiiBJaiA09JRmAY5wjL2iyqKnRpjj/zixYpaeI
         kUGrUWjxBCMxhwwT0eWUkUUeU9UDMQGr8eobuuGpHdYk2I5Yb1BTkhUqVhUjeXjDtWfo
         z6PFnyuLRZUMA07b6sk37IgPF/oSzbziK5q+ocg/Qhp5jKJewp34P8Eskrqbx9kCSwKB
         i+cZ9uniKLG1ep4BvYKg3G5FKDQB7zJZ4Zdz2/hinZ+EF6/YUZygHXREE3i8pK2BGF43
         iiQP+uLUFFvSK/jvg7n28DK8l62xYceDB88kyikGPsuddNTia2KN4a/g6eAVVaoy5rOW
         NalQ==
X-Gm-Message-State: AOAM530uQBxquWw+RmvxR9zbn8tCE5NEKU7xjO+sIGbDsRk4aZbu+Pj8
        5+3Bd6tJoKKJYloGENx+4FS0KKS1a6UpokUxQ1qYItLy7GKkNnUO4FD+HYvey0xbtrUsnpmTVin
        DLi4pZejrfGR20sDiAMsE5g==
X-Received: by 2002:a05:6214:76a:: with SMTP id f10mr4489257qvz.85.1643310464978;
        Thu, 27 Jan 2022 11:07:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynf7Rz6AS8mWVd28TKss0f24ARumnzqA4qfRaxnHbQp6Zr3lwHM7g2J6br5z8MWE6Gpw7AKA==
X-Received: by 2002:a05:6214:76a:: with SMTP id f10mr4489237qvz.85.1643310464748;
        Thu, 27 Jan 2022 11:07:44 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l1sm1934493qkp.100.2022.01.27.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:07:44 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 0/3] block/dm: fix bio-based DM IO accounting
Date:   Thu, 27 Jan 2022 14:07:39 -0500
Message-Id: <20220127190742.12776-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Just over 3 years ago, with commit a1e1cb72d9649 ("dm: fix redundant
IO accounting for bios that need splitting") I focused too narrowly on
fixing the reported potential for redundant accounting for IO totals.
Which, at least mentally for me, papered over how inaccurate all other
bio-based DM's IO accounting is for bios that get split.

This set fixes things up properly by allowing DM to start IO
accounting _after_ IO is submitted and a split is occurred.  The
proper start_time is still established (prior to submission), it is
passed in to a new __bio_start_io_acct().  This eliminates the need
for any DM hack to rewind block core's excessive accounting in the
face of a split bio recursing back to block core.

All said: If you'd provide your Acked-by(s) I'm happy to send this set
to Linus for v5.17-rc (and shepherd the changes into stable@ kernels).
Or you're welcome to pickup this set to send along (I'd obviously
still do any stable@ backports). NOTE: the 3rd patch references the
linux-dm.git commit id for the 1st patch.. so that'll require tweaking
no matter who sends the changes to Linus.

Please advise, thanks.
Mike

Mike Snitzer (3):
  block: add __bio_start_io_acct() to control start_time
  dm: revert partial fix for redundant bio-based IO accounting
  dm: properly fix redundant bio-based IO accounting

 block/blk-core.c       | 27 ++++++++++++++++++++-------
 drivers/md/dm.c        | 20 +++-----------------
 include/linux/blkdev.h |  1 +
 3 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.15.0

