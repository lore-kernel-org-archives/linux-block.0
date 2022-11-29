Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7856C4167B
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 08:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiK2IfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 03:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiK2Ieu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 03:34:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F610DC9;
        Tue, 29 Nov 2022 00:33:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B069368AFE; Tue, 29 Nov 2022 09:33:18 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:33:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] elevator: repalce "len+name" with "name+len" in
 elv_iosched_show
Message-ID: <20221129083318.GC24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <d96b45ef44f240db39d985661ba306eb7bde77d0.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d96b45ef44f240db39d985661ba306eb7bde77d0.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:13PM +0800, Jinlong Chen wrote:
> The "pointer + offset" pattern is more resonable.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
