Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96321C433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiEZRn2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 May 2022 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbiEZRn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 13:43:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A546A186
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 10:43:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 2so2291409iou.5
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Cf7d3NdarROeO1DBR6AQD9JX7+zz8hgqvCHij6VuBns=;
        b=i5RGf+k9walnItpnx9yAiefDNhrFFACOtNsgMSJlDnHnGephcTbEi+zjiQHLzVAo8+
         k4SOaRKhzngDYnGwYINC/jcFhBXif0tYHZG1v64RMdPBfa37Yi+uID+4jOE5YZBtIxsp
         /oNXEJf0IJTtKa/P3aFhK+s4XLxW35f0F62le9b/Gv75WZ0HZCkI4qfnO8HskWQDrc6S
         Ka9onSdDxRZz6vP8LqwtlPVdt1BRWqJ5NGq2vMOkOYPSXEgrqiGy/inAMtVE3RNMsGHZ
         MPjOhsctJI1j24aSzqOjcdy6C4/LB1SdNH1GTRd7nAlWFgQ1MGj7bYciI3JfvLXyP68P
         pCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Cf7d3NdarROeO1DBR6AQD9JX7+zz8hgqvCHij6VuBns=;
        b=B1w+rNBrZ2IaAl8u8KLv0zL3k+Jt+zCIdkrxd7LMkKDAyS4l5LzUyIXcgRc5kDBjA5
         HM+RY3dlUVm3xc6vOYMWC9A1L0fHZ3/bqfMkUCy9fTXe+OtHJPNUIDMZtdQHz1tx5sbg
         592BrOTdd/6IOaHMO8N30Mj9TQQY10CVlSyJYzC3v4h0l2q7DuWugBB6JIBcO52MFdYy
         HLsQsjtyjz7a3PJ5KkdRayzLlwND8ioDiSo4YxymXJrcW6FK8susWiuSCe9jd6pclL6k
         j64yCKezkh5qFKNDmHbuzfOquYy9iGROmQ6LT7sq59N3YdlrsSuP8mpQgaSXR4fWMY+9
         pyvA==
X-Gm-Message-State: AOAM530gvtqZKhlyfgQuSkQtdZgcGpdJiRiLQYcdMk07kla1ZLUc0bTJ
        bRQbucdRjdFZ6AzFpMmvxJJL2+Bgwr8Jhg==
X-Google-Smtp-Source: ABdhPJzAPHoImUvr5c2HdKzi8nCAIOvgk3aG8fJbLYXnzTkl+x/PRDnKjx1gTAaHdP+CGKkq/NKUiw==
X-Received: by 2002:a6b:8e0d:0:b0:65e:50f1:afd8 with SMTP id q13-20020a6b8e0d000000b0065e50f1afd8mr14714599iod.112.1653587006740;
        Thu, 26 May 2022 10:43:26 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x18-20020a927c12000000b002d149ec2606sm652748ilc.65.2022.05.26.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:43:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        bo.liu@linux.alibaba.com, kernel-team@fb.com, josef@toxicpanda.com
In-Reply-To: <Yn9ScX6Nx2qIiQQi@slm.duckdns.org>
References: <Yn9ScX6Nx2qIiQQi@slm.duckdns.org>
Subject: Re: [PATCH block/for-5.19] blk-iolatency: Fix inflight count imbalances and IO hangs on offline
Message-Id: <165358700562.497212.14751047590663347545.b4-ty@kernel.dk>
Date:   Thu, 26 May 2022 11:43:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 13 May 2022 20:55:45 -1000, Tejun Heo wrote:
> iolatency needs to track the number of inflight IOs per cgroup. As this
> tracking can be expensive, it is disabled when no cgroup has iolatency
> configured for the device. To ensure that the inflight counters stay
> balanced, iolatency_set_limit() freezes the request_queue while manipulating
> the enabled counter, which ensures that no IO is in flight and thus all
> counters are zero.
> 
> [...]

Applied, thanks!

[1/1] blk-iolatency: Fix inflight count imbalances and IO hangs on offline
      commit: 8a177a36da6c54c98b8685d4f914cb3637d53c0d

Best regards,
-- 
Jens Axboe


