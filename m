Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E96BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D71F6103D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTAYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhJTAYK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 20:24:10 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE69C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 17:21:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o184so10505141iof.6
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZB3qGopYEqS8IjLqAnOijAkDWhWvTyFYGIOiiUlobw=;
        b=1bfnQ29cCRsQKLHUvPq2SzkeGc+vEryLgWODhUAhzE2C3TKn1vSTR7xfk2IyG2wmRV
         TkQhAtGkVnxkfrcH40BI6yJXGPn3I+ovgzzt2xbej8ieIbAdES4NJ2Abp4AATzP2vg/7
         A34edv796Fm3vbLWnhjNG+hPlAn4Zp0RvqfPT1GJHMxbQ06xolwaZpmJho+hykdoZ6/q
         bpUA2obwTSznQ7G5C/YL8DKSSHrFGfbhQhDd02sSz2L4R+rP4qrFGzN3cdsSn9f+F71D
         wkWnOTr1dRKujCNF5C8n7Pb7+0VxmekGSMPFLPwW1DVB4BtaMVRCWVztxBrZs814Dy9v
         910Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZB3qGopYEqS8IjLqAnOijAkDWhWvTyFYGIOiiUlobw=;
        b=p+Zqdose67XUMLkV/E+Iy/5nUDcJ4v7Ii0UEVSzAOw0nq7iQWKP1b1mT/x/qvfG/5K
         Mh7G8Arwrh0ufo/XPT0oMc2Hx11kdq1m9lihYC1Mxbp/VhDKxGmZK/NuhMjV2iqNFQ1l
         wIZOD9+aoq5JMdiLYgGpbPL+fVsgbIZ2V0w/yzH5ihedzt4+kAvK1p6GmqGwoE9hooym
         0LhjYDG2/wThRS0vZqfuX/UUPgJF7HNZ0SphCVMKz3z25lZmDnRQD5q+yefWnoCeKpyp
         XXYIsSD+bIj7XGciJoc8osxYPTg/rJPQB/xGfrgtbJ62uf2oqppQ6DR18MzJM9XT5bbM
         6I9g==
X-Gm-Message-State: AOAM5307az7r2RIHraloSWde8kIyjYUxlQ9gMBl3rq86eiOoSyngngAa
        BKwALNw8PcpsCBSyv6A/fVRW4YVYKp362Q==
X-Google-Smtp-Source: ABdhPJwNNbPbRmdtEMWLJ32UiU8aONLIIG2Iw9d1rIdxPWrsI/b5FhMl2WnuKHwhyh3CSsN3zTjTDQ==
X-Received: by 2002:a05:6638:1489:: with SMTP id j9mr4240841jak.18.1634689315847;
        Tue, 19 Oct 2021 17:21:55 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g3sm316621ile.61.2021.10.19.17.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 17:21:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 00/16] block optimisation round
Date:   Tue, 19 Oct 2021 18:21:52 -0600
Message-Id: <163468930893.717031.16208964380009227106.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 22:24:09 +0100, Pavel Begunkov wrote:
> Jens tried out a similar series with some not yet sent additions:
> 8.2-8.3 MIOPS -> ~9 MIOPS, or 8-10%.
> 
> 12/16 is bulky, but it nicely drives the numbers. Moreover, with
> it we can rid of some not used anymore optimisations in
> __blkdev_direct_IO() because it awlays serve multiple bios.
> E.g. no need in conditional referencing with DIO_MULTI_BIO,
> and _probably_ can be converted to chained bio.
> 
> [...]

Applied, thanks!

[01/16] block: turn macro helpers into inline functions
        (no commit info)
[02/16] block: convert leftovers to bdev_get_queue
        (no commit info)
[03/16] block: optimise req_bio_endio()
        (no commit info)
[04/16] block: don't bloat enter_queue with percpu_ref
        (no commit info)
[05/16] block: inline a part of bio_release_pages()
        (no commit info)
[06/16] block: clean up blk_mq_submit_bio() merging
        (no commit info)
[07/16] blocK: move plug flush functions to blk-mq.c
        (no commit info)
[08/16] block: optimise blk_flush_plug_list
        (no commit info)
[09/16] block: optimise boundary blkdev_read_iter's checks
        (no commit info)
[10/16] block: optimise blkdev_bio_end_io()
        (no commit info)
[11/16] block: add optimised version bio_set_dev()
        (no commit info)
[12/16] block: add single bio async direct IO helper
        (no commit info)
[13/16] block: add async version of bio_set_polled
        (no commit info)
[14/16] block: skip advance when async and not needed
        (no commit info)
[15/16] block: optimise blk_may_split for normal rw
        (no commit info)
[16/16] block: optimise submit_bio_checks for normal rw
        (no commit info)

Best regards,
-- 
Jens Axboe


