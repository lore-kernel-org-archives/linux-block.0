Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBACC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE17610CF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 23:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJUXF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJUXF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 19:05:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF5C061764;
        Thu, 21 Oct 2021 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VI1zo5ns2BGuRC5SeZqvz11HlioNJpoIGp+InH7kBGw=; b=ujZuC3EzKWNmxs8THzypqFOyec
        Ewo+1t/ICBLsY14LMnKHx3bQEZ22SwR25yRZFfXo6zKJNx/9wn4zq6f3NsbazUDeCmp+GBr0WkfK0
        r8Q1z59ts9/eLtb7FWBbMk6A+zeZlWYDKSZU+Dn50A2Ry7ksSjQh3AUgURGRZ06NTIJ9Fx71Lp6ht
        VrXGZZj2IVFL1xAyk0emJbvfyfhGmkLoLMXDSk6Eqc1VnONBNbg1IQoX+2nomH3RWnITiOXIeE6oK
        SHSQMGBwzKJvA3ZzAygCbFpJOMEb3suf1NnjJtGjzcTIOQxsvAJg5nmmGbCcuPJWEI8PzAXMSSkXS
        ZqiS8OZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdh5a-009GeW-VN; Thu, 21 Oct 2021 23:03:10 +0000
Date:   Thu, 21 Oct 2021 16:03:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] zram: fix race between zram_reset_device() and
 disksize_store()
Message-ID: <YXHxrnnZpqCzOVDI@bombadil.infradead.org>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <20211020015548.2374568-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020015548.2374568-2-ming.lei@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 09:55:45AM +0800, Ming Lei wrote:
> When the ->init_lock is released in zram_reset_device(), disksize_store()
> can come in and try to allocate meta, but zram_reset_device() is freeing
> free meta, so cause races.
> 
> Link: https://lore.kernel.org/linux-block/20210927163805.808907-1-mcgrof@kernel.org/T/#mc617f865a3fa2778e40f317ddf48f6447c20c073
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
