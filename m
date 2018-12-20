Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724AEC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4180A218C3
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uBpdciRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbeLTQBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:01:54 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:36054 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbeLTQBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:01:54 -0500
Received: by mail-it1-f176.google.com with SMTP id c9so2503591itj.1
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6CFXp9cw50IV8GUuwh6d+rhJHViQKENupRRaIajJMkc=;
        b=uBpdciRzThZxVeXyE19mECKiL4CGMFPHMXGJi571pFY+0ee8p+hxg6Rk98V5MLavnB
         6wAYs4LwO9RzfXy80EpQ2IX8JPvYZrQJBRNDVKZPGMSyMnZ12L+oJgrfkUvYegmNpEWN
         uv4vVc1mUkuQD1L66I4odiLw/24Pgsu17TNkPaPtwYulfEv2oMq43Nu2DzInFeEcDKuk
         nVa5hCi1gV6OtfexyaixPOedfTVn00SuTPMbU/s+bvnjmeJ2vUqrQq+c3C+N3czfZU5k
         6Qe5jGZGHrkuzv2Fztw08JgpvTssXS9mEQbz2nUKdBsfRellWy7fgxTDiu1O3W2GD+G3
         p5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6CFXp9cw50IV8GUuwh6d+rhJHViQKENupRRaIajJMkc=;
        b=l2GTQnMroVJNagDjXkakwTk/ql4/emnVEc2QgtPYENW44YBY84A9lZvjFu/WjheYt0
         auOXx/05/imQhMP96uB/TMvLZB409+WCVsfiOiBwnN9XxMg6RDic5KCchyQAaX/YlQdw
         sLRqbamwdgnsuzO55RSbA9l0Qsh5WGJUnxEpxaRYRclfsUeS4nGCGZAcErhlsvg/q2kV
         QsmD/7jTrqL8aJtn90n7rl+W4hXL5cpym/NijIhddTTNiPoynFk0ut2+8F2A7uR+RSbo
         M5ONMQQdtefiBbCopCMvRy7R1ikcfovHFqUzC/Xis75ogZIvPUDkioFfIl4JmaIm3Ytg
         DCRQ==
X-Gm-Message-State: AA+aEWZBc1FTpppnRhlQ96pHZ+0EUnQOL4tD2k06hpI7KVACbroa3PMd
        nymt8FpfHECfkBYoKuKhx6VPHnRnSigm4Q==
X-Google-Smtp-Source: AFSGD/VVq7S1tULMJw9u6QHnymt1LSsYo8eGfFscsEX+qD9nc05JDkF2AYqWGL40ckuuc4HZh/G67w==
X-Received: by 2002:a24:248:: with SMTP id 69mr9862469itu.91.1545321712269;
        Thu, 20 Dec 2018 08:01:52 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x99sm4974365ita.23.2018.12.20.08.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:01:51 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, osandov@osandov.com
Subject: [PATCHSET v2] Fix kyber hang
Date:   Thu, 20 Dec 2018 09:01:47 -0700
Message-Id: <20181220160149.4042-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the wrong kyber patch was included in the first one, here's a
v2 with just that one line corrected.

First one adds the necessary sbitmap helpers for users to be able to
do add_wait_queue() and list_del(wait_entry) type operations, and
still work with the optimized wakeup checking.

Second one converts kyber to use it, fixing a hang with domain tokens.

-- 
Jens Axboe


