Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2on0068.outbound.protection.outlook.com ([65.55.169.68]:54880
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751547AbcFNPCJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 11:02:09 -0400
To: Jens Axboe <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 0/3] Three minor patches for kernel v4.8
Message-ID: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
Date: Tue, 14 Jun 2016 17:01:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens,

The three patches in this series are what I came up with after having 
analyzed the output of building the block layer with make options W=1 
and C=2. It would be appreciated if you would consider these patches for 
inclusion in kernel v4.8. These three patches are:

0001-block-partition-generic.c-Remove-a-set-but-not-used-.patch
0002-block-bio-integrity.c-Add-include-blk.h.patch
0003-block-blk-cgroup.c-Declare-local-symbols-static.patch

Thanks,

Bart.
