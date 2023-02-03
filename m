Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C686C05027
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjBCTav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjBCTat (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 14:30:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B91C7CA
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 11:30:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id r8so6293533pls.2
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2023 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwncs/90hqDkN2LA3y1rv9cis6YegI7u/19Uv9sNq/k=;
        b=Z7XOoMMHemcM0BGEckRAYZ3H5aAUc7jOeXDqNbqgw9UpyzmnFr8si62bJp/wgPOTCE
         Lzl/Vs4T9zjo9aQ4b9mvGBm3fXRO6ZIKWJ1fD0r/Vj7xYQfUZ/DTJNhmupxeXFTE+iOV
         23ImO7E0QFBTw1pT6cJt0SVWyl/gvRwRhdYQbHUlcFIxZMwjKMunLCqh2w31yUm+VI7o
         Zp7uWgPZcwDiOiJJ7vqnWWr4GzQ0mP31jhx+ELptMSuLpQd/9Cm2PpyQ02ZEvoGV1m3P
         SsGUveBna5M1msNXacd5+hcWY7FpYOlw1W7Qk/oby+1vyffGz3xkdbE09zIIe4lhFMJg
         3fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wwncs/90hqDkN2LA3y1rv9cis6YegI7u/19Uv9sNq/k=;
        b=SW2Jv/RfwfJZSGLOO2k9vQ6qDi7LrttXvrZkXdht58cOLl6sr6N3YTA9Hm6iVS7kPD
         FnGB8UQx3rn6PF1nuFWavZhG8CTc3epyh+doN3IND1Mc4s+I9DA5k62ReBpv6h5UP5DK
         cbcrrlhTogGLoQFtN3++nwhV7NPWxt8LI0w3EN61cqwNYnRedKBX16eQ6jUAdck7mRY3
         6NaaNd0rvTIs1hu/8W/PQFJbgHygXF3mtDWBE5JvPKYNz11eZ7Jo30SGtdS2i1e0qPsM
         vmkhRcwykYU5eb8CiSGJxiMjbLUwLpugDvQaoQBqGByQ2SdUeAysRfnICzITXiD/2hhs
         6NYw==
X-Gm-Message-State: AO0yUKXIz1XYhlvnW984yZ7jQ3prw+SiVUiY/2VHxCoIZXcss3PsyJJi
        24P1wJHHy/CYErwStboaHBxrsCG41L396QP3
X-Google-Smtp-Source: AK7set+Ylfv0N1Jsofc7krHzUx4QYrrV9kPlcUwTFFbGDSBVUiAG8tZ9nnuVg4CaUh2utUeOC00eIw==
X-Received: by 2002:a05:6a20:931f:b0:bc:b98c:a8c5 with SMTP id r31-20020a056a20931f00b000bcb98ca8c5mr10488890pzh.2.1675452626054;
        Fri, 03 Feb 2023 11:30:26 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090acc0a00b00219186abd7csm2028517pju.16.2023.02.03.11.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 11:30:25 -0800 (PST)
Message-ID: <0914e4ad-7922-4ac7-b3bf-be5db7075236@kernel.dk>
Date:   Fri, 3 Feb 2023 12:30:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.2-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes that should go into this release. A bit bigger than I'd
like at this point, but mostly a bunch of little fixes. In detail:

- NVMe pull request via Christoph
	- Fix a missing queue put in nvmet_fc_ls_create_association
	  (Amit Engel)
	- Clear queue pointers on tag_set initialization failure
	  (Maurizio Lombardi)
	- Use workqueue dedicated to authentication (Shin'ichiro Kawasaki)

- Fix for an overflow in ublk (Liu)

- Fix for leaking a queue reference in block cgroups (Ming)

- Fix for a use-after-free in BFQ (Yu)

Please pull!


The following changes since commit db3ba974c2bc895ba39689a364cb7a49c0fe779f:

  Merge tag 'nvme-6.2-2023-01-26' of git://git.infradead.org/nvme into block-6.2 (2023-01-26 11:43:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-02-03

for you to fetch changes up to e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3:

  Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2 (2023-02-02 11:02:12 -0700)

----------------------------------------------------------------
block-6.2-2023-02-03

----------------------------------------------------------------
Amit Engel (1):
      nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association

Bart Van Assche (1):
      block: Fix the blk_mq_destroy_queue() documentation

Jens Axboe (1):
      Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2

Liu Xiaodong (1):
      block: ublk: extending queue_size to fix overflow

Maurizio Lombardi (2):
      nvme: clear the request_queue pointers on failure in nvme_alloc_admin_tag_set
      nvme: clear the request_queue pointers on failure in nvme_alloc_io_tag_set

Ming Lei (1):
      blk-cgroup: don't update io stat for root cgroup

Shin'ichiro Kawasaki (1):
      nvme-auth: use workqueue dedicated to authentication

Yu Kuai (1):
      block, bfq: fix uaf for bfqq in bic_set_bfqq()

 block/bfq-cgroup.c       |  2 +-
 block/bfq-iosched.c      |  4 +++-
 block/blk-cgroup.c       |  4 ++++
 block/blk-mq.c           |  5 +++--
 drivers/block/ublk_drv.c |  2 +-
 drivers/nvme/host/auth.c | 14 ++++++++++++--
 drivers/nvme/host/core.c |  5 ++++-
 drivers/nvme/target/fc.c |  4 +++-
 8 files changed, 31 insertions(+), 9 deletions(-)

-- 
Jens Axboe

