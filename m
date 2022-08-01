Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F498C00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 02:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiHACsK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiHACsK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 22:48:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC713D41
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:48:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o3so9257363ple.5
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=sIhpHEWmweS6rta1kFchPdJbnAjJYE5U/WARvW+n9u8=;
        b=sPReVOsN/+ZNJ+uSbyMhqMFkyQo25DpSxv0jZr3kKa61uRfxFnFK8Ln/p4DZqQNrET
         m8jXMJMDVSrPUcX+hMV6ZcHj6vwf6cD4EZZiffQSkRFp8JrboJ4C3f67rKpu2F6Dz2De
         Szv50u+qjrc5BWUF5xWbP5F0L0Mls96N+fdrveOpYLbNKXSzhTswtLhgin7DmknvEBKS
         hUWfb3Uc4pHjnyCUDLZV8ZtFxWUJM8siFMjr0ZfUntpKzDRQ0620bO5SdF30I+SG+din
         BLbT3xLpjXcAGhyh6EUFejBV93X0FIORo8qm16Rzj2i2NYyF1J8WJBUmBiVr55Sp5UuY
         rkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=sIhpHEWmweS6rta1kFchPdJbnAjJYE5U/WARvW+n9u8=;
        b=Q09lMCUuReDEH4fev8WetmkMr3vs8USjdgUCV4J/D6QrI/uc8HeU2hIcMlkjWgMZLB
         yUNMXxjn8O+Zee1DTNbyHHXQ5E+U1nmxbOnOmrGrdCbj9mtWUKzb/20MFtD+bIps+IOO
         ccbAgM7rXnpF+FeUBbKTW1rngAKM4uST0JzREeSKXTsIw8CKe76RJJqyuTYu/Ex6r7yJ
         65wVFEBk36GEyA3ivVVgRLeoy5tppQUWbKo4qbD0kVaai5uQ7j8BAFSYjPujNKfC9xbk
         hnIemUtEaQNseGymEUP39u8Iy014NcRhObJ3dbOnCDw255/Rc4x6Kh1S1XORPL0DCZTT
         DDXg==
X-Gm-Message-State: ACgBeo2LZfH8DexHJNUQofdfSnmlN/napMySBoXwLwPYB+prNZ60vk6W
        zrgGw4TkOnQfQ9A+jkYx3RdQew==
X-Google-Smtp-Source: AA6agR4/2HEvZmhjCuplruQuQ539pxPOuUJIEe9Fy8fStLUUYYh5/lgBGYi7hmZlk8fWrmf69f3uuQ==
X-Received: by 2002:a17:90b:4b0a:b0:1f2:a904:8af7 with SMTP id lx10-20020a17090b4b0a00b001f2a9048af7mr16932999pjb.76.1659322088905;
        Sun, 31 Jul 2022 19:48:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b0016909be39e5sm7854608pll.177.2022.07.31.19.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:48:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ZiyangZhang@linux.alibaba.com, ming.lei@redhat.com
Cc:     xiaoguang.wang@linux.alibaba.com, linux-block@vger.kernel.org
In-Reply-To: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Message-Id: <165932208816.183707.5495009296503956559.b4-ty@kernel.dk>
Date:   Sun, 31 Jul 2022 20:48:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 28 Jul 2022 20:39:14 +0800, ZiyangZhang wrote:
> 1. Introduction:
> UBLK_IO_NEED_GET_DATA is a new ublk IO command. It is designed for a user
> application who wants to allocate IO buffer and set IO buffer address
> only after it receives an IO request from ublksrv. This is a reasonable
> scenario because these users may use a RPC framework as one IO backend
> to handle IO requests passed from ublksrv. And a RPC framework may
> allocate its own buffer(or memory pool).
> 
> [...]

Applied, thanks!

[1/2] ublk_cmd.h: add one new ublk command: UBLK_IO_NEED_GET_DATA
      commit: 5af6c7916ed4b76e704f5badf13188be3e1eaec3
[2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
      commit: e363c522e6736855a663fd81f3cefa09e238a2d7

Best regards,
-- 
Jens Axboe


