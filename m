Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:48674 "EHLO
        mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754977AbdEKM5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2017 08:57:33 -0400
Date: Thu, 11 May 2017 14:57:24 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>
Subject: Kyber scheduler brings system to halt when used on swap partition
Message-ID: <20170511125724.GA302@x4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Using the new Kyber mq scheduler brings my system to a halt as soon as it
starts swapping. The swap partition resides on an SSD and is the only
partition in use on that drive.
Symptoms are stuttering sound and non moving mouse pointer. After a
while the monitor switches off, because it gets no signal anymore.
At which point only a hard reset will bring the system back.

"none" works fine.

-- 
Markus
