Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B37C38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F11924954
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588993864;
	bh=rSajl9rxA5i6FspnKKMANOguIinALbJibmOqGZM4rdA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lEnMCKrnm4GWDTb6kowrcs/EjpHJxjdg+6ciVQnpCULC0w0EZsZ6sy6OvBggHnXCD
	 T+Czg9QFX4PXkLg1yXjvvCBrOJAm5OmaQ8njbqP9C5El/beOwXYFx5z7NGgXXc++qi
	 kvc1ex1Er9asmArBEXX5IRH34CqIfs45W40zjgzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgEIDLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:11:03 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52368 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgEIDLD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:11:03 -0400
Received: by mail-pj1-f65.google.com with SMTP id a5so5172278pjh.2;
        Fri, 08 May 2020 20:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5NcTJui4Fu9/J9tXQ/zepXkgIKrwl9gDgd73XI0wYc=;
        b=ja0ShmthooFHI65GVbxrDfAXLGW6Q6YJ3/zNDpkofbXcZ1Li07H0YgPtUJuvXbrlsR
         Ds0PRB6ZqCy7zBWc8r6vJOJiHOzGsFcZqcjUJT6wucqN0CgV1Cf23ri/Enek8PYZS8cW
         Ix/SdKk/2z+Sk++D6G6f41VLnvPlGqzvHGYg9Hlx9zlYpqy1GK5LDtOaImfzqnApSoo/
         x5NEBxzBfaYx2qriIA2Tf35F87QvilTDv8i4XBaRoT+jac2GR3qOaotg66mgLCQyQCcG
         s1z0bNsJF8JE5ck85G4dhIPAk/oBe3hdQcpywNqSd2l7/i6zLUlo4gMEOxjVH4CUNLtb
         myOw==
X-Gm-Message-State: AGi0PuY7xzyFVDb3moUoTXLrPDH9kQ9/Q3djxdD1e0h5SoJzoV1S2G5G
        wRoVRQxbzd/AIOx32W/zoi4=
X-Google-Smtp-Source: APiQypJJo3vtBLT/+F50uK9YwKjnwZupKT9TMWAfYkMfkofkKXyVoI6FIcRSuFmkZZNsc5UL7pmUIw==
X-Received: by 2002:a17:90a:20ca:: with SMTP id f68mr1501737pjg.67.1588993861986;
        Fri, 08 May 2020 20:11:01 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b1sm3105905pfa.202.2020.05.08.20.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:11:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BBC854035F; Sat,  9 May 2020 03:10:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 0/5] block: fix blktrace debugfs use after free
Date:   Sat,  9 May 2020 03:10:53 +0000
Message-Id: <20200509031058.8239-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Phew, well, since we did't hear back about removing scsi-generic
blktrace functionality I put work into addressing to keep it. That
took a lot of code inspection and also testing. Since libvirt
is limited to what devices you can test I resorted to testing
all supported device types with iscsi tcp and tgt.

I decided to simplfiy the partition work further by just using
a symbolic link. In the end that makes the blktrace code even
cleaner than anything we had before.

scsi-generic stuff still required quite a bit of work to figure
out what to do. Since scsi devices probe asynchronously and scsi-generic
is nothing but a class_interface whose sg_add_device() runs *prior*
to the scsi device probe, we currently address the symlink on the
sg ioctl. I however think this reveals a shortcoming of the class
interface, now that we have async probe and its used widely. I
think we need a probe_complete() call or something like that.
If that seems reasonable I can work on that, that would allow us to
move the debugfs_dir symlink / settings from sg's ioctl to a new
proper call. I'd prefer to address that later though, as an evolution.

Its my first time touching scsi stuff, so I'd highly appreciate a good
review of what I propose for scsi-generic. It gets a bit more
complicated with some drivers using the bsg queue. FWIW, if bsg is
enabled we *reshare* the request_queue from the scsi_device, unless
you're a scsi transport, in which case it creates its own.

You can find this on my git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200508-block-fixes

Luis Chamberlain (5):
  block: revert back to synchronous request_queue removal
  block: move main block debugfs initialization to its own file
  blktrace: fix debugfs use after free
  blktrace: break out of blktrace setup on concurrent calls
  loop: be paranoid on exit and prevent new additions / removals

 block/Makefile               |   1 +
 block/blk-core.c             |  32 ++++--
 block/blk-debugfs.c          | 202 +++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.c       |   5 -
 block/blk-sysfs.c            |  46 ++++----
 block/blk.h                  |  23 ++++
 block/bsg.c                  |   2 +
 block/genhd.c                |  73 ++++++++++++-
 block/partitions/core.c      |   9 ++
 drivers/block/loop.c         |   4 +
 drivers/scsi/ch.c            |   1 +
 drivers/scsi/sg.c            |  75 +++++++++++++
 drivers/scsi/st.c            |   2 +
 include/linux/blkdev.h       |   6 +-
 include/linux/blktrace_api.h |   1 -
 include/linux/genhd.h        |  69 ++++++++++++
 kernel/trace/blktrace.c      |  33 ++++--
 17 files changed, 539 insertions(+), 45 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.25.1

