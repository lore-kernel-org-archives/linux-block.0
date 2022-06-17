Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C7C43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381174AbiFQMja (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiFQMj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 08:39:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B162CF6
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:39:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso3199261pjd.3
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=prc6vo9UtEUb0+NEUXY+sEuVoqXzXH159hY5xoOO6Yg=;
        b=QiaHSkTnafDVQCn/pj26ojcYfjeiZwd4rGYY+pmuB7k38kCfZ+RY/wCEf3y644giy4
         hlyOMEq05STdSG6HSF0fcptMgxjzwq4yUwidTAkRIMkIgat04qGCo53oP537czvy4NW8
         qKIEd5X0F3/JzEjJ+OpEfzApdkNSHKqMcMPBImJzRuS0/OxjGR1TwEA63A9djdUBoQZA
         /KjC+cp4IrF98TQwNAXrjbuasaYl4N7tyn1gnZAXFVHEbaq9x4LEWY4HsJ3ZKUkFe2Gr
         Mwyl94Hs3FRF7i9A+o1u2zXjMqDqO8/gj2HrOqWf6LdD0y/aNV7HmYnbWLr4SSC5ydGs
         HmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=prc6vo9UtEUb0+NEUXY+sEuVoqXzXH159hY5xoOO6Yg=;
        b=Xc6bVgDxI28kq0JOxFp7CwO8zdN5wbO4b+LhYX4NCk0JxmWkBzk++im48pTYoLDC44
         SZ/HHGQChNeN62dbz7KSwc9MPE4B11L7eVBK+4kQ+UQayvpzHMv2U93pxVk+nRQ20sw1
         SwZawA+8xN0OBv89kt0yQ1xivPyatjxXRgiTPbeuFi5i7lQdVf47fYODOrv0jIzIeY8r
         xS9QbGmPPcRu7GDdDtH9PfPKBANBAkGmTLagAM+GKvHQVemlbre4S3dhB8tZGdyWTS4w
         P01TnNEoekgWckmZicwcl4OKm10u+OEXuk6Gj2l9qB4GGgcnKCqXo0WMdmrjUAnOJrYQ
         xb/Q==
X-Gm-Message-State: AJIora/GF1zR1E5tIETnyMmYmbQgyFjImcJtHGCjTYQSTDnolQuUvzSM
        XcPxih/goU4kaMIGRdUrURUz4T+LrTzmlA==
X-Google-Smtp-Source: AGRyM1sCJQxpCz0Cb2KjTNHJhkP1bkBVMukKykWQ+XRJIPXAB31d8VQjRg8AZp0cECmhhASSlWm4/Q==
X-Received: by 2002:a17:902:64c2:b0:168:c298:bdee with SMTP id y2-20020a17090264c200b00168c298bdeemr9497058pli.82.1655469567752;
        Fri, 17 Jun 2022 05:39:27 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nk10-20020a17090b194a00b001e2f53e1042sm5529503pjb.7.2022.06.17.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:39:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        snitzer@kernel.org
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
Subject: Re: clean up the chunk_sizehandling helpers a little
Message-Id: <165546956681.341943.17711027449182235917.b4-ty@kernel.dk>
Date:   Fri, 17 Jun 2022 06:39:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 14 Jun 2022 11:09:28 +0200, Christoph Hellwig wrote:
> this series cleans up a bunch of block layer helpers related to the chunk
> size.
> 
> Diffstat:
>  block/blk-merge.c      |   28 ++++++++++++++++------------
>  block/blk.h            |   13 +++++++++++++
>  drivers/md/dm.c        |   17 ++++++-----------
>  include/linux/blkdev.h |   39 +++++++--------------------------------
>  4 files changed, 42 insertions(+), 55 deletions(-)
> 
> [...]

Applied, thanks!

[1/6] block: factor out a chunk_size_left helper
      commit: d0e3310bb972f65c4b614c29f8022f57a52123c8
[2/6] dm: open code blk_max_size_offset in max_io_len
      commit: 6d5661a5d0e513dde5d49820315c5d6249a5c732
[3/6] block: open code blk_max_size_offset in blk_rq_get_max_sectors
      commit: 92ac28684e7eccf968b556893ca09c57d1fb3cdd
[4/6] block: cleanup variable naming in get_max_io_size
      commit: 08fdba80df1fd78a22b00e96ffd062a5bbaf8d8e
[5/6] block: fold blk_max_size_offset into get_max_io_size
      commit: d8f1d38c87b87ea3a0a0c58b6386333731e29470
[6/6] block: move blk_queue_get_max_sectors to blk.h
      commit: d8fca63495fb21e9b2dfcf722346aa844459139a

Best regards,
-- 
Jens Axboe


