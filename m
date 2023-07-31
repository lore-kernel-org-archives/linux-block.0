Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE923C001DE
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 05:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGaFzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 01:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGaFzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 01:55:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC74E78;
        Sun, 30 Jul 2023 22:55:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3946E68AFE; Mon, 31 Jul 2023 07:55:34 +0200 (CEST)
Date:   Mon, 31 Jul 2023 07:55:33 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: make bvec_try_merge_hw_page() non-static
Message-ID: <20230731055533.GB30066@lst.de>
References: <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1> <CGME20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1> <20230728075704epcms2p1fec48202cbda466411c44437cf788dea@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728075704epcms2p1fec48202cbda466411c44437cf788dea@epcms2p1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
