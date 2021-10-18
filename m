Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62AEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A9B60F8F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJRO1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJRO1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:27:15 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Oct 2021 07:25:04 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E61C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 07:25:04 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 7AA06E809E1;
        Mon, 18 Oct 2021 16:19:21 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 0C15A160DBD; Mon, 18 Oct 2021 16:19:20 +0200 (CEST)
Date:   Mon, 18 Oct 2021 16:19:20 +0200
From:   Lennart Poettering <lennart@poettering.net>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Martijn Coenen <maco@android.com>
Cc:     linux-block@vger.kernel.org, Luca Boccassi <bluca@debian.org>,
        Karel Zak <kzak@redhat.com>
Subject: Is LO_FLAGS_DIRECT_IO by default a good idea?
Message-ID: <YW2CaJHYbw244l+V@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

eMing, Christoph, Jens!

Ming, 5 years ago or so you added support for dio/aio for the
loopback block device, i.e. LO_FLAGS_DIRECT_IO. As I understood it's
supposed to improve performance of loopback block devices
substantially. I noticed that there's various software that enables it
by default (Android, Docker), but a lot of other candidates currently
do not (util-linux, Ubuntu Snaps, various systemd tools). We recently
got a request to enable it by default in systemd, but information is
scarce on the precise effect of enabling this, and whether there are
any drawbacks.

So my question really is just: is this a flag we should all just
enable by default? Is there any reason not to enable it? Should
util-linux' losetup defaults be changed regarding this?

A brief answer like "yes, please, enable by default" would already
make me happy.

Thank you,

Lennart

--
Lennart Poettering, Berlin
