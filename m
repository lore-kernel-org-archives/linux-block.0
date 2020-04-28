Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF8DC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC89C206E2
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588083424;
	bh=P8EyMruI62o1eKZ5R8w31u+3QO3JiIKloZ7NNBv1dto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uP26dXb4iTHlg7wa0DzgIFmcI8O3BtEtUbW18rj7kxDpKBDHlqAx//5nfc9OaFG4H
	 QFWGP+PyowgDBMG4RbMggmGKgPQ6FQBAOZeev9efa6zmgy8xeQ9VPkrxvoltdYE17S
	 DBYqxqCggLrrcIksidsATIPHziNgoVtgO9IyYDtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgD1ORE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgD1ORD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:17:03 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB19206D9;
        Tue, 28 Apr 2020 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588083423;
        bh=P8EyMruI62o1eKZ5R8w31u+3QO3JiIKloZ7NNBv1dto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bu78jWzo4Dp9qdI1Sv2ntKPsA2a1v3dFNcyTtaud2JeLIXN7mHEGppqldkB6YW0YF
         VUx47eZ7Ptli5GtyU8hffQVMvPz9XvulbqOvrGN4GOaLiB2XKjifIvwZCSDOHxfEMD
         4lLInTkj7W0mSvoK3bokNgqgsCIZr5d0LHJ3Lfp4=
Date:   Tue, 28 Apr 2020 07:17:01 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: improve the submit_bio and
 generic_make_request documentation
Message-ID: <20200428141701.GA2269866@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428112756.1892137-2-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 01:27:53PM +0200, Christoph Hellwig wrote:
> + * fully set up &struct bio that describes the I/O that needs to be done.  The
> + * bio will be send to the device described by the bi_disk and bi_partno fields.

s/send/sent

Otherwise looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
