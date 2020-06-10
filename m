Return-Path: <SRS0=qLys=7X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2AEC433E1
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B6D2072E
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 13:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="E0W97Phx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgFJNWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:22:16 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:20790 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgFJNWQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 09:22:16 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 09:22:15 EDT
IronPort-SDR: SOfhtoo3cpPQCaGkiVCLO+0Xcv1JaC0cxYzO1+Xr/hUPpQHW6xNnOkNnznXfSEq7ylKpH+1SV7
 uObid5vBytdKiWX/Q3SPDPaQazWqjcedy/dE10EaQAO3n8tt+lGsKxmKiLTCQs+1LMC0oGgj7k
 MMp+qTugf/Ct28bdM2uMduwiHeHTF9pPjTgi85Mu21/f43YJAyH7m7HN4hsr0JKvzohbyfyoL6
 7gpHVdCghawn6yXWUK7nIEI2ppfA2jsOQoSYEBB5+Vq//QpSJFgV4pXN0C6qPG4iIUImSQOPPR
 vNE=
X-IronPort-AV: E=Sophos;i="5.73,496,1583190000"; 
   d="scan'208";a="12638479"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Jun 2020 15:15:04 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 Jun 2020 15:15:04 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 Jun 2020 15:15:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591794904; x=1623330904;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=TGTIzXlZhILMwfzfkA0Ocp9bCG1jW+m/WMFkKoJLGXU=;
  b=E0W97PhxpNq3lCE9RokfYjozbtzQsZDXaz+u0CawBHiyaLjqiCcVW397
   KxtDlc1VTWewjYKpnGMBlvXNX7hjedtIqgrTHhP3SDQxZA/n4YG9vxucf
   K6MNlPditsRGe0xj9NOO8mNs69fh8OJPBimK/vMe4DicW9CjpBDTZp28F
   1Ye3oE6BVdckmEuanchYadA/qNwQobn3p/IpMaOGiVkt7HqxPIbG1kLWJ
   kQO9iNw1atGGtZHSbK2w35OqQBQ5UhimKNRBHoKYiZ1A2W8WuLUNnrInW
   t5Um83HktLc72/6QUdEmCFN81yO4I59VqpnLVm2wdvq3tIFEswaCLsr4l
   g==;
IronPort-SDR: H2jn5AkN840HjfNLY7chLDDFaHSLNEvxTuoZAQ2lc1MRLVISi0Y6+z5L8mlg0yysVPF4aQb8nN
 i7ifUzS0OIrAZpbXg5rUf0tJ6+oqYKDNMeFFW3kvZuYdyNtwhc2YLStxIxuA58BDur7iRhNHlT
 8LPJzR0kuRNsMjyDHVe/QfynVklGu+FuQlC860YG7Xv7JTvnMVe8mSFFvA8j64eBk7qQe/yp2J
 j0Ki0ljZaxtF+ViQbCDL5e2HeswK3BYr2jqQQIoFExNZQumqE2N6dv+Yme1fy3gmFvsyhXNsLE
 9Ps=
X-IronPort-AV: E=Sophos;i="5.73,496,1583190000"; 
   d="scan'208";a="12638478"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jun 2020 15:15:04 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A04A4280065;
        Wed, 10 Jun 2020 15:15:04 +0200 (CEST)
Message-ID: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
Subject: Consistent block device references for root= cmdline
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, s.hauer@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 15:15:03 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello all,

there have been numerous attempts to make the numbering of mmcblk
devices consistent, mostly by using aliases from the DTS ([1], [2],
[3]), but all have been (rightfully) rejected. Unless I have overlooked
a more recent development, no attempts for a different solution were
made.

As far as I can tell, the core of the issue seems to be the following:

The existing solutions like LABELs and UUIDs are viable alternatives in
many cases, but in particular on embedded systems, this is not quite
sufficient: In addition to the problem that more knowledge about the
system to boot is required in the bootloader, this approach fails
completely when the same firmware image exists on multiple devices, for
example on an eMMC and an SD card - not an entirely uncommon situation
during the development of embedded systems.

With udev, I can refer to a specific partition using a path like
/dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was proposed
to add a way to refer to a device path/phandle from the kernel command
line. Has there been any progress on this proposal?

Kind regards,
Matthias


[1] https://patchwork.kernel.org/patch/8685711/
[2] https://lore.kernel.org/patchwork/cover/674381/
[3] https://www.spinics.net/lists/linux-mmc/msg26586.html
[4] https://www.spinics.net/lists/linux-mmc/msg26708.html

