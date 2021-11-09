Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC7C433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5946108E
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbhKIKuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:50:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41961 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKIKuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 05:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636454845; x=1667990845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bDWMpAmH7auEmTZ8QtXtNAAu1nHGO4qEFzNYKjesy78=;
  b=AMpPk1QNGzqA8IlS6DuUKbJYyABMp/8N0QI8CBmutik0/0XrHcTw5rSP
   3qHe9ZxIbxTln7nkSO2SRz/Oyt+N9mGCRZAgImltvt0aFlgtS+dtKB1S4
   t7a+zbqiXHw0gni9fTC3bOZt4ytr0m418LdzUUyScrYJlti6ghqULto64
   dMxpOV41+VhIoXDwyuMPXKuqYXrlI1yE47cEmR3n+6TDCc0un+yTUyC0S
   4/tMpgoFuPX5PkanN9f5wJr0U5i6shiBazOhkVhEDEGXtxx5tabcwgP7w
   xqjXLvUbPzZ3dH/iRu5TZbb7NYjm7NYjtOtxT82zuZKVvkSyr4aDeH4dh
   A==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631548800"; 
   d="scan'208";a="296901844"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 18:47:25 +0800
IronPort-SDR: mze57m4k4JmXehgcfdvPPtA8SoFdTXyBlSJTquPKzC3LioSMi7a3KabpN3kjvgLPAD300KbVl3
 l/2tjmKkXpshP0PgWiNhKuSPZWJNQnYQjkO7K4/iV0er8CZD45P5+F+0o3QfOi7v8vdjX1/0g5
 An2DrOvPhqZLvRjZ2lRiGgV+dKjhCOcgB6K22vp+CNZp1hF/iQUavBV1oD6++Zt4ruFlalniB4
 VMATqOBBn9SF3aDSYlzeWbXVx5NHVJwuQv1mCtKkVyei4zkBgqMX6cVOamKxoSZx2ZDxNZwP5a
 c8T9ML7/fXYjimS38wOzGnJg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 02:22:37 -0800
IronPort-SDR: /ADF3BrZvErD8ADWd+J/xve5oTsg+MX8jwe8DOEIt79SRFdDzUr/mdZyZ7W961dvz65g5mrUXs
 zj1T/JrxKpqrnfawTEMY3r6PBw6cIGREWo/fp8+kEGCmoATuMK5DrrAHeYuB5Hxo8+Db5aPB9i
 wVpLcaCRZn8HBLXMOnHBH3+qjSFqxC5EULyc6zrKWSWboQVzfuLmczDJSC4n4bgm+WuwEj0YJg
 Js3nbhLkewmh1Dy0u+n8/qVo2lbXQRDJn93AO9J4SWG5vSJy6Q8BzxFF65YBDpVMuuTwU0K97p
 jBk=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Nov 2021 02:47:25 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] block: Fix stale page cache of discard or zero out ioctl
Date:   Tue,  9 Nov 2021 19:47:21 +0900
Message-Id: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cache is
left. This patch series have two fox patches for the stale page cache. Same
fix approach was used as blkdev_fallocate() [1].

[1] https://marc.info/?l=linux-block&m=163236463716836

Shin'ichiro Kawasaki (2):
  block: Hold invalidate_lock in BLKDISCARD ioctl
  block: Hold invalidate_lock in BLKZEROOUT ioctl

 block/ioctl.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.33.1

