Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D7C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 19:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbhLCTPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhLCTPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 14:15:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E9C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 11:12:27 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n26so3779943pff.3
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=I7V7pWqTOBEYWpETupUH4d0l+MFKC3/d0mfXGDS/uSE=;
        b=WBJBlg4G/t+UA7SCHV8JcVH3sPOp3U8FE+pte4lkqJ+IkkmwlA1MbkXYL90E36+d9q
         HeqRqG/JC3mUZWiy49C95XBtjwfEy1NBHgRZD0hXobbJ5qemwtEz6c6wVHWAkDJE1H5l
         Db7Gw+zyoQAQrU5TxEN+uVKUIoSW4yXDztbp+cKXbARf3SGJxej413YXVSIcfqwlA9ah
         WKKYrF2kaJ7dvjnDqso579q0PCIk5MbIjiih0EWxCGRA5DT3XyZ3XeCcgBIDIz+CeQzh
         /pyDEtRcDCu3sJ8n+S/gbhDiXIvmIzCForeajaTM612Vn4dBRr/zNW9h+sH78TJqpGQt
         NSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=I7V7pWqTOBEYWpETupUH4d0l+MFKC3/d0mfXGDS/uSE=;
        b=Waa1s3cEdOdOO09Z5yBjhrJ5E/BmvC+yJp2//sA1dgeViipme94+vOSvt8IwsyYIhx
         s2CfAmz2P+Qg4sfW5b+dwq3C8woxi38bfGhWXM0LDdocrg+dgkVVXRrAqBr4LRdDaD56
         ssHb9saeazszcWE7TrRaUU6AVHmVX6LYu/rPcMBj6nWW1PPR/IFz1l5GC9pj7CAdfC8I
         06CySfxw43xC/sJVqZGSKWxMSH+T/D+IdWqdEwJvxmOgy+R3Minw2oT04bA6Q+QYnzdu
         EVrX8OBLVipOEr6jRqSGiDwpADAu9OeVjcCTOrV2vB3SPCbjAKrt5sgVWjseIApRXLnO
         8vMQ==
X-Gm-Message-State: AOAM531eE9e8K6S9JHlF/bw72q6c48hWE4L9lHM5h9neouaq/IKPRIs0
        zDtI0sLgiM403D7PBOgwhbEm/kP1ytsUjHuH
X-Google-Smtp-Source: ABdhPJzdA63AYLJGtsmrjHYDFuIse1PRKoA/eCO+7nqq3c8Ev1la6NoLSYyURC1V+ZcKL+iHy6hCuA==
X-Received: by 2002:a63:1858:: with SMTP id 24mr6055200pgy.338.1638558746312;
        Fri, 03 Dec 2021 11:12:26 -0800 (PST)
Received: from [127.0.1.1] ([2600:380:7445:97b0:c22:6d1:fc86:abf7])
        by smtp.gmail.com with ESMTPSA id j4sm341363pgp.58.2021.12.03.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:12:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211203131534.3668411-1-ming.lei@redhat.com>
References: <20211203131534.3668411-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq: improve dispatch lock & quiesce implementation
Message-Id: <163855874530.329261.16162603083936025439.b4-ty@kernel.dk>
Date:   Fri, 03 Dec 2021 12:12:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 3 Dec 2021 21:15:30 +0800, Ming Lei wrote:
> The 1st patch replaces hctx_lock/hctx_unlock with
> blk_mq_run_dispatch_ops(), so that the fast dispatch code path gets
> optimized a bit.
> 
> The 2nd patch moves srcu from hctx into request queue.
> 
> The last two patches call blk_mq_run_dispatch_ops once in case of
> issuing directly from list.
> 
> [...]

Applied, thanks!

[1/4] blk-mq: remove hctx_lock and hctx_unlock
      commit: 0ae36d0d96a27b748ade2b2f1550e52e9bafb137
[2/4] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
      commit: 8770079f7b1c48b6cf4a9853c3f5c071f5a8df55
[3/4] blk-mq: pass request queue to blk_mq_run_dispatch_ops
      commit: ffa0cfa2b689413db2a97fa2dad90218befa66f9
[4/4] blk-mq: run dispatch lock once in case of issuing from list
      commit: daa7d82f3e50cfe005d620672dfe939e8ed804b1

Best regards,
-- 
Jens Axboe


