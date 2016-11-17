Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35191 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbcKQCsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 21:48:39 -0500
To: Keith Busch <keith.busch@intel.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@fb.com,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH 2/5] block: add support for REQ_OP_WRITE_ZEROES
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
        <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
        <20161116175906.GA10050@localhost.localdomain>
Date: Wed, 16 Nov 2016 21:48:02 -0500
In-Reply-To: <20161116175906.GA10050@localhost.localdomain> (Keith Busch's
        message of "Wed, 16 Nov 2016 12:59:07 -0500")
Message-ID: <yq1h976akkd.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Keith" == Keith Busch <keith.busch@intel.com> writes:

Keith> Your maximum bi_size exceeds the 2-bytes an NVMe Write Zeroes
Keith> command provides for the block count. Instead of having a simple
Keith> queue flag for write zeroes support, have it take a max sectors
Keith> value instead.

Yes, please. Make it a queue limit and make sure it is properly stacked.

The rest looks sensible to me. I'll wire up the SCSI pieces.

-- 
Martin K. Petersen	Oracle Linux Engineering
