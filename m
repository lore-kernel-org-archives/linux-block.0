Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750818AbdEBP7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 11:59:07 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH 0/2] Convert mtip32xx to use block path for commands
Date: Tue, 2 May 2017 09:58:59 -0600
Message-ID: <1493740741-4471-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

One prep patch that fixes up some potentially bad assumptions about
the value of the internal tag, and a functional patch that shifts
mtip32xx over to use the normal block infrastructure for issuing
and completing internal requests.

I have tested this on my local box, and it works fine. I've also
tested the timeouts by faking missed completions, and verified
that we catch internal command timeouts and handle those
appropriately.

Against my for-linus branch, on top of the other mtip32xx cleanups.

-- 
Jens Axboe
