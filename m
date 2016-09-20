Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:60680 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbcITMFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 08:05:43 -0400
Message-ID: <1474373138.31504.13.camel@codethink.co.uk>
Subject: [4.4-stable] lightnvm: put bio before return
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wenwei Tao <ww.tao0320@gmail.com>,
        Matias =?ISO-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>, stable@vger.kernel.org
Date: Tue, 20 Sep 2016 13:05:38 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Please cherry-pick:

commit 16c6d048d7b74249a4387700887e8adb13028866
Author: Wenwei Tao <ww.tao0320@gmail.com>
Date:   Thu Feb 4 15:13:23 2016 +0100

    lightnvm: put bio before return

for 4.4-stable only.  (It is included in 4.5 and no earlier stable
branch has lightnvm.)  This is a follow-up to commit 3bfbc6adbc50
"lightnvm: add check after mempool allocation" which you already
cherry-picked in 4.4.21.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.


