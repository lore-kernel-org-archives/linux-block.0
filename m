Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B9C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 02:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjDSCcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 22:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDSCcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 22:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CB3A92
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681871513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0QDdmk1E8mI7VEapW+tMKz9aT+HTtwH6PGH+nSPsAs=;
        b=RHsO9buXUOv0pjz2sugu+bCdulSMYEuG7iOAR+gGNI51U8VouXw2l97dqv9n7oRYU75Vav
        ABDEauSyq+XzgyQJYWLBskkfQHdsfuBGoLwWZxVPWF82DG2rOp65emOElSQ5Gu5Ri58XCg
        WqnIBaP/nzfpG2YvtxZn2qaHvNZmwss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-xYA4jZLyMVO0Uw4Kp2BOrw-1; Tue, 18 Apr 2023 22:31:49 -0400
X-MC-Unique: xYA4jZLyMVO0Uw4Kp2BOrw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61F9F101A531;
        Wed, 19 Apr 2023 02:31:49 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EFEA492C3E;
        Wed, 19 Apr 2023 02:31:45 +0000 (UTC)
Date:   Wed, 19 Apr 2023 10:31:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Harris, James R" <james.r.harris@intel.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        ming.lei@redhat.com, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: Question about ublk and NEED_GET_DATA
Message-ID: <ZD9SjEd7D2AXQypp@ovpn-8-18.pek2.redhat.com>
References: <0D50EEFA-BCFE-4D5F-8653-99656A8C49F8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D50EEFA-BCFE-4D5F-8653-99656A8C49F8@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 19, 2023 at 12:03:40AM +0000, Harris, James R wrote:
> Hi,
> 
> I’m working on adding NEED_GET_DATA support to the SPDK ublk server, to avoid allocating I/O buffers until they are actually needed.
> 
> It is very clear how this works for write commands with NEED_GET_DATA.  We wait to allocate the buffer until we get UBLK_IO_RES_NEED_GET_DATA completion and submit again using UBLK_IO_NEED_GET_DATA.  After we get the UBLK_IO_RES_OK completion from ublk, we submit the block request to the SPDK bdev layer.  After it completes, we submit using UBLK_IO_COMMIT_AND_FETCH_REQ and can free the I/O buffer because the data has been committed.
> 
> But how does this work for the read path?  On a read, I can wait to allocate the buffer until I get the UBLK_IO_RES_OK completion.  But after the read operation is completed and SPDK submits the UBLK_IO_COMMIT_AND_FETCH_REQ, how do I know when ublk has finished copying data out of the buffer so that I can reuse that buffer?
> 
> I’m sure I’m missing something obvious, if anyone can provide a pointer I would appreciate it.

Yeah, it is one known issue.

But the buffer is guaranteed to be ready for reuse after io_uring_enter()
returns.

Also the patch[1] exposes read/write interface to /dev/ublkcN,
then NEED_GET_DATA becomes not necessary any more. The initial
motivation is for zero-copy, but it can be used for non-zc too, such as
don't do any copy in driver side, and simply let userspace cover
everything:

1) ublk server gets one io command, allocate buffer and handle this
command

2) if it is WRITE command, read buffer data via read() from
/dev/ublkcN, then handle the write by this buffer 

3) if it is READ command, handle the read using the allocated buffer,
and after the data is ready in this buffer, write data in buffer to
/dev/ublkcN.

This approach could be cleaner for both sides, but add one extra cost
of read/write /dev/ublkcN in userspace, and it can be done via io_uring
too.

What do you think of this approach?

[1] https://lore.kernel.org/linux-block/20230330113630.1388860-16-ming.lei@redhat.com/


Thanks,
Ming

