Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530CFC10F05
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C221873
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfCTM6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:58:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:46642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTM6I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 08:58:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18908AC24;
        Wed, 20 Mar 2019 12:58:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B97971E4255; Wed, 20 Mar 2019 13:58:06 +0100 (CET)
Date:   Wed, 20 Mar 2019 13:58:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Revert commit 310ca162d77
Message-ID: <20190320125806.GD9485@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

commit 310ca162d77 "block/loop: Use global lock for ioctl() operation." has
been pushed to multiple stable trees. This patch is a part of larger series
that overhauls the locking inside loopback device upstream and for 4.4,
4.9, and 4.14 stable trees only this patch from the series is applied. Our
testing now has shown [1] that the patch alone makes present deadlocks
inside loopback driver more likely (the openqa test in our infrastructure
didn't hit the deadlock before whereas with the new kernel it hits it
reliably every time). So I would suggest we revert 310ca162d77 from 4.4,
4.9, and 4.14 kernels.

Another option would be to backport other locking fixes for the loop
device but honestly I don't think that's a stable material - never heard
of real users hitting problems, only syzkaller could, and we are still
fixing up some small glitches resulting from that rework...

								Honza

[1] https://bugzilla.suse.com/show_bug.cgi?id=1129739

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
