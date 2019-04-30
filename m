Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA8EC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC914216FD
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 01:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcAc0cUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfD3Bc0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:32:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44882 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3BcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 21:32:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id d14so3067953qkl.11
        for <linux-block@vger.kernel.org>; Mon, 29 Apr 2019 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0EPmsUn+n5eO3EHREMBcK3XY5nU5nQ6kG/M5UEjZCNE=;
        b=AcAc0cUMn7Uq2UFhLN9Yo2svwdGxe8AbMEm6NKvy66xdSzN96NeCK0xDAsuaET8I09
         c8FVYIxa8qCerMM0SQpvsG+D2jIrXA6MAvzVKOsmfJtP148RAswFCo7/GRulCYi3Gya+
         o99Qvdb5l7GuPrPHuwR8IeoWHt1rOB2pb/pZxl0CKhvXbZDOJYDl0piJs2u0+W46WvOP
         XQ0rq1bSyFFcMD9Wr70Hf5/RXWaU2mo4HWN4MjTZ0q1XPlR+1MxzT6EPANArudoQ4hWH
         7rpyx+5ke8ZL7lWfqzJcmJ19XiABJQqrJgK2KLweMFvfad5hQ4qLjANNR6p+yaJ+9aMr
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0EPmsUn+n5eO3EHREMBcK3XY5nU5nQ6kG/M5UEjZCNE=;
        b=oE2BSRFoN1YwdDH5txywtGpNlsAZK17hooB60a2L+xvVlhx+wNQqKBM+IBYFv3Pou9
         pC/FRQdt8BhaBLLolEy0T28aNRLbLN1z1yKYrjWruEEpGCsBVwpFLIXIsAOO1BnKmhdl
         jihdnu/lIQ9s3EVCJw7wvP+vW38Eh/6jQoUD/+zvWEvMYawpR3UjGjo6LmSu52ESYxuk
         wIxJPbeQstybWlD2uSJfZ2vEzDNvcnGWI+idpbiXo4h/U2Y8qOjzmsXQP7N2e6YEV/tP
         mBnVfVFajMUFNDW1FaETIkjP6+FaLmt8W6LcK3kcXSluvgsNihXRCzT4MLeZPZvopKDq
         INiw==
X-Gm-Message-State: APjAAAUOwcCY/K1nn7zP6fB9/WH/6bs3AMrD+4wOaDJNthlUpJYchAV3
        zERDVEZTP7FYFyei3hLWvDmjcPS1
X-Google-Smtp-Source: APXvYqy/1o6jlShyyUlI3kvxKvUWTKKHoPlI25dkDLli35BFL5kUJ5dnRGfvwq36hiVMWDfx4buPeA==
X-Received: by 2002:a37:aacc:: with SMTP id t195mr24582366qke.202.1556587944343;
        Mon, 29 Apr 2019 18:32:24 -0700 (PDT)
Received: from laptop.suse.cz ([179.185.223.166])
        by smtp.gmail.com with ESMTPSA id v57sm5127019qtc.10.2019.04.29.18.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:32:23 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 0/2] Introduce size_to_sectors helper in blkdev.h
Date:   Mon, 29 Apr 2019 22:32:03 -0300
Message-Id: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

My previous submission was an RFC, but I got a reviewed-by from Chaitanya, so
I removed the RFc tag.

Changes from v1:
Reworked the documentation of size_to_sectors by removing a sentence that was
explaining the size -> sectors math, which wasn't necessary given the
description prior to the example.

Let me know if you have more suggestions to this code.

Here is the cover letter of the RFC sent prior to this patchset:

While reading code of drivers/block, I was curious about the set_capacity
argument, always shifting the value by 9, and so I took me a while to realize
this is done on purpose: the capacity is the number of sectors of 512 bytes
related to the storage space.

Rather the shifting by 9, there are other places where the value if shifted by
SECTOR_SHIFT, which is more readable.
This patch aims to reduce these differences by adding a new function called
size_to_sectors, adding a proper comment explaining why this is needed.

null_blk was changed to use this new function.

Thanks,
Marco

Marcos Paulo de Souza (2):
  blkdev.h: Introduce size_to_sectors hlper function
  null_blk: Make use of size_to_sectors helper

 drivers/block/null_blk_main.c | 18 +++++++++---------
 include/linux/blkdev.h        | 17 +++++++++++++++++
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.16.4

