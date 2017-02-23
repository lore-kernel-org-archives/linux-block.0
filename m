Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47386 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbdBWAv7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 19:51:59 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernek.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: sense handling improvements
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170214191600.17480-1-hch@lst.de> <yq18tp6by2n.fsf@oracle.com>
        <20170222071915.GA18084@lst.de>
Date: Wed, 22 Feb 2017 19:51:44 -0500
In-Reply-To: <20170222071915.GA18084@lst.de> (Christoph Hellwig's message of
        "Wed, 22 Feb 2017 08:19:15 +0100")
Message-ID: <yq1shn57mqn.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph,

>> I can bring them in after Linus' initial block pull.

Christoph> Both the block and SCSI trees are now merged by Linus, and
Christoph> Jens didn't pick up patch one from this series yet - maybe
Christoph> it's best to send the whole series through the SCSI tree in
Christoph> this case.

I applied 1-4 to 4.11/scsi-fixes. Both 5 and 6 had problems so please
fix those up.

-- 
Martin K. Petersen	Oracle Linux Engineering
