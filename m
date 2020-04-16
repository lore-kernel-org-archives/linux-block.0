Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E453C2D0EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3102076A
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587023574;
	bh=3fiYWHnYtchWwv0cEVbTD22IwPZ63nhey1tpUdIy0eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGriHxsDbugWhbqOS/Xr2uhKjoyUvK31Fro77S/Rn4Cd1/MU+qk8QP6e75g0k/1/n
	 DiVrvJflgAaFz7z7kB4K2qDkbRCmaW2vB3cynGXQzTBiZ9n64BjlSXkd2KmFJlAD0x
	 AY0E4xX3H9zXrzcrhmrnqosoED1G+01Nf7GAy/uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439919AbgDPHww (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439830AbgDPHwv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 03:52:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B8C2076A;
        Thu, 16 Apr 2020 07:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023570;
        bh=3fiYWHnYtchWwv0cEVbTD22IwPZ63nhey1tpUdIy0eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBWBZ/8aRM86Ne+b8qFGgrKfGBeqpLXH7upksukzDDKBFjJ/kAZelzyxKh4C1mAEs
         nYSHIAbieJFRCKNm4/N538Mv7XtJr6fSM7bDlFttHzPsU532o+9d5Xntf3uh2kqRuv
         Qdz+QP70NxgjxOZBPC7IPmFd5n2bECXwqv6RRqYM=
Date:   Thu, 16 Apr 2020 09:52:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] bdi: use bdi_dev_name() to get device name
Message-ID: <20200416075248.GC376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-3-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:13AM +0200, Christoph Hellwig wrote:
> From: Yufen Yu <yuyufen@huawei.com>
> 
> Use the common interface bdi_dev_name() to get device name.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
