Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E72C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684B42171F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="UM2+Boo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfGOULY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:11:24 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37899 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGOULY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 16:11:24 -0400
Received: by mail-pl1-f170.google.com with SMTP id az7so8846691plb.5
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=OGwYZDSFOYpQneKzmR6GHuduQqKLVukFj22D/tY0NkY=;
        b=UM2+Boo4j5eb/6hWRYYU2k9aTnwOVVQiP5GODFCaVklsDXJhAyXUxjx/AJbm966mOj
         cTQoJ+ct6Exof18RRNEqjuh8APBZ42kWFpnsxJXwJJRoVVzhPKMveYlwW9cLzr8bCpcG
         3fEATRgh6KcfvLQkdoWkxY5CvHmEpJ3uyCBQPEIdCm3ijNOlpOFTNTdFdS+YF/yJUEIA
         b/rhdmfqeOEx22JwZb/Fz7A3F/zKAa09mG7VugSmMTJCHkVJ9BJ5/Ycc3zLIw9bArzlF
         PcZViw1xiC774jWteTcKilqkhVe/H8N17g3yMJyIDiVs9FCBixifxFe0Sxqw1NvL9W9N
         IT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=OGwYZDSFOYpQneKzmR6GHuduQqKLVukFj22D/tY0NkY=;
        b=m+dy4sNWMb40M+kqZ4pMpR/hGziVWBPABE45vHAC0VtA7pQxRvLM9pOXF4hi2r0beq
         Y+2IOhQ7sjxLg5V18PpBx/yCtD2hxv7Mc4aykxHoUWROoRyMHAi5obJlOUzqCsIBaWO1
         IU+xDQgGon6ovJIWL+jjutPpAvDlCUpqToCTyfASF5Sf2rV3Iv6lKvfTARW7LcOTNOGP
         s4npeEr6ZbevjHZQY2ti23jDMeDks6NH/IaOvGMndRfViSBsr93eUR9+rofuY8YVWQ9d
         kTD+tJK7D8w8+HC/gX3aXlmX/a0YLJitGHSKzl0ww9xOoGOXpBZ1Ik07UvVqQ8FvrEQL
         laqQ==
X-Gm-Message-State: APjAAAXsbV/+KbyG+PNKT9sFdBTyo1C89StvyLnFxaH9UjaOlhzl7drk
        ltDRhsWLsPZbqPLRo7mX0As=
X-Google-Smtp-Source: APXvYqy2lnXbnSXbit52ZIm/YG8vlwWYA5vRczIZyEmclOyCuFLiELKbSlJq9pjJAlLeN6nh2Xdj2w==
X-Received: by 2002:a17:902:be0a:: with SMTP id r10mr28699325pls.51.1563221483848;
        Mon, 15 Jul 2019 13:11:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4caf])
        by smtp.gmail.com with ESMTPSA id s15sm18248147pfd.183.2019.07.15.13.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:11:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 0/4][v2] rq-qos memory barrier shenanigans
Date:   Mon, 15 Jul 2019 16:11:15 -0400
Message-Id: <20190715201120.72749-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the patch series to address the hang we saw in production because of
missed wakeups, and the other issues that Oleg noticed while reviewing the code.

v1->v2:
- rename wq_has_multiple_sleepers to wq_has_single_sleeper
- fix the check for has_sleepers in the missed wake-ups patch
- fix the barrier issues around got_token that Oleg noticed
- dropped the has_sleepers reset that Oleg noticed we didn't need

Thanks,

Josef

