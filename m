Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD77C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 09:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7406C21850
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 09:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfCTJaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31823 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfCTJaC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 05:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 870FC30FD859;
        Wed, 20 Mar 2019 09:30:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4C7B5D9C4;
        Wed, 20 Mar 2019 09:29:57 +0000 (UTC)
Date:   Wed, 20 Mar 2019 17:29:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, houtao1@huawei.com,
        yanaijie@huawei.com, jianchao.w.wang@oracle.com
Subject: Re: [PATCH] blk-mq: fix a hung issue when set device state to
 blocked and restore running
Message-ID: <20190320092951.GA9051@ming.t460p>
References: <1553068921-6605-1-git-send-email-zhengbin13@huawei.com>
 <20190320081110.GA8408@ming.t460p>
 <c0821276-2127-e6d8-97b0-b96628d11ba7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0821276-2127-e6d8-97b0-b96628d11ba7@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 20 Mar 2019 09:30:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 04:52:40PM +0800, zhengbin (A) wrote:
> Thanks for your quick reply, I will study BLK_STS_DEV_RESOURCE in detail
> 
> > BLK_STS_DEV_RESOURCE means that the driver will rerun hw queue, so
> > maybe you need to investigate why it is returned from scsi driver first.
> because we set the device state to blocked,
> scsi_queue_rq-->prep_to_mq(return BLK_STS_RESOURCE)
> 	     -->out_put_budget  transfer BLK_STS_RESOURCE to BLK_STS_DEV_RESOURCE
> In this situtation, the request does not send to the driver.

Then the queue will be run when the scsi_device becomes un-blocked,
see scsi_internal_device_unblock_nowait().


Thanks,
Ming
