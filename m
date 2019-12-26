Return-Path: <SRS0=USsu=2Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A732AC2D0DA
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 18:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCDA2080D
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 18:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wDZcxno1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfLZSRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:17:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39474 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZSRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Dec 2019 13:17:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so13510168pfs.6
        for <linux-block@vger.kernel.org>; Thu, 26 Dec 2019 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9KcrEyfLgjgi6kSK4iO160XQbEs0MUcD69xCLp/Xv0Q=;
        b=wDZcxno1j93Rm0S0vaQbHjGrCiir0tIANelwtamd+dgK9/AAGjCYeqLbksYb574HYq
         Rz2o/oasuiebAKQdVdLhx5w+wEvVy72jwDIeT+xR4rriu6W6QCTntF5SrHi9o3QnQNck
         0oNmvZKD9jUU59HzlkdzMqFXSBFXeQuOg2BEpuJ0DkgZeKCOUsa/z2js8CFANIUqB+Sq
         VcKwa0GyCriOwBbKNJK08Mn8ksI08AIoDYADXpXEB1UgMuYU+wbxcktvT5rroPsITAFh
         oAvPGgz00zBOL4m3ObMCQjhbL3cqqTnBH+9gJBNjbng55+0ovX9qgl0ZdNWghEUtIBoW
         XXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9KcrEyfLgjgi6kSK4iO160XQbEs0MUcD69xCLp/Xv0Q=;
        b=pBNYT4Fkw2WiE7u1I31xWQKZmYoT7bT+O8OBlXyuPvliVScEUOOx+QBFU5MdyxGDRy
         72NAbCmarV+duQJKXyqp4o498c3inO23Rrg2gM6D9pS8Gix4518FzcOOWx+OAEwMSQS0
         H6YwuSBG7wkSJ+dADd6Mi+R+eRvv/x5BnslGe+zmTa4ml6M6CgdgCrWS6qpXtsTlZYBC
         tfUmE8gzC4W6fVddKKXxqUr7ZPc+Txw/69As0MnIN6zof5GGDn+4+P/vYblr51TCorGO
         fydWrbOu6+HuvYBkRoY7qoQkd/ROyjCE96BGAarPdHdM56Db538xp93qhQECPbnzRJ0z
         leIA==
X-Gm-Message-State: APjAAAW1xQPqavuuuWQzQ2iA77Qass+FbXEpqwFYU1HsRFa4Kw60zeup
        nhJiAn1txzukXMQhUI7/nZQOGm5LN8aRng==
X-Google-Smtp-Source: APXvYqzPYiePMso4UWouPFCMWJ4xDkFbFNfhqU6OyoJ05KEDWe50rlMBp22vwdCCapE2kkonmE7PvA==
X-Received: by 2002:a63:2308:: with SMTP id j8mr24164539pgj.86.1577384226467;
        Thu, 26 Dec 2019 10:17:06 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s185sm16782365pfc.35.2019.12.26.10.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 10:17:05 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.5-rc4
Message-ID: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
Date:   Thu, 26 Dec 2019 11:17:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Only thing here are the changes from Arnd from last week, which now have
the appropriate header include to ensure they actually compile if COMPAT
is enabled.

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.5-20191226


----------------------------------------------------------------
Arnd Bergmann (5):
      pktcdvd: fix regression on 64-bit architectures
      compat_ioctl: block: handle BLKREPORTZONE/BLKRESETZONE
      compat_ioctl: block: handle BLKGETZONESZ/BLKGETNRZONES
      compat_ioctl: block: handle add zone open, close and finish ioctl
      compat_ioctl: block: handle Persistent Reservations

 block/compat_ioctl.c    | 16 ++++++++++++++++
 drivers/block/pktcdvd.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
Jens Axboe

