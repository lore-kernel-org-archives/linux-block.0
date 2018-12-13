Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023EC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43720880
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeLMP2K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:28:10 -0500
Received: from opengridcomputing.com ([72.48.214.68]:47428 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbeLMP2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:28:10 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 74ABA2267C;
        Thu, 13 Dec 2018 09:28:09 -0600 (CST)
Subject: Re: [PATCH v2 5/6] nvme-rdma: implement polling queue map
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-6-sagi@grimberg.me>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <8ae11687-ad3f-953d-883e-98ac45aecfea@opengridcomputing.com>
Date:   Thu, 13 Dec 2018 09:28:14 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213063819.13614-6-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> When passed with nr_poll_queues setup additional queues with cq polling
> context IB_POLL_DIRECT (no interrupts) and make sure to set
> QUEUE_FLAG_POLL on the connect_q. In addition add the third queue
> mapping for polling queues.
>
> nvmf connect on this queue is polled for like all other requests so make
> nvmf_connect_io_queue poll for polling queues.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>


Looks good.

Reviewed-by: Steve Wise <swise@opengridcomputing.com>

