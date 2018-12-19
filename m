Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7846C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 03:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ADD21873
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 03:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLSD1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:27:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeLSD1s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 22:27:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C91EA2D7E8;
        Wed, 19 Dec 2018 03:27:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 497AE5DD65;
        Wed, 19 Dec 2018 03:27:43 +0000 (UTC)
Date:   Wed, 19 Dec 2018 11:27:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: block: percpu ref (blkg_release) <= 0 (0) after switching to
 atomic
Message-ID: <20181219032738.GB4451@ming.t460p>
References: <20181219032520.GA4451@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219032520.GA4451@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 19 Dec 2018 03:27:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 11:25:21AM +0800, Ming Lei wrote:
> Hi Jens and Dennis,
> 
> The following warning can be triggered on for-4.21/block when running
> xfstests generic/475(xfs), and it is introduced by recent Dennis's patches.
> 
> test disk: virtio-blk
> scratch: nvme-pci disk

oops, the test disk is virtio-scsi, and seems it isn't easy to trigger
on virtio-blk.


Thanks,
Ming
