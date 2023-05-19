Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C4C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 05:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjESFiO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFiN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 01:38:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE887E7F;
        Thu, 18 May 2023 22:38:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D7A7A68AFE; Fri, 19 May 2023 07:38:09 +0200 (CEST)
Date:   Fri, 19 May 2023 07:38:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: remove the special !CONFIG_BLOCK def_blk_fops
Message-ID: <20230519053809.GA11987@lst.de>
References: <20230508144405.41792-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508144405.41792-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, can you pick this one up?

