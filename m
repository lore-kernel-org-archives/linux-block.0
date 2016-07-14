Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41509 "EHLO
	esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbcGNBXw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 13 Jul 2016 21:23:52 -0400
Subject: Re: [PATCH] block: Fix front merge check
To: Jens Axboe <axboe@fb.com>, <linux-block@vger.kernel.org>,
	<hch@lst.de>, <hare@suse.de>
References: <1468387413-2754-1-git-send-email-damien.lemoal@hgst.com>
 <57866A2B.5000403@fb.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
Message-ID: <8a365634-e2e7-45d9-a86d-10894212a4d2@hgst.com>
Date: Thu, 14 Jul 2016 10:23:42 +0900
MIME-Version: 1.0
In-Reply-To: <57866A2B.5000403@fb.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Jens,

On 7/14/16 01:19, Jens Axboe wrote:
> On 07/12/2016 10:23 PM, Damien Le Moal wrote:
>> For a front merge, the maximum number of sectors of the
>> request must be checked against the front merge BIO sector,
>> not the current sector of the request.
>
> Why does this matter? The merging should only happen before we start the
> request, hence rq pos and first bio should be one and the same.

The block device of SMR drives is set up as chunked with the chunk size 
equal to the drive zone size. Since write requests directed to 
sequential zones cannot cross zone boundaries, both the front merge code 
and the back merge code must ensure that requests resulting from a merge 
do not cross chunk boundaries.

The back merge code does this well, but the front merge code fails to 
prevent merging when the BIO is the last write in a zone and the request 
is the first write in the following (empty) zone. The check against the 
request LBA does not prevent the merge as the request+bio size fit in 
the empty zone. The check must be against the BIO LBA to detect the 
chunk boundary crossing.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital brand
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

