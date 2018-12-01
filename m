Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D5C04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0E2082F
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X5BxRbw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB0E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725733AbeLBF46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:56:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38079 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBF46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 00:56:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so3922181pgc.5
        for <linux-block@vger.kernel.org>; Sat, 01 Dec 2018 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Eo5Aw0GFMoAm99QobwK+qS+wB786sQz44IqIamDNK3A=;
        b=X5BxRbw6eNqNOlaiOw/LogXWZ1QAATFxzS7ie7zjOY/VYnr5Hr6pve+ka2vuEq0KW+
         jiwc258cB2JgJZcvT4trqVLYgGXNwUOTsx7oyuAhycspAm/TuyWcGlIgdA5IZwa3J1Ie
         9PfJnxFRvxGJL4cy7Ui0/OzuKX06+E4lpyTFtKFsAl2MBd134dIQ1/uTkb24IicuIzhG
         nmewDqL4WZnGoXDjjqfeo7Y5mwGFzsLRdNuoE6IB36KqyoaJ/m+F6G2aAR+PJ5ZrKk+u
         4voCe1XVNm92XzHYdS7lGvWs8HtTpWjWJDsWLFIbWFyNGfKIEiEnJgnvmi8ySySFIJo0
         XtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Eo5Aw0GFMoAm99QobwK+qS+wB786sQz44IqIamDNK3A=;
        b=IzHDTFCx/TEMHlqBijD7tMkVYQk+gkQw4lI+LBhgBSsXEAXID3IR0J+1tOY1yXPg+F
         eSFALXYoL0GL4+h9zz0Wn0TCpC6R7RPFVmyHqn9JP4Gj8Q7y+BovDTQhw+MXX2RCytFz
         1FBF5GNcqLHGGg/odC4WIX7ErfvB+3viPMXycezHn489j/R7H47dKXIPsDXHfB0JnXKX
         2XjJ+eQRHI0xHzjj62WQbpcBMCaHJxMWRXffphYdp0iyDeYpq6A0TNuJG52Ohet8QAjs
         eQNmaLY0WRtAq1mqvgSIXZxSkj8l/qzbmsT60aYOKfjIuO9pXn37n3zWIJ+LuAmgfSQS
         sdow==
X-Gm-Message-State: AA+aEWbw/3Hi7lrMSoAhSisP5HqaZKl05RoCFysvlqd8BXAyOfoWLNLc
        myekH1tqjpI0YW/xDDG1RFdmTFarmFw=
X-Google-Smtp-Source: AFSGD/Vw/GkRjBXQqyf5vdFUpmBRlnNpUGwde1aDQH8BWhblvIQC31UXTVnY9CgiJ8McxROXUlN3Xw==
X-Received: by 2002:a63:4456:: with SMTP id t22mr8809109pgk.0.1543689828763;
        Sat, 01 Dec 2018 10:43:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a15sm9098202pgb.1.2018.12.01.10.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:43:47 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.20-rc5
Message-ID: <356ff70c-9de6-12f6-ddc1-bb49d0f5df30@kernel.dk>
Date:   Sat, 1 Dec 2018 11:43:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A set of fixes for the next -rc release. This pull request contains:

- Single range elevator discard merge fix, that caused crashes (Ming)

- Fix for a regression in O_DIRECT, where we could potentially lose the
  error value (Maximilian Heyne)

- NVMe pull request from Christoph, with little fixes all over the map
  for NVMe.


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181201


----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: warn when finding multi-port subsystems without multipathing enabled

Ewan D. Milne (1):
      nvme-fc: initialize nvme_req(rq)->ctrl after calling __nvme_fc_init_request()

Igor Konopko (1):
      nvme-pci: fix surprise removal

Jens Axboe (1):
      Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus

Keith Busch (1):
      nvme: Free ctrl device name on init failure

Maximilian Heyne (1):
      fs: fix lost error code in dio_complete

Ming Lei (1):
      block: fix single range discard merge

Prabhath Sajeepa (1):
      nvme-rdma: fix double freeing of async event data

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

 block/blk-merge.c        | 2 +-
 drivers/nvme/host/core.c | 8 +++++---
 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/host/nvme.h | 3 +++
 drivers/nvme/host/rdma.c | 2 ++
 fs/direct-io.c           | 4 ++--
 6 files changed, 14 insertions(+), 7 deletions(-)

-- 
Jens Axboe

