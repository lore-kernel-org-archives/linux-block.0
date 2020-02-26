Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76FEC4BA1E
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D84A2465D
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582740507;
	bh=CyH5Cj+lK4LdkjdulLh4uDHWRzDbMUJnvuyfXtec9n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohhvD0j6Hz9GX+FW043RuNk1ZvjaN94FipQqqrT3kYmEjlWrC9pZPHRV7YNzhxyRm
	 dAuWYkRLGVHMlk91HTelgN1LM6CcGtUmK3hVlRcSA++qn7bJs2TelESCbAZgVJUvN8
	 Ry+elV3BcN7iGn5R3OGFc7dAlEWAiqUfWFwNCi1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgBZSI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:08:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZSI0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 13:08:26 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5461724650;
        Wed, 26 Feb 2020 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582740506;
        bh=CyH5Cj+lK4LdkjdulLh4uDHWRzDbMUJnvuyfXtec9n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Btec+EwUVo3ENmRKI0X1EQ/SGCjz3U1LEZloDDFUBSvhCa+rrgMjmO18+ACW6z72i
         0MoiRId+OmwaKCyNdHQaR/XAzM6f9pmh5xGcjAyMl+1dSukyebOJT4N2TJwIo2u0vJ
         6KU836rtZ7hXF7FXExozxTrHrVlqDbVxZBDjqJcA=
Date:   Thu, 27 Feb 2020 03:08:19 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, mst@redhat.com, jejb@linux.ibm.com,
        hch@lst.de
Subject: Re: [PATCH v2 4/5] drivers/nvme/host/core.c: Convert to use
 set_capacity_revalidate_and_notify
Message-ID: <20200226180819.GA23813@redsun51.ssa.fujisawa.hgst.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
 <20200225200129.6687-5-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225200129.6687-5-sblbir@amazon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 08:01:28PM +0000, Balbir Singh wrote:
> block/genhd provides set_capacity_revalidate_and_notify() for
> sending RESIZE notifications via uevents. This notification is
> newly added to NVME devices
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>

Patch looks fine. Please change the commit subject prefix to just "nvme:"
to match the local style and for length constraints (the committer may
do this if they want).

Acked-by: Keith Busch <kbusch@kernel.org>
