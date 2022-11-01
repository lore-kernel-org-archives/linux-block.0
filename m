Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72618C4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 14:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKAOSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKAOR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 10:17:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FF1BE8C
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 07:17:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so13579081pfh.6
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVsPtY3gVVM6m0QHBZpxv+Y/aCVxmoQdB7+i7F7TWCQ=;
        b=MM8TAdVEAPrMP4gB+CoMrgeFjUrfg/XOHPXB2QECZc6ixysal1mRzAx+qI0QpzX0Mz
         gYelXhLGuCHbx9ajsVOu/DG5uzVHmmbVYwGqNyzDvfg12PMKOxP4kxnfb4vP56g+Pr8Z
         8yqbNT4j14QXmo3RjpT+SElJHRyc97dv/wNR56e6EFusM7TcGLNlos+dmkne+7mjcV7O
         o87MC8/TvQ5OQdvXlNCmOiL9TuRQI8mMpOzB9gEmbzoNGY4WHkcgN3KaJse/OxNSWd0R
         WFoxseVM9ZtvF/DbweUs9EuL2pE47WQVZDUE9Q3uWWLnU2fzYjE8zObULHZJPlpSKBKp
         3fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVsPtY3gVVM6m0QHBZpxv+Y/aCVxmoQdB7+i7F7TWCQ=;
        b=MWzQuE+5DKUjaIp0XEGsujvWipLb3DA5vx6coVbh+6t9x5myDP+RiJrRdJqDhDA+97
         wbWOXc2vCVIelQ1rVpd5kAt3GFha/SUes5LyhTWX2yRGAbFjMQytBxnF96evD/YaUhx2
         JUxxo3s8o6lWOVauMGMCNRqmzIDPNO+ULe6z4a3Dq//UbxVeexm2b/aSMXim7Y+rYx98
         PqFenvS2XQ4XSskw/OFUaJrDOgBVu1u5HJtTrJ4v96gNzUDF0r+4CZ1sYMI5QAm9y68F
         Lvr4si5qztXoIbE5F3QgWdeyut9lJb9YZclBxZAluKuTEEoMCL51YW2p8m246eR4avPf
         1Zhg==
X-Gm-Message-State: ACrzQf2CE4aYiKp13Diz3J4ucToNXp4zY4gLV6DUT4sVFYWynp+GkJ5O
        tO3JiDtYbEffXWNkHVhE35fnjg==
X-Google-Smtp-Source: AMsMyM72gNO54ErtsjGoUazzXoJi35Y8ynT6N5Dt40dHY6HOEqnAG6xuh0sWSdTndAqizB3NaDV0eQ==
X-Received: by 2002:a63:4383:0:b0:440:3e0d:b9ec with SMTP id q125-20020a634383000000b004403e0db9ecmr17966187pga.54.1667312277768;
        Tue, 01 Nov 2022 07:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902bcc600b00186e2d57f79sm6386770pls.288.2022.11.01.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:17:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kemeng Shi <shikemeng@huawei.com>, josef@toxicpanda.com,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20221018111240.22612-1-shikemeng@huawei.com>
References: <20221018111240.22612-1-shikemeng@huawei.com>
Subject: Re: [PATCH v2 0/3] A few cleanup patches for blk-iolatency.c
Message-Id: <166731227683.256723.3065138031958824780.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 08:17:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Oct 2022 19:12:37 +0800, Kemeng Shi wrote:
> This series contains three cleanup patches to remove redundant check,
> correct comment and simplify struct iolatency_grp in blk-iolatency.c.
> 

Applied, thanks!

[1/3] block: Remove redundant parent blkcg_gp check in check_scale_change
      commit: b6e03072a91ecc815c9f62037871d621b09df2b3
[2/3] block: Correct comment for scale_cookie_change
      commit: 77445572e643538019d9919669ddf36efb6a353a
[3/3] block: Replace struct rq_depth with unsigned int in struct iolatency_grp
      commit: 718ac0e343f8fd81ab042aa4936d25fe10f6b318

Best regards,
-- 
Jens Axboe


