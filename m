Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD03C33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F72620705
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ui7hbxTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgAaJY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:24:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53191 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgAaJY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 04:24:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so7086019wmc.2
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSXbMxnOg8YIX/3kR6+7l+XVNm8PvjjA37JEVs4qXJA=;
        b=ui7hbxTOZhC0wBm4XNnnM0Qrgnmx1S1n0GrL/Laudw0hYYdsR1GLIa9vOUBxjFZlHz
         HhUqsfWj+95bLSa2fDIqoAy2Sju/2K+fz2mPXDywWxSV9lAQNBE+sibovuiLHGDn2Prc
         ts8yBm+V8hKRLucF6mM+5eGEnjgbMResPLnLf/15pN9uHZtj/qWPBth7G5O0cFI62R1Q
         rPrruQnZ0uu+PVy+Lx2pwT4PKKZcD3H/USUe5xcWlKF+KPCBZ78CkF8gtcKU0r32MACG
         ZVt+ZjVbWcZ5MHz/pAqB1m1kSJWBdYp4SL6FZcgsZMg868zQsB2SMjufSaUHf2HvDowP
         s0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSXbMxnOg8YIX/3kR6+7l+XVNm8PvjjA37JEVs4qXJA=;
        b=UYtLbECYX1MtOTkV37OFn1XPpMZ/Up/XcMr7tMd6O5bEpds2dgyQnGwYktEzDIwMcE
         6ioN6FAhkSut+1ik7eR3NiK8C9DzRbbolTUPyVlDERXqrxBqnK4PVdVzzgVN02tBOEKd
         AABPl+KEoiqQ1yE6NREso3PHmImCW5A2+o9l6ZUpzZd5eE2cOxu2P9JexMWwDifXcvuL
         uoSeQBplOLFGKdPVANcFV/jwPeNG2sEFbbVnKOwUHG56wfvK+BhhBbmLF4byLHuZTCNa
         DkRsIZWu+PnvegtxTpXKZSrAvAyttNmyK0bfiE1kwb4JJ7Soxg5oOpQBN0zWDbfG4XWJ
         eqGg==
X-Gm-Message-State: APjAAAU5ffUZ1NojXyv+uQAZMZC1ILMNkjxv8+btryOU0yY0o6KEbfRz
        aVimgpcFP/Ng4ixU691MDep7wA==
X-Google-Smtp-Source: APXvYqwIzUPuurz2q/j3XhmwutPdbx25t66VPpjsBDm8EXvsA9RKUuu8D/EHwhxi1yQ72R9rcNqNdA==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr11703127wmc.168.1580462695648;
        Fri, 31 Jan 2020 01:24:55 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:24:54 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/6] block, bfq: series of fixes, and not only, for some recently reported issues
Date:   Fri, 31 Jan 2020 10:24:03 +0100
Message-Id: <20200131092409.10867-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
these patches are mostly fixes for the issues reported in [1, 2]. All
patches have been publicly tested in the dev version of BFQ.

Thanks,
Paolo

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205447

Paolo Valente (6):
  block, bfq: do not plug I/O for bfq_queues with no proc refs
  block, bfq: do not insert oom queue into position tree
  block, bfq: get extra ref to prevent a queue from being freed during a
    group move
  block, bfq: extend incomplete name of field on_st
  block, bfq: get a ref to a group when adding it to a service tree
  block, bfq: clarify the goal of bfq_split_bfqq()

 block/bfq-cgroup.c  | 12 ++++++++++--
 block/bfq-iosched.c | 20 +++++++++++++++++++-
 block/bfq-iosched.h |  3 ++-
 block/bfq-wf2q.c    | 27 ++++++++++++++++++++++-----
 4 files changed, 53 insertions(+), 9 deletions(-)

--
2.20.1
