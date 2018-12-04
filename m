Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C18DC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6382082D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6382082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeLDPEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:04:05 -0500
Received: from verein.lst.de ([213.95.11.211]:44324 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLDPEF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:04:05 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 65E3A68BDB; Tue,  4 Dec 2018 16:04:03 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:04:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue
 enabled
Message-ID: <20181204150403.GA3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de> <20181202164628.1116-3-hch@lst.de> <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 04:54:15PM -0800, Sagi Grimberg wrote:
>
>> @@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>     	if (nr_io_queues == 0)
>>   		return 0;
>> +	
>> +	clear_bit(NVMEQ_ENABLED, &adminq->flags);
>>   
>
> This is a change of behavior, looks correct though as we can fail
> nvme_setup_irqs after we freed the admin vector. Needs documentation 
> though..

I have a hard time parsing the above, can you point to where the problem
is?
