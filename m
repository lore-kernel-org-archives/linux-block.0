Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC1C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C29C204FD
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C29C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeLMP0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:26:32 -0500
Received: from opengridcomputing.com ([72.48.214.68]:47328 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728822AbeLMP0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:26:32 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 748062267C;
        Thu, 13 Dec 2018 09:26:31 -0600 (CST)
Subject: Re: [PATCH v2 4/6] nvme-fabrics: allow user to pass in nr_poll_queues
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-5-sagi@grimberg.me>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <19dbe333-55cb-d16c-f9b3-4aa2b1ce2ca1@opengridcomputing.com>
Date:   Thu, 13 Dec 2018 09:26:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213063819.13614-5-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> This argument will specify how many polling I/O queues
> to connect when creating the controller. These I/O queues
> will host I/O that is set with REQ_HIPRI.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Is there a default if none is specified on the 'nvme connect' command?

Reviewed-by: Steve Wise <swise@opengridcomputing.com>

