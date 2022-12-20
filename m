Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40634C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 15:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiLTPRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTPRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 10:17:36 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2F1B1CA
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:17:34 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q190so6487840iod.10
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNn528CAV7DsNF2EauLHazDCPD2RqBNodT41wFUTkmU=;
        b=Y1WwAtX0rFFVY4u/pal0MMaKaDKhpF6R7xmL/EKOOcibDJOzt8K0q26sLT9OU5F7Cr
         faD0LgOMWTknetL1JTPWSxLSvLDam6ugcCpjxUf/wn0gPUG++XlGgLIVP7EMDhir24J6
         2cPdaWotDxCaLdS9jvWQFLj6bIr37c2oIO3a7zfrn2+nOKKI24dhg3trZk82+XiQNdbA
         a6fVBFF1rvWvJL7q7tFBsDaDcygU3E43rf9nKp8FeAqKADy7N+KkKGlGPXhGLvRcId2+
         cTMShHuQdWcISsUA1YBE8/GdnX1lFD1mTsao/iceQ+P1VoOkFHTohFgsmi1v++S/5pHr
         ccCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNn528CAV7DsNF2EauLHazDCPD2RqBNodT41wFUTkmU=;
        b=VMg0YYp40VclgokG1rF71KcSyTnPL/0sVBJ8a9y75TEd5/cRBBAKmPF/Le7+amDerG
         vEPUznAxdPfczlaMQW6Bz6bcGjYj5XHt7CKc+2tFv/XxGE2vSiNqUKgM9DG+RZg6qCxC
         Md5cMdJpwtTijUl+FyghLAPA9azl9Qg0u4S3++xZfhqfRgoLFs8G8Wma13tZgx8eSwjg
         Wemw2+Ar17m+ZRmFTrG+B67XF+1CeCBwK+K3NUkXrJ1oqQXb2XmgxLGlhkFB2xHs1p00
         sghwLVygaOkeMXLzmz3GXmv0BzaAU1RJ1CoPNOsNy94r/vIa6CxfjHWmI0XUhsDpOFyO
         GuNg==
X-Gm-Message-State: AFqh2kop6iooQWLj88/Dsf7PQn7ySF4dSYIT1Yo4j3hSCPxEB45CBt2O
        QPhBE4JfhjSTOKKP/2nq2ceI2nROctXQMBjbMbw=
X-Google-Smtp-Source: AMrXdXv14tAJod3UjweDabdNyO2B7vBXZcqnOhkRvIQf6mLk2is2yXJOIjWTrb8YLUSZXXf5w4Eeuw==
X-Received: by 2002:a5d:8519:0:b0:6ed:95f:92e7 with SMTP id q25-20020a5d8519000000b006ed095f92e7mr644931ion.0.1671549453910;
        Tue, 20 Dec 2022 07:17:33 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g24-20020a056602073800b006e30c7e5cb2sm5370556iox.47.2022.12.20.07.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:17:33 -0800 (PST)
Message-ID: <b4f6146f-6bbf-c58a-21fd-a03acb28c4a0@kernel.dk>
Date:   Tue, 20 Dec 2022 08:17:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block fixes for 6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Series of fixes that should go into this merge window:

- Various fixes for BFQ (Yu, Yuwei)

- Fix for loop command line parsing (Isaac)

- No need to specifically clear REQ_ALLOC_CACHE on IOPOLL downgrade
  anymore (me)

- blk-iocost enum fix for newer gcc (Jiri)

- UAF fix for queue release (Ming)

- blk-iolatency error handling memory leak fix (Tejun)

Please pull!


The following changes since commit e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770:

  Merge tag 'mm-stable-2022-12-13' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2022-12-13 19:29:45 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2022-12-19

for you to fetch changes up to 53eab8e76667b124615a943a033cdf97c80c242a:

  block: don't clear REQ_ALLOC_CACHE for non-polled requests (2022-12-16 09:18:09 -0700)

----------------------------------------------------------------
block-6.2-2022-12-19

----------------------------------------------------------------
Isaac J. Manjarres (1):
      loop: Fix the max_loop commandline argument treatment when it is set to 0

Jens Axboe (1):
      block: don't clear REQ_ALLOC_CACHE for non-polled requests

Jiri Slaby (SUSE) (1):
      block/blk-iocost (gcc13): keep large values in a new enum

Ming Lei (1):
      block: fix use-after-free of q->q_usage_counter

Tejun Heo (1):
      blk-iolatency: Fix memory leak on add_disk() failures

Yu Kuai (3):
      block, bfq: fix possible uaf for 'bfqq->bic'
      block, bfq: don't return bfqg from __bfq_bic_change_cgroup()
      block, bfq: replace 0/1 with false/true in bic apis

Yuwei Guan (1):
      block, bfq: only do counting of pending-request for BFQ_GROUP_IOSCHED

 block/bfq-cgroup.c   | 16 +++++++---------
 block/bfq-iosched.c  | 13 ++++++++++---
 block/bfq-iosched.h  |  4 ++++
 block/bfq-wf2q.c     |  8 ++++----
 block/blk-cgroup.c   |  2 ++
 block/blk-core.c     |  9 +++++----
 block/blk-iocost.c   |  2 ++
 drivers/block/loop.c | 28 ++++++++++++----------------
 include/linux/bio.h  |  3 +--
 9 files changed, 47 insertions(+), 38 deletions(-)

-- 
Jens Axboe

