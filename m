Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEEFCDB474
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 11:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377001AbjJTLXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376988AbjJTLXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 07:23:14 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EEF91
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 04:23:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9d132d92cso1089365ad.0
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697800991; x=1698405791; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRDpYpXIVIdSaHDJN6BEuySH5Zi8PqIby1wdM/1XOuk=;
        b=TY6mTIcSy7JazewMPrlPaqYYzf/TmPU/Pw+7xftP4eFvXJ33JaOs1lglrl6wVzJZ5+
         +O2QRvyAdA/BCbviLMPhKd8tlW9PfCtJ331NobR/uDG2F53nqjSufSoecgOP/mv2Eq8i
         kKXnydd5ipjaKeAJZheT7PC+pgv69iUd6vnukJlMSOw6cuf4b2RakuB88bWuVj8UQwwF
         oUl4tPLbn19hiH38LET6slNumCOdiMzaV372qCA1lwtXZqPcypJAlpCGGUmVUraOX0Wo
         u3xzP8bagLqq01lIGJd9G2Bh5W9vYmnz6m4hvVLj4qE/bFar49NNeJwxIYP9koRIznCj
         BAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800991; x=1698405791;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRDpYpXIVIdSaHDJN6BEuySH5Zi8PqIby1wdM/1XOuk=;
        b=G54cnYGzunWRJDCU/+P5lnc6vYQwdeuA+ovFpArin+aUWti9Et3KAnqlfWE9cUFDWv
         t+cnuEzSRg27n8OUfzdhtiCbatfaQVIBeU6GAZ8jN4FbKkD37c+wJxek2FBlaVTucyiG
         MjOiBhJkPafJdDQsQp05XP4S5u99TLgm90lSX2qv1Qwtdv5OOkbaFQUGUkINLrMMCx1S
         Ly3RmcWIcG5JMRoMLJTX5t2twrgWpIEyxaLnyHrum853JtkP18jwFw13xmfAErPh4kUR
         3LsXxfzDlXx04xwpUo5fftm1zfEJ8kA0lVvuBWlMHRtvXaPCI+CsEDDxOWYOfqRc2fg4
         rhcw==
X-Gm-Message-State: AOJu0YwfautkweUJ7VyeXv70hHoyFK+Dhje3Sw51gLMUhAJP52PNePDX
        vZcEdDFLQliFSgMpSwDMeGew8auPE3xvoZvRRAVU4A==
X-Google-Smtp-Source: AGHT+IFO3+gOrJpwvhtdyhAgmfMFws+RB+7P8RrUlf2BibdnIpW83KrCaKJDUcYoqCMXbO+mrhdxeA==
X-Received: by 2002:a17:903:6c7:b0:1ca:85b4:b962 with SMTP id kj7-20020a17090306c700b001ca85b4b962mr1502910plb.4.1697800991115;
        Fri, 20 Oct 2023 04:23:11 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id je17-20020a170903265100b001c728609574sm1311723plb.6.2023.10.20.04.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 04:23:10 -0700 (PDT)
Message-ID: <749c0287-422a-4e7b-ba96-e485f777ccda@kernel.dk>
Date:   Fri, 20 Oct 2023 05:23:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.6-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A fix for a regression with sed-opal and saved keys, and outside of that
an NVMe pull request fixing a few minor issues on that front.

Please pull!


The following changes since commit 1364a3c391aedfeb32aa025303ead3d7c91cdf9d:

  block: Don't invalidate pagecache for invalid falloc modes (2023-10-11 15:53:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-10-20

for you to fetch changes up to c3414550cb0d4dfad1816ee14ff1f44819d270db:

  Merge tag 'nvme-6.6-2023-10-18' of git://git.infradead.org/nvme into block-6.6 (2023-10-18 15:32:51 -0600)

----------------------------------------------------------------
block-6.6-2023-10-20

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.6-2023-10-18' of git://git.infradead.org/nvme into block-6.6

Keith Busch (2):
      nvme: sanitize metadata bounce buffer for reads
      nvme-pci: add BOGUS_NID for Intel 0a54 device

Martin Wilck (1):
      nvme-auth: use chap->s2 to indicate bidirectional authentication

Maurizio Lombardi (2):
      nvme-rdma: do not try to stop unallocated queues
      nvmet-auth: complete a request only after freeing the dhchap pointers

Milan Broz (1):
      block: Fix regression in sed-opal for a saved key.

Sagi Grimberg (1):
      nvmet-tcp: Fix a possible UAF in queue intialization setup

 block/sed-opal.c                       |  7 +++----
 drivers/nvme/host/auth.c               |  4 ++--
 drivers/nvme/host/ioctl.c              | 10 +++++++---
 drivers/nvme/host/pci.c                |  3 ++-
 drivers/nvme/host/rdma.c               |  3 +++
 drivers/nvme/target/fabrics-cmd-auth.c |  9 ++++++---
 drivers/nvme/target/tcp.c              |  7 ++-----
 7 files changed, 25 insertions(+), 18 deletions(-)

-- 
Jens Axboe

