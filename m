Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3BDC7EE21
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjECP5u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjECP5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:57:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3BF4EEB;
        Wed,  3 May 2023 08:57:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44F2368AA6; Wed,  3 May 2023 17:57:45 +0200 (CEST)
Date:   Wed, 3 May 2023 17:57:45 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
Message-ID: <20230503155745.GD31700@lst.de>
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4> <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p6> <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 07:10:48PM +0900, Jinyoung CHOI wrote:
> When a request is initialized through the bio, bio's integrity
> information is not reflected in the request.

Uuh.  This looks like a pretty grave bug unless I'm missing something.
Can you:

 - submit this as a fix for 6.3 and -stable?
 - maybe find what broke this and add a fixes tag?
