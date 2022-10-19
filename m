Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA4C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 06:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJSGzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSGze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 02:55:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC1481DB
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aZ7DpfaBmS25liDU5Hs2TfHxsUU7VLC1MnUlXTOJ+Y=; b=scowe3qOfHCpNdeoZLBU9tg76v
        kN0dcWir1Fspm+Hcn00qR7OngYG0Oii/j++1cVt9clylWpDXIY1G4JhI+LwLJ3FMS9q9XMml39BxS
        3E5+TsxrhRsEogj0gkgLv32j0+IlJoeUXl7lKHqMlsibtwhVda8RZAmwlKaioU3nV8gX+Q68QKM1Y
        CmHghhkcbKRp7RCVE+FKOTyYTfQF7PU+TLCl4+1vTws3rndWUkoEUUBprJnx+gCfz7oWZJ3eZRnX2
        6Zji14F8814iDNbqMSDvjcTJKInOTtcyadt5xJ69PieJiGRZ65GF/LKTlw0WYuOzIWrkhb9jeF73O
        0Sjvi6TQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol2z5-00FsjG-1U; Wed, 19 Oct 2022 06:55:23 +0000
Date:   Tue, 18 Oct 2022 23:55:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] block: clear the holder releated fields on late
 disk_add failure
Message-ID: <Y0+fW7niNe7L20VH@infradead.org>
References: <20221018073822.646207-1-hch@lst.de>
 <20221018073822.646207-2-hch@lst.de>
 <8c5359e3-39ee-d363-9425-0cb8b716dcb0@huaweicloud.com>
 <20221018082651.GA26079@lst.de>
 <4c5acbb5-72e6-3f63-2e78-478d3230aa0c@huaweicloud.com>
 <7c021c4f-d31c-1a2b-70e4-4f21fea31488@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c021c4f-d31c-1a2b-70e4-4f21fea31488@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 05:05:09PM +0800, Yu Kuai wrote:
> 2) run the cmd:
> 
> dmsetup create test1 --table "0 100000 linear /dev/sda 0" &
> sleep 1
> echo 1 > /sys/block/sda/device/delete
> 
> And the follwing uaf is triggered:

Yes, for that we also need to clear the pointer and unregister all
holder in del_gedisk (or even better move this mess to dm :()
