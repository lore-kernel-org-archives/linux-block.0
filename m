Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5FCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C277E214AF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 15:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkHuGPA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfJ0Pf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 11:35:27 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39800 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfJ0Pf0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 11:35:26 -0400
Received: by mail-wr1-f53.google.com with SMTP id a11so7294942wra.6;
        Sun, 27 Oct 2019 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDb8Ix03BeXmmQfRYUptA8l64yP3LhsJwp6xJ2O8ihc=;
        b=CkHuGPA0gZd4wgb0vl2mhIF0pkpEMOpbEAwIF6mfJdn2LkL9rNbTcd4uqaDNX4VrXC
         xiRjHyYJYyJBm54DSCTKVMPbZ+bZE738bSLx67D3klgw1gOio29wvGsFXxBgoOsWyIni
         8Zhg3InN5BjdmWiPVib36PPGTwRg0vY9H9Dg4TFoaISb7CZaUOQwRDagssIQO2O5vvfa
         uY3bPijDvQf4qFNy6EYoRtUFqAI70MyuDJ0XenLW4XwmQvKeTI27l+NvHabebW6zxG5a
         90dyG5B0P0ldw3tB9ohfzRo81V+sfxnwL2jFvkEjHJwpZSxMfxxhASU6OOEb/w4A61a6
         2dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDb8Ix03BeXmmQfRYUptA8l64yP3LhsJwp6xJ2O8ihc=;
        b=Fm1JQbVm6A1bP6UVZH7bqLXwR3/A2W+LDeQovXYtkPr9btw5ed9s/Iztwa/QIM2zFr
         fAL+om+/5r6u76Hjypf7/vQUJRoeytwk+fab/a7wv9xAbhc/3yB5K0bLtnwXAfJP2T+o
         Ub0A1dBDiYZqBEBCJ4KWvSo3v0wDXqnoojKvHcxRLcCKyZyNyJB9t9wtTekswdbYdlJ/
         JbV0SmzYmIr9E1diy+aj8g7PN7l4uVNYv2I7olgSqdz0IBTMHMve5dk39H/iX7z/nfKx
         M1dwssbwscXmyP2h9tbQp0FnqyadbO5aPAiXZOLL+2V8+kuzFu0sSqpddz/n2Vu1smWA
         JOKg==
X-Gm-Message-State: APjAAAUmNYxmwgkyIuTgg0JJKZ/SV5oXKxRPO+NElIizHbAbokslBvff
        blXmBVnHStiekK0vXppfT8Aft1hr
X-Google-Smtp-Source: APXvYqxXaZFkP0rFOVoNSTHCOesyc0zseJZwu+rhiNBj6WOl10VrDr7eAvd/G9rdQEvjDwY8G6aOCA==
X-Received: by 2002:a5d:678e:: with SMTP id v14mr11081520wru.393.1572190523124;
        Sun, 27 Oct 2019 08:35:23 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id k3sm4226282wrn.95.2019.10.27.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:35:22 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2][for-next] cleanup submission path
Date:   Sun, 27 Oct 2019 18:35:03 +0300
Message-Id: <cover.1572189860.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A small cleanup of very similar but diverged io_submit_sqes() and
io_ring_submit()

Pavel Begunkov (2):
  io_uring: handle mm_fault outside of submission
  io_uring: merge io_submit_sqes and io_ring_submit

 fs/io_uring.c | 116 ++++++++++++++------------------------------------
 1 file changed, 33 insertions(+), 83 deletions(-)

-- 
2.23.0

