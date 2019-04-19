Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC4C282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9BC20869
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 20:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp1iU2d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfDSUfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:35:51 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45168 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfDSUfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 16:35:51 -0400
Received: by mail-pl1-f173.google.com with SMTP id bf11so3045493plb.12
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2019 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPi5LhrK9g7xvx6+mwGpbKf5P625PAJk/QWxhSdBCNg=;
        b=rp1iU2d4c5zG0sApkNhMqDyC9hXel0pZWKGiYv9HifwdRRy5NWccfxeEr5JgGMCpyj
         X2VCkdgUqBDdtPwk8HRaGRL4KPwsJaiBkXKPdn+GZL5tjy4f/IAEGlJruk66Bj7uwbX4
         9x+7ioQi7k7hqwYk2yNP3U1Zo7s1GeyXa6YPjkopVbzOrZW4XCq/3f/uHIRMkvJuDQRY
         mkDWqYX5GXlJ9rqivNI/c4SynqoS11C/ALAq8Lh60TpZgmvpbxi6gDCUfVWJho2k1gPe
         1JrUvF+CtDwFLy5mzAw3RLM4iUKpqptzPWdEbWWSZ0/HxeigONfXzFAVJipKMW6n2aCA
         6zVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPi5LhrK9g7xvx6+mwGpbKf5P625PAJk/QWxhSdBCNg=;
        b=IqfTmwTKx/U41n8j1tAqmSRV6cNMKoRiitduyVRVZ7Y/9XqyKh7CbncmJC+SB5Xap7
         9M8v1g+BU2mUc7C5/Z+fr4g/MdQTxl2WoEiYmMfbRpByriKqrAMJBWhs9iDJrShCxk9g
         nhsp1pAmaPJb0gbfnNssxE/s4f8uBrLgwLDh2NBfq5NEALR28sYP8TWBSgBObAR+24aY
         /sctqzeICfOQh3AW0MUpjNJrNsPf+rR1WlLQr0HTukKW4jcUC/uS5FlwBFNios0DdFQx
         AXRoWQi0odTTfPrLslVLOvO/3otqPahTa1kg+kfqiTA5P8ZI9i+O9Hdx1qRdN+0HJ97g
         LqNQ==
X-Gm-Message-State: APjAAAUC184IQVjqs0+VKyPEZrE5kTxIPc3aNViE1O0aq9lOzLU2c0TN
        3WfTO7ftR6Dmy8uNpckXzZMLSX7KtYfAjA==
X-Google-Smtp-Source: APXvYqwRtZ9hDiSUHcAkzRQBphXv38nILgMcygrPyjT3aMWz5HDFgN6opQ1VRyRInv5CXlq/l7U6SQ==
X-Received: by 2002:a17:902:20c9:: with SMTP id v9mr5794978plg.239.1555706150420;
        Fri, 19 Apr 2019 13:35:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5cfc])
        by smtp.gmail.com with ESMTPSA id h189sm11598937pfc.125.2019.04.19.13.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 13:35:49 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 0/1] blk-mq error handling memory leak
Date:   Fri, 19 Apr 2019 16:35:43 -0400
Message-Id: <20190419203544.11725-1-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Hi,

Digging through this, I don't see the callback data getting freed in
case of errors in blk_mq_init_allocated_queue() unless I am missing
some obscure path that cleans it up later?

Cheers,
Jes

Jes Sorensen (1):
  blk-mq: Fix memory leak in error handling

 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

