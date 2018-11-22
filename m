Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE83C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 13:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1065D20672
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 13:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Sq3IdjXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1065D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391419AbeKWA0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:26:37 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34704 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbeKWA0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 19:26:37 -0500
Received: by mail-ed1-f44.google.com with SMTP id b3so7791477ede.1
        for <linux-block@vger.kernel.org>; Thu, 22 Nov 2018 05:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4K0RfKZuTEFq4ISG/bDV5lfLZONGf3gcd9HKJharY88=;
        b=Sq3IdjXRCPt0sAu0x9Qywv2Zl9BB9pbCL6wQZMDXhKGx4ge7VWacCD/UPkD5neeSE4
         WvuOWzxNJkqyW6ZYvBcf8xJRzJ6NKVs87Lp38ymSN2EB4YOB/TpT8pi8nQFEkdzwt+Hq
         wrCvasg1+EYe23AIZlu5eANa4r+MSrDuEPFIlZ59N+wK4wm5fDVpbp/0v+FH9l6BNQ6w
         CGIGa/uqwDhoRmNeXEWVZu6/NMssYN0Ci8aliwVgDA1c3TqgKNya7qB7n6dd7GZAfLQS
         +UZ0jJbcWGb572hwsW3DP5skKixSXwLQc7GsKdsMS0ojLA8Emo3yVW8lrchVMFoeEABE
         wWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4K0RfKZuTEFq4ISG/bDV5lfLZONGf3gcd9HKJharY88=;
        b=amdSSUH8Xq7+xsFhCPJ14rVjDKCX6GyX+X1C8+zO1hoWAm19vjLxN+srdkN8LuI9QY
         BFvkXtlGKwup3oxg6gjOu9BdiV4fSUqYS/ALyge6jZbso4Cj9CIV8i7LgIZ/4p3o+ckY
         zJgxB1NmoNJZJfAX8sbZWvfJcP527OMisuaMWzNF6REfl1HpPrP74a1Gu9QVJgGO2Acn
         DEPPBl0PF7YwYCDThmyyhbj7/qzFZJbJ7vP8yLv+XbWj/X3cbohr/pn+UVbNCf9kzq/3
         6gPVn8jYrgXMUrKDivd55yK0AQCagNXV/s0Ml+cNEd04xzqpVaRB9IUY/61HuuaEWTXY
         wCOA==
X-Gm-Message-State: AA+aEWYyxcZuVmIC7cX/SycHlC+cBclbSWs+72M04XkRkfWQjcAUK5Hj
        6YKH5Gpm+pVcEmGST9G9J1QEHdS3CGo=
X-Google-Smtp-Source: AFSGD/Wp73W8+SG2GkrMDMqINzOAEX1Wb6LsP31NMRoAaBuYWn+uIJkNfNeVFtWZcuTGIrDPXWfBng==
X-Received: by 2002:a50:ac19:: with SMTP id v25mr9578232edc.218.1542894430628;
        Thu, 22 Nov 2018 05:47:10 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id s6-v6sm14246263edh.89.2018.11.22.05.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Nov 2018 05:47:10 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: lightnvm: pblk: avoid ref warning on cache creation
Date:   Thu, 22 Nov 2018 14:46:49 +0100
Message-Id: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matias,

Can you pick this up for 4.20? Even though it is not an error per se, it
does trigger an ugly false positive warning when CONFIG_REFCOUNT_FULL is
set.

Thanks,
Javier

Javier González (1):
  lightnvm: pblk: avoid ref warning on cache creation

 drivers/lightnvm/pblk-init.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.7.4

