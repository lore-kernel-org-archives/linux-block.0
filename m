Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23CAC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64BA20675
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 17:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cqgrzXd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEBRoP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 13:44:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfEBRoO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 13:44:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so1478084pfn.7
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaxzxxOXmSYT43huW/8pQz+RgmKXstrPXGFCyBXfTWk=;
        b=cqgrzXd22XU7oynLzRW6hQwwNgI0uX4uZoJ5Nti7TAvN4spfZmEnvLTyIOli1Cn/A8
         Xeff5jxuWRF+JWT47q7vsCd2uuXLZ8ZkeE7ECEJLdxbexh1UokS/mQenczvm+HyG8cbv
         repRb03fjAWAygyiix0+kr0tjv2K6ITVjOrxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaxzxxOXmSYT43huW/8pQz+RgmKXstrPXGFCyBXfTWk=;
        b=QuSIk7AH5n+/6byHZk0Lj+UJr3VEqNhXJg4K6Y6XuBpltz3wZfYKINhoHseqiFgR3P
         VDe9QDasmGwcjO5AInwxYJV9LTMaeePcLLmIKu2TGy7soKm/VAVuZGvDyzqwiCWq0V62
         AbPNpH1PJ+C7rWg00QUywWOKBdc5lXKntEmaYCCGHVEIRRhv7InnP1fcS8SdVHdA4inT
         Uv7r87q4o1lw+8FQw4zSNEmiARj/3TRUHbtrHKcaoGxedjpq5vEE1nOp609iCEd/WIdk
         O/QjCeSFO1EmdugUzPx0HG+dAAKCtD4vU8i1HckmaT7hac/0HoMndw4vsKtO5gbJicCZ
         EArg==
X-Gm-Message-State: APjAAAUwmtC274MpG3uZ+Z2auDa7aMzg8xEwJHcciuaGt+KA2ASmIbwv
        Sgb4+RtDLBGKNZWVWk/nOAcB3A==
X-Google-Smtp-Source: APXvYqzrJ6y6SKQc3knz6JDorZCyQr9RqOoaV0+6FdEhc0QwUPEk8j7/6yaSHyOh8xQOkiSESj/0vg==
X-Received: by 2002:a63:e451:: with SMTP id i17mr5358153pgk.312.1556819054100;
        Thu, 02 May 2019 10:44:14 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id w38sm48319600pgk.90.2019.05.02.10.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 10:44:13 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] loop: Better discard for block devices
Date:   Thu,  2 May 2019 10:44:07 -0700
Message-Id: <20190502174409.74623-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.

The errors look like this:
[   90.880875] print_req_error: I/O error, dev loop5, sector 0

The errors occur when trying to do a discard or write zeroes operation
on a loop device backed by a block device that does not support write zeroes.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
zeroing capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does an fallocate operation on the
backing device. After this change, backing block devices that do support
zeroing will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support zeroing will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.


Changes in v4:
- Mirror blkdev's write_zeroes into loopdev's discard_sectors.

Changes in v3:
- Updated tags
- Updated commit description

Changes in v2:
- Unnested error if statement (Bart)

Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 66 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 22 deletions(-)

-- 
2.20.1

