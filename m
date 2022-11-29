Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E392C4332F
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 08:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiK2IgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 03:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiK2Ifc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 03:35:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC819002;
        Tue, 29 Nov 2022 00:34:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67ACB68AFE; Tue, 29 Nov 2022 09:34:09 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:34:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] elevator: use bool instead of int as the return
 type of elv_iosched_allow_bio_merge
Message-ID: <20221129083409.GD24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <1a179a01463c7dbbc1b2be09111ea35617f763a9.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a179a01463c7dbbc1b2be09111ea35617f763a9.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:14PM +0800, Jinlong Chen wrote:
> We have bool type now, update the old signature.

Looks good, especially as the allow_merge method already returns a bool:

Reviewed-by: Christoph Hellwig <hch@lst.de>
