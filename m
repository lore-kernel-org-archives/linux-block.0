Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1BEC433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 15:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbhLDPVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Dec 2021 10:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhLDPVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Dec 2021 10:21:05 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AAFC061751
        for <linux-block@vger.kernel.org>; Sat,  4 Dec 2021 07:17:39 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j21so5769211ila.5
        for <linux-block@vger.kernel.org>; Sat, 04 Dec 2021 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RXqvOH4CwL/3qxOhohhG6Ak7eWAgSzlHYWCOq43wkrs=;
        b=c/lPPYeO685DsJZeYX7pYXwfHwpkYfQ6jKNnDxiV5kYFyVIQQF9NYJTCP0WNVAXIGJ
         NrZt2/ZSfSJpR3tigM9FG7jZLRJswXZAUkukJM0STP0kPtD8ERKxNg8kpS8DAra/6sgd
         Nuw4fRPaI0dvv0K5x9MGqQq6iaXQ2z5sf1EoYQ0iDO4uUU6HVw4RtePUJVaHjY0fgcvJ
         oE3soLvxxulcqkygP4NWstXV1r+OxJol5jRLuTZuPAC0N4P5/RMkWVISmECuNjr9GWwE
         Q4gOwd2ZTNNAlAjxyxL7EGJ5wYj9KbRnfektsPxVEZCqgV52sDWC9Yxs02K6RkxIObIp
         08LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RXqvOH4CwL/3qxOhohhG6Ak7eWAgSzlHYWCOq43wkrs=;
        b=M0gRu4KSBaq+KNOD2lVKWTs5byfA+A2LAb7CLurqac1yaMAxKkTRuxDj7atMrRmx2E
         Nn7hdCdZaAK+mMr5C9XteEkbSHq22bWGTbiVNaSO/liMJmvq9rhVi/tT4qfWliN/58UV
         1+D71euxmrK3NEwo5CFv0oxekiFUA3EjUHIpt5htn7SADjDbH6ql7PCc1VtWNvoGoKEc
         K0nGAvEsAbQ2mvDgD1IF7mpn/ve5eljowG/nclhuBswNPH8SjX5B5rK1YeFPc3xwx/hr
         uZKkaclyO+vvaIkSzszRFCPi9zEXoxVhrBxuKQlfjbeVoATBmutRFky4Vpw/iETeidRt
         pfRw==
X-Gm-Message-State: AOAM530P65NrxFF1fclc2kQXdP4PDZFQSdFyZ2KWcWzFuL45E0OvZWfQ
        nKEcu7aW8tvUS7JSKGI/7Qp7K/wZ/Uf+ZYgb
X-Google-Smtp-Source: ABdhPJzW7heFIdyPZ1xvyWtIjp29AtOQzgV5aVWmaxsooLKZnFYG+9mNu4xTESmE3cAgcpr7ERQ3CA==
X-Received: by 2002:a92:d38b:: with SMTP id o11mr23156892ilo.35.1638631058486;
        Sat, 04 Dec 2021 07:17:38 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r18sm3207775ilh.59.2021.12.04.07.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 07:17:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.16-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <193033b8-3652-d5f3-f7e9-29038de4a6a1@kernel.dk>
Date:   Sat, 4 Dec 2021 08:17:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single fix for repeated printk spam from loop. Please pull!


The following changes since commit d422f40163087408b56290156ba233fc5ada53e4:

  zram: only make zram_wb_devops for CONFIG_ZRAM_WRITEBACK (2021-11-26 09:57:32 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-03

for you to fetch changes up to e3f9387aea67742b9d1f4de8e5bb2fd08a8a4584:

  loop: Use pr_warn_once() for loop_control_remove() warning (2021-11-29 06:44:45 -0700)

----------------------------------------------------------------
block-5.16-2021-12-03

----------------------------------------------------------------
Tetsuo Handa (1):
      loop: Use pr_warn_once() for loop_control_remove() warning

 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

