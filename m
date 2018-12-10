Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09022C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 04:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E96A20821
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 04:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="yfkQrGaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E96A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeLJEyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:54:23 -0500
Received: from imap.thunk.org ([74.207.234.97]:40936 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeLJEyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Dec 2018 23:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ifP5JV1vKQfvCzNNNUJlkosNk73xaPx5dyhR9Bpo/Ck=; b=yfkQrGaE7embIjlvgLzs/qU+aq
        Fgh0P3tsYB0pdSCRev+FLjXgvqMyQlJPlTrmqGNeLBLZAGpQt+CZHhdo5GCDPcLRPb/bxEV+UeujE
        scWcs4oaq8QZkAs20jY1TXW0SMeqxu1KX1C4HStgFFsPZO4E1L7lFX2D8ysHKoInWmaw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gWDaG-0003ni-LR; Mon, 10 Dec 2018 04:54:20 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AC34F7A4A89; Sun,  9 Dec 2018 23:54:19 -0500 (EST)
Date:   Sun, 9 Dec 2018 23:54:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: blktests: trying to debug nvme test failures
Message-ID: <20181210045419.GF1840@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I've been trying to run blktsts in an automated environment, and I've
been trying to figure out which failures are test bugs, environment
bugs, and which are kernel bugs.

In the NVME tests, there are a number of failures that are caused by
the missing line:

    -NQN:blktests-shubsystem-1 disconnected 1 controller(s)

I'm not sure what that means, or how to fix the problem.  Could
someone give me a hint?

Many thanks!!

					- Ted

FSTESTVER: blktests	69a95c6 (Fri, 7 Dec 2018 10:13:57 -0800)
FSTESTVER: fio		fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
FSTESTVER: fsverity	bdebc45 (Wed, 5 Sep 2018 21:32:22 -0700)
FSTESTVER: ima-evm-utils	0267fa1 (Mon, 3 Dec 2018 06:11:35 -0500)
FSTESTVER: nvme-cli	v0.2-918-ge145ab4 (Fri, 7 Dec 2018 15:15:48 -0700)
FSTESTVER: quota		59b280e (Mon, 5 Feb 2018 16:48:22 +0100)
FSTESTVER: stress-ng	977ae357 (Wed, 6 Sep 2017 23:45:03 -0400)
FSTESTVER: syzkaller	4b6d14f2 (Tue, 27 Nov 2018 13:16:46 +0100)
FSTESTVER: xfsprogs	v4.19.0 (Fri, 9 Nov 2018 14:31:04 -0600)
FSTESTVER: xfstests-bld	461a0aa (Sun, 9 Dec 2018 23:39:23 -0500)
FSTESTVER: xfstests	linux-v3.8-2246-g12eec16d (Sun, 9 Dec 2018 23:15:23 -0500)
FSTESTSET: "nvme"
FSTESTEXC: ""
FSTESTOPT: "blktests aex"
CPUS: "2"
MEM: "1979.4"
              total        used        free      shared  buff/cache   available
Mem:           1979          46        1828           8         104        1891
Swap:             0           0           0
BEGIN BLKTESTS Sun Dec  9 23:47:00 EST 2018
nvme/*** => vdb                                              [not run]
    /dev/vdb is not a NVMe device
nvme/002 (create many subsystems and test discovery)        
    runtime  29.493s  ...
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  29.493s  ...  28.269s
nvme/003 (test if we're sending keep-alives to a discovery controller)
    runtime  10.227s  ...
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.227s  ...  10.246s
nvme/004 (test nvme and nvmet UUID NS descriptors)          
    runtime  0.347s  ...
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  0.347s  ...  0.316s
nvme/005 (reset local loopback target)                       [not run]
    nvme-core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns)
    runtime  0.292s  ...
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.292s  ...  0.258s
nvme/007 (create an NVMeOF target with a file-backed ns)    
    runtime  0.202s  ...
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.202s  ...  0.151s
nvme/008 (create an NVMeOF host with a block device-backed ns)
    runtime  0.423s  ...
nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
    runtime  0.423s  ...  0.386s
    --- tests/nvme/008.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/008.out.bad	2018-12-09 23:47:40.514592807 -0500
    @@ -1,5 +1,4 @@
     Running nvme/008
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/009 (create an NVMeOF host with a file-backed ns)      
    runtime  0.320s  ...
nvme/009 (create an NVMeOF host with a file-backed ns)       [failed]
    runtime  0.320s  ...  0.311s
    --- tests/nvme/009.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/009.out.bad	2018-12-09 23:47:40.947926140 -0500
    @@ -1,5 +1,4 @@
     Running nvme/009
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/010 (run data verification fio job on NVMeOF block device-backed ns)
    runtime  27.516s  ...
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [failed]
    runtime  27.516s  ...  27.912s
    --- tests/nvme/010.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/010.out.bad	2018-12-09 23:48:08.994592800 -0500
    @@ -1,5 +1,4 @@
     Running nvme/010
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/011 (run data verification fio job on NVMeOF file-backed ns)
    runtime  21.947s  ...
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [failed]
    runtime  21.947s  ...  23.609s
    --- tests/nvme/011.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/011.out.bad	2018-12-09 23:48:32.724592785 -0500
    @@ -1,5 +1,4 @@
     Running nvme/011
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns)
    runtime  58.246s  ...
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [failed]
    runtime  58.246s  ...  51.121s
    --- tests/nvme/012.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/012.out.bad	2018-12-09 23:49:23.934592771 -0500
    @@ -1,5 +1,4 @@
     Running nvme/012
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns)
    runtime  13.267s  ...
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [failed]
    runtime  13.267s  ...  13.653s
    --- tests/nvme/013.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/013.out.bad	2018-12-09 23:49:37.694592754 -0500
    @@ -1,5 +1,4 @@
     Running nvme/013
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/014 (flush a NVMeOF block device-backed ns)            
    runtime  5.472s  ...
nvme/014 (flush a NVMeOF block device-backed ns)             [failed]
    runtime  5.472s  ...  6.397s
    --- tests/nvme/014.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/014.out.bad	2018-12-09 23:49:44.164592749 -0500
    @@ -2,5 +2,4 @@
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     NVMe Flush: success
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/015 (unit test for NVMe flush for file backed ns)      
    runtime  4.390s  ...
nvme/015 (unit test for NVMe flush for file backed ns)       [failed]
    runtime  4.390s  ...  4.524s
    --- tests/nvme/015.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/015.out.bad	2018-12-09 23:49:48.744592747 -0500
    @@ -2,5 +2,4 @@
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     NVMe Flush: success
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery)
    runtime  22.275s  ...
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [failed]
    runtime  22.275s  ...  20.610s
    --- tests/nvme/016.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/016.out.bad	2018-12-09 23:50:09.434592742 -0500
    @@ -1,6 +1,6 @@
     Running nvme/016
     
    -Discovery Log Number of Records 1, Generation counter 1
    +Discovery Log Number of Records 1, Generation counter 3
     =====Discovery Log Entry 0======
     trtype:  loop
     adrfam:  pci
nvme/017 (create/delete many file-ns and test discovery)    
    runtime  22.004s  ...
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  22.004s  ...  21.729s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns)
    runtime  0.378s  ...
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [failed]
    runtime  0.378s  ...  0.323s
    --- tests/nvme/019.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/019.out.bad	2018-12-09 23:50:31.664592737 -0500
    @@ -2,5 +2,4 @@
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     NVMe DSM: success
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns)
    runtime  0.306s  ...
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [failed]
    runtime  0.306s  ...  0.254s
    --- tests/nvme/020.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/020.out.bad	2018-12-09 23:50:31.951259403 -0500
    @@ -2,5 +2,4 @@
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     NVMe DSM: success
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/021 (test NVMe list command on NVMeOF file-backed ns)  
    runtime  0.298s  ...
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [failed]
    runtime  0.298s  ...  0.255s
    --- tests/nvme/021.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/021.out.bad	2018-12-09 23:50:32.241259401 -0500
    @@ -1,5 +1,4 @@
     Running nvme/021
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/022 (test NVMe reset command on NVMeOF file-backed ns) 
    runtime  0.414s  ...
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [failed]
    runtime  0.414s  ...  0.366s
    --- tests/nvme/022.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/022.out.bad	2018-12-09 23:50:32.647926067 -0500
    @@ -1,5 +1,4 @@
     Running nvme/022
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns)
    runtime  0.359s  ...
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [failed]
    runtime  0.359s  ...  0.338s
    --- tests/nvme/023.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/023.out.bad	2018-12-09 23:50:33.017926067 -0500
    @@ -1,5 +1,4 @@
     Running nvme/023
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns)
    runtime  0.308s  ...
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [failed]
    runtime  0.308s  ...  0.269s
    --- tests/nvme/024.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/024.out.bad	2018-12-09 23:50:33.351259401 -0500
    @@ -1,5 +1,4 @@
     Running nvme/024
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns)
    runtime  0.302s  ...
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [failed]
    runtime  0.302s  ...  0.294s
    --- tests/nvme/025.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/025.out.bad	2018-12-09 23:50:33.724592735 -0500
    @@ -1,5 +1,4 @@
     Running nvme/025
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    -Test complete
    +Test Failed
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns)
    runtime  0.291s  ...
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [failed]
    runtime  0.291s  ...  0.264s
    --- tests/nvme/026.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/026.out.bad	2018-12-09 23:50:34.077926069 -0500
    @@ -1,5 +1,4 @@
     Running nvme/026
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    -Test complete
    +Test Failed
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns)
    runtime  0.288s  ...
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [failed]
    runtime  0.288s  ...  0.293s
    --- tests/nvme/027.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/027.out.bad	2018-12-09 23:50:34.417926069 -0500
    @@ -1,5 +1,4 @@
     Running nvme/027
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    -Test complete
    +Test Failed
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns)
    runtime  0.297s  ...
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [failed]
    runtime  0.297s  ...  0.284s
    --- tests/nvme/028.out	2018-12-09 23:39:23.000000000 -0500
    +++ /results/nodev/nvme/028.out.bad	2018-12-09 23:50:34.744592735 -0500
    @@ -1,5 +1,5 @@
     Running nvme/028
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    -Test complete
    +The '<device>' may be either an NVMe character device (ex: /dev/nvme0) or an
    +nvme block device (ex: /dev/nvme0n1).Test Failed
              total        used        free      shared  buff/cache   available
Mem:           1979          55        1787           8         136        1882
Swap:             0           0           0
END BLKTESTS Sun Dec  9 23:50:34 EST 2018
