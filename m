Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88376C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKANKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKANKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 09:10:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE50E1A82F
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 06:10:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b11so13144936pjp.2
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HodXEuYzqCTG15c9CAh+5cByd+S8fmEjuYPaH6ghzhM=;
        b=knk5c/ux/y+eglyyWWu4j84v8Ixq48CJt4i6w1OYiGXLO7ZbsDuN1LZ9K8gjNEXT5/
         hbIWLRqA0lkXtkUwHfcsuW6QYxCGdKl4w/kXLoRohhz0aTjbuaZBnVK7wqeCOUWdxd+9
         6tKG/0IlXKVbwFh5KlXOe+TNLH/3M75z2O8Pzk/QRl1hHGe3YIdoGxMdNr8cW7DzKs7n
         1zthSjGfeet4uE2cKkMEoucbJKxS23TnfcQu62MBMB0DcvbqhYkIIdcTHSKzZGxWMNok
         +kXWDnlzy7os746o9KBcVFg0NpEbqyOLCxLYpInlga+0m8H2YbadRiCDV1SWVAGjiwvs
         JI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HodXEuYzqCTG15c9CAh+5cByd+S8fmEjuYPaH6ghzhM=;
        b=hoKq7XS+ARxGinSwrJvyhLmUBkzBTz34t7hAe0oXsBeWYxgi5mtHcKQCT13PXoPHVK
         cd/HbNrpePNA+4XZWnUk4cyYGRNJgpFLdQkQOm+IrKw4fc4jAyLm2lxLX8Vt2v8qa5Ab
         ub2x/k66XIyZoRwOHBo1KS2oe/cwwK2YoecweBB1YMjziR72LUFnV8gWnzr7Q1Zi7GsH
         orua4xpg7ybcSyR1ZucUUXRoLVKTa/HFT0zSi1TRiQs1uCNDBUzUsYVvIxnzmL7KvQtl
         BR2hAbKIcXTuOz8Adyxufl7RFJtUbgOhexeDhSMTzHBlDtWytuFL91NikRA6ST61tEjT
         OSmA==
X-Gm-Message-State: ACrzQf3NXh0ODcG1Yu4Jwq/FdEqfoaZ+A72hZV75LYg/7SMphSMPgnq0
        Y9QGX/HcQpMlK51xc7GTOlRtvg==
X-Google-Smtp-Source: AMsMyM7AsUERJZGxdlKUJXlDnooCAE7Bx7toADGqJAI1DxXNkDerEMNtwcPUtTk3YLcZ4bhI9ecSXg==
X-Received: by 2002:a17:903:183:b0:184:8c1a:7a95 with SMTP id z3-20020a170903018300b001848c1a7a95mr19464851plg.137.1667308208882;
        Tue, 01 Nov 2022 06:10:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f70700b0016c50179b1esm6335596plo.152.2022.11.01.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 06:10:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, paolo.valente@linaro.org,
        tj@kernel.org, jack@suse.cz
Cc:     yukuai3@huawei.com, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
In-Reply-To: <20220916071942.214222-1-yukuai1@huaweicloud.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail occasion
Message-Id: <166730820758.252147.11493585744578710855.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 07:10:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 16 Sep 2022 15:19:36 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v11:
>  - keep the comments in bfq_weights_tree_remove() and move it to the
>  caller where bfqq can be freed.
>  - add two followed up cleanup patches.
> 
> [...]

Applied, thanks!

[1/6] block, bfq: support to track if bfqq has pending requests
      commit: 3d89bd12d352e20f4f7c8f11a0f1a712b95a5295
[2/6] block, bfq: record how many queues have pending requests
      commit: 60a6e10c537a7459dd53882186bd16fff257fb03
[3/6] block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
      commit: 71f8ca77cb8764d46f656b725999e8b8b1aec215
[4/6] block, bfq: do not idle if only one group is activated
      commit: eed3ecc991c90a4a0ce32ea2b35378dc351f012b
[5/6] block, bfq: cleanup bfq_weights_tree add/remove apis
      commit: afdba14612622ec75896e5646950b3562a9aadd3
[6/6] block, bfq: cleanup __bfq_weights_tree_remove()
      commit: eb5bca73655cb6aa3bb608253e1e47283240c933

Best regards,
-- 
Jens Axboe


