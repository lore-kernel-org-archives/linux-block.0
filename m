Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C364DC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74777218D2
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JChw2043"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBIWo3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:44:29 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33591 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfBIWo3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 17:44:29 -0500
Received: by mail-pl1-f171.google.com with SMTP id y10so963767plp.0
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=fwO/Me/MCyoWV60XtF39PF6pZXkNqPYXYn7CNi7H7ws=;
        b=JChw2043EN4U+DD7WWfVDrLe3ku3DVNKgZ1yeme9J79GOUI/MJD73sk2PNZH6aBX5E
         bMv5vjWkI6OndvWELchZks8VNZGct2kyC7t7S0Nox/BbyGFxg354FA1PzKcBLX1EAqW8
         3HkES9h+HiG6DnbjfUKwy9PKUg2eiReA03ZeiZcBfTTf3M2fSWYGB2Mq91eW6OplzUop
         FNHvnjpyPQJu7FGv7pQ72mIJcoNbFOE6vrDz1rDsMpCjsrCJa+RJl1SGpoJ2yt14/oQc
         0f9EH6P+yBu6dJIJdvOzQUqpRf3K4CtmTcVk+LH5Dsw0IpM+xJyfLrO0Y0RgagyIk2dH
         qoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fwO/Me/MCyoWV60XtF39PF6pZXkNqPYXYn7CNi7H7ws=;
        b=hj6vMYxy4HQjhEsceyG1/bWMvmWPAuVC4SeZa/7XZ5GflKE6v/JeEJEQhBp4zWQxAJ
         H8PASEsWrdlHQNuM8Vo4xUg5xahjz1Tol/hIRt1c46sw6Y3EToYm2lLex7eWqUMxRkUO
         h6XQ4+V3nK0iMI5A6fUYUDu5lXSkHayppNe3ee11A7fcTXECKG75N4dSH0ekUUHtw2yX
         NKue/D1/zosbqjsgYnbPVvaAZ2FTms1FN3qoOa1HTKL1m9BZcodk7As3Yp4+JvpkfJ68
         ZmeJmtIytrzbpEJpP0dlzk4rPLPcLeazTXyGW3e5eiUUWY8v/VuqeWlhXe/yxe+BuxI2
         VsRQ==
X-Gm-Message-State: AHQUAuY8tJm6fpsD3inPNfZT/XB4uzcnPGLR1lbSx52IHao4dfF8bj8J
        XLnjXPUm4H/xz5HaF2jEuOs7rFiQC1kLTg==
X-Google-Smtp-Source: AHgI3IYdIzq+JMJiXOZ9Huj4GLqjZdij9zMflTtSzrlKxNwwICq/QN7Ukh0GQy0ssN1ZFSic7bPs6w==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr30767046plb.235.1549752268197;
        Sat, 09 Feb 2019 14:44:28 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm8779147pfe.91.2019.02.09.14.44.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 14:44:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET] Sanitize queue flags
Date:   Sat,  9 Feb 2019 15:44:22 -0700
Message-Id: <20190209224424.7560-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Small series to remove (now) unused functionality, and to clean
up the flags we have and do use.

-- 
Jens Axboe


