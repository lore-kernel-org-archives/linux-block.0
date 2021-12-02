Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED557C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbhLBTvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhLBTvH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 14:51:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FAFC06174A
        for <linux-block@vger.kernel.org>; Thu,  2 Dec 2021 11:47:44 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 15so536160ilq.2
        for <linux-block@vger.kernel.org>; Thu, 02 Dec 2021 11:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhG8Om5YrW40AWnCbrH78RLdzfbKXDgLUjKuZhfkQ1U=;
        b=Q6lVVmzyf5T/2pXwtG63t7z3u5a3T65IfL8IhJO/hL7HBNF50T4dM5qmoH/ueaEynA
         Nav7xW4WdqVT/Kt2QtQY80PUxKoajSL83dITfAnZATY3CHumn4jeHPobMJhb/3ppi+fk
         EgjrZYfQwuFitRM8CHiqZ4mbkp17K1lzSPhKE6+SHiU6b7VoEFGWUpS18yWEKdQOacQK
         WY7GmydyHIoPP6O/u5C0f2SRTPNwOydFU82UC3rvHnP/EuxhVjr5nBvJHCGQXs8ZMQ31
         oLiJDpXbP7s//sl2sPYKD+BKUA6YplSTXionEaQNRfLbHhxjjZOublTCBAgirretoBHO
         gkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhG8Om5YrW40AWnCbrH78RLdzfbKXDgLUjKuZhfkQ1U=;
        b=UBuhJHF+q11rwtun+0vcHFx4ee+/bqHHAfZPMfyQ1FQF0V9g7lbSQVU2R+dht8e/e1
         N7qNWR/Bgai+MOZki359Dmora04FkekD7HpP7mlq+gH8UIxgFTmcPgF5DnQm4Nklvm8d
         68cRI5kcSO5kB/26MwtK91U2FDmAFuuO6w3NetZJ9FCRgH0D9MCHY/ZhvacY5vTLZEDS
         63WzrMcbnf69J9oPYDwzJfXP2hdC5I9LmJpO+aTPxrbIDBHjCVw3kYUQjOsMm8oj5EMR
         dIDV432UKcGvKe2dZiGddCGCSxy03z5MQM3XrUwECA0tp5iRv/GOnMoUFeeaBBNwkz+T
         7r5w==
X-Gm-Message-State: AOAM530tumMpYhV5X/+NiRtr+V8H4U4hGYxNkWdkVrMHiFooj9p8dOl8
        t7Yq5pteLJoaljRok4+70xZoBHtEDyN0l8sM
X-Google-Smtp-Source: ABdhPJxR40zMVXJKTc0z8tVmu1wPatWEkGWl8bReZLVU5tJeKhgq0apf7ODZ2VrqaMKQQEsbitN4UQ==
X-Received: by 2002:a92:cf52:: with SMTP id c18mr18358836ilr.226.1638474463750;
        Thu, 02 Dec 2021 11:47:43 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 18sm359477iln.83.2021.12.02.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:47:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org
Subject: [PATCH 0/2] Fix bio merge off cached request path
Date:   Thu,  2 Dec 2021 12:47:39 -0700
Message-Id: <20211202194741.810957-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

#1 is just a cleanup, #2 fixes the real issue here that's leading to
crashes for me.

-- 
Jens Axboe


