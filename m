Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:41178 "EHLO othala.uls.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753503AbeBVL3Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 06:29:25 -0500
Received: from uls-154-73-35-201.wall.uls.co.za ([154.73.35.201] helo=tauri.local.uls.co.za)
        by othala.uls.co.za with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jaco@uls.co.za>)
        id 1eooaa-00070p-Kd
        for linux-block@vger.kernel.org; Thu, 22 Feb 2018 12:59:00 +0200
To: linux-block@vger.kernel.org
Cc: Pieter Kruger <pieterk@uls.co.za>
From: Jaco Kroon <jaco@uls.co.za>
Subject: disk-io lockup in 4.14.13 kernel
Message-ID: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
Date: Thu, 22 Feb 2018 12:58:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

We've been seeing sporadic IO lockups on recent kernels.

Currently installed on the server is 4.14.13.

Previously we ran 4.0.9, due to various problems from 4.1 onward with
respect to RAID problems, and netfilter etc ... with 4.13 being the
first usable kernel again that doesn't require additional patching.  I'm
not sure if the situation currently is RAID related, or actual disk, I
doubt it's filesystem (ext4 in this case).

As far as I can tell the issue has been coming along since the
introduction of 4.1.

We've got LVM in use, with dm-5 representing vg=lvm, lv=home, mounted on
/home (quite a big one).  Two PVs backing that, each a mdadm based RAID6.

The clear symptom that we see every time is this snippet from iostat -dmx 1:

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sds               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdq               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdo               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdr               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdl               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdp               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdn               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdj               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdb               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdf               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdk               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdc               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdh               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sde               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdm               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdi               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdg               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
sdd               0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
md127             0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
md125             0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
md126             0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
md124             0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-0              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-3              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-4              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-5              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     1.00    0.00    0.00    0.00   0.00 100.00
dm-6              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-7              0.00     0.00    0.00    0.00     0.00     0.00    
0.00     0.00    0.00    0.00    0.00   0.00   0.00

Normally I see that the sd* devices carries approximately the same load
as the md* devices as the dm-* devices (in terms of number of requests,
not by utilization %).  So if we have outstanding requests on dm-* we
will see oustanding requests on md* on sd*.  This is not the case above,
which leads me to believe that dm-5 in this case received a request, but
for some or another reason never responded (ie, kernel believes there is
an outstanding request).

The file-system on /home is non-responsive at this point for any
non-cached data (meaning that some folders an ls on will work, whereas
others the ls process will go into uninterruptible wait and stay there -
far majority of them).

/proc/mdstat is looking very happy based on my experience.  No failed
drives or the like.

Capture of everything I thought to capture available at
http://downloads.uls.co.za/lockup/, specifically:

dmesg output
dmsetup -v info
dmsetup -v table
/proc/mstat
px axf
uptime
iostat -dmx 1 60

System is currently in "broken" state, and I can leave it there for
approximately the next four hours to gather additional information, at
which point I'll have to trigger a hard reset (system fails to shut down
cleanly).

Kind Regards,
Jaco
