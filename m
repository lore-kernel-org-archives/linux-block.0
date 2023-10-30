Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC3C4167B
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 03:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJ3DVc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Oct 2023 23:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3DVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Oct 2023 23:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61406C2
        for <linux-block@vger.kernel.org>; Sun, 29 Oct 2023 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698636047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=P6Jst2cnwGRfUR0jda/O+BDtsFhLRLTlD3CHHxL3Bjw=;
        b=aVcDNIU9pz7BLBHLiR/zkA4arOVp1/HTcF/8+5e8s1hsDD8fwlNBfoA/fdGiH2bJlRS5lG
        SoYjC446VOCfq9Gdju1jMpbnhPoPXdK9/7/MrifuYddvmZYBApanoZBmwmECcUs8PThWIh
        4qjhP4Y+RqhybsGpxV509g1KOErzhMM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-30ikrEmSOBaVQkRnS8qtMg-1; Sun,
 29 Oct 2023 23:20:44 -0400
X-MC-Unique: 30ikrEmSOBaVQkRnS8qtMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1B511C05153;
        Mon, 30 Oct 2023 03:20:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6747C1596D;
        Mon, 30 Oct 2023 03:20:40 +0000 (UTC)
Date:   Mon, 30 Oct 2023 11:20:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, ublk@googlegroups.com
Subject: libublk-rs: v0.2 with async/await support
Message-ID: <ZT8hBFcmmHsw9cDY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

libublk-rs v0.2 is released:

https://crates.io/crates/libublk
https://github.com/ming1/libublk-rs

Changes:

- support async/await for generic async fn(don't depend on runtime) and io_uring.
- unprivileged ublk
- queue idle handle
- almost all features in libublksrv are supported in libublk-rs now
- command line support for examples

Now each io command can be handled in dedicated io task as following,
and it looks like sync programming, but everything is handled in async
style:

         let mut cmd_op = libublk::sys::UBLK_IO_FETCH_REQ;
         let mut result = 0;
         let addr = std::ptr::null_mut();
         loop {
             if q.submit_io_cmd(tag, cmd_op, addr, result).await
                 == libublk::sys::UBLK_IO_RES_ABORT
             {
                 break;
             }

             // io_uring async is preferred
             result = handle_io_cmd(&q, tag).await;
             cmd_op = libublk::sys::UBLK_IO_COMMIT_AND_FETCH_REQ;
         }

Roadmap:
1) write more complicated targets with async/await

- re-write qcow2 with clean async/await implementation in rublk project which
depends on libublk

	https://crates.io/crates/rublk
	https://github.com/ming1/rublk

2) tens of thousands of ublk device support
- switch control command to async/await, and make ublk device in one
  thread with single blocking point

- shared task: one task can create multiple ublk devices

- shared uring: create multiple ublk device with single uring.

3) support tokio async, especially for non-io_uring target io handling


Thanks,
Ming

