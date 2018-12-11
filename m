Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12BBC6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A922084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 22:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A922084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKW6a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:58:30 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:37529 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKW6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 17:58:30 -0500
Received: by mail-pl1-f176.google.com with SMTP id b5so7619443plr.4
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 14:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=zqAx5hcz2pNj4KBRORsJwWz7ILgoO9Fk+EM4aHLOkqA=;
        b=KZglJzD6SJnHv+aSAwfSe9G2Vi5DvHsVFPcwwz2+XbHh+DRHTzTv3gTE2KEcOlAr5F
         SQqv+BNXWSEll9lSWoF5+jLd+mAlwErO6q2KgRFtjicmMxsRVyn6YbzJ+bDAsVeexiqM
         48mkYVkXgABNjX/FL3GmpBAzhtJJ/2FPm1QVaiNC5Xs9NED/rMpPJKpa6k0MtgeGy7oT
         CRi2GxpRcj9HjYc1rYh/Rwx6Fmkdcpp3VWUDzGF9FipTTOR10H9mbdxrSwQDxwV6jIfj
         V4yhyeI7larTC0DLtiyRSks1dePBHf2PIxjjB8XwX5LLbh9BHIPneatAAJu0JVAdaeSU
         4Ofw==
X-Gm-Message-State: AA+aEWayOB9KszqWzJ5WYPvhsaDymK/ny/mT+Zey1zQZBBhBHAqP72lv
        e7Zlx+Fv9zcIDQJxkgbEu3o=
X-Google-Smtp-Source: AFSGD/UN2fg1PC1njGkRUqyHP9iiv5Y6A2U3RQq7bMw8fCWeBn6J5p59/yn+4qp6M5U8nk5OUrRDeA==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr18200937plt.30.1544569109503;
        Tue, 11 Dec 2018 14:58:29 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i123sm26617261pfg.164.2018.12.11.14.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:58:28 -0800 (PST)
Message-ID: <1544569107.185366.391.camel@acm.org>
Subject: for-next hangs on test srp/012
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Tue, 11 Dec 2018 14:58:27 -0800
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

If I run the following subset of blktests:

  while :+ADs do ./check -q srp +ACYAJg ./check -q nvmeof-mp+ADs done

against today's for-next branch (commit dd2bf2df85a7) then after some
time the following hang is reported:

INFO: task fio:14869 blocked for more than 120 seconds.
      Not tainted 4.20.0-rc6-dbg+- +ACM-1
+ACI-echo 0 +AD4 /proc/sys/kernel/hung+AF8-task+AF8-timeout+AF8-secs+ACI disables this message.
fio             D25272 14869  14195 0x00000000
Call Trace:
 +AF8AXw-schedule+-0x401/0xe50
 schedule+-0x4e/0xd0
 io+AF8-schedule+-0x21/0x50
 blk+AF8-mq+AF8-get+AF8-tag+-0x46d/0x640
 blk+AF8-mq+AF8-get+AF8-request+-0x7c0/0xa00
 blk+AF8-mq+AF8-make+AF8-request+-0x241/0xa70
 generic+AF8-make+AF8-request+-0x411/0x950
 submit+AF8-bio+-0x9b/0x250
 blkdev+AF8-direct+AF8-IO+-0x7fb/0x870
 generic+AF8-file+AF8-direct+AF8-write+-0x119/0x210
 +AF8AXw-generic+AF8-file+AF8-write+AF8-iter+-0x11c/0x280
 blkdev+AF8-write+AF8-iter+-0x13c/0x220
 aio+AF8-write+-0x204/0x310
 io+AF8-submit+AF8-one+-0x9c6/0xe70
 +AF8AXw-x64+AF8-sys+AF8-io+AF8-submit+-0x115/0x340
 do+AF8-syscall+AF8-64+-0x71/0x210
 entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe

When that hang occurs my list-pending-block-requests script does not show
any pending requests:

+ACM list-pending-block-requests        
dm-0
loop0
loop1
loop2
loop3
loop4
loop5
loop6
loop7
nullb0
nullb1
sda
sdb
sdc
sdd
vda
vdb

Enabling fail+AF8-if+AF8-no+AF8-path mode did not resolve the hang so I don't think
that the root cause is in any of the dm drivers used in this test:

+ACM dmsetup ls +AHw while read dm rest+ADs do dmsetup message +ACQ-dm 0 fail+AF8-if+AF8-no+AF8-path+ADs done+ADs dmsetup remove+AF8-all+ADs dmsetup table
360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1

The same test passes against kernel v4.20-rc6.

Thanks,

Bart.
