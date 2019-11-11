Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F0C43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6122245B
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJG431fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfKKTBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:01:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfKKSun (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 13:50:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so10003168pgh.3
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2019 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqHuH+O1ZtrNaMwGovrIH7hD1eYbuecwgYp3TILG6e4=;
        b=TJG431fn1FQazvBV6Wgeh1D1wZrDk14udOcQWLRSZYNozaF4BCdB3j2A0utl5FXPFt
         NgTBU+vR/As+hZEKwnhqOjqj+szVkfsP89rSv7JbOcPAdAv1yAmmE5/QW3sJq4JAEBpZ
         2kqULMCOeTgNBVUSkKn4qxCkgV0hofZMUgKCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqHuH+O1ZtrNaMwGovrIH7hD1eYbuecwgYp3TILG6e4=;
        b=WPn+K9hcpNtSbcoy/yk1ITC52vuSTa6A8RgfL9XNp6lIlda5sGTDDuaDMaHJ+7Aki8
         A2puyWsO9pJX20xnCbDH3dj6XDz8J9BZKQlyfpQmVMxw2awRQHR2+WTopA0Ge4oTlNxi
         tEgUdc28t1HzHg5lC9YXn0KqP/EyM0RQS/mErL/Orbtuwe65VBZWWSnlVIzBXQxZ4T6j
         NI4B8HTFVd0jlC1o5jqP3hzINh11nf3MAe1NRl8Is13C89Og4Bxe85/dd1YmMKgFS+Ax
         UkXF1+3Y8OMulQ23lwqat3MeBbxlXvqz4TVp1O5JJPPSGTi6kiQJ5FfACoS1e6OV+Fov
         SzrQ==
X-Gm-Message-State: APjAAAUX0uhHuZ+B7jxLiKbuHnDiZXEMkimPfnv4l/BEZn7lu2RjQcFr
        8RNd4vFvyVWpNEgbytuT0OY05A==
X-Google-Smtp-Source: APXvYqzgUhSewfB+4TJd+kX8NbecYhFiDmQoSYio8sWbACFZFKCrIXhdmbochMPYaHa6i8+pBxCOyg==
X-Received: by 2002:aa7:9189:: with SMTP id x9mr4439687pfa.41.1573498242139;
        Mon, 11 Nov 2019 10:50:42 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v63sm15220971pfb.181.2019.11.11.10.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Nov 2019 10:50:41 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] loop: Better discard for block devices
Date:   Mon, 11 Nov 2019 10:50:28 -0800
Message-Id: <20191111185030.215451-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.21.0
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

Darrick, I see you've got a related change in linux-next. I'm not sure what
the status of that is, so I didn't base my latest spin on top of yours.

Changes in v6:
- Updated tags

Changes in v5:
- Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)

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
2.21.0

