Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39619 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbcKRCXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 21:23:05 -0500
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH v2 2/5] block: add support for REQ_OP_WRITE_ZEROES
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
Date: Thu, 17 Nov 2016 21:22:33 -0500
In-Reply-To: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com>
        (Chaitanya Kulkarni's message of "Thu, 17 Nov 2016 14:17:11 -0800")
Message-ID: <yq11sy97cie.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Chaitanya" == Chaitanya Kulkarni <ckulkarnilinux@gmail.com> writes:

Chaitanya> This adds a new block layer operation to zero out a range of
Chaitanya> LBAs. This allows to implement zeroing for devices that don't
Chaitanya> use either discard with a predictable zero pattern or WRITE
Chaitanya> SAME of zeroes.  The prominent example of that is NVMe with
Chaitanya> the Write Zeroes command, but in the future this should also
Chaitanya> help with improving the way zeroing discards work.

Looks good. Please also export the queue limit in blk-sysfs.c and create
a suitable entry in Documentation/ABI/testing/sysfs-block.

-- 
Martin K. Petersen	Oracle Linux Engineering
