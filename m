Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1FC742D2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37221019
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 19:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMmXcaAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLTFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:05:55 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:43428 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGLTFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 15:05:55 -0400
Received: by mail-qk1-f174.google.com with SMTP id m14so7183132qka.10
        for <linux-block@vger.kernel.org>; Fri, 12 Jul 2019 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A89k2QBX+ifN58xgjSwKur5/GOghr6/HQzXuEW38IeY=;
        b=WMmXcaAbw0c9pMcJCZ5CyKXUgVpjIWFrRZlIT69RmqKeLaYdWm2K2zzFUKEbjI5Hbb
         9CCLaLAL9t5HM9+bMGD3QDqtK+HmDkcqd55Mro02OPRskkglZTXs29LesSgD9vUu05kd
         m76otCp6CpvYXj2Re/333SmIpTRI/NBd0ybX36dY7/j/hodaUEZB6U8k5Cb9Y9alVU5g
         Fbxoh4or9T3w1a5GO2ftVIlnzu/b2WGlYB9RBQ2FPBt13uP3o44EMfm8zsTMuuhaxq67
         4djI+c0QY1BUHGElN6GaMNZBG18j+5wzBcimSXoWHaSC8GhEO1rloiTh967PB6i2bjOK
         7E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=A89k2QBX+ifN58xgjSwKur5/GOghr6/HQzXuEW38IeY=;
        b=ZCnH+rQiubxJXdW3wrdd86af2GC1ULwGprST3qAy6atLHEnSBeIojAZN92roT+e3yA
         zFbcN7kvQmgrSLVJTlaHGmsTLJoP+2Vht8k18//A7gs0U+5MyrpetiZi9q1LqyHxy0vZ
         roO496/p7opi8nhHEIOHB5JBIhgWFr7JXQObY8HAg8tn1QUyaf5u+Y9AUCZD7fx0G76J
         DMIC6u3BpVcqPqFFX6u9CCCheZmfN6ZHGW/RKRO2yNYZ+vBHYxDVbXjK/f3AZx8tWo/Z
         /8JiC9m7ntqjgE0HCI/OmKCVdkudCieMVWkARGOU2y49HX4H8vZ2PhALAUltdl/ASMT7
         oHhA==
X-Gm-Message-State: APjAAAW1ef7qMRsggncYVlb9x0SCvwa0pTS/XkcgzO/mz9vuClSQjNFy
        sYnW56mDn6MtuhHfaGtYm35QBcqLzW8=
X-Google-Smtp-Source: APXvYqw0ikm+ZPVkqqJSWm0o5jlXH6CI1HTOadroID2Cd1BEylNFjwFq4YIDc57jJXeZD46xHd5aCQ==
X-Received: by 2002:a37:ad0f:: with SMTP id f15mr7467328qkm.68.1562958354379;
        Fri, 12 Jul 2019 12:05:54 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t8sm3904990qkt.75.2019.07.12.12.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 12:05:53 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:05:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Fuqian Huang <huangfq.daxian@gmail.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Milan Broz <gmazyland@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Qu Wenruo <wqu@suse.com>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Subject: [git pull] device mapper changes for 5.3
Message-ID: <20190712190552.GA52544@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Merging these DM changes will require manual conflict resolution in the
snapshot target's Documentation updates due to conflicts with the
shotgun blast of RST changes to DM documentation that I didn't ack but
got in anyway -- clearly the RST Documentation train brakes for nobody ;)
Feel free to have a look at the test merge I did in the linux-dm.git
'dm-5.3-merge' branch.

Also, you'll note that the last 2 commits of this pull were rebased
today; I did that because the dm-bufio fix's commit header needed a lot
of grammar fixes and was also missing the stable@vger.kernel.org Cc.

The following changes since commit 2eba4e640b2c4161e31ae20090a53ee02a518657:

  dm verity: use message limit for data block corruption message (2019-06-25 14:09:14 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-changes

for you to fetch changes up to bd293d071ffe65e645b4d8104f9d8fe15ea13862:

  dm bufio: fix deadlock with loop device (2019-07-12 09:59:37 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Add encrypted byte-offset initialization vector (eboiv) to DM crypt.

- Add optional discard features to DM snapshot which allow freeing space
  from a DM device whose free space was exhausted.

- Various small improvements to use struct_size() and kzalloc().

- Fix to check if DM thin metadata is in fail_io mode before attempting
  to update the superblock to set the needs_check flag.  Otherwise the
  DM thin-pool can hang.

- Fix DM bufio shrinker's potential for ABBA recursion deadlock with DM
  thin provisioning on loop usecase.

----------------------------------------------------------------
Fuqian Huang (1):
      dm integrity: use kzalloc() instead of kmalloc() + memset()

Junxiao Bi (1):
      dm bufio: fix deadlock with loop device

Mike Snitzer (2):
      dm thin metadata: check if in fail_io mode when setting needs_check
      dm snapshot: add optional discard support features

Milan Broz (4):
      dm integrity: always set version on superblock update
      dm crypt: wipe private IV struct after key invalid flag is set
      dm crypt: remove obsolete comment about plumb IV
      dm crypt: implement eboiv - encrypted byte-offset initialization vector

Pavel Begunkov (1):
      dm: update stale comment in end_clone_bio()

Qu Wenruo (1):
      dm log writes: fix incorrect comment about the logged sequence example

Zhengyuan Liu (2):
      dm crypt: use struct_size() when allocating encryption context
      dm log writes: use struct_size() to calculate size of pending_block

 Documentation/device-mapper/snapshot.txt |  16 +++
 drivers/md/dm-bufio.c                    |   4 +-
 drivers/md/dm-crypt.c                    | 101 +++++++++++++++--
 drivers/md/dm-integrity.c                |   7 +-
 drivers/md/dm-log-writes.c               |   4 +-
 drivers/md/dm-rq.c                       |   2 +-
 drivers/md/dm-snap.c                     | 186 +++++++++++++++++++++++++++----
 drivers/md/dm-thin-metadata.c            |   7 +-
 8 files changed, 284 insertions(+), 43 deletions(-)
