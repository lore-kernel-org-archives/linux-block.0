Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26842C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA7D61374
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhJTQMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 12:12:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75809C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 09:10:21 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r6so10252243oiw.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ZVPpPne3hTAcsySPNM/JdUSxROLoLWQduZ0ukg/aGcU=;
        b=no+a4TOoa/yuVasJoRAakoU05XWEklc9FM7Tc5612B6pqupyZ2ii4oOBpMGzIvgeaj
         c6HrFK9uEzA7m/6rjzpj/jbdfsZLyxGw3H/fZ2XeF8pe+2Se+xOr1MGh8O8W6rIee0gf
         u2QcB7BJXOlwrbsk6U3ozuVF4E0iaLJ7Y5uuMbzC9cS3VFp0t8AG5NBic+3dA+8fqwPm
         BnTVeQhPGAf+9w5RNw28jNfCvIs2Ek6exw0fJjwSk8qfVpnv5I3F6LuW8KW9dSau0ozq
         qoR2Fsr6I99ttZb4bqThbyLxQ5TllS9/GoQst49cthWMpCRh8W055IW3z9WaqrxJDE5F
         jKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ZVPpPne3hTAcsySPNM/JdUSxROLoLWQduZ0ukg/aGcU=;
        b=kwW4ZHoB8uOEqVwxAg1U5V+t2wQUXE38F74qKUtwK3xIEtAJQyNR500PNCQK6ThsoK
         151wqbZDdD/Ls5/J9Fne2uLfchp3r/Bom4jkrXuqEI2d8fj2QcGv0qjQyDPfh+Paaej3
         hXyFp96CSNbKZ6/66aaByz/6CF8xcABePp9bI57qDyXd9Am9mKiQbl7Utg3X/POCn7ir
         A+xK5fhagkSChXzlk8w9KoM0RFtF44D8SVXj+ESmp4eclyZjAgcDxM3uIBZTBEgPO3rN
         C7wSFL57Cv5rdAAgpJBWgDnt0nLXq8u0XSXfMdkpNhk3EeoYmcCp081FNE76qJO3ki5O
         9oEg==
X-Gm-Message-State: AOAM531B3XMaWU0ns3j59NkfTmodHeg2cFpGN3IT40+URrlfUo7LSaUk
        ziSlUzDLEAXebk1BMiRpUPbWgg==
X-Google-Smtp-Source: ABdhPJxiRqdVDqKsvg7hRm82+e2FigxxVGFVwgVU0N/Hl2eFeaPWDCPxjyeSUaKANZwfGijoyk0c3Q==
X-Received: by 2002:a05:6808:2129:: with SMTP id r41mr292866oiw.110.1634746220468;
        Wed, 20 Oct 2021 09:10:20 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m23sm481459oom.34.2021.10.20.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:10:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20211020144119.142582-1-hch@lst.de>
References: <20211020144119.142582-1-hch@lst.de>
Subject: Re: cleanup and optimize block plug handling
Message-Id: <163474621989.782268.9399115618832147943.b4-ty@kernel.dk>
Date:   Wed, 20 Oct 2021 10:10:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Oct 2021 16:41:15 +0200, Christoph Hellwig wrote:
> this is a spinoff from Pavel's misc optimizations.  It shuld take care
> of his two painpoints and also cleans up the interface for flushing
> plugs a bit.
> 
> Diffstat:
>  block/blk-core.c       |   17 ++++++++---------
>  block/blk-mq.c         |    2 +-
>  block/blk-mq.h         |    1 +
>  fs/fs-writeback.c      |    5 +++--
>  include/linux/blk-mq.h |    2 --
>  include/linux/blkdev.h |   29 ++++-------------------------
>  kernel/sched/core.c    |    5 +++--
>  7 files changed, 20 insertions(+), 41 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] blk-mq: only flush requests from the plug in blk_mq_submit_bio
      commit: a214b949d8e365583dd67441f6f608f0b20f7f52
[2/4] blk-mq: move blk_mq_flush_plug_list to block/blk-mq.h
      commit: dbb6f764a079d1dea883c6f2439d91db4f0fb2f2
[3/4] block: optimise blk_flush_plug_list
      commit: b600455d84307696b3cb7debdaf3081080748409
[4/4] block: cleanup the flush plug helpers
      commit: 008f75a20e7072d0840ec323c39b42206f3fa8a0

Best regards,
-- 
Jens Axboe


