Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082FDC433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 16:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiCDQJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 11:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiCDQJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 11:09:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381E13FAEA
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2y1RfK55FJZaR70vWvm5yGJi5uCNI37x8hx/JJe9EPg=; b=FGA0u+V5VwkwooKhgTUjWGanlq
        cN7SRc3zudSh+crVQlTfu0taOSIfII23QCdQcPBCipFY7BvPkJlMiBsaMknWxD3RQLg6jWQrq1sxL
        F8UPRYGOD3sdFTyoiNK61fl8n99QKXaGjhee5OM/etGJJHm1b2eS+f2T0GPXMESfML1pdumBfdqn2
        lF6HKuzrga0FlAmyuSW3UJEO0jMzstMYkqUFtQtEtd+vuK1pwAz8/CSl0sZLDbYIAdmgZ77h78bzv
        zr+32RxNhrZ+mnvMPZLsXhTZW0algQp3Aq45xUXVIMhhwFHGSNGT5wbkpASMafyhLml99nvVcz6rw
        2yCitCJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAUA-00AvRv-Tw; Fri, 04 Mar 2022 16:08:54 +0000
Date:   Fri, 4 Mar 2022 08:08:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: emit disk ro uevent in device_add_disk()
Message-ID: <YiI5ls2Wuaocacc7@infradead.org>
References: <20220303175219.272938-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303175219.272938-1-ushankar@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 03, 2022 at 10:52:20AM -0700, Uday Shankar wrote:
> Userspace learns of disk ro state via the change event emitted by
> set_disk_ro_uevent. This function has cyclic dependency with
> device_add_disk: the latter performs kobject initialization that is
> necessary for uevents to go through, but we want to set up properties
> like ro state before exposing the disk to userspace via device_add_disk.
> 
> The usual workaround is to call set_disk_ro both before and after
> device_add_disk; the purpose of the "after" call is just to emit the
> uevent. Moreover, because set_disk_ro only emits a uevent when the ro
> state changes, set_disk_ro needs to be called twice in the "after"
> position to ensure that the ro state flips. See drivers/scsi/sd.c for an
> example of this pattern.

I don't see any such pattern there.  I also don't see what the point
is.  KOBJ_CHANGE uevents tell about a change in device state.  But
if a device is marked read-only before disk_add that read-only
state is already visible by the time the device is added and thus
shows up in sysfs, and we do not need an extra notification.
