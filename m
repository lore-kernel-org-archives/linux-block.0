Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80697C2D0BF
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C6624655
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 15:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfLQPgx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:36:53 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:51120 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727695AbfLQPgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:53 -0500
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 10:36:52 EST
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihEdz-0003vi-6E; Tue, 17 Dec 2019 15:20:15 +0000
Message-ID: <f0e7384f3eb6203eb72b36433b0666150cf560ff.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 10/24] compat_ioctl: cdrom: handle
 CDROM_LAST_WRITTEN
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>,
        Hannes Reinecke <hare@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Martin Wilck <mwilck@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Tue, 17 Dec 2019 15:20:14 +0000
In-Reply-To: <20191211204306.1207817-11-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
         <20191211204306.1207817-11-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-12-11 at 21:42 +0100, Arnd Bergmann wrote:
> This is the only ioctl command that does not have a proper
> compat handler. Making the normal implementation do the
> right thing is actually very simply, so just do that by
> using an in_compat_syscall() check to avoid the special
> case in the pkcdvd driver.
[...]

Since this uses blkdev_compat_ptr_ioctl() it needs to be moved after
the following patch.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

