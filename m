Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9778C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91CF610FC
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJ1L07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:26:59 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:57604 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhJ1L07 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 07:26:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 57A8746189;
        Thu, 28 Oct 2021 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1635420270; x=
        1637234671; bh=SxAiOc0229g8LhpQIwNXx6LR+NkN/jAjoVMNQ2h/DkE=; b=b
        V5gwh4TEiJYq1pzS1ia0W2A0nOORIIkGbWPXiTgtRj0D7TVP/h8hUgU57iaissn8
        nmF42KN/ATjybV7TIW/DIl3zJLVToGXdt/00SCUwcibm0ecrHDWCaLQ8jhZ4zBX4
        gdz2FBA3FuJ7RuOt8RsIqL68i6VJQrL6mpEVVakWUw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 53E0SFiFCja8; Thu, 28 Oct 2021 14:24:30 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DEDDF460E5;
        Thu, 28 Oct 2021 14:24:29 +0300 (MSK)
Received: from localhost.localdomain (10.199.10.99) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 28 Oct 2021 14:24:29 +0300
From:   "Alexander V. Buev" <a.buev@yadro.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, <linux@yadro.com>,
        "Alexander V. Buev" <a.buev@yadro.com>
Subject: [PATCH 0/3] implement direct IO with integrity 
Date:   Thu, 28 Oct 2021 14:24:03 +0300
Message-ID: <20211028112406.101314-1-a.buev@yadro.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.10.99]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patches makes possible to do direct block IO
with integrity payload using io uring kernel interface.
Userspace app can utilize READV/WRITEV operation with a new 
(unused before) flag in sqe struct to mark IO request as 
"request with integrity payload". 
When this flag is set, the last of provided iovecs
must contain pointer and length of this integrity payload.

Alexander V. Buev (3):
  block: bio-integrity: add PI iovec to bio
  block: io_uring: add IO_WITH_PI flag to SQE
  block: fops: handle IOCB_USE_PI in direct IO

 block/bio-integrity.c         | 124 +++++++++++++++++++++++++++++++++-
 block/fops.c                  |  71 +++++++++++++++++++
 fs/io_uring.c                 |  32 ++++++++-
 include/linux/bio.h           |   8 +++
 include/linux/fs.h            |   1 +
 include/uapi/linux/io_uring.h |   3 +
 6 files changed, 235 insertions(+), 4 deletions(-)

-- 
2.33.0

