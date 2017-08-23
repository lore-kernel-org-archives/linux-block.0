Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42979 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdHWW34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 18:29:56 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/2] Two copy_in_user() declaration fixes
Date: Wed, 23 Aug 2017 15:29:09 -0700
Message-Id: <20170823222911.29453-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Al,

When I analyzed the block layer core with sparse I noticed that the declaration
of copy_in_user() and also that of a pointer in compat_hdio_ioctl() are wrong.
Please consider these two patches for kernel v4.14.

Thanks,

Bart.

Bart Van Assche (2):
  <linux/uaccess.h>: Fix copy_in_user() declaration
  compat_hdio_ioctl: Fix a declaration

 block/compat_ioctl.c    | 2 +-
 include/linux/uaccess.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.14.0
