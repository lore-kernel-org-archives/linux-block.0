Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33746 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754674AbcIITBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2016 15:01:04 -0400
Received: by mail-pa0-f67.google.com with SMTP id h5so4201540pao.0
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2016 12:01:04 -0700 (PDT)
Message-ID: <1473447658.8897.13.camel@researchut.com>
Subject: wb-buf-throttle feedback
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: axboe@fb.com, linux-block@vger.kernel.org
Date: Sat, 10 Sep 2016 00:30:58 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Jens,

[Please CC me in replies. I'm not subscribed to the list]

Based on your announcement about the writeback patches, I have picked up your
changes for testing.

I tested it on a 4.7.3 stable kernel with patches applied from your axboe/wb-
buf-throttle-v4.7 branch.


Instead of the infamous dd use case, I picked up the other generic one i.e. to
build the linux kernel.


Machine config:

Intel(R) Core(TM) i5-4210U CPU @ 1.70GHzRAM: 8 GiB
Disk: Rotational SATA HDD Hitachi - 7200 RPM


The machine has 4 logical CPUs. 


Unfortunately, the issue is still easily reproducible. Building a kernel with
defaults, which results in make -j4, ended up stalling the entire OS.

systemd-journald couldn't really log the messages because it too gets affected
by this writeback issue. 

https://github.com/systemd/systemd/issues/1353

The only message it logged are:

Sep 07 16:43:12 chutzpah systemd-journald[348]: Runtime journal
(/run/log/journal/) is 8.0M, max 73.8M, 65.8M free.
Sep 07 16:43:13 chutzpah systemd-journald[348]: System journal
(/var/log/journal/) is 3.9G, max 4.0G, 7.7M free.
Sep 07 16:43:14 chutzpah systemd-journald[348]: Time spent on flushing to /var
is 1.790678s for 2 entries.
Sep 07 16:43:20 chutzpah systemd-journald[348]: Journal started
Sep 08 00:28:55 chutzpah systemd-journald[348]: Suppressed 454 messages from
/system.slice/laptop-mode.service
Sep 08 23:07:29 chutzpah systemd-journald[348]: Suppressed 79 messages from
/user.slice/user-1000.slice
Sep 09 19:48:02 chutzpah systemd-journald[28710]: System journal
(/var/log/journal/) is 4.0G, max 4.0G, 0B free.
Sep 09 19:49:45 chutzpah systemd-journald[5986]: System journal
(/var/log/journal/) is 4.0G, max 4.0G, 0B free.
Sep 09 19:50:07 chutzpah systemd-journald[5986]: Journal started
Sep 09 19:43:30 chutzpah systemd[1]: systemd-journald.service: Watchdog timeout
(limit 3min)!
Sep 09 19:43:30 chutzpah systemd[1]: systemd-journald.service: Killing process
348 (systemd-journal) with signal SIGABRT.
- -- Reboot --

Which is self-explanatory.


At this time, the easy way to workaround the bug is to spare some resources.
In the above use case of mine, I've been working it around by consuming lesser
resources than what the machine has.

So my successful kernel builds have been firing `make -j3` instead. Not
efficient but definitely better than bringing the entire OS to a halt.


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX0wbqAAoJEKY6WKPy4XVpOZMP/jjSCCIwl5yekBnwtjITg1aO
2e6LLiNRn40H0+j6qwgfGU2ho+pptjxHPQSC0ViE/cICZ8QSmWzrNRhQgVnNj+ur
g8cADdBZT/0+GJ8pvbpmynL3LIK8rZuSbeXwdlKBYlZQiiMoCzUSA96l78IQ5R40
CyL8HP1JWmixxPkEPVX/xQ7cfdernrokFwLhwGkeWaqM9wiGutaZo9PY/4PBPXgn
A/P9Xrg3dAxu2OCiZNVIuiP3NC/AJ7S14FiUCCqOYGlvjlxwSBgCaNzHvYCzRcEs
xAV4XGu8DQMFOmHQ7PHXWjb5V2dwgYKDUc79sxzj8m9sF/UKFb53QFrA6S6z8jHO
hLXfiiimaYqI3qEwLw6lqkZ9EzUaIWxVW8gfFDqAV1xkYs1vcEpxkR6MpVPoK2UY
EaFNO+h3aWB6i9FxTn3x3pLKQHRoNEYORFEmMCPktlXZaqPMCORO0rKKfOPmr/DZ
wEDt8PHP+H0y74I6ZEwDv4jJCsqkz1IXc5narVmMAQ6bl64D6o5kUqNWLlfBqv24
R8ata+15oFsAD1LtVFo68ugR+7BFpHDL/1SClgfKrEECVefsQcY+ticO53tnQUoZ
6yHO2f7vqe1InVFoZh07g2jbEsSApBe/XX1jNffklMC2WQI1cHeRYJscI1izQjHO
S7rMxqUE3UhQYAtICn0b
=4zuC
-----END PGP SIGNATURE-----

