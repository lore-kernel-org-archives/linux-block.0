Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798DC10F0E
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7418C20693
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfDRWEy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:04:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49614 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRWEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 18:04:54 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hHF9I-00050B-0u
        for linux-block@vger.kernel.org; Thu, 18 Apr 2019 22:04:52 +0000
Received: by mail-qk1-f197.google.com with SMTP id 23so2864529qkl.16
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 15:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyeFXOjqKLFt3eJ8elJq5KwOzSRh1y1w19XMk2cP5II=;
        b=fcTnhlNZ8NilHhYRPDsIrpApEl54cVTwhenlc1JOQNfuA969Zx4I9WcRqC4n5zas4E
         /aICz4CX8y1E3oOi6icqPXz8or6DIA/bfWISXGLrbbMStxomRqJGIbrzIZo2jOTgLEZa
         ykpjwvtOVGsOYMhF4znDKx1V0uW/mld2dKbbpV//JcsnflJpg2CD3L38xBOyuH1jaEJC
         lxaJWDJ/BOZEuVRZV54C/kqiGjjS7NNQt3FUSUduOYiEg6kLYp6MwNBt2vuqYTGxzvrc
         iwmxTD1pEuTn+KsEUkAok2HzZRHqjjquSiF+bZq0wJXlZzRxGyCIy+2em4RfNA9Orsxc
         5C9A==
X-Gm-Message-State: APjAAAWC4mcOV8K8zTFXw0wvLU5faya1gCPEXBOqllpUdk5pJdj6oqzo
        t5SKytwCIKfTYtAW1DS65ciyWfJNu5eJHtpjgrVlvfHr0DADiPreTmdarRWSr4sJ+RuWFAnZZbz
        fqXkYL9o6osgVfNY+MAeIAr8M8YCd0ug1RHwxFBc+
X-Received: by 2002:ac8:2246:: with SMTP id p6mr384085qtp.225.1555625091168;
        Thu, 18 Apr 2019 15:04:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqywF7IvrJi0Ts+N8+BEIHKPOkJDTXEv7ToP6bwKyWpzHlzv5+ZWzxfbiJVxRHJHxHWTlmtinw==
X-Received: by 2002:ac8:2246:: with SMTP id p6mr384064qtp.225.1555625090899;
        Thu, 18 Apr 2019 15:04:50 -0700 (PDT)
Received: from localhost ([177.103.98.6])
        by smtp.gmail.com with ESMTPSA id v6sm1490044qkd.46.2019.04.18.15.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 15:04:50 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     axboe@kernel.dk, linux-raid@vger.kernel.org
Cc:     gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        kernel@gpiccoli.net, neilb@suse.com, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC] [PATCH V2 0/1] Introduce emergency raid0 stop for mounted arrays
Date:   Thu, 18 Apr 2019 19:04:47 -0300
Message-Id: <20190418220448.7219-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the md driver completely relies in the userspace to stop an
array in case of some failure - for raid0, if we remove a raid0 member like via
PCI hot(un)plugging an NVMe device, and the raid0 array is _mounted_, mdadm
cannot stop the array, since the tool tries to open the block device to perform
the ioctl with the O_EXCL flag.

So, an array in this situation is "alive" - users may write to it and unless
they check the kernel log or some other monitor tool, everything will seem fine
and the writes are completed with no errors. Being more precise, direct
writes will not work, but since usually writes are done in a regular form
(backed by the page cache) the most common scenario is an user being able to
regularly write to a broken raid0, and get all their data corrupted.


PROPOSAL:
The idea proposed here to fix this behavior is mimic other block devices:
if one have a filesystem mounted in a block device on top of an NVMe or
SCSI disk and the disk gets removed, writes are prevented, errors are
observed and it's obvious something is wrong; same goes for USB sticks.

We believe right now the md driver is not behaving properly for raid0
arrays (it is handling these errors for other levels though). The approach
took for raid-0 is basically an emergency removal procedure, in which I/O
is blocked from the device, the regular clean-up happens and the associate
disk is deleted. It went to extensive testing, as detailed below.

Not all are roses, we have some caveats that need to be resolved.
Feedback is much appreciated.
There is a caveats / questions / polemic choices section below the test
section.

V1 link: https://marc.info/?l=linux-raid&m=153313538013458

Thanks in advance,


Guilherme


* Testing:

The device topology for the tests is as follows:

                            md6
                             |
              |******************************|
              |                              |
             md4                            md5
              |                              |
       |*************|                |*************|
       |             |                |             |
      md0           md2              md1           md3
       |             |                |             |
   |*******|       |***|            |***|       |*******|
   |       |       |   |            |   |       |       |
nvme1n1 nvme0n1   sda sdd          sde sdf   nvme2n1 nvme3n1


We chose to test such complex topology to expose corner cases and timing
issues (which were found in the development phase). There are 3 test
subsets basically: the whole set of devices, called here "md cascade", and
2 small branches, called here "md direct" testing.

So, in summary:
### md direct (single arrays composed of SCSI/NVMe block devices) ###
A1 = md1      A2 = md3
C1 = sde      C1 = nvme2n1
C2 = sdf      C2 = nvme3n1

### md cascade (array composed of md devices) ###
A3 = md6
underlying component UC1 = nvme1n1
underlying component UC2 = sdd
underlying component UC3 = sdf
underlying component UC4 = nvme2n1


### Method of removal ###
- For NVMe devices, "echo 1 > /sys/block/nvmeXnY/device/device/remove"
- For SCSI devices, "echo 1 > /sys/block/sdX/device/delete"


### Test ###
Write a file using the command: "dd if=/dev/zero of=tmpfile bs=X" where
X might be 8K or 384K (varied in the tests).

Each array also contains a valid file to be checked later, in order to
validate that filesystem didn't get severely corrupted after the
procedure.

Tests marked with @ indicate direct writes were tested too.
Tests with a [] indicator exhibited some oddity/issue, detailed in the
caveats section.

After each test, guest was rebooted.

Tests were performed in kernel v5.1-rc5.


* Test results
("partition X" means we have a GPT table with 2 partitions in the device)


### md direct

Remove members and start writing to array right after:
A1 with:                               A2 with:
 -ext4                                  -ext4
 --Removed C1: PASSED @                 --Removed C2: PASSED @

 -xfs                                   -xfs
 --Removed C2: PASSED                   --Removed C1: PASSED

 -partition 1 + ext4                    -partition 1 + xfs
 -partition 2 + xfs                     -partition 2 + ext4
 --Removed C1: PASSED                   --Removed C2: PASSED


Start writing to array and remove member right after:
A1 with:                               A2 with:
 -ext4                                  -ext4
 --Removed C1: PASSED                   --Removed C1: PASSED
 --Removed C2: PASSED @

 -xfs                                   -xfs
 --Removed C1: PASSED                   --Removed C1: PASSED
                                        --Removed C2: PASSED @

 -partition 1 + ext4                    -partition 1 + xfs
 -partition 2 + xfs                     -partition 2 + ext4
 --Removed C2: PASSED                   --Removed C1: PASSED @


### md cascade
Remove members and start writing to array right after:
A3 with:
 -ext4:
 --Removed UC2: PASSED
 --Removed UC4: PASSED @

  -xfs:
 --Removed UC2: PASSED @
 --Removed UC4: PASSED

 -partition 1 + ext4
 -partition 2 + xfs
 --Removed UC1: PASSED @
 --Removed UC3: PASSED


Start writing to array and remove member right after:
A3 with:
 -ext4:
 --Removed UC2: PASSED
 --Removed UC4: PARTIAL @ [(a) (b)]

  -xfs:
 --Removed UC2: PASSED
 --Removed UC4: PARTIAL @ [(c)]

 -partition 1 + ext4
 -partition 2 + xfs
 --Removed UC1: PASSED
 --Removed UC3: PARTIAL @ [(b)]


* Caveats / points of uncertainty / questions:

=> Some arrays  still show in /dev after the removal. We noticed if FS
is unmounted and "mdadm --detail" is tried against that, it hangs.

#For md cascade only (nested arrays):

a) After direct writes, if we issue a regular right (backed by page
cache), observed an oops sometimes, in ext4 filesystem.

b) We might face an ext4 journal task blocked in io_schedule().
Backtrace: https://pastebin.ubuntu.com/p/KgvHjRn6Pg

c) Hung task in xfs after direct I/O only, when trying to write again after
failing one of the members (2nd write is using page cache).
Backtrace: https://pastebin.ubuntu.com/p/7NMRV9fG2H



#Generic questions / polemic choices:

i) With this patch, the STOP_ARRAY ioctl won't proceed in case a disk is
removed and emergency stop routine already started to act, even in case of
unmounted md arrays. This is a change in the old behavior, triggered by
the way we check for failed members in raid0 driver.

ii) Currently, the patch implements a kernel-only removal policy - shall
it rely on userspace (mdadm) to do it? A first approach was based in
userspace, but it proved to be more problematic in tests.

iii) Would a new state ("error") for RAID0 be a better solution? I'm
experimenting a simpler approach that would introduce a new state, but
wouldn't force the removal of the device.

Guilherme G. Piccoli (1):
  md/raid0: Introduce emergency stop for raid0 arrays

 drivers/md/md.c    | 123 +++++++++++++++++++++++++++++++++++++++++----
 drivers/md/md.h    |   6 +++
 drivers/md/raid0.c |  14 ++++++
 3 files changed, 134 insertions(+), 9 deletions(-)

-- 
2.21.0


