Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F3FC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 03:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKBDLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 23:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiKBDLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 23:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAE23BE1
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 20:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 724F961799
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 03:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E88C433C1;
        Wed,  2 Nov 2022 03:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667358676;
        bh=HoBCmdH2JyJ9OFeROhfm/rc1VGnWZyeDz+ImLloggQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Q1n8uOCOSn8oanOriuGLGrlAPM2Ya8VlQLK4LMu+PFybx44K11Y8xq0OgEJ+R3SN/
         wQt+vQGgKLhZjm6dx0XWRGsMhYRgsWDFtHFocghCzu3xwjnWNCh6UZH/jtcR7/PXCz
         7d6ZBWDNfmTKnnXtDOBzEHZP4CUf3ztInUE+qRDqwMPE+vCApAi+m4+p2UzhHb3mI2
         8YIRPzHfDnl6OQOgHxzthO0XojfDglcrJa9vlnvrx7/nEhj27/V5yhr1HbL8jp9wkj
         isA/xeaRbIUkaRqaXKs9n7leoKz/Ab50SYmIE1gTFx/bT/w8cwxd0Vjp5VKlBN6Bxh
         61wkAnUHBhicQ==
Date:   Tue, 1 Nov 2022 20:11:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>
Subject: Regression: wrong DIO alignment check with dm-crypt
Message-ID: <Y2Hf08vIKBkl5tu0@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I happened to notice the following QEMU bug report:

https://gitlab.com/qemu-project/qemu/-/issues/1290

I believe it's a regression from the following kernel commit:

    commit b1a000d3b8ec582da64bb644be633e5a0beffcbf
    Author: Keith Busch <kbusch@kernel.org>
    Date:   Fri Jun 10 12:58:29 2022 -0700

        block: relax direct io memory alignment

The bug is that if a dm-crypt device is set up with a crypto sector size (and
thus also a logical_block_size) of 4096, then the block layer now lets through
direct I/O requests to dm-crypt when the user buffer has only 512-byte
alignment, instead of the 4096-bytes expected by dm-crypt in that case.  This is
because the dma_alignment of the device-mapper device is only 511 bytes.

This has two effects in this case:

    - The error code for DIO with a misaligned buffer is now EIO, instead of
      EINVAL as expected and documented.  This is because the I/O reaches
      dm-crypt instead of being rejected by the block layer.

    - STATX_DIOALIGN reports 512 bytes for stx_dio_mem_align, instead of the
      correct value of 4096.  (Technically not a regression since STATX_DIOALIGN
      is new in v6.1, but still a bug.)

Any thoughts on what the correct fix is here?  Maybe the device-mapper layer
needs to set dma_alignment correctly?  Or maybe the block layer needs to set it
to 'logical_block_size - 1' by default?

- Eric
