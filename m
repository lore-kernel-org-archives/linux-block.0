Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC1EC05027
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 16:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBJQLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjBJQLa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 11:11:30 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB047358F
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 08:11:28 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id l128so2117423iof.2
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676045487;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgvOi4wUeIc8H2OD1Ykj3zEVvhTX0r8aiiFA5QEsxd8=;
        b=HnyMHosOW/PVJrJE+YS7uA1KuHrS/j6QOzUenA5SrhXceiHSBLG/Y5piNyUNPShnCe
         +FYdOy0TyuQTRO6Z6swCMYYP5tTcdcyPhdBraOAlnjLBal56bWLq1Oo7Pm3z0bwJ3g6y
         JZTdAa1C+wciQ8MeyTeBhft/ZmhmDSQEXZiMB6GjJ6aJx/15/Jfj/lg3Djw4Bvoq70tD
         FhBU9oXmwAw8ffTBuW1vISV//rYucjDs97n2dePz+blbRP+SJx189UmcPAgnDixhZnxR
         kZg00CdnM87Nmg0ZfMKLAirQ6OStSX0dmKowJ0vCmOZV2j3P9XDeg5i0rs4/3PBY+ldc
         g4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676045487;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sgvOi4wUeIc8H2OD1Ykj3zEVvhTX0r8aiiFA5QEsxd8=;
        b=B6jelWZxY7kdpPAyeku2MGJyyag4F7YPJjDlwT7Kikg+4dv7edX7yDvDVGwbAHCggX
         /1tf2PkB7XpT+0sM5p0/q2b7O+XWgwinRuqeCzcKdo+OLBgg9ZTmM1u9HwPb7a93MAB0
         0HYRugLLuibXFwJ33C2g3+f0rJ2keR5BQG4OhNq3hzgEmY6UeSbVmLRlTMdTHb/qvT1V
         sMKHp++vgqKYz7G9j1kaLLFeaxZyEtVmpaXrPGVaSY9ogMgDeq05H14b3t83bTzRZmJT
         VJsrRiofygo3AgizsPtlOabNhcVRzbGONE2kV/0i9b9XBYocaOimzPSEJ75MeTsFOsef
         Jfsg==
X-Gm-Message-State: AO0yUKWyTUi+z+BhdVRYMnOsjckMsq5t9OyaR7OPkJPQ/s9BjpXQMDjo
        qi/2uLjWfMCjcoP+j/jhfvSAf3S49m7d9qNT
X-Google-Smtp-Source: AK7set9m1JDI0Y/deGx1IsSh1c7GseERWtg5ePIwTURX+n0fJC0cbukUJfQ+jOZbU1RGirmLzbI/bw==
X-Received: by 2002:a05:6602:1581:b0:73a:397b:e311 with SMTP id e1-20020a056602158100b0073a397be311mr6827496iow.0.1676045487348;
        Fri, 10 Feb 2023 08:11:27 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n17-20020a056638121100b003a9515b47ebsm1499920jas.68.2023.02.10.08.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:11:26 -0800 (PST)
Message-ID: <0834a42a-fc2c-6847-4f4d-4125d41e60ba@kernel.dk>
Date:   Fri, 10 Feb 2023 09:11:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.2-rc8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for a smatch regression introduced in this merge
window. Please pull!


The following changes since commit e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3:

  Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2 (2023-02-02 11:02:12 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-02-10

for you to fetch changes up to 38c33ece232019c5b18b4d5ec0254807cac06b7c:

  Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2 (2023-02-09 08:12:06 -0700)

----------------------------------------------------------------
block-6.2-2023-02-10

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2

Tom Rix (1):
      nvme-auth: mark nvme_auth_wq static

 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

