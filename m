Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83209C67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4FF20672
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4FF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLLASE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:18:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41537 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLLASE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:18:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so7427337pgh.8
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 16:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJuwGhRysfemHW6agu5XIxlGIpVnQjCnPb6+2zLEIxg=;
        b=cVbPPT81CQ3AtPMykc1JaPynov7Nk9zDbXh6lmpgVj+kCBK/jbeUPuSovHMAXBUgb+
         fXvmiRIMSzMyDX6CIr9kdQFzRluXGsQpb31akvelKcOY2kW21fdALWex4KQLhPmL2qA8
         Jf5GnzweAQ1k+MCzZCXiMrOfEwjz3o+sXuN3jEO2Pva32QO+Ria3wzJK8g7okwKghvVH
         p7T1prk7gKe5MOcmhquqimpAmuFD/fRWNQlJVCCJsdnrzhRmXe86VuX2KQ51nkXWI12a
         2IfS4rvSEo2sALgdB52zd9A56l04dIszHE4P7TAglb82zqgrJXTUShcwH4lQvKbM0whH
         BISQ==
X-Gm-Message-State: AA+aEWaTY+ow0pKbLV3O+4qR3sXy+xHhrxTyC740GleFSmKgyTC3RoOU
        J+vxWwJnK2qNUDli7oG2Yp8=
X-Google-Smtp-Source: AFSGD/WezNOuTDEBdbcCWB2iD2svdPwhO2Y3s68joJtzZc+Qn2LpwKI/SgoW1/vuuzfE1MeqWS4PUA==
X-Received: by 2002:a62:7e93:: with SMTP id z141mr17905341pfc.239.1544573883401;
        Tue, 11 Dec 2018 16:18:03 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t90sm24987739pfj.23.2018.12.11.16.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 16:18:02 -0800 (PST)
Message-ID: <1544573881.185366.402.camel@acm.org>
Subject: Re: for-next hangs on test srp/012
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Tue, 11 Dec 2018 16:18:01 -0800
In-Reply-To: <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
References: <1544569107.185366.391.camel@acm.org>
         <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-11 at 17:02 -0700, Jens Axboe wrote:
+AD4 On 12/11/18 3:58 PM, Bart Van Assche wrote:
+AD4 +AD4 Hi Jens,
+AD4 +AD4 
+AD4 +AD4 If I run the following subset of blktests:
+AD4 +AD4 
+AD4 +AD4   while :+ADs do ./check -q srp +ACYAJg ./check -q nvmeof-mp+ADs done
+AD4 +AD4 
+AD4 +AD4 against today's for-next branch (commit dd2bf2df85a7) then after some
+AD4 +AD4 time the following hang is reported:
+AD4 +AD4 
+AD4 +AD4 INFO: task fio:14869 blocked for more than 120 seconds.
+AD4 +AD4       Not tainted 4.20.0-rc6-dbg+- +ACM-1
+AD4 +AD4 +ACI-echo 0 +AD4 /proc/sys/kernel/hung+AF8-task+AF8-timeout+AF8-secs+ACI disables this message.
+AD4 +AD4 fio             D25272 14869  14195 0x00000000
+AD4 +AD4 Call Trace:
+AD4 +AD4  +AF8AXw-schedule+-0x401/0xe50
+AD4 +AD4  schedule+-0x4e/0xd0
+AD4 +AD4  io+AF8-schedule+-0x21/0x50
+AD4 +AD4  blk+AF8-mq+AF8-get+AF8-tag+-0x46d/0x640
+AD4 +AD4  blk+AF8-mq+AF8-get+AF8-request+-0x7c0/0xa00
+AD4 +AD4  blk+AF8-mq+AF8-make+AF8-request+-0x241/0xa70
+AD4 +AD4  generic+AF8-make+AF8-request+-0x411/0x950
+AD4 +AD4  submit+AF8-bio+-0x9b/0x250
+AD4 +AD4  blkdev+AF8-direct+AF8-IO+-0x7fb/0x870
+AD4 +AD4  generic+AF8-file+AF8-direct+AF8-write+-0x119/0x210
+AD4 +AD4  +AF8AXw-generic+AF8-file+AF8-write+AF8-iter+-0x11c/0x280
+AD4 +AD4  blkdev+AF8-write+AF8-iter+-0x13c/0x220
+AD4 +AD4  aio+AF8-write+-0x204/0x310
+AD4 +AD4  io+AF8-submit+AF8-one+-0x9c6/0xe70
+AD4 +AD4  +AF8AXw-x64+AF8-sys+AF8-io+AF8-submit+-0x115/0x340
+AD4 +AD4  do+AF8-syscall+AF8-64+-0x71/0x210
+AD4 +AD4  entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
+AD4 +AD4 
+AD4 +AD4 When that hang occurs my list-pending-block-requests script does not show
+AD4 +AD4 any pending requests:
+AD4 +AD4 
+AD4 +AD4 +ACM list-pending-block-requests        
+AD4 +AD4 dm-0
+AD4 +AD4 loop0
+AD4 +AD4 loop1
+AD4 +AD4 loop2
+AD4 +AD4 loop3
+AD4 +AD4 loop4
+AD4 +AD4 loop5
+AD4 +AD4 loop6
+AD4 +AD4 loop7
+AD4 +AD4 nullb0
+AD4 +AD4 nullb1
+AD4 +AD4 sda
+AD4 +AD4 sdb
+AD4 +AD4 sdc
+AD4 +AD4 sdd
+AD4 +AD4 vda
+AD4 +AD4 vdb
+AD4 +AD4 
+AD4 +AD4 Enabling fail+AF8-if+AF8-no+AF8-path mode did not resolve the hang so I don't think
+AD4 +AD4 that the root cause is in any of the dm drivers used in this test:
+AD4 +AD4 
+AD4 +AD4 +ACM dmsetup ls +AHw while read dm rest+ADs do dmsetup message +ACQ-dm 0 fail+AF8-if+AF8-no+AF8-path+ADs done+ADs dmsetup remove+AF8-all+ADs dmsetup table
+AD4 +AD4 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
+AD4 +AD4 
+AD4 +AD4 The same test passes against kernel v4.20-rc6.
+AD4 
+AD4 What device is this being run on?

Older versions of the srp and nvmeof-mp tests used the brd block device.
Today these tests use null+AF8-blk with memory+AF8-backed set to 1. See also
configure+AF8-null+AF8-blk() in common/multipath-over-rdma. null+AF8-blk is accessed
by ib+AF8-srpt. The dm-mpath driver is stacked on top of the ib+AF8-srp instance
that communicates with ib+AF8-srpt driver. The ib+AF8-srp and ib+AF8-srpt drivers
communicate with each other over the loopback functionality of the
rdma+AF8-rxe driver.

Bart.
