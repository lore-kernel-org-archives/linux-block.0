Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F427C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 15:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjCOPHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjCOPHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 11:07:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8EF1DBA0;
        Wed, 15 Mar 2023 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hhjj39aBNPHmPcImnS2rxOatDMbbYAct3kQhJtKMQjM=; b=DN3Hm7BwaEm+fyFv1RrWLL/1mU
        f0GDNRGuVBJjo+IkdehaM/kgpKMmKXK+8lZWOlTNLU/eeWpt37/N8GvppXsLzGvJoqDz810zlH0vJ
        zFCEZflEYPt79Zq6IT+c9p4F9gKjkJne9O6+tNpnYweum37WINJe5bpT4xG/JHegZ7TXgM1XooeB4
        S9i5e01Qq/WxI7bIxSAOafDDtgOKx9hGkoMMHeAORVhHVskyUYIjhlvHKJNh1TAWahmO3hz8AUdVD
        gZQ/hETWfckMEbOExZy/8wR1tgWMiuH9rJCnU36jY2VvBYpibNgElJicMc/EfBWq6yHbxRFxFWzIK
        luNvyxiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSig-00Djce-24;
        Wed, 15 Mar 2023 15:07:14 +0000
Date:   Wed, 15 Mar 2023 08:07:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/4] blk-integrity: drop integrity_kobj from gendisk
Message-ID: <ZBHfItq+gXGBvyWG@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-4-761a50d71900@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-4-761a50d71900@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 10, 2023 at 10:40:05PM +0000, Thomas Weißschuh wrote:
> The previous patches made the integrity_kobj member in struct gendisk
> superfluous, remove it.

Maybe fold this into the patch that removes the last use?
