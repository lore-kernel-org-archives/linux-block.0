Return-Path: <SRS0=k455=3T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A019AC2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 00:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBE82070E
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580343667;
	bh=yUFDInoTdiXdrWOcGGvH3XCuTARojRfC9jwaLbaBh8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GPOtYU9TVyeVduYQVkvUA9OzLtZD+Q7K+83IGYeaIGFqQGNrtZANRD9wfsjwGz4mt
	 KIeMmmhMl5uILU8pQKx6JMQo1P5iUkDd+RthyuDf+h5MmDXVMHzN67h2eIU6wnTfCa
	 zrRSljpl3amsY1zq4ChFMjLDz9P6gIhE11AL4eyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA3AVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgA3AVG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 19:21:06 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F571206A2;
        Thu, 30 Jan 2020 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580343666;
        bh=yUFDInoTdiXdrWOcGGvH3XCuTARojRfC9jwaLbaBh8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEAWqqqq4Z2xO6+xdUa4uwEfY0TWLmdDxHVHfmVshHEw9SCtglTDuxlSwCOnglozV
         q7+jmNYrTlslqINM9ol05YPbYYRCLneK63M3jChPkcAZVIUDU6tMFLJa5oZl914Ocf
         9ODMe3dNUjVjP7MtfwXhWmsR5HGjFQJCG9VifeSE=
Date:   Thu, 30 Jan 2020 09:21:00 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v1 0/2] nmve/018 fixes
Message-ID: <20200130002100.GA6785@redsun51.ssa.fujisawa.hgst.com>
References: <20200128084434.128750-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128084434.128750-1-dwagner@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 28, 2020 at 09:44:32AM +0100, Daniel Wagner wrote:
>   nmve/018: Reword misleading error message

s/nmve/nvme

Otherwise looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
