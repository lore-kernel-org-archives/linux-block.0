Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55447 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933386AbcLMOyE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 09:54:04 -0500
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Coly Li <colyli@suse.de>
Subject: extend bi_size to unsigned long ?
Message-ID: <359dd6f4-b0fa-da37-f4fb-82a055451714@suse.de>
Date: Tue, 13 Dec 2016 22:53:55 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi linux-block and linux-nvme lists,

Recently when I work on md-raid0 DISCARD optimization, I found the
maximum DISCARD bio length that raid0_make_request() receives is 8388608
sectors. I find it is because of the limitation of bi_size, which is
unsigned int and 32 bits length.

A 32 bits bi_size means a DISCARD bio can only cover UINT_MAX>>9
sectors, see commit a22c4d7e3440 ("block: re-add discard_granularity and
alignment checks"). To format a xfs volume on 4x4TB NVMe SSDs, the
original DISCARD bio has to be split for 4x1024 times. If bi_size is a
64 bits unsigned long, in ideal condition the original DISCARD bio can
only be split for 4 times, that is one split bio for each device.

Now days it won't be a big issue since block layer may merge the split
bios (or may not if its block-mq and NVMe). When the underlying device
becomes larger and larger, maybe a 32 bits bi_size will hurt DISCARD
performance.

I know this is not simple, it changes a very important KABI. But this is
really an interesting question to ask: do we have any idea to extend
bi_size from unsigned int to unsigned long ?

Thanks in advance.

Coly Li
