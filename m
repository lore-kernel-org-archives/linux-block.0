Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbdGZX6L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2017 19:58:11 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: hch@infradead.org, jack@suse.cz, linux-raid@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 0/9] Nowait feature for stacked block devices
Date: Wed, 26 Jul 2017 18:57:57 -0500
Message-Id: <20170726235806.12148-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a continuation of the nowait support which was incorporated
a while back. We introduced REQ_NOWAIT which would return immediately
if the call would block at the block layer. Request based-devices
do not wait. However, bio based devices (the ones which exclusively
call make_request_fn) need to be trained to handle REQ_NOWAIT.

This effort covers the devices under MD and DM which would block
for any reason. If there should be more devices or situations
which need to be covered, please let me know.

-- 
Goldwyn
