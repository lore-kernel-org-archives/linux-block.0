Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail3.protonmail.ch ([185.70.40.25]:64093 "EHLO
        mail3.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBDJXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Feb 2018 04:23:53 -0500
Date: Sun, 04 Feb 2018 04:23:48 -0500
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jordan Glover <Golden_Miller83@protonmail.ch>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Unsafe shutdowns on TOSHIBA THNSF5256GPUK NVME
Message-ID: <3R4XYOaCHnSEOR172rNrH05ByS93wcnaAw2I0qnOCiqYxvNeOSSUhxvNkMGPPJNlLp1ay00lYLoCzbMfu06gYltNIn_j93dg2Os3rq1XGr8=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I have problem with "unsafe shutdowns" on Lenovo laptop with TOSHIBA
THNSF5256GPUK NVME disk. It happens every time I power-off my machine and I=
 can
hear characteristic "click" sound like with rotational disks. (maybe that's
something else but I'm basing on info from S.M.A.R.T data not this).

I looked around and saw that people report similar problems in different NV=
ME
disks[1][2], even across different OSes[3][4]. I also found some old patche=
s
witch tried to deal with this[5].

I know that my disk was already put on $hitlist due to power saving issues[=
6].

I tested this with linux kernels 4.14.x - 4.15. My BIOS and disk firmware a=
re
updated.

Is there anything I could do to resolve this issue? Thx for any help.

Jordan

[1] https://bbs.archlinux.org/viewtopic.php?id=3D230723
[2] https://bugs.alpinelinux.org/issues/5082
[3]https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D211852
[4] https://www.win-raid.com/t2041f38-SAMSUNG-PRO-NVMe-SSD-unsafe-shutdowns=
-NVMe-driver-W-x-unexpected-shutdown.html
[5] http://lists.infradead.org/pipermail/linux-nvme/2014-March/000744.html
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/nvme/host/core.c#n1950
