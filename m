Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1145DFA3748
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 13:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJaNcP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiJaNcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 09:32:14 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7652110058
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so10685299pgb.13
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugTm/u2jy4pd2kxS+scWBZjg6LGxe8n/YNYVW38sYhU=;
        b=u6qinkMCHoNyE0cGeyXTBzgI7tog6amMwjX3vhlMB8WA7uxXy/B/s75yNvyRM0nR93
         LbFr8TNBCgWDlTJsD4FZAHDOp5NpSOfjdnMaRasj1HarfJjC51EpQEwSpsshcC8M3zxq
         AanvPftdJZXBB1cSE6HiDeGhEHicM2n2QCaiAIEbfRV9SjSvBL+ZljKnfga770C1Ha9m
         Qp4BZh1kKlyf//GQfvQoAKCzZYf52bXavCfDnjPjFeGKOKw1tcIexmYr2anAu5rj42uZ
         idGKGVmv1PVPyTuvAhdFpoVu4HQaPzyxQfKpciah4DKuKVvB9HQ/r2r9aVEIiymA3cAN
         4kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugTm/u2jy4pd2kxS+scWBZjg6LGxe8n/YNYVW38sYhU=;
        b=TZ5JajekIpPtv1sQp8vxjErKtXYGdGugviNnLufflOHRu6aWBMC6YnE0kB0YyWe/dF
         g3nrqOVtHnz5sz86Cql+SzbF9kHG93OX6J1/uQi3EOA8Z2KPp55rSctlBQODwAEAqTif
         pObQZl5THWUjbzuCMfW9yokHpEMCF9mZi8Iu5ZIW8gIFZUmjWJyLtu/udKjwTxBsc/Uo
         rxFbDDJIKKNXO/lVbvUcOcfe+P2AofBkBuurlCBtJ93hT++lzODo2wnATh0We4cyAr0r
         2hnjIb6FCc0WFMeuQmqpULGxIBa0aWVxnAzpKFzmPtMjOTunPQ4FOvfT++H+YOc4RnK5
         2UUA==
X-Gm-Message-State: ACrzQf03wnCnnlgOwoJ1+i6Tx/crgAOcCbCMSFOb8+Bd2bKBnLen0tsN
        20H+YCQOTpjQanF+AalD1hqgwA==
X-Google-Smtp-Source: AMsMyM4ZKXTMAaJgpxx0z9iUkgeAJZtz+ff0/1Qqg35SH7vj1POacxOO2f9EMcB85IbXbJJP0kdnYg==
X-Received: by 2002:a63:f457:0:b0:46f:7e1c:8538 with SMTP id p23-20020a63f457000000b0046f7e1c8538mr12566090pgk.554.1667223132881;
        Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005668b26ade0sm4565791pfd.136.2022.10.31.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:32:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-block@vger.kernel.org
Cc:     mcgrof@kernel.org, hare@suse.de
In-Reply-To: <20221029071355.35462-1-chenzhongjin@huawei.com>
References: <20221029071355.35462-1-chenzhongjin@huawei.com>
Subject: Re: [PATCH] block: Fix possible memory leak for rq_wb on add_disk failure
Message-Id: <166722313202.68022.4514926407660406546.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:32:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 29 Oct 2022 15:13:55 +0800, Chen Zhongjin wrote:
> kmemleak reported memory leaks in device_add_disk():
> 
> kmemleak: 3 new suspected memory leaks
> 
> unreferenced object 0xffff88800f420800 (size 512):
>   comm "modprobe", pid 4275, jiffies 4295639067 (age 223.512s)
>   hex dump (first 32 bytes):
>     04 00 00 00 08 00 00 00 01 00 00 00 00 00 00 00  ................
>     00 e1 f5 05 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000d3662699>] kmalloc_trace+0x26/0x60
>     [<00000000edc7aadc>] wbt_init+0x50/0x6f0
>     [<0000000069601d16>] wbt_enable_default+0x157/0x1c0
>     [<0000000028fc393f>] blk_register_queue+0x2a4/0x420
>     [<000000007345a042>] device_add_disk+0x6fd/0xe40
>     [<0000000060e6aab0>] nbd_dev_add+0x828/0xbf0 [nbd]
>     ...
> 
> [...]

Applied, thanks!

[1/1] block: Fix possible memory leak for rq_wb on add_disk failure
      (no commit info)

Best regards,
-- 
Jens Axboe


