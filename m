Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB6C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436BD20873
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544656203;
	bh=VIIl/v5jzMKyM0phhoG8Uwe16N90e6JW8miQcgwKjP4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Rpr3CUK0+0iSPKEtpTY6Ase2zLs2aon2mWwSXySIja9I5gxSXg47tFI9ixTMBDY4C
	 HrTkcCCyU4sMQr0LDCOG93zVdbXDNfVfBRShArSyVawwXvx9Je+7NVEFFsZKmyHhFf
	 WlaxeWw9/AsGz37gFSG1tJS1C120ylvo1FsQloww=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436BD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLLXKC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:10:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46458 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 18:10:02 -0500
Received: by mail-yb1-f194.google.com with SMTP id f9so37852ybm.13
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 15:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eXpdDkKiUDjveA6kYQltmgJy07xHSzx3WgzDWKvEgeY=;
        b=pV6QbFkOdJZcHUBPm57YQAXMrPSBYZ12omF0MibDlE1D7o+jydScJvrF9kTddrs4c+
         m813ut4ehKHTGX0sDxHhS0g+e1tVLq8rpIndldWJ4UBbMk9mF8II2qyv+2BRae4WtTMo
         Tyz09EKn7aoy1a+4LeEd+k7wSPtmHpqHdLVuqbFG7fca+d+9Fv2i3kS7ADjZGNwxgPk1
         hZJmBbY8MH1OyCfNh9SGHtQ8LfawVmP8lpW8XAVRZDp4CQaAbCVvI7TVI0dADQLoXZwN
         jO7CdDpdhaBHRXWzBStOT8XOxlYiCEhYsxvPpRSCUQgY3gWvDHp47vzp9zqpw/9V/QIx
         UrUw==
X-Gm-Message-State: AA+aEWY6KmQCywdueWlXVnuPWLbPY7+4OsjX384j3ceCH3bkQGQVU7GF
        XEZq6N8kiOMoNu4LWoT9BMg=
X-Google-Smtp-Source: AFSGD/XASisXm4B65WN1d0KT1cS3JU7dgnzXHqn3ZEgyfeuyTj4rB35JTsDvd5IBDRno+SBVMennmQ==
X-Received: by 2002:a25:11c4:: with SMTP id 187mr22602745ybr.284.1544656201572;
        Wed, 12 Dec 2018 15:10:01 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id i21sm137832ywg.5.2018.12.12.15.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Dec 2018 15:10:00 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH blktests 0/2] Add scsi-stress-remove to blktests
Date:   Wed, 12 Dec 2018 18:09:57 -0500
Message-Id: <20181212230959.69975-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Ming Lei's scsi-stress-remove test found a bug in blkg destruction [1]
where bios being created when the request_queue was being cleaned up
threw a NPE in blkg association. The fix is currently being discussed in
[2]. To make this test more accessible, I've ported it to blktests with
Ming Lei's copyright. I've tested this in my qemu instance and verified
we do not see the NPE on a fixed kernel.

Ming, please let me know if you have any objections.

[1] https://lore.kernel.org/linux-block/CACVXFVO_QXipD3cmPvpLyBYSiEcWPN_ThQ=0pO9AwLqN-Lv93w@mail.gmail.com
[2] https://lore.kernel.org/lkml/20181211230308.66276-1-dennis@kernel.org/

This patchset is ontop of osandov#josef ad08c1fe0d9f.

diffstats below:

Dennis Zhou (2):
  blktests: split out cgroup2 controller and file check
  blktests: add Ming Lei's scsi-stress-remove

 common/cgroup       | 18 ++++++---
 tests/block/022     | 96 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/022.out |  2 +
 3 files changed, 111 insertions(+), 5 deletions(-)
 create mode 100755 tests/block/022
 create mode 100644 tests/block/022.out

Thanks,
Dennis
