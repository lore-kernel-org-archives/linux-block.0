Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35914 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbcEQVo6 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 17 May 2016 17:44:58 -0400
Received: by mail-lb0-f196.google.com with SMTP id r5so1734741lbj.3
        for <linux-block@vger.kernel.org>; Tue, 17 May 2016 14:44:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 May 2016 15:44:56 -0600
Message-ID: <CADm5WxPvYdy9bBr3aY3irAktm+05=Y+dvGE-i+XsesGpZUMo9A@mail.gmail.com>
Subject: [PATCH v2 0/4] block: Separating discards from writes in Linux IO statistics
From: Michael Callahan <coder.callahan@gmail.com>
To: linux-block@vger.kernel.org
Cc: Michael Callahan <michaelcallahan@fb.com>,
	Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch set separates block layer statistics for discards from
writes.  Discards are currently bundled with writes in the
various /sys/block/*/stat files as well as in /proc/diskstats.
However discards are nearly always used to mark storage that is
no longer in use.  There are many reasons having discard not
counted with writes is useful:

1) For many non volatile memory devices it is just nice to know
   that discards are enabled and working properly.

2) Discards have different performance characteristics than
   writes.  They are generally much faster and larger and bundling
   them makes performance statistics less meaningful.

3) Discards are not writes in terms of tracking device lifetime.
   If a device supports six device writes per day it is nice to know
   how many writes have actually been written to the device as
   discards do not count against that total.

Separation of discard statistics is accomplished by expanding the
struct diskstat arrays to 3 entries for STAT_READ, STAT_WRITE,
and STAT_DISCARD.  A new rw_stat_group function is then used to
convert from rw_flags (cmd_flags from requests, bi_rw from bios)
into the appropriate stat group which is then tracked as before.
Lastly the new statistics are appended to the current
/sys/bloc/*/stat and /proc/diskstats on output such that they are
the last four entries of each.  These are analogous to the four
read and write statistics.

 * Number of discard ios completed
 * Number of discard ios merged
 * Number of discard sectors completed
 * Milliseconds spent on discard requests.

[before ~]# cat sys/block/nvme0/stat
296550701        0 2372405688 67317193 19672752        0 7972237312
9375167        0  2787238 79718726

[after ~]# cat sys/block/nvme0/stat
296550701        0 2372405688 67317193 18034352        0 4616794112
9125902        0  2787238 79718726  1638400        0 3355443200
249265

Note that the discards have moved out of the write fields to the
end and that the write fields are now smaller by the difference.

Adding the new statistics to the end of /sys/block/*/stat and
/proc/diskstats is backwards compatible with both iostat and
vmstat which pick up just the old fields:

[root@after ~]# iostat -x
Linux 4.5.0_68319_ge5065f4-dirty (##hostname###)        05/17/2016
 _x86_64_        (48 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.41    0.00    0.23    0.01    0.00   99.35

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
sda               0.01     7.50    0.20    3.61    16.65   708.41
190.03     0.09   22.53   1.16   0.44
nvme0n1           0.00     0.00  587.03   35.70  4696.25  9139.08
22.22     0.16    0.24   0.01   0.55


[root@after ~]# vmstat -d
disk- ------------reads------------ ------------writes----------- -----IO------
       total merged sectors      ms  total merged sectors      ms    cur    sec
ram0       0      0       0       0      0      0       0       0      0      0
ram1       0      0       0       0      0      0       0       0      0      0
ram2       0      0       0       0      0      0       0       0      0      0
ram3       0      0       0       0      0      0       0       0      0      0
ram4       0      0       0       0      0      0       0       0      0      0
ram5       0      0       0       0      0      0       0       0      0      0
ram6       0      0       0       0      0      0       0       0      0      0
ram7       0      0       0       0      0      0       0       0      0      0
ram8       0      0       0       0      0      0       0       0      0      0
ram9       0      0       0       0      0      0       0       0      0      0
ram10      0      0       0       0      0      0       0       0      0      0
ram11      0      0       0       0      0      0       0       0      0      0
ram12      0      0       0       0      0      0       0       0      0      0
ram13      0      0       0       0      0      0       0       0      0      0
ram14      0      0       0       0      0      0       0       0      0      0
ram15      0      0       0       0      0      0       0       0      0      0
sda   102903   5247 8408420   47424 1820306 3782041 357153613 43320121
     0   2228
nvme0n1 145633279      0 1165066312 18981333 13107200      0
3355443200 6663655      0   1796
loop0      0      0       0       0      0      0       0       0      0      0
loop1      0      0       0       0      0      0       0       0      0      0
  [chop rest of loop devices]

Comments and suggestions welcome.

Signed-off-by: Michael Callahan<michaelcallahan@fb.com>
