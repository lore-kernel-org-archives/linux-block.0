Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55423 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753638AbdERHgY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2017 03:36:24 -0400
To: Omar Sandoval <osandov@osandov.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: blktests and /dev/sg syzkaller reproducers
Message-ID: <ed7bae97-5623-2191-f46d-4fc288eda13e@suse.de>
Date: Thu, 18 May 2017 09:36:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Omar,

I was thinking of adding some of the syszcaller reproducers I've
collected, which have been crashing the SCSI generic driver.

This would require blktests to have a build infrastructure (not a big
deal I know).

So my question is, are you comfortable with adding these tests (in a new
group probably) I'll look through my reproducer collection and work on a
patch set.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
