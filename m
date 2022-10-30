Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA43C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ3Hkl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ3HkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:40:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC12DE;
        Sun, 30 Oct 2022 00:40:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00C9268AFE; Sun, 30 Oct 2022 08:40:10 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:40:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 3/3] block: hide back blk_freeze_queue_start
 and export its blk-mq alias
Message-ID: <20221030074010.GD4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 30, 2022 at 01:26:46PM +0800, Jinlong Chen wrote:
> blk_freeze_queue_start is used internally for universal queue draining and
> externally for blk-mq specific queue freezing. Keep the non-blk-mq name
> private and export a blk-mq alias to users.

I really don't see the point here.  Eventually all of the freezing
should move out of the mq namespace.  But that given that we have
actual technical work pending here I'd suggest to just leave it alone
for now, and just respin a version of patch 1 without the pointless
comment.
