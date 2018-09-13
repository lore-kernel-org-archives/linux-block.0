Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38850 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMGdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Sep 2018 02:33:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so1818469plq.5
        for <linux-block@vger.kernel.org>; Wed, 12 Sep 2018 18:26:42 -0700 (PDT)
Date: Wed, 12 Sep 2018 18:26:40 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Klaus Kusche <klaus.kusche@computerix.info>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Subsystem responsible for /proc/diskstats timings?
Message-ID: <20180913012640.GB32250@vader>
References: <fdbf1284-a111-f99b-30e4-4d35a35b119c@computerix.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fdbf1284-a111-f99b-30e4-4d35a35b119c@computerix.info>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 09, 2018 at 10:03:35AM +0200, Klaus Kusche wrote:
> 
> Hello,
> 
> Which subsystem could be responsible for
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=200857
> 
> ("4.18 regression: /proc/diskstats: I/O busy time not updated correctly")?
> 
> This is for AHCI SATA disks (/dev/sda, /dev/sdb, ...),
> and the busy time reported by /proc/diskstats for SSD's is still (4.18.6)
> to low by at least a factor of 20 (!).
> 
> Many thanks in advance for your help!

This was probably 522a777566f5 ("block: consolidate struct request
timestamp fields"). Not the proper fix, but can you try the following:

diff --git a/block/blk-core.c b/block/blk-core.c
index 4dbc93f43b38..663430090281 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2738,7 +2738,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		struct hd_struct *part;
 		int cpu;
 
-		duration = nsecs_to_jiffies(now - req->start_time_ns);
+		duration = max(nsecs_to_jiffies(now - req->start_time_ns), 1);
 		cpu = part_stat_lock();
 		part = req->part;
 
