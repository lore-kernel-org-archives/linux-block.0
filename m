Return-Path: <linux-block-owner@vger.kernel.org>
Received: from vostok.pvgoran.name ([71.19.149.48]:35559 "EHLO
        vostok.pvgoran.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeITUrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Sep 2018 16:47:09 -0400
Date: Thu, 20 Sep 2018 21:58:08 +0700
From: Pavel Goran <via-bcache@pvgoran.name>
Reply-To: Pavel Goran <via-bcache@pvgoran.name>
Message-ID: <1481894441.20180920215808@pvgoran.name>
To: Junhui Tang <tang.junhui.linux@gmail.com>
CC: colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] bcache: add a command to show bcache topology
In-Reply-To: <CA+NNRhHpArYXt7YofXcH0h8yhcPvFhWC9ZKnRTcPhXziSPDHPg@mail.gmail.com>
References: <CA+NNRhHpArYXt7YofXcH0h8yhcPvFhWC9ZKnRTcPhXziSPDHPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Junhui,

Thursday, September 20, 2018, 8:26:58 PM, you wrote:

> From 647ac21a0068df1fafb038a628791d2fcc135462 Mon Sep 17 00:00:00 2001
> From: Tang Junhui <tang.junhui.linux@gmail.com>
> Date: Fri, 21 Sep 2018 04:52:20 +0800
> Subject: [PATCH] bcache: add a command to show bcache topology

> This patch add a command to show bcache topology as bellow:
> [root@ceph x86_64]# cat /sys/fs/bcache/show

"show" doesn't look like a good file name here, it's vague and doesn't
convey the meaning. Maybe just use "topology" instead?

> ( sdb ) : ( sdg:bcache4 sdf:bcache3 sde:bcache2 sdd:bcache1 sdc:bcache0 )
> ( sdh ) : ( sdm:bcache9 sdl:bcache8 sdk:bcache7 sdj:bcache6 sdi:bcache5 )
> In the output result, each line shows cache devices in the first () and
> its cached devices in the second (). By this command, we can be easily
> to know cached device bcache4 base on backing device sdg and cache device
> sdb, we also can see bcache0 bcache1 bcache2 bcache3 and bcache4 are in
> the same cache set.

> (patch skipped)

Pavel Goran
  
