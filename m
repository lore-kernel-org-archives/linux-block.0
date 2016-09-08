Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753271AbcIHVM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 17:12:29 -0400
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
Subject: [RESEND][PATCH 0/5] nbd improvements
Date: Thu, 8 Sep 2016 17:12:05 -0400
Message-ID: <1473369130-22986-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Apologies if you are getting this a second time, it appears vger ate my last
submission.

----------------------------------------------------------------------

This is a patch series aimed at bringing NBD into 2016.  The two big components
of this series is converting nbd over to using blkmq and then allowing us to
provide more than one connection for a nbd device.  The NBD user space server
doesn't care about how many connections it has to a particular device, so we can
easily open multiple connections to the server and allow blkmq to handle
multi-plexing over the different connections.  This drastically improves
performance with multi-threaded workloads over NBD.  The multi-connection
support requires some changes to the NBD userspace client code, and you can find
that code here

https://github.com/josefbacik/nbd

I have been testing this for a few months and it is pretty solid and gives
excellent performance improvements.  Thanks,

Josef

