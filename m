Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32874 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeI1Fra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Sep 2018 01:47:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so3045051pge.0
        for <linux-block@vger.kernel.org>; Thu, 27 Sep 2018 16:26:44 -0700 (PDT)
Message-ID: <1538090802.226558.17.camel@acm.org>
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
From: Bart Van Assche <bvanassche@acm.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date: Thu, 27 Sep 2018 16:26:42 -0700
In-Reply-To: <20180919001815.GF479@vader>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
         <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
         <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
         <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
         <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
         <20180824002133.GA14674@vader>
         <66df74ec-43d3-c7c4-73d0-16e008b23695@acm.org> <20180918232429.GB479@vader>
         <e73f116a-f665-7222-1c3e-63ef1c031687@acm.org> <20180919001815.GF479@vader>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-09-18 at 17:18 -0700, Omar Sandoval wrote:
+AD4 On Tue, Sep 18, 2018 at 05:02:47PM -0700, Bart Van Assche wrote:
+AD4 +AD4 On 9/18/18 4:24 PM, Omar Sandoval wrote:
+AD4 +AD4 +AD4 On Tue, Sep 18, 2018 at 02:20:59PM -0700, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 Can you have a look at the updated master branch of
+AD4 +AD4 +AD4 +AD4 https://github.com/bvanassche/blktests? That code should no longer fail if
+AD4 +AD4 +AD4 +AD4 unloading the nvme kernel module fails. Please note that you will need
+AD4 +AD4 +AD4 +AD4 kernel v4.18 to test these scripts - a KASAN complaint appears if I run
+AD4 +AD4 +AD4 +AD4 these tests against kernel v4.19-rc4.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Thanks, these pass now. Is it expected that my nvme device gets a
+AD4 +AD4 +AD4 multipath device configured after running these tests?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +ACQ lsblk
+AD4 +AD4 +AD4 NAME     MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
+AD4 +AD4 +AD4 vda      254:0    0  16G  0 disk
+AD4 +AD4 +AD4 +JRQlAA-vda1   254:1    0  16G  0 part  /
+AD4 +AD4 +AD4 vdb      254:16   0   8G  0 disk
+AD4 +AD4 +AD4 vdc      254:32   0   8G  0 disk
+AD4 +AD4 +AD4 vdd      254:48   0   8G  0 disk
+AD4 +AD4 +AD4 nvme0n1  259:0    0   8G  0 disk
+AD4 +AD4 +AD4 +JRQlAA-mpatha 253:0    0   8G  0 mpath
+AD4 +AD4 
+AD4 +AD4 No, all multipath devices that were created during a test should be removed
+AD4 +AD4 before that test finishes. I will look into this.
+AD4 +AD4 
+AD4 +AD4 +AD4 Also, can you please fix:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 	+AF8-have+AF8-kernel+AF8-option NVME+AF8-MULTIPATH +ACYAJg exit 1
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 to not exit on failure? It should use SKIP+AF8-REASON and return 1. You
+AD4 +AD4 +AD4 might need to add something like +AF8-dont+AF8-have+AF8-kernel+AF8-option to properly
+AD4 +AD4 +AD4 handle the case where the config is not found.
+AD4 +AD4 
+AD4 +AD4 OK, I will change this.
+AD4 +AD4 
+AD4 +AD4 +AD4 Side note which isn't a blocker for merging is that there's a lot of
+AD4 +AD4 +AD4 duplicated code between these helpers and the srp helpers. How hard
+AD4 +AD4 +AD4 would it be to refactor that?
+AD4 +AD4 
+AD4 +AD4 Are you perhaps referring to the code that is shared between the
+AD4 +AD4 tests/srp/rc tests/nvmeof-mp/rc shell scripts?
+AD4 
+AD4 Yes, those.
+AD4 
+AD4 +AD4 The hardest part is probably
+AD4 +AD4 to chose a location where to store these functions. Should I create a file
+AD4 +AD4 with common code under common/, under tests/srp/, under tests/nvmeof-mp/ or
+AD4 +AD4 perhaps somewhere else?
+AD4 
+AD4 Just put it under common.

Hi Omar,

All feedback mentioned above has been addressed. The following pull request has
been updated: https://github.com/osandov/blktests/pull/33. Please let me know
if you want me to post these patches on the linux-block mailing list.

Note: neither the upstream kernel v4.18 nor v4.19-rc4 are stable enough to pass
all nvmeof-mp tests if kernel debugging options like KASAN are enabled.
Additionally, the NVMe device+AF8-add+AF8-disk() race condition often causes multipathd
to refuse to consider /dev/nvme... devices. The output on my test setup is as
follows (all tests pass):

+ACM ./check -q nvmeof-mp
nvmeof-mp/001 (Log in and log out)                           +AFs-passed+AF0
    runtime  1.528s  ...  1.909s
nvmeof-mp/002 (File I/O on top of multipath concurrently with logout and login (mq)) +AFs
passed+AF0-time  38.968s  ...
    runtime  38.968s  ...  38.571s
nvmeof-mp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-
nvmeof-mp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-
mq)) +AFs-passed+AF0-38.632s  ...
    runtime  38.632s  ...  37.529s
nvmeof-mp/005 (Direct I/O with large transfer sizes and bs+AD0-4M) +AFs-passed+AF0
    runtime  13.382s  ...  13.684s
nvmeof-mp/006 (Direct I/O with large transfer sizes and bs+AD0-8M) +AFs-passed+AF0
    runtime  13.511s  ...  13.480s
nvmeof-mp/009 (Buffered I/O with large transfer sizes and bs+AD0-4M) +AFs-passed+AF0
    runtime  13.665s  ...  13.763s
nvmeof-mp/010 (Buffered I/O with large transfer sizes and bs+AD0-8M) +AFs-passed+AF0
    runtime  13.442s  ...  13.900s
nvmeof-mp/011 (Block I/O on top of multipath concurrently with logout and login) +AFs-pass
ed+AF0 runtime  37.988s  ...
    runtime  37.988s  ...  37.945s
nvmeof-mp/012 (dm-mpath on top of multiple I/O schedulers)   +AFs-passed+AF0
    runtime  21.659s  ...  21.733s

Thanks,

Bart.
