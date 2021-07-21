Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5205C07E9B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29DA61175
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhGUEqA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 00:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhGUEp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 00:45:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D4C061574;
        Tue, 20 Jul 2021 22:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mgYRCt/WE3g4ArIxNSEiTBCKixk35dYvntS3C3v4Ldo=; b=UH6q4VDp5NmuztLkKO306ATLmk
        dkC382GW2mo/epktRxsbWcM/OTc4YVIjbCq6QveK9kM2dIGSyV0rn1d/IaDQH1iln+CMS0nmIKoLn
        2XD8Za+B6l3UJ1an7XRdhUNcM/AmpTwrPuLAvt3zZhDGwUXNNW0O+yIVkU1p+eF6BhPYlXo4G1TTl
        6xNDT39V374WYlyfKgcOW/Eo6vVmlY3kRU2+YmbpnlE33q2B4f86OMJS08WNvTKGN/fhioYYoZjD0
        DqZNeQfs3nlWuTks2fWOWHmWZeozjF86mpjysP0QwmPrUDzXQcYvFKMeGg6xkcVJDRHzz0Unp/YRU
        F8yjDATg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m64jz-008pL4-Mt; Wed, 21 Jul 2021 05:25:59 +0000
Date:   Wed, 21 Jul 2021 06:25:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/block_dev: replace GENHD_FL_UP with
 GENHD_FL_DISK_ADDED
Message-ID: <YPev47BHsZ5Tmlt3@infradead.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <20210720182048.1906526-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720182048.1906526-6-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 20, 2021 at 11:20:48AM -0700, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.

No.  Here we must reject opens once del_gendisk has been called.
