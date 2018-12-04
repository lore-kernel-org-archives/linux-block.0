Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12201C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72B22082D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72B22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeLDPFT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:05:19 -0500
Received: from verein.lst.de ([213.95.11.211]:44347 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeLDPFT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:05:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4C14868BF4; Tue,  4 Dec 2018 16:05:17 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:05:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
Message-ID: <20181204150517.GC3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de> <20181202164628.1116-7-hch@lst.de> <0997230c-a13e-65ea-130a-cca366336989@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0997230c-a13e-65ea-130a-cca366336989@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 05:00:59PM -0800, Sagi Grimberg wrote:
>
>> @@ -2428,7 +2426,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>   	nvme_stop_queues(&dev->ctrl);
>>     	if (!dead && dev->ctrl.queue_count > 0) {
>> -		nvme_disable_io_queues(dev);
>> +		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
>> +			
>
> Would be nice if the opcode change would be kept inside but still
> split like:

I actually like not having another wrapper to stop through..

Keith, Jens, any preference?
