Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5935DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiF2RLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiF2RLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 13:11:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA91AD86
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 10:11:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 65so15663532pfw.11
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Zb4/aY6E1qSlItEgEd6ywE5d9Ix6kZf5/po5ijStHyA=;
        b=28ZC9Mn9+ferBmtO8Hrfi+xboVhSzszu95wC29SgegzNys9oDvC6gcKZhPriI7VcW8
         Dq9IjJWHEAmqvLIbpqxh2flSVCgZo1O/0A2pJkLd4WbtrZ5Y+52BoFINozPPt7MOmTV+
         /rCQI7uEgb5MnLF5HEcv4P79qFTxLJ45QhecEwxwIq8EOOioVgBk/OOvty/Z1DUKzkwO
         3vOgzbb/tEfSRl9WCFOEl6xw/HtpLplIym2zEXCs3jDxcBAVoXsIsw/Y8dSs8ifTNXOe
         ZGAJdvPPLt+q2Yac2wW3pcRHsDVwGatuBNPS3NGH3GQteZ8eRKAWtcMYQjFe+tqsJ9iv
         aM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Zb4/aY6E1qSlItEgEd6ywE5d9Ix6kZf5/po5ijStHyA=;
        b=jOs5P2rEdY7GKtK6bKhUmMKgpxNjTkrS+DdKJ7rKddzFi9iLCKh5RHABf1PUDGmMMc
         e3mkjGeN1/KwoKPpH6iHWJB+ciGMiyrv5W07w1yRtknS72dbDeKoJIMeF0LbOFtWh6Pz
         feB5NVm1iU1KYGZYYii9kUeirTda7livJT9kWoXYac0f/a7iALm0yTCuRY18hULwOshS
         /fMeTeJC4B6QfQVyHjtGHv1TNfAP9jtcvqU1aQVyig1Vb3FPNbkmidc06WuOS+g8oJnn
         /7VHzYu5kFhxi0uXP7Cb/m3Ss51EvA4XRZhX33csMtUB2rgETQkOeBbLyO7K2GeV99G/
         MNuw==
X-Gm-Message-State: AJIora+V6nRgdJky4MDpO+ztm+SNnWZfwgj09clKaRjjqxoqrZi7GYAw
        aNw0btjkDmE8wV97lXtm/MuuQUH31saejA==
X-Google-Smtp-Source: AGRyM1tuwEp/tqWndrtYRSEJoxCksKickjJ2hCWAoqqU5PKx1Z5b40QRei2E/SYB7/exsVN406uIRA==
X-Received: by 2002:a05:6a00:16c1:b0:520:6ede:24fb with SMTP id l1-20020a056a0016c100b005206ede24fbmr10195571pfc.7.1656522660486;
        Wed, 29 Jun 2022 10:11:00 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090320d100b0016a38f8ba7fsm11663297plb.162.2022.06.29.10.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:11:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, jack@suse.cz, Christoph Hellwig <hch@lst.de>,
        yanaijie@huawei.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220629070917.3113016-1-yanaijie@huawei.com>
References: <20220629070917.3113016-1-yanaijie@huawei.com>
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
Message-Id: <165652265967.185141.4524482473734650672.b4-ty@kernel.dk>
Date:   Wed, 29 Jun 2022 11:10:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 29 Jun 2022 15:09:15 +0800, Jason Yan wrote:
> Two duplicated code segment refactors. No functional change.
> 
> v2->v3: Fix indentation and add review tags.
> v1->v2: Remove inline keyword of blkcg_iostat_update().
> 
> Jason Yan (2):
>   blk-cgroup: factor out blkcg_iostat_update()
>   blk-cgroup: factor out blkcg_free_all_cpd()
> 
> [...]

Applied, thanks!

[1/2] blk-cgroup: factor out blkcg_iostat_update()
      commit: 362b8c16f8fc73fddfe4bded25055fa0c9e2bf1e
[2/2] blk-cgroup: factor out blkcg_free_all_cpd()
      commit: e55cf798140518b900e5254093f1195f65c23026

Best regards,
-- 
Jens Axboe


