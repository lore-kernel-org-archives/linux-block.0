Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:45076 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeB0Rtg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 12:49:36 -0500
Received: by mail-pg0-f44.google.com with SMTP id i133so576526pgc.12
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 09:49:36 -0800 (PST)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com
Subject: [PATCH 0/2] Bcache fixes for 4.16
Date: Tue, 27 Feb 2018 09:49:28 -0800
Message-Id: <20180227174930.15911-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Please pick up these two critical fixes to bcache by Tang Junhui.
They're both one-liners and have been reviewed and tested.

The first corrects a regression when flash-only volumes are present
that was introduced in 4.16-RC1.  The second adjusts bio refcount
and completion behavior to work with md RAID5 backing.

Thanks,

Mike
