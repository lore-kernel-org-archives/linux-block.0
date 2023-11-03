Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC876C4332F
	for <linux-block@archiver.kernel.org>; Fri,  3 Nov 2023 08:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjKCIPo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Nov 2023 04:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjKCIPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2023 04:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67694112;
        Fri,  3 Nov 2023 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nc5z+fIoiWRGbEoDiN5kVtNuvPICZUxfahsCp834BCE=; b=spe+jzZxRfB+62sO4nxQ7USAMJ
        KB3DzJHdXAqWy0Bqmlc10+CfnEqeb5o4VoFldf6wjTXKFQEas6t0+lM1EN+JdM/lPR6YmyN3J2Xvw
        YzMqIXLn7bODzLtd6179CZtAu1NZxGugvde5j6oUbCE35B0iyaLE6eOtySF7vg62m1xA1XKddUBFO
        I4sR+AprZH89LFNNtDjnd4Rv6HqPNShyL8vy7FMXwBX2tggzjMZanz58uK+qkGrnJ76lwOp8L+Hgm
        NQPQS4GGSpOBlu2oC8GA4FF30J0ujRlZxQSA5ZvB/174tj3k7BQ/vHZ7elTMnlg3LXNLi855HZSB8
        oYVKlt3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qypL3-00AxfM-33;
        Fri, 03 Nov 2023 08:15:33 +0000
Date:   Fri, 3 Nov 2023 01:15:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Will Shiu =?utf-8?B?KOioseaBreeRnCk=?= <Will.Shiu@mediatek.com>,
        Peter Wang =?utf-8?B?KOeOi+S/oeWPiyk=?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Chao =?utf-8?B?KOi2meePruWdhyk=?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= 
        <Chun-hung.Wu@mediatek.com>,
        Powen Kao =?utf-8?B?KOmrmOS8r+aWhyk=?= <Powen.Kao@mediatek.com>,
        Naomi Chu =?utf-8?B?KOacseipoOeUsCk=?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu =?utf-8?B?KOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Message-ID: <ZUSsJbcSPSR52J2l@infradead.org>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

You need to look into the splitting code to see why the splits are
suboptimal for your device.  We can't limit the upper bio size as
we have code relying on it not having arbitrary limits.

