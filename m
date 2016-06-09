Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36826 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbcFITnz (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 15:43:55 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF020384
	for <linux-block@vger.kernel.org>; Thu,  9 Jun 2016 19:43:54 +0000 (UTC)
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9881D20397
	for <linux-block@vger.kernel.org>; Thu,  9 Jun 2016 19:43:52 +0000 (UTC)
Received: by mail-vk0-f54.google.com with SMTP id d127so69588325vkh.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2016 12:43:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160609140909.GA30293@lst.de>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org> <20160609140909.GA30293@lst.de>
From: Ming Lin <mlin@kernel.org>
Date: Thu, 9 Jun 2016 12:43:51 -0700
Message-ID: <CAF1ivSaJUPQg2uTQVZLGL36yERF6eGFF6_jot7DsSZ=D3uPqPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] check the number of hw queues mapped to sw queues
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 9, 2016 at 7:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jun 08, 2016 at 03:48:10PM -0400, Ming Lin wrote:
>> It adds check code to blk_mq_update_queue_map().
>> But it seems too aggresive because it's not an error that some hw queues
>> were not mapped to sw queues.
>>
>> So this series just add a new function blk_mq_hctx_mapped() to check
>> how many hw queues were mapped. And the driver(for example, nvme-rdma)
>> that cares about it will do the check.
>
> I think it would be better to have this number available a structure
> field.  Any reason not to update nr_hw_queues in the tag set
> with the actual number of queues?

One reason is we don't know which hctx(s) not mapped.

HW Queue 1 <-> CPU 0,4
HW Queue 2 <-> CPU 1,5
HW Queue 3 <-> None
HW Queue 4 <-> CPU 2,6
HW Queue 5 <-> CPU 3,7
HW Queue 6 <-> None

If we updated nr_hw_queues from 6 to 4,
then queue_for_each_hw_ctx will not work.

#define queue_for_each_hw_ctx(q, hctx, i)                               \
        for ((i) = 0; (i) < (q)->nr_hw_queues &&                        \
             ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
