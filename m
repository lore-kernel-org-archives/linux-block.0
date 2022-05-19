Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 15:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiESPBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbiESPAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 11:00:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB99EBE8D
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:59:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7623D68AFE; Thu, 19 May 2022 16:59:31 +0200 (CEST)
Date:   Thu, 19 May 2022 16:59:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Muneendra <muneendra.kumar@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Message-ID: <20220519145931.GA25382@lst.de>
References: <20220519144555.22197-1-hare@suse.de> <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk> <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de> <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 08:57:53AM -0600, Jens Axboe wrote:
> I'm assuming that commit is from the scsi tree? It's certainly not in
> mine. So your commit message may be correct, but since it was sent to me,
> I was assuming it's breakage from my tree. Which doesn't appear to be the
> case, and I don't see any of the SCSI maintainers on the to/cc.

Yes, all this went in through the scsi tree.
