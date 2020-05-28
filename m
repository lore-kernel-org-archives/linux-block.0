Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE1C433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 19:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5226E207BC
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693287;
	bh=4TNZ1gE0J4wNNJPj2ShQ7dR9eAGvXi/dNokp1xdJ1OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x/SSB8HPNOQvvfU2Cjtd2rLOg59MEzTNkvvczq8ACDoO63ImYdNHio/VOD0ZKbrkS
	 u0byt+JUHO9dJsAdwCOxznEnzFFPToHBjOCnYe5RqUDJaH3uGWgIDa+EkiSozDuy+/
	 K+xp51/brRLS+KmW5bPupDz8PeLqDFv8wevtiRYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406156AbgE1TOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 15:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406126AbgE1TOq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 15:14:46 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF502075A;
        Thu, 28 May 2020 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590693285;
        bh=4TNZ1gE0J4wNNJPj2ShQ7dR9eAGvXi/dNokp1xdJ1OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQnBAZ0NqV80gCe2QUr33PmR+PVVlLb7Cmd5VglOG/xZ3VvIeNz3vaTQKO0hjRltS
         tRKZEFj3Y1ph49XjLmsb1+K1I2jon+NgTlsZK7wv+sQ5UVce66g5SUfFt6D4eMDeAP
         GhtUP2otbjB1HgZSEJILaxkmySCiHN65JhiWS40s=
Date:   Thu, 28 May 2020 12:14:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alan Adamson <alan.adamson@oracle.com>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
Message-ID: <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 12:11:18PM -0700, Keith Busch wrote:
> You can expect your fake timeout with 100% probablility to take 150
> seconds minimum to return a retryable request.

Sorry, I should have said 300 seconds. We restart the timer for aborts,
so 5 requeues * 30 seconds * 2 timer starts = 300 seconds.
