Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbiBKQRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:17:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiBKQRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 11:17:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCABB70
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwUOT5mcKlzxD68fAPG/Jbxkj0+8cpfwWhMpu2ETAx4=; b=ghbyDQMRfCglYx2daSWr+LxaT3
        0cmJGP2Q0bd8IVo8LTd85lWMisqAm/Jlybf04lt1+3Eu1tqxwxCx69c3mCYjZSmEtme3Ah5th8IBP
        8kh/Ppju7G+cyxNfIR15YMWYSiGqIHKJz9RaaeS2maF95cBtUqeTRguFckyZpKBJwinFWaZnFOZ/Y
        SI4Inkd1aKKkLrR8+m9bb4UA2njKPjaok9Eb4/0wppFatIq/SkpfXHNlsBmWuQcZSG8m2ziZWR2Dc
        rr5gKTAI1QlfbO/drx1WpGZqkE5aK0mlT4AI1to8I5EhnN30lpXDcDuqpG23X980oST8fHPunU4Hh
        mOzWXMOQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIYbx-007yRM-Uu; Fri, 11 Feb 2022 16:17:29 +0000
Date:   Fri, 11 Feb 2022 08:17:29 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Message-ID: <YgaMGbtYHgscxfxZ@bombadil.infradead.org>
References: <20220211093425.43262-1-p.raghav@samsung.com>
 <CGME20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314@eucas1p1.samsung.com>
 <20220211093425.43262-2-p.raghav@samsung.com>
 <PH0PR04MB7416B842B185ECF0F52AF0949B309@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416B842B185ECF0F52AF0949B309@PH0PR04MB7416.namprd04.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 11, 2022 at 10:02:26AM +0000, Johannes Thumshirn wrote:
> On 11/02/2022 10:42, Pankaj Raghav wrote:
> > Zone append command needs special handling to update the bi_sector
> > field in the bio struct with the actual position of the data in the
> > device. It is stored in __sector field of the request struct.
> > 
> > Fixes: 5581a5ddfe8d ("block: add completion handler for fast path")
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> I would've preferred if you had put the trace and steps to reproduce 
> in the changelog instead of the cover letter but, maybe Jens can update
> it when he applies the patch.

That would be wonderful. And a new fstests :)

I'm surprised no one caught this earlier... does this mean... no fstests
yet covers this? If a test does... then does that mean...

  No one is testing zone btrfs... since... around December
  (5581a5ddfe8d) or January (merge commit to Linus)?

> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
