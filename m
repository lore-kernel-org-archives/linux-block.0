Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8CC04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 06:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2032054F
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 06:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfFFGmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:42:21 -0400
Received: from verein.lst.de ([213.95.11.211]:47422 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGmV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jun 2019 02:42:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9AB2968B05; Thu,  6 Jun 2019 08:41:53 +0200 (CEST)
Date:   Thu, 6 Jun 2019 08:41:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
Message-ID: <20190606064153.GD27033@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de> <345c3931-0940-7d59-ebc6-fa1ea56c60ac@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345c3931-0940-7d59-ebc6-fa1ea56c60ac@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 06, 2019 at 08:02:07AM +0200, Hannes Reinecke wrote:
> >  	scsi_change_queue_depth(sdev, device_qd);
> >  
> What happened to the NOMERGES queue flag?

Quote from the patch description:

"Also remove the bogus nomerges flag, merges do take the virt_boundary
 into account."
