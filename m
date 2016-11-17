Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34637 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbcKQW2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 17:28:13 -0500
Received: by mail-qk0-f194.google.com with SMTP id 124so28607510qkh.1
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2016 14:28:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <yq1h976akkd.fsf@sermon.lab.mkp.net>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175906.GA10050@localhost.localdomain> <yq1h976akkd.fsf@sermon.lab.mkp.net>
From: chaitany kulkarni <ckulkarnilinux@gmail.com>
Date: Thu, 17 Nov 2016 14:28:12 -0800
Message-ID: <CAK0tqi=rMd9EqXLzAVXp0RnTGpv3USLcu95=vwhZPbK-qZos5A@mail.gmail.com>
Subject: Re: [PATCH 2/5] block: add support for REQ_OP_WRITE_ZEROES
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, axboe@fb.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Incorporated the comments and sent new patch.

On Wed, Nov 16, 2016 at 6:48 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Keith" == Keith Busch <keith.busch@intel.com> writes:
>
> Keith> Your maximum bi_size exceeds the 2-bytes an NVMe Write Zeroes
> Keith> command provides for the block count. Instead of having a simple
> Keith> queue flag for write zeroes support, have it take a max sectors
> Keith> value instead.
>
> Yes, please. Make it a queue limit and make sure it is properly stacked.
>
> The rest looks sensible to me. I'll wire up the SCSI pieces.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
