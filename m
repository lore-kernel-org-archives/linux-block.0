Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37526 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbcFITr6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 15:47:58 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id EC3DC203A0
	for <linux-block@vger.kernel.org>; Thu,  9 Jun 2016 19:47:56 +0000 (UTC)
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 300CF20384
	for <linux-block@vger.kernel.org>; Thu,  9 Jun 2016 19:47:56 +0000 (UTC)
Received: by mail-vk0-f50.google.com with SMTP id d127so69733929vkh.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2016 12:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160609141012.GB30293@lst.de>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <1465415292-9416-3-git-send-email-mlin@kernel.org> <575950DB.6080701@lightbits.io>
 <20160609141012.GB30293@lst.de>
From: Ming Lin <mlin@kernel.org>
Date: Thu, 9 Jun 2016 12:47:54 -0700
Message-ID: <CAF1ivSbkU2q4bUReMHo0W=wCYs2rO8ZWEFQYyH1qtzjftJrkug@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@lightbits.io>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@fb.com>,
	James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 9, 2016 at 7:10 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jun 09, 2016 at 02:19:55PM +0300, Sagi Grimberg wrote:
>> This needs documentation in the form of:
>>
>> /*
>>  * XXX: blk-mq might not map all our hw contexts but this is a must for
>>  * us for fabric connects. So until we can fix blk-mq we check that.
>>  */
>
> I think the right thing to do is to have a member of actually mapped
> queues in the block layer, and I also don't think we need the XXX comment
> as there are valid reasons for not mapping all queues.

I think it is a rare case that we need all hw contexts mapped.
Seems unnecessary to add a new field to "struct request_queue" for the
rare case.
