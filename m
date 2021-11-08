Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E09C433EF
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1D61208
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhKHV2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240333AbhKHV2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Nov 2021 16:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W7TpvqGrz04otehW9BPhDkn1ECsn2bQCSMhkfPgKOyA=;
        b=d54602fwQMJFYlSpV/ikOe6q3q+PD6M7S/7kaDsQY0bILkl5klEUhOK98HO7SiAG0+AlL/
        G9l3cSc5pvie+CTdundxYrTem5ixvuUFv2au+etSFEWWzq8FyzKT0IE6UfDdJOxQYZfYDd
        k49663yQjE4mq62UJiZuzl6By92Pmro=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-7Nb-YtwSOfOHpMln9T1KBA-1; Mon, 08 Nov 2021 16:25:30 -0500
X-MC-Unique: 7Nb-YtwSOfOHpMln9T1KBA-1
Received: by mail-qt1-f200.google.com with SMTP id b21-20020a05622a021500b002acb563cd9bso9456842qtx.22
        for <linux-block@vger.kernel.org>; Mon, 08 Nov 2021 13:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=W7TpvqGrz04otehW9BPhDkn1ECsn2bQCSMhkfPgKOyA=;
        b=73UXBBftAvC2DECcE3HTg70GCYP2FSfO5XjOs6V3n1BjBAUMaY2CfyeinedfflRg+o
         bgp/r4TKUjRvCxV87N1hXJ4BQnE9JtkRX2mgw00OkKLJHn8UIcLrjotWNSXWtxywfkqN
         7tp67dLv32yQelqoejOhUuZN9yFVYC5PlKpcqqkpb8H2iN9C73f2lG39XaimgkgyqPzD
         JweMGViVjux1bsTt0WpGi+9QpSkmHHYeyZxs4vzri3JTutqwx1DW6k8BnZ0gl3mnOo9b
         FrBRIM+ouPxgDNwM/GFYOaF1UOVKOApFNh/alIel+ccy8YiQ4XOcDLzfXAejQyQ+Zj4G
         XalA==
X-Gm-Message-State: AOAM530CZtwx6u74G6QrFRlUNjMtrAQMLgR5G88f4m+1krEdXzecTi4G
        mTfpBwj5LLV+uctB0caYmCVEiQ4GpIIb/ogaPzHT9Kq+4ZCtvwGNygSREewhGKY/8RyWhWVKRu2
        fJuyDkhwSJT5NrG2yYBNPUg==
X-Received: by 2002:a05:622a:1828:: with SMTP id t40mr2055977qtc.0.1636406729802;
        Mon, 08 Nov 2021 13:25:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTf9eWxWzxdB+GBDlg+lz8e3uJ2Sr3lNLecaQE3xf5NzhVYRaDToWPOIlVifcLZALUzR0mxw==
X-Received: by 2002:a05:622a:1828:: with SMTP id t40mr2055960qtc.0.1636406729617;
        Mon, 08 Nov 2021 13:25:29 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o126sm768581qke.11.2021.11.08.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:25:29 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:25:28 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Christoph Hellwig <hch@lst.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: [git pull] device mapper changes for 5.16
Message-ID: <YYmVyArwFwN/FdfA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit d208b89401e073de986dc891037c5a668f5d5d95:

  dm: fix mempool NULL pointer race when completing IO (2021-10-12 13:54:10 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.16/dm-changes

for you to fetch changes up to 7552750d0494fdd12f71acd8a432f51334a4462d:

  dm table: log table creation error code (2021-11-01 13:28:52 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Add DM core support for emitting audit events through the audit
  subsystem. Also enhance both the integrity and crypt targets to emit
  events to via dm-audit.

- Various other simple code improvements and cleanups.

----------------------------------------------------------------
Cai Huoqing (2):
      dm crypt: Make use of the helper macro kthread_run()
      dm writecache: Make use of the helper macro kthread_run()

Christoph Hellwig (4):
      dm integrity: use bvec_kmap_local in integrity_metadata
      dm integrity: use bvec_kmap_local in __journal_read_write
      dm log writes: use memcpy_from_bvec in log_writes_map
      dm verity: use bvec_kmap_local in verity_for_bv_block

Christophe JAILLET (1):
      dm: Remove redundant flush_workqueue() calls

Luis Chamberlain (1):
      dm: add add_disk() error handling

Michael Weiß (3):
      dm: introduce audit event module for device mapper
      dm integrity: log audit events for dm-integrity target
      dm crypt: log aead integrity violations to audit subsystem

Michał Mirosław (2):
      dm: make workqueue names device-specific
      dm table: log table creation error code

 drivers/md/Kconfig            | 10 ++++++
 drivers/md/Makefile           |  4 +++
 drivers/md/dm-audit.c         | 84 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-audit.h         | 66 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-bufio.c         |  1 -
 drivers/md/dm-crypt.c         | 25 +++++++++----
 drivers/md/dm-integrity.c     | 35 +++++++++++++-----
 drivers/md/dm-log-writes.c    |  6 ++--
 drivers/md/dm-table.c         |  4 +--
 drivers/md/dm-verity-target.c |  6 ++--
 drivers/md/dm-writecache.c    |  6 ++--
 drivers/md/dm-zoned-target.c  |  1 -
 drivers/md/dm.c               |  6 ++--
 include/uapi/linux/audit.h    |  2 ++
 14 files changed, 224 insertions(+), 32 deletions(-)
 create mode 100644 drivers/md/dm-audit.c
 create mode 100644 drivers/md/dm-audit.h

