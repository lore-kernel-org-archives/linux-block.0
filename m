Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAFAC4332F
	for <linux-block@archiver.kernel.org>; Sat, 10 Dec 2022 18:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLJSlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Dec 2022 13:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJSlI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Dec 2022 13:41:08 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD27F01A
        for <linux-block@vger.kernel.org>; Sat, 10 Dec 2022 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X3wRvD3cJCZb5+oWbWuCYenc1B/DLWK+kOZ1ZdNSwFg=; b=A0eyNInTR7SHEuNgzzb4qxV8d6
        O2IhufKTbB+9eUwnhg410kKGxLftOwr1oYHSvwAMiqKB+viP/5ymJWrKSLxOHyfKDrqnUY6dOUGSH
        oFeYnObogmC3QrAZl41tYEwdOw/JcPLV33kmsM9qgaatKDQWzXohVkt/5Y0ubl3ynvB7ZdZlcOAoN
        F1v/NlrO16I62jzKYYDT+tJMp2Fb9ZLubeTvd2MY8U6DEm/JovxdhfE3+PvqcQh+zaUPCj9oOPR2B
        CNBCdrV0Upg9lKQY4INNdm1uC+FDWg8Vjr5bWFCVFpCwhpdbW6sFZPvuqQ0/IPbTE+QcSNARsFELw
        pmVbcstw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p44mS-00ArIN-2t
        for linux-block@vger.kernel.org;
        Sat, 10 Dec 2022 18:41:01 +0000
Date:   Sat, 10 Dec 2022 18:41:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-block@vger.kernel.org
Subject: can queue_virt_boundary() exceed PAGE_SIZE?
Message-ID: <Y5TSvDH3kadijZhT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

	I'd always assumed that to be impossible, but...

drivers/infiniband/ulp/srp/ib_srp.c:add_target_store()
		target_host->virt_boundary_mask = ~srp_dev->mr_page_mask;

and
        /*
         * Use the smallest page size supported by the HCA, down to a
         * minimum of 4096 bytes. We're unlikely to build large sglists
         * out of smaller entries.
         */
        mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
        srp_dev->mr_page_size   = 1 << mr_page_shift;
        srp_dev->mr_page_mask   = ~((u64) srp_dev->mr_page_size - 1);

and it looks like some drivers have ->page_size_cap come from the hardware.

Can it actually end up with ->virt_boundary_mask greater than PAGE_SIZE
and if it does, how could things like bio_copy_user_iov() possibly
work?  page_alloc() won't give us alignment better than PAGE_SIZE,
after all...
