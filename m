Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72085C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3EC2087B
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="L8t0ORuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfD3XbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 19:31:09 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:59484 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfD3Xa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 19:30:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id 4D0A9A02D4;
        Wed,  1 May 2019 01:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556666468; i=@fjfi.cvut.cz;
        bh=ilYqmYI1sLVecoSemBH0A3zy0RgR2DNeT9RBT5MmbSo=;
        h=From:To:Cc:Subject:Date;
        b=L8t0ORuGVcRX15rlXRKApnMQCXn6AHSyw2OZ82HybvsnSeSGSFvrbjfLhaea4B0vK
         vhl3wF6T/IYabjEVeLDFzQa+ANvHBwnwLvZ7vu47GzQpnxKb3dvixIMDXj+4d5rZuB
         82dPXFY40bwJdX81d1mNzBo9NkkxXnt+VCqeqOXg=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 2RPag0q5S8ZB; Wed,  1 May 2019 01:21:00 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id 8DB6FA022D;
        Wed,  1 May 2019 01:20:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz 8DB6FA022D
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 37BB46004D; Wed,  1 May 2019 01:20:59 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 0/3] block: sed-opal: add support for shadow MBR done flag and write
Date:   Wed,  1 May 2019 01:20:56 +0200
Message-Id: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series extends SED Opal support: it adds IOCTL for setting the shadow
MBR done flag which can be useful for unlocking an Opal disk on boot and it adds
IOCTL for writing to the shadow MBR.

The code has been already submitted in [1] but it was suggested to split this
part off. In comparison to that version, I tried to apply Scott's suggestions
from [2].

This series requires the previously-submitted Opal cleanup patches[3]. It
applies on current linux-next/master (e.g. next-20190430).

I successfully tested toggling the MBR done flag and writing the shadow MBR
using some tools I hacked together[4] with a Samsung SSD 850 EVO drive.

[1] https://lore.kernel.org/lkml/1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz/
[2] https://lore.kernel.org/lkml/20190210182655.GA20491@hacktheplanet/
[3] https://lore.kernel.org/lkml/1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz/
[4] https://gitlab.com/zub2/opalctl

Jonas Rabenstein (3):
  block: sed-opal: add ioctl for done-mark of shadow mbr
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  16 ++++
 block/sed-opal.c              | 160 +++++++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |  20 +++++
 4 files changed, 196 insertions(+), 2 deletions(-)

-- 
2.20.1

