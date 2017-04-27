Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38579 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754765AbdD0Wvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 18:51:42 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH 0/6] Fixup mtip32xx for scheduling
Date: Thu, 27 Apr 2017 16:51:28 -0600
Message-ID: <1493333494-600-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This attempts a cleaner solution, where we simply mark a request
as having come from the reserved pool. mtip32xx can then be
converted to using that info, and moving it's internal command
issue over to the regular block infrastructure.

First three are prep/cleanup patches for mtip32xx, which an easier
conversion of the driver.

-- 
Jens Axboe
