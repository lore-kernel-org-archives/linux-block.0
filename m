Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F5DC07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 01:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiI0BTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiI0BTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 21:19:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16CF248FA
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 18:19:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b23so8328880pfp.9
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=ZjyZ4yzXnb8TF9SAaoOWcept8gWfCAEasPAqh6Frv6Y=;
        b=Hd4shHarLOa1gWwquDK/lsKJlVT7u5ciMO+WJGRcMkEX58cF+LFbnwFYbwJ59Twg2r
         lXztfdkr78QQp/UR3oJH/O/IucYhxwYSHXlzMEj3hJLKclNs264B9ESNjBRlUr8hN0gg
         Kan1tAxiuGm//Z62Dl782QilqXLJsrGtFHqFgZyAI3E9SLmKHAk5ALCu5HW8/r9Mz1rd
         +hdcLpqgFUNAj3VGT970yKJj+b/1r14a3AMs+4BbgZ0sWPDwa+/1eB2ndQnfRHpJmSA0
         A1+J2FAuxbPuaydgSixBGkSdRMFfu+KMRvTSw3EfXpGLZ+Sofp1ITsanL3AZUJgWKG5I
         3yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZjyZ4yzXnb8TF9SAaoOWcept8gWfCAEasPAqh6Frv6Y=;
        b=NzrIit+F8Hlj6KLidB098SnjTDltIRxGSN4U7Wbca5/s2DDwYY4zgFD9IqCAdOTGQV
         gfT8bp5Nz7jCKSx/7khgUlKIjzVIQWFQ4JwwLk9ezUR4QaH+QG+etokJTcW7h0b8Cw8Y
         bJLOHVo6jra1lCcSCO88XmmAZcg7APvQ5nZhN46c0eZ1G+nna1BEdTYXGRG5xCxKSDVF
         FmE6z8Q6Vlm6tsFLRJcB2Ve1faTSPd2i1g0tGUuPT3oTHV2e3sYitaam0mRIi1Tg4RnU
         iM1aARO55Gm3/6pTOTN+9SMgpZRgkPrgk7usm4jNefYXlvJXs0T6LncfPinR2bn26pFY
         ysgg==
X-Gm-Message-State: ACrzQf0/Bj51X7v1hQZrhq8d6TLIeHE0D5M2XVL58bHd53rwDtPikyp/
        4n2ouTHt6MnJ3cow1MGOVtZVLBS8FSuPZg==
X-Google-Smtp-Source: AMsMyM7bc2U6z6a/Xh4/nGFBxkOUN7RQ6btyACJZ10GmC2IttCYCGFvSwMo3j7+PG5n37XMqG00N4Q==
X-Received: by 2002:a05:6a00:1390:b0:540:b6b6:e978 with SMTP id t16-20020a056a00139000b00540b6b6e978mr26460625pfg.8.1664241578062;
        Mon, 26 Sep 2022 18:19:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090a150600b002001c9bf22esm109278pja.8.2022.09.26.18.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:19:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
Subject: Re: blk-cgroup cleanups
Message-Id: <166424157734.27933.5286509804789927275.b4-ty@kernel.dk>
Date:   Mon, 26 Sep 2022 19:19:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 21 Sep 2022 20:04:44 +0200, Christoph Hellwig wrote:
> this series has a bunch of blk-cgroup cleanups and preparation
> for preparing to make blk-cgroup gendisk based.  Another series
> for the next merge window will follow for the real changes that
> include refcounting updates.
> 
> Diffstat:
>  block/blk-cgroup.c         |  186 +++++++++++++++++----------------------------
>  block/blk-cgroup.h         |   68 ++++------------
>  block/blk-iocost.c         |   37 ++++----
>  block/blk-iolatency.c      |    5 -
>  block/blk-ioprio.c         |    8 -
>  block/blk-ioprio.h         |    8 -
>  block/blk-sysfs.c          |    2
>  block/blk-throttle.c       |   13 ++-
>  block/blk-throttle.h       |   16 +--
>  block/blk.h                |    4
>  block/genhd.c              |    7 -
>  include/linux/blk-cgroup.h |    5 -
>  mm/swapfile.c              |    2
>  13 files changed, 148 insertions(+), 213 deletions(-)
> 
> [...]

Applied, thanks!

[01/17] blk-cgroup: fix error unwinding in blkcg_init_queue
        commit: 33dc62796cb657a633050138a86253fb2a553713
[02/17] blk-cgroup: remove blk_queue_root_blkg
        commit: 928f6f00a91ecbef6cb1fe59474831ceaf205290
[03/17] blk-cgroup: remove open coded blkg_lookup instances
        commit: 79fcc5be93e5b17a2a5d36553f7a5c1ad9e953b6
[04/17] blk-cgroup: cleanup the blkg_lookup family of functions
        commit: 4a69f325aa43847e0827fbfe4b3623307b0c9baa
[05/17] blk-cgroup: remove blkg_lookup_check
        commit: f753526e327bc849c445c084d0f374e992038ae9
[06/17] blk-cgroup: pass a gendisk to blkcg_init_queue and blkcg_exit_queue
        commit: 9823538fb7efe66ce987a1e4c0e0f3dc882623c4
[07/17] blk-ioprio: pass a gendisk to blk_ioprio_init and blk_ioprio_exit
        commit: b0dde3f5d628f76f461fb650e2cebfac3460cff6
[08/17] blk-iolatency: pass a gendisk to blk_iolatency_init
        commit: 16fac1b5912b778a30d8863dbc928bef25c8d307
[09/17] blk-iocost: simplify ioc_name
        commit: 9df3e65139b923dfe98f76b7057882c7afb2d3e4
[10/17] blk-iocost: pass a gendisk to blk_iocost_init
        commit: 57b64554977e28ab84d33d298032872a8047a557
[11/17] blk-iocost: cleanup ioc_qos_write
        commit: 3657647e33dff916a2d2d9df926d9bca3907d34f
[12/17] blk-throttle: pass a gendisk to blk_throtl_init and blk_throtl_exit
        commit: e13793bae65919cd3e6a7827f8d30f4dbb8584ee
[13/17] blk-throttle: pass a gendisk to blk_throtl_register_queue
        commit: 5f6dc7522ac2e1701c92f20b9a1a664736787728
[14/17] blk-throttle: pass a gendisk to blk_throtl_cancel_bios
        commit: cad9266abcef586aa95f6f4095781e3e55473f2a
[15/17] blk-cgroup: pass a gendisk to blkg_destroy_all
        commit: 00ad6991bbae116b7c83f68754edd6f4d5e65e01
[16/17] blk-cgroup: pass a gendisk to blkcg_schedule_throttle
        commit: de185b56e8a62822d4e1cdb3e068b38ca709aa47
[17/17] blk-cgroup: pass a gendisk to the blkg allocation helpers
        commit: 99e603874366be1115b40ecbc0e25847186d84ea

Best regards,
-- 
Jens Axboe


