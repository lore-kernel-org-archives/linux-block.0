Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937577AbdD1Ozs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:55:48 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH v3 0/7] Fixup mtip32xx for scheduling
Date: Fri, 28 Apr 2017 08:55:33 -0600
Message-ID: <1493391340-24629-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sending out a new version, since it'd be great to get this fixed
up before sending out the 4.12 pull requests.

Changes since v2(a):

- Kill RQF_RESERVED. Export helper to help the driver see if a given
  request is reserved or not, and use this insead of RQF_RESERVED.

-- 
Jens Axboe
