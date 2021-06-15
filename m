Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23895C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 06:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E666A61417
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 06:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhFOG62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 02:58:28 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:37522 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOG61 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 02:58:27 -0400
Received: by mail-lf1-f52.google.com with SMTP id p7so25238232lfg.4;
        Mon, 14 Jun 2021 23:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j00yDKFRObYyA/b4kREgAOqG+iHTmLKQXoPW6ou7r8c=;
        b=brql9yswnj4RgtT+EtUkZX9C/62dW0WyAgHgkLPhLsC4gmi1Ibk868kQQwfbp4buTJ
         sxOPcxQSLAiYCaaH4kO9H5L09XBLAiKYjJf6tZ4RAfX0KSW19ArOBxc/wcB5+QoLkHTm
         Yg+817smYRcICwnTaCc8QZuuGHIpNh9NrIJQY+HkEJ+Ga4f8Fq9jwUNI9Dd8sL9c0D1/
         sV4pG8Fps36Z5/n4fCe5ouYj6/xxL7X8FiNrG+7b7lGAH+Gv6PBYZiqUX1bpXadKwefp
         /GFQXIeRCH3YA3qrl54vMBEBoxnyOkDSUJEIPF9biH0v7LBBRZuoG3h4BYlAuAo8x6eZ
         BnNA==
X-Gm-Message-State: AOAM533QyGFa+FkXQ1EXhlhIVRXD4Fkj+nl6CQhTcjqzcLwfP2ZU2h8b
        bYnqQX8C+YJ6El3xrJHZ23zgfse7YD0=
X-Google-Smtp-Source: ABdhPJxheD2SFrmAJOYzOWf+6x7l+4UvQRWbn30OUFlVYLgjCYZ8DjXXy9RFg4ti/HuZVvkNrMXofg==
X-Received: by 2002:ac2:43c5:: with SMTP id u5mr15512555lfl.156.1623740181831;
        Mon, 14 Jun 2021 23:56:21 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id q6sm1707271lfj.88.2021.06.14.23.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 23:56:21 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Denis Efremov <efremov@linux.com>
Subject: [GIT PULL] Floppy changes for 5.14
Message-ID: <2f80871f-a1a5-7c02-52f9-118a0e68d84c@linux.com>
Date:   Tue, 15 Jun 2021 09:56:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The following changes since commit d07f3b081ee632268786601f55e1334d1f68b997:

  mark pstore-blk as broken (2021-06-14 08:26:03 -0600)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy.git tags/floppy-for-5.14

for you to fetch changes up to 2c9bdf6e4771a5966a4f0d6bea45a1c7f38312d7:

  floppy: Fix fall-through warning for Clang (2021-06-15 09:18:55 +0300)

Please pull

----------------------------------------------------------------
Floppy patches for 5.14

Two oneliners to fix clang warnings:
- -Wimplicit-fallthrough warning fix from Gustavo A. R. Silva.
- Redundant assignment warning fix from Jiapeng Chong.

No semantic and behavioural changes.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      floppy: Fix fall-through warning for Clang

Jiapeng Chong (1):
      floppy: cleanup: remove redundant assignment to nr_sectors

 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

