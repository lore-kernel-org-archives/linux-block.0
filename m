Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C3AC05027
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 17:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjBCRSM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjBCRSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 12:18:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478B21A39
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 09:18:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so9452253pjq.0
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2023 09:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/gOe5c4d8g4HlmwXcDcqeT+1g0VQI8Av9sZXDtgtRk=;
        b=wVGuDktsLDUFo44IpWODMNa/V8eF+q+w1L52f/+4zRlfsZAuFkNhv4yLmxi4maRo1n
         1tOFM2J+e2CKebBqs6wVbOt3NisbDGPQu+jkrFm3oI0eZa1GTCzsvx9mw1AKj4et8HPz
         JBMjU/CkPQBFSlQfu0kiwJdOfB1WMLrhO9Qfg0yWCh/FUuNtLiwBIEdypM6+sP37X1cA
         wi/wQS1P+txRXfrn5WWYPcwmzqY8mzCBQaiy02DT8U59sI84cGD44nRntk72w84X8lpI
         nSARdEYOnSAhWtRSVas+02Tl0WztFcWo1mYf8ANNGfhm2KOcg+cejCtuwEjDD/6pVLGc
         3+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/gOe5c4d8g4HlmwXcDcqeT+1g0VQI8Av9sZXDtgtRk=;
        b=0bW3ARz5P8twI9f/Wm6haQ4+8UOLLBrmrmjx969B+g6wh0fCSAYFB75Z2WBahW8RB4
         Ld4TvpSAuhe2T0Hu6Mt0s3ruFVcKQPbcoSxkgUS7PuSviAlGZ7tDPwa1rzJQnbee/s41
         0Xqhp3vVXZ+7s56eBess2JatqgDJlCm/yZxbxWecet7WkxXDMvRXZ8Wwz4kMNsyezWUX
         SmQWX+q5yhSXAapARgc86HjPtl6tZFhQJozJbD0AMhnHme8tO30Phd+cyyxMZwkdaKCU
         8nPrkCszZKHUU5GrFBPSV3sRE09cWt+HaQrQMzPIzmutkO4NtWPS00c2sBJcfl4ljZGH
         ieFA==
X-Gm-Message-State: AO0yUKXblKWp+tJSFKYVwEUuQww8nlg+0rckOlstjBFyUq72tC/hTGwJ
        aX0HbGTAGOTPWXZ77CFyUAlc8pYg2SuZD7ug
X-Google-Smtp-Source: AK7set/Nhox+fodPv6peRODQ9dYYOL+p0aof8vKcSmFJRARZwKihRKoQ8aSfc1sKca4xs87HS0JQhA==
X-Received: by 2002:a05:6a20:3d88:b0:be:cd93:66cd with SMTP id s8-20020a056a203d8800b000becd9366cdmr14186941pzi.2.1675444689059;
        Fri, 03 Feb 2023 09:18:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a6e4100b0021900ba8eeesm5189271pjm.2.2023.02.03.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:18:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
Subject: Re: switch blk-cgroup to work on gendisk v4
Message-Id: <167544468813.66559.10558458278064918482.b4-ty@kernel.dk>
Date:   Fri, 03 Feb 2023 10:18:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 03 Feb 2023 16:03:41 +0100, Christoph Hellwig wrote:
> blk-cgroup works on only on live disks and "file system" I/O from bios.
> This all the information should be in the gendisk, and not the
> request_queue that also exists for pure passthrough request based
> devices.
> 
> Changes since v3:
>  - improve a commit log
>  - drop a change to not acquire a pointless disk reference
> 
> [...]

Applied, thanks!

[01/19] block: don't call blk_throtl_stat_add for non-READ/WRITE commands
        commit: a886001c2da8dd02357d0d336ddb021903347f89
[02/19] blk-cgroup: delay blk-cgroup initialization until add_disk
        commit: 178fa7d49815ea8001f43ade37a22072829fd8ab
[03/19] blk-cgroup: improve error unwinding in blkg_alloc
        commit: 0b6f93bdf07e52620f725f721e547408e0d04c9d
[04/19] blk-cgroup: simplify blkg freeing from initialization failure paths
        commit: 27b642b07a4a5eb44dffa94a5171ce468bdc46f9
[05/19] blk-cgroup: remove the !bdi->dev check in blkg_dev_name
        commit: 180b04d450a7137270c12dbb6bebf1d5e6c0a6f2
[06/19] blk-cgroup: pin the gendisk in struct blkcg_gq
        commit: 84d7d462b16dd5f0bf7c7ca9254bf81db2c952a2
[07/19] blk-cgroup: store a gendisk to throttle in struct task_struct
        commit: f05837ed73d0c73e950b2d9f2612febb0d3d451e
[08/19] blk-wbt: pass a gendisk to wbt_{enable,disable}_default
        commit: 04aad37be1a88de6a1919996a615437ac74de479
[09/19] blk-wbt: pass a gendisk to wbt_init
        commit: 958f29654747a54f2272eb478e493eb97f492e06
[10/19] blk-wbt: move private information from blk-wbt.h to blk-wbt.c
        commit: 0bc65bd41dfd2f75b9f38812326d767db5cd0663
[11/19] blk-wbt: open code wbt_queue_depth_changed in wbt_init
        commit: 4e1d91ae876bd12f327340f11a16a1278985e7e1
[12/19] blk-rq-qos: move rq_qos_add and rq_qos_del out of line
        commit: b494f9c566ba5fe2cc8abe67fdeb0332c6b48d4b
[13/19] blk-rq-qos: make rq_qos_add and rq_qos_del more useful
        commit: ce57b558604e68277d31ca5ce49ec4579a8618c5
[14/19] blk-rq-qos: constify rq_qos_ops
        commit: 3963d84df7974b6687cb34bce3b9e0b2686f839c
[15/19] blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos
        commit: ba91c849fa50dbc6519cf7808177b3a9b7f6bc97
[16/19] blk-cgroup: pass a gendisk to blkcg_{de,}activate_policy
        commit: 40e4996ec099a301083eb7e29095ebdfc31443da
[17/19] blk-cgroup: pass a gendisk to pd_alloc_fn
        commit: 0a0b4f79db2e6e745672aa3852cf5fdf7af14a0f
[18/19] blk-cgroup: pass a gendisk to blkg_lookup
        commit: 479664cee14d8452d3d76f8d0b7fccd0cbe4ed49
[19/19] blk-cgroup: move the cgroup information to struct gendisk
        commit: 3f13ab7c80fdb0ada86a8e3e818960bc1ccbaa59

Best regards,
-- 
Jens Axboe



