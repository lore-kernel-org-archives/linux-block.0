Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C741EC282C5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9529821726
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdsL7DJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfAXTxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:53:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44727 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbfAXTid (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id o8so4018468qkk.11
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 11:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ldJYKW5tYcCNWEqGMH2++PWdKB1n6wF/24iKVK1vPt0=;
        b=FdsL7DJ0fG/rIW3igs8D5VV4fIXnEWUBwQxYUsc0hwvkZgOYTWIub56HqIgUoLKQzp
         bHmvU8BFuRQf8s4qd+VMo8Z6Kb66rnWXZgx92PxSxIdSGuPeuDb4hn159VZ6WsfSVwK9
         68ukny2pqA1iYDn0jDWLjuvtB2JMybvoLDlYP4FDso/xRaTuxgcGMuoylZjhKWFxzchE
         EE3twl9MQtptOYXDFo4LPcUjwvIG0yt23gCAEhe20aQTJcXsbpzHKHj4nMG/aQK2yhUd
         9jBpZmUrl1jbV7weBBmvllLxIMRlEVt9k0bk9fi+dSJjYgyEMWWdUgNPk5ICOa/cdKLN
         uydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ldJYKW5tYcCNWEqGMH2++PWdKB1n6wF/24iKVK1vPt0=;
        b=bE+zG3qBa3qubgr0wIPKY54H67f3XUyGesRUgCb6WCU1kn73FUhKESfNSBUi/7jYXx
         Fvpt+/XG6SpALjGa259G8AIpBtvAw6rHoFl5dM2WbJlYWoEsMJ9nMKboVnIVz+F7OpmR
         nUe4WpmX+jzXX177ZzBQC5TgD6NS0ehAkqjEn8me/JcMh9+KkdTpgoGR8xXFNkNgh+AO
         rSmEA3LN1SrdKocIQWfdHQCCtbFgJ4lsTD/RMZ7UQ787kkpvM/0eqwiJNwTr5MD39OJW
         uCOXfqOo9Z3aQriNZKF5kujzsLMwRDln2ET134k1b6+amJHEKO/vPpUAcGEhUtRlYBfM
         K11g==
X-Gm-Message-State: AJcUukfPh83iDearCSQ51Tv5ONL4gIHudFuduXKR2/Sb0NeDQZxD+MVS
        Z5wORPbzmA4Qu7mVYzKnlpo=
X-Google-Smtp-Source: ALg8bN7qShdxPWUU/TlkjVT2B/YfpgWFY7MlGa0yethozKGMJzJS+bL64Gq1wN10B32HviEnjGFdQw==
X-Received: by 2002:a37:9e0d:: with SMTP id h13mr7063831qke.260.1548358711869;
        Thu, 24 Jan 2019 11:38:31 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z207sm57936219qka.57.2019.01.24.11.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:38:30 -0800 (PST)
Date:   Thu, 24 Jan 2019 14:38:29 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Joe Thornber <ejt@redhat.com>, Milan Broz <gmazyland@gmail.com>
Subject: [git pull] device mapper fixes for 5.0-rc4
Message-ID: <20190124193829.GA22312@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.0/dm-fixes

for you to fetch changes up to 075c18c3e124a1511ebc10a89f1858c8a77dcb01:

  dm: add missing trace_block_split() to __split_and_process_bio() (2019-01-22 13:41:48 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM crypt's parsing of extended IV arguments.

- Fix DM thinp's discard passdown to properly account for extra
  reference that is taken to guard against reallocating a block before a
  discard has been issued.

- Fix bio-based DM's redundant IO accounting that was occurring for bios
  that must be split due to the nature of the DM target (e.g. dm-stripe,
  dm-thinp, etc).

----------------------------------------------------------------
Joe Thornber (1):
      dm thin: fix passdown_double_checking_shared_status()

Mike Snitzer (4):
      dm: fix clone_bio() to trigger blk_recount_segments()
      dm: fix redundant IO accounting for bios that need splitting
      dm: fix dm_wq_work() to only use __split_and_process_bio() if appropriate
      dm: add missing trace_block_split() to __split_and_process_bio()

Milan Broz (1):
      dm crypt: fix parsing of extended IV arguments

 drivers/md/dm-crypt.c         | 25 +++++++++++++++++--------
 drivers/md/dm-thin-metadata.c |  4 ++--
 drivers/md/dm-thin-metadata.h |  2 +-
 drivers/md/dm-thin.c          | 10 +++++-----
 drivers/md/dm.c               | 43 +++++++++++++++++++++++++++++++------------
 5 files changed, 56 insertions(+), 28 deletions(-)
