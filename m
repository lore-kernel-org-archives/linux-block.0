Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95277C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 19:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJGTgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJGTgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 15:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C52C0696
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 12:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6096061D0C
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 19:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFFDC433C1;
        Fri,  7 Oct 2022 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665171376;
        bh=sYsTdSPBRRr+rla4T87usDKNrxBA341Lc9WAAaR1tiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GD68/G1bxFO49B2maJ1yUXFPAaDfCFl2uVF+XmsuoNsMEvoyCTFytqpEDM1e2Tbwz
         z0vikgBJps71snyxyv9YK8zNweccrwpSy8eVvHFUF4+OX4eESHEfEEVpX7W38pBV6i
         Pzr5hsOtzex+LBDjb4OGeC0isarju9DyV20/aNf0IBQu7+M4eUI7xzEKiNQM3zy02W
         KrCXXeQRWvL9VE7sOsM6zx7H88RnCJe05BLdAJvURLIOSvkoeaf0MAqwYqDVm+fw2w
         wUwrOmM2gIbQG4Halw1yUnjT4IDfNGJr2Az8e/KLAZcjmEQPOwDV+3mJhYnxS4bw7h
         +3SJcQ1OC1Dcw==
Date:   Fri, 7 Oct 2022 13:36:13 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] block: fix leaking minors of hidden disks
Message-ID: <Y0B/rX00Rl8FKSp2@kbusch-mbp.dhcp.thefacebook.com>
References: <20221007193234.3958465-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007193234.3958465-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 07, 2022 at 12:32:34PM -0700, Keith Busch wrote:
> +	if (disk->major == BLOCK_EXT_MAJOR)
> +		blk_free_ext_minor(disk->first_minor);
>  	iput(disk->part0->bd_inode);	/* frees the disk */
>  }

Oops, the above is missing the check for the hidden flag. V2 coming.
