Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50964C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277412083B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfBEUxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:53:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEUxX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 15:53:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC4C010F9B;
        Tue,  5 Feb 2019 20:53:22 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id C108C7B8CC;
        Tue,  5 Feb 2019 20:53:14 +0000 (UTC)
Date:   Tue, 5 Feb 2019 15:53:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190205155256-mutt-send-email-mst@kernel.org>
References: <20190131163403.11363-1-joro@8bytes.org>
 <20190201080946.GA15512@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201080946.GA15512@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 05 Feb 2019 20:53:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:09:46AM +0100, Christoph Hellwig wrote:
> For some reason patch 5 didn't make it to my inbox, but assuming
> nothing has changed this whole series looks good to me now.

Could you send a formal series ack pls?

