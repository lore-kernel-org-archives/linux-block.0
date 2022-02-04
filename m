Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0047BC433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 14:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359386AbiBDOnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359385AbiBDOnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 09:43:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F59C061714
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 06:43:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso6311342pjt.3
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=WutBl0QBGx1pfuztZArDy53so35nYoGLBU641tHFA5E=;
        b=5gLVPsHkRMBCV3E2Lf+LAZfl+lzQIxL8Dx8Ab7iW8SOaOjyaFuD4bPeO6+4n7dxN4f
         iRduYxxz46TcrYyX+1Ap0liSOrAFAXvfPsN4qY3fQaX+BVHW9pb73FM1FKbk7roOUQRO
         0BjkojN1tKKuNenJkR7GBuZ5Mb+ArbvidZ2wkuyKdKG57XlG1tBiNfGikC8Iame6xsTe
         jtDZ/jbvWCD9VvaWHpQSPrbCiRdCsHkigU+lcXMijK7epLnz6DEi/Jo9+lafuDW94ZRb
         ysIOKKVQL32DJkrl070vAgP97yYeEKcA0rVgMzTgfSbXDdyOKCYNziiX6F6rYHWr/JQm
         u8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=WutBl0QBGx1pfuztZArDy53so35nYoGLBU641tHFA5E=;
        b=wH7QB6GUvMOP4qRBjGCXO2OIsVLV79sWns+kaLnAknjrqxK5lLdxpZkE9JjCowdbKE
         ytbDT5ynSWa//iLS0+YZ4V8sw6RvUH/8PvYpBK4q4/srFsM00IiZjS5XiuK9TtTUhwjP
         O/hxbkIKPmKmFHu86Z0uZzUr3M6u3WvNwB4bzfg+nqi0E2CUZCITNxzoEtza9237k/Tf
         tJtSOhXeiw+xSbYChpnenHlCsELzNIOrn9QF+ebzAw/MMKqnCzFbJc4QzDaBuisK2D+Y
         Gkhl552zJGEZ0UrD6UTmlJbE2TqbKJ2b+5A4XCSXoaqlFcxOthsmxsVUQnGA5AZj5ogM
         Etww==
X-Gm-Message-State: AOAM531vnzwQQI/jTT2sxrgTz3lMzHP+Fg9TNLHK1Ei3f9oJviQKGTuf
        lRGz6NUAeKXwPIpUJxEpFcNt7g==
X-Google-Smtp-Source: ABdhPJyjdkHc+scNtjJ/hehBMbW1t656mFAyg1ZRbmeSiQlqVZ7Age59IT9W0N6D7yrhQorPc/BDeA==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr3528802pje.161.1643985818424;
        Fri, 04 Feb 2022 06:43:38 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id pf4sm15474779pjb.35.2022.02.04.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:43:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Mike Snitzer <snitzer@redhat.com>
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
Subject: Re: improve the bio cloning interface v2
Message-Id: <164398581785.446137.16953674702943074856.b4-ty@kernel.dk>
Date:   Fri, 04 Feb 2022 07:43:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2 Feb 2022 17:00:56 +0100, Christoph Hellwig wrote:
> this series changes the bio cloning interface to match the rest changes
> to the bio allocation interface and passes the block_device and operation
> to the cloning helpers.  In addition it renames the cloning helpers to
> be more descriptive.
> 
> To get there it requires a bit of refactoring in the device mapper code.
> 
> [...]

Applied, thanks!

[01/13] drbd: set ->bi_bdev in drbd_req_new
        commit: c347a787e34cba0e5a80a04082dacaf259105605
[02/13] dm: add a clone_to_tio helper
        commit: 6c23f0bd7f16d88c774db37b30c5da82811c41be
[03/13] dm: fold clone_bio into __clone_and_map_data_bio
        commit: b1bee79237ce0ab43ef7fe66aa6e5c4783165012
[04/13] dm: fold __send_duplicate_bios into __clone_and_map_simple_bio
        commit: 8eabf5d0a7bd9226d6cc25402dde67f372aae838
[05/13] dm: move cloning the bio into alloc_tio
        commit: dc8e2021da71f6b2d5971f98ee3e528cf30c409c
[06/13] dm: pass the bio instead of tio to __map_bio
        commit: 1561b396106d759fdf5f9a71b412e068f74d2cc9
[07/13] dm: retun the clone bio from alloc_tio
        commit: 1d1068cecff70cb8e48c7cb0ba27cc3fd906eb31
[08/13] dm: simplify the single bio fast path in __send_duplicate_bios
        commit: 891fced644a7529bfd4b1436b2341527ce8f68ad
[09/13] dm-cache: remove __remap_to_origin_clear_discard
        commit: 3c4b455ef8acdacd0e5ecd33428d4f32f861637a
[10/13] block: clone crypto and integrity data in __bio_clone_fast
        commit: 56b4b5abcdab6daf71c5536fca2772f178590e06
[11/13] dm: use bio_clone_fast in alloc_io/alloc_tio
        commit: 92986f6b4c8a2c24d3a36b80140624f80fd93de4
[12/13] block: initialize the target bio in __bio_clone_fast
        commit: a0e8de798dd6710a69d69ec57b246a0e34c4a695
[13/13] block: pass a block_device to bio_clone_fast
        commit: abfc426d1b2fb2176df59851a64223b58ddae7e7

Best regards,
-- 
Jens Axboe


