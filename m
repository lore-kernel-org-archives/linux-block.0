Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA8C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C3260C41
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbhHFLTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:19:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39959 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhHFLTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 07:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628248738; x=1659784738;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Nm8xJvK6D6Eb+y2OhfvZoCxVrMeFWiNC57rtvdI0Z8=;
  b=Hq8/Xhbujtr40+zNnpFb5rW7n3Hj1nLZzTA58pPM6TKoCghwznbqOyfl
   36VsjzYCLe6Q7aM9IOeIu5rEWRGa6MlvHhueeGiIIxhdr9itoZTi9nMFd
   dtg/M52BPurYF4zbFqdAbfplVTphxkhtGbQWUl4+3BRsQQhU8zFKOAk4t
   nwQGeQllHi6DEDsmMKnHaf6FzXtw3tF751jga4NYftB5EVczJAwti0OG1
   5ehraIY7sDzuDvTjwGZBFQDoxx2EBAINOcrUIQZbPUqz1I6+K4u1Y3iQz
   pmLgMM5RdzDA/v5n6Srh6T+IfL9jJ2W5R3tfweclk+zUuCJMIsEwIeY48
   A==;
X-IronPort-AV: E=Sophos;i="5.84,300,1620662400"; 
   d="scan'208";a="181309758"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 19:18:58 +0800
IronPort-SDR: DIXtFmLvx4jrKki24hZKzf8Eidzlp7G+PIJY0YJ3OgjgJAx3OpTZ3e1ERJCvIP5Vrpy7AFuPuF
 JOJOmAgpuFVVEQTTwD9zbKw+NIdaCKpHmiH734x0SVt170CzXMtzNcBdV35kf1/KLXvzXp0rEX
 WrA6YfyBBlGqswGfemZ8mbf8hudTmcGl0I/KtxLX+YCYayN4Z+yZs0W6wOFfCteriVq0Gd9m3b
 U0EFprGom2+J2NwBrZ41h/i+twAFKj6BIZJbyGsrqkEZ9eKS8mrxya/l1lw1RPJgb0uGtZZO/7
 ycagclfuFCgF6IHPPvDPjcTR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:54:35 -0700
IronPort-SDR: SIxZVF9dtQfoWIEv9z+PTY9l2YxibRVzoXZgfCV8TwN16yyOpO7Mv8NqzfbbtInY+1A0jyTjXo
 kLZtZcV2bDckY2mpLkJWayuwUYSkR93xGPJRyM/QJAXfauXhzhbvDY6r6hAUffkj+KHKbEcSA0
 TBPvz+gafbgwftvOVF70oI8T8F9W5lCWoorFf0bfVqZvtUvxSp0x9Z01OHcZ0CM1KsDM2YHt1F
 syEMdpA/5VIotn4+7cPwQ8QQwGh42bcO/11AGE504+X1ZrM26IUL1D1tOX5/ItBr0yDeGlE7Pg
 B8g=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2021 04:18:59 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 0/4] IO priority fixes and improvements
Date:   Fri,  6 Aug 2021 20:18:53 +0900
Message-Id: <20210806111857.488705-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series fixes problems with IO priority values handling and cleans
up several macro names and code for clarity.

Changes from v2:
* Fixed typo in a comment in patch 3
* Added reviewed-by tags

Changes from v1:
* Added patch 4 to unify the default priority value used in various
  places.
* Fixed patch 2 as suggested by Bart: remove extra parenthesis and move
  ioprio_valid() from the uapi header to the kernel header.
* In patch 2, add priority value masking.

Damien Le Moal (4):
  block: bfq: fix bfq_set_next_ioprio_data()
  block: fix ioprio interface
  block: rename IOPRIO_BE_NR
  block: fix default IO priority handling

 block/bfq-iosched.c          | 10 +++++-----
 block/bfq-iosched.h          |  4 ++--
 block/bfq-wf2q.c             |  6 +++---
 block/ioprio.c               |  9 ++++-----
 drivers/nvme/host/lightnvm.c |  2 +-
 fs/f2fs/sysfs.c              |  2 +-
 include/linux/ioprio.h       | 22 ++++++++++++++++++----
 include/uapi/linux/ioprio.h  | 23 +++++++++++++----------
 8 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.31.1

