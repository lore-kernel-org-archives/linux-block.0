Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB96CC2BA2B
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 07:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9302078B
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587023610;
	bh=REaCTv1NFfNXUAPAdMRA/Z/Gf7WB62TZTmgqbr6U2a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KkFPlEDTgnG3PoQQ9Muk5sBUQPt22r+kklOlOYctat4TFKNHZAE/FcKUzdw3Mny3+
	 22ZKr82vh5zVdrwebisbWhe8Bgc+7Uua0OJh5vLZ/gnZ9PLD7AHHgmuSqKDaD/AA/k
	 lVHxD9pZ5BiRpauU6Vgp+k8AlFcHrsHajTTUmI5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440004AbgDPHx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440002AbgDPHx1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 03:53:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E50E2076A;
        Thu, 16 Apr 2020 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023606;
        bh=REaCTv1NFfNXUAPAdMRA/Z/Gf7WB62TZTmgqbr6U2a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p37IBuWH7cLom8ahKY9GSPheAtxHEpj9JmESkifLQ1UemBTbpGKbiWnaCOGvObv8A
         751AbUP7aq0dDZauXvBoNwd2GgTQfWW+bkUPsHE+mq+vnwzJJB/rVLcM3eV1/vwX5S
         YVBEfgPn+CvN0YbBB3pYnfrHNANtIkKSfYl67M7Y=
Date:   Thu, 16 Apr 2020 09:53:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] bdi: unexport bdi_register_va
Message-ID: <20200416075324.GE376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-6-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:16AM +0200, Christoph Hellwig wrote:
> bdi_register_va is only used by super.c, which can't be modular.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
