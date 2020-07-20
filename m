Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF61C433E2
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83DC2073A
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faTb0th5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgGTMeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgGTMef (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 08:34:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A1C061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W3GmXvYdXMhNcHTUsr7n/7tOgGq1KTL6YI0G7m+Qcho=; b=faTb0th5+A76iLjlY06pdD+6iD
        9cK5Y6/Vl6d/D65jkZXPnUobib4z5ldTEHDdRHEHNCzM1SuLziZzBrqEdZnAchnJo5cq0P420UsWT
        HdKSEdVg3LQBeYFswUGg8cyBPV5Vq4nMqjn1iz1UPsloYweHFmAGaPP2wlEfdo/cwhSLbMvTjVmEd
        y72nJJ++N/QDjnt7374yGcNOw5zpWqs29kj09a1sVSHccDyqbB/Sbn+Gkb0YwCKnqjMxSn1wnzpmO
        2XFE4ZplyZbDN2VkAZLyxbN1+kweFdpUvTWzGjbhye3ftXFNKyAMSX16NCilJnI3TxOLX/CEX2hyM
        +qjpoGJA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxUzz-0003jk-FO; Mon, 20 Jul 2020 12:34:27 +0000
Date:   Mon, 20 Jul 2020 13:34:27 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Message-ID: <20200720123427.GA14186@infradead.org>
References: <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
 <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717100232.GD670561@T590>
 <CY4PR04MB3751B7720950B99A50CEF485E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720110831.GA28284@infradead.org>
 <CY4PR04MB3751CAF3D387E973AB6D9D29E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751CAF3D387E973AB6D9D29E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 20, 2020 at 12:32:48PM +0000, Damien Le Moal wrote:
> But for regular 4Kn drives, including all logical drives like null_blk, I think
> it would still be nice to have a max_hw_sectors and max_sectors aligned on 4K.
> We can enforce that generically in the block layer when setting these limits, or
> audit drivers and correct those setting weird values (like null_blk). Which
> approach do you think is better ?

I guess we can just round down in the block layer.
