Return-Path: <SRS0=vA4A=OD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936BEC43441
	for <linux-block@archiver.kernel.org>; Sat, 24 Nov 2018 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507FE20874
	for <linux-block@archiver.kernel.org>; Sat, 24 Nov 2018 14:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyzd3EjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507FE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeKYAye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 19:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeKYAye (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 19:54:34 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929B22086B;
        Sat, 24 Nov 2018 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543068363;
        bh=cAUODXnN0bd/5FPeBUzD/o00hGIH9sKkV2f7Rv3WRos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wyzd3EjBEfn6aZDGOhEdN87u0XAMgZHXb+J2lkIQecoEVbW2MUztHQfLrlvr70MwZ
         JsPOjylVoj2PxsH+B6OHNYeCVKfj4xRTNYBSQvVKLhMSmUa/bsxbMVUgtAuq34DxmR
         /nA9baU4VcG3Hpkn/1eu6Q+QrvbBMxh0RYlp8Vkk=
Date:   Sat, 24 Nov 2018 19:35:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-media@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        akpm@linux-foundation.org, jiangqi903@gmail.com, hverkuil@xs4all.nl
Subject: Re: [PATCH] mm: Replace all open encodings for NUMA_NO_NODE
Message-ID: <20181124140554.GG3175@vkoul-mobl.Dlink>
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23-11-18, 15:24, Anshuman Khandual wrote:

> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -386,7 +386,8 @@ EXPORT_SYMBOL(dma_issue_pending_all);
>  static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
>  {
>  	int node = dev_to_node(chan->device->dev);
> -	return node == -1 || cpumask_test_cpu(cpu, cpumask_of_node(node));
> +	return node == NUMA_NO_NODE ||
> +		cpumask_test_cpu(cpu, cpumask_of_node(node));
>  }

I do not see dev_to_node being updated first, that returns -1 so I would
prefer to check for -1 unless it return NUMA_NO_NODE

-- 
~Vinod
