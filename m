Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89CC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282506112E
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhKDSYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhKDSYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:24:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DDC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:22:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id s19-20020a056830125300b0055ad9673606so8220826otp.0
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9yxGy8Q4aKVHJkoSzL/P9cJZrxZ0/OlvRULTMxmGoPQ=;
        b=47oXwMnpWbqW35XsTwXjKP6ELtmWQxocYwOz9WyF+pIqtr0CVh3WZFeksOSjyNl1T6
         6s2sYLV+htytMlPMY8iJ8H/U6JY0ZPWwKWQreq86SiF4isp7jN8WMM0k+yz3MS2A5H8/
         jfgX3G91s9jqZ00CPrCJvz15oz1kmEaovOpxBrMq8LF/PU6LgTiWRuiuIFqArb2I95pJ
         oYIppGhtxGbtge0OefqmXf30f1ogi1W1+zRU6heSOovDpiQZQczHWuU7RK/1cvElRMtx
         qYQPs+ausrSnpY7+hurslzg4/0O91Wc9NLlftbgF6HHONbDJal7bOGK+47bvnNK5gWXC
         Ysyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9yxGy8Q4aKVHJkoSzL/P9cJZrxZ0/OlvRULTMxmGoPQ=;
        b=UViE/ZquQ2d+5vjEWE9XPDbI1O2iBGE61owBu6wuOvtWJ+zhnJu8+tKeDvcQKk8dS1
         +QEr8dBWJLpuuBGy/dYwG3s7h44rZIj2xloQYoPtWgbbj2VZlALsMI60fpLPMdOB0OLp
         ujR2PbeUOyXHpmsaZaSEgTGYJCE/moexMoBRnP1skbNXeOP022tnzUYkClWkAMVnYsbn
         wsYTNlqHcwNT1z7aTyffuO5rFqoVutzYmt3X4Fz0mEptJ2ft7mjrZrgrMrvmZ9QIPxgj
         LhHXFP0f/g46axX1CU44RThpkos2CKkTtxTKxmoevDqYw247anfKJ5k/gSJvcv3dL3/q
         LfNg==
X-Gm-Message-State: AOAM532wob7Ao6LsTustdujtwiGRJR8wKOzJF3Gs+S1xqX1QkKk320hS
        nYgS/YyGApWaM0mpi388BfmXjNlb+lbFRQ==
X-Google-Smtp-Source: ABdhPJxxmMeF/hKGBdVNP2UIcUP0yJOoYabEUCgWkEsTk3zcju1W8UJ2jo4Aq9j2+A4MFHUuYp39yA==
X-Received: by 2002:a05:6830:70f:: with SMTP id y15mr3152997ots.232.1636050127200;
        Thu, 04 Nov 2021 11:22:07 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s206sm1595445oia.33.2021.11.04.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:22:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org
Subject: [PATCHSET v3 0/5] Alloc batch fixes
Date:   Thu,  4 Nov 2021 12:21:56 -0600
Message-Id: <20211104182201.83906-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since the new feedback on v1 arrived post v2, here's a v3 that takes
it all into account.

A few fixes related to the batched allocations:

- Have the requests hold a queue reference, flush them on schedule
  unplug as well.

- Make sure the queue matches, could be a mismatch if we're driving
  multiple devices.

Since v2:
- Split both alloc handlers into helpers
- Retained blk_try_enter_queue() the way that it was, don't want to
  inline all of bio_queue_enter(). Added justification for that in the
  commit message.
- Add fops based submit_bio helper
Since v1:
- Reshuffle series to do plug rq alloc helper before enter changes
- Protect submit_bio_checks() by queue enter reference as well

-- 
Jens Axboe


