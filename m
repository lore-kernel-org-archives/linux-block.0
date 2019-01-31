Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12412C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC172087F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGD/7t3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfAaWNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:13:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33986 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfAaWNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 17:13:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so2123500plz.1
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcXvSDSPy9bgfIgUOH90Lcwdn7ixN1lGbyJwaRTlUHQ=;
        b=UGD/7t3D1sqs0Oxwzkugt+4GoJENoEhdkE18BCxu3b0cI4I8HAWmQTLcf9JCOR+KbN
         YHJrVVaixW/p7AliIQpmYaVsMrMzVsGZKaCBAnKnh1vxBLWug7VyP4ZBNiafbPq+mECp
         nEu4worV26FAaMW4F+XIGAnJX31wvNkBzgtGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcXvSDSPy9bgfIgUOH90Lcwdn7ixN1lGbyJwaRTlUHQ=;
        b=sPc6KJMx7+ApY4nJ/pTqkXItIO2qmzuIsCb5SgX0IvNyX84LEo0f+vnQh7sHevzhFi
         wj0uuKWqmjFH017rOBWa3Zu1AktHu8M8INXrrN+yCs2ayHjDUpMBzu4Po589/dbHX9Hm
         klBa/a2K1ll9k8k58FqsKskUgyo0t8qxrPu7nF7rXsgXbKQHVdSMcofoKuI5vEA2tHci
         0xjZoHcYvJYsov7uzrhQDnQizlqAmwZ/ba05U6P5JC0BRMDnb7/yJ2GuJgxqRrD09qUB
         j9PSaopgQGCNdXmvlXi0mjdtE7/m/TjrC4s3z9oZ1ychk38L48jyjTEWSIAMekJYevHW
         r8hg==
X-Gm-Message-State: AJcUukdyjveVZFSCc8T6OzLkX75owj82Kq9w6xkAgiCQ8YuEUnRJnqqu
        Nru3LEnp782rOI9s1zyZl4pbsQ==
X-Google-Smtp-Source: ALg8bN4Y4LTCygc9vt2/BX+K3QfXCkG+pjXFtGSxIJ5tI9AehBxJJj9uDvPFN4bg2iPrTbFIZxCf5A==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr36941880plc.108.1548972826464;
        Thu, 31 Jan 2019 14:13:46 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z10sm7961681pfg.120.2019.01.31.14.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 14:13:45 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Martin K Peterson <martin.peterson@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/2] loop: Better discard for block devices
Date:   Thu, 31 Jan 2019 14:13:26 -0800
Message-Id: <20190131221328.85343-1-evgreen@chromium.org>
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
on a loop device backed by a block device that does not support discard.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
discard capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does a discard operation on the
backing device. After this change, backing block devices that do support
discard will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support discard will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.



Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 75 ++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.20.1

