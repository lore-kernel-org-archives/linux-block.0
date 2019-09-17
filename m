Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A4FC4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778A520862
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzvpovQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfIQQwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:52:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45824 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfIQQwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 12:52:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so3883951wrm.12
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evGS757tUJRmyH52cxf9DkgpsYSHsrNAYfq4amowEcw=;
        b=SzvpovQ546505iDrUP05F8IpyFdT1dpX3Y/0NcmUEIc0FreHeRRL31AHZUNYbgyPmU
         oC+YkPCDQz0FAXCkH7NGK1kJ7afkoEZMAXl4FCPEm5VmQfRkExTaPCvtYx/0mjpp7J+I
         T9SexfGNqMRUy7TsivzQIk3QYp3JuOrTVsInW+L/jqLujZ8BP+KbMzHgeEcV4GPmdv4r
         opVw2WZBeKC5M3PZUGrDRuECiMA5gr3eekLGkXE7NUkBzRdNmArqYjllfzUk2Xmdon+7
         a+nBopIS4wLmoETEBmcew/feLr37/N9H97NGyKsnhSwhywZFWt4ccP4ZjiWPyY3Bkg4N
         vF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evGS757tUJRmyH52cxf9DkgpsYSHsrNAYfq4amowEcw=;
        b=h48s/TvNWZsNZNyLyamkURcmrg/nlYS9Y68tgTNMNFKgqtE8ZlnHyPFlF36zt6fXjd
         Wb36ID9r3ZSMTRAi+0J2PpEsTd56R+LUfKTFWTDJviZvXBCx+W4H62nkvtAkVCeNnHnw
         sZkDnTBgGC3GLaM6nP1OcnPdmoCDflP2JJir+7ANSWYWn8SJokptg2tBJBHtu8lwZJfH
         Da52pmvLyjT9qEvdVjT0KuQCA+b6brmBTCAxJNgcEXjJk/2gLQL+xY5/hmhvyJMFHoqQ
         0kYDLaLFKVG2XrWROpdn+otf6gg883bELHm/rkqX+I3t7DqdojaVv9aTPkz+KRmEdXK3
         HZWQ==
X-Gm-Message-State: APjAAAVQ94VxjOIr21/nHsnM2+UsafGY7xdLXVjMWW2e7S/ZHlFJlXmd
        qBD8ilucUvyMwr9KMJt0a4wHiw==
X-Google-Smtp-Source: APXvYqwF4qKDqJDaznPd8mF/OQbDHcZh290VNcmFnJQXI03OrOsRsfQYFuIXzoCCXXDwTmqPkiNfaA==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr3540087wrm.238.1568739128540;
        Tue, 17 Sep 2019 09:52:08 -0700 (PDT)
Received: from localhost.localdomain (146-241-53-114.dyn.eolo.it. [146.241.53.114])
        by smtp.gmail.com with ESMTPSA id g73sm4012378wme.10.2019.09.17.09.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:52:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/2 block/for-next] block, blkcg, bfq: make bfq disable iocost and delete bfq prefix from cgroup filenames
Date:   Tue, 17 Sep 2019 18:51:46 +0200
Message-Id: <20190917165148.19146-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
here is the pair of patches from [1] and [2].

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/9/16/469
[2] https://lore.kernel.org/linux-block/20190917151334.GI3084169@devbig004.ftw2.facebook.com/

Angelo Ruocco (1):
  block, bfq: delete "bfq" prefix from cgroup filenames

Tejun Heo (1):
  blkcg: Make bfq disable iocost when enabled

 Documentation/admin-guide/cgroup-v2.rst |  8 +++--
 block/bfq-cgroup.c                      | 48 +++++++++++++------------
 block/bfq-iosched.c                     | 32 +++++++++++++++++
 block/blk-iocost.c                      |  5 ++-
 include/linux/blk-cgroup.h              |  5 +++
 kernel/cgroup/cgroup.c                  |  2 ++
 6 files changed, 71 insertions(+), 29 deletions(-)

--
2.20.1
