Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3948C77B7D
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 01:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjESBux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 21:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESBuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 21:50:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19141B1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:50:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae65e44536so2872655ad.0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684461050; x=1687053050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpI/H0Qbl9cfe0qC0Xe8mBwHLwTj6EWlyHepYD9LNCg=;
        b=haBqRvqgwvG0Lekgc/RTrWzmT+3x+E9EXAvrNdhuTAfex0+Y05FkN9TsVTf38z2jfc
         CMRGSgymlUfwbITzhg/NJ5iQIBXB5BBYty2iRPAtfYj98udVoIlJulFUZdJQRtoXkrh0
         WQh/dvA16dzuUsEiewBjdkpPZvxWKRTWWafqPCTFBFMJfRqXbbwqXtyavsB/sWCCqr6W
         eQHaZ3gUKDS/dCY85QGLssOh957Ihf57mdGy3M2t/ssakVTXPuwBV9feGE+8MVEiG78e
         jzhl+h9JnfZALUrlVv1zfsRdH3GKKFwMKpIu8qXB34iymnIGC3vORX2GgAv7ORyNFPVK
         ABfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684461050; x=1687053050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpI/H0Qbl9cfe0qC0Xe8mBwHLwTj6EWlyHepYD9LNCg=;
        b=Ngp1B6bTf4anvd9bALDiFBE5by/rqlWW6ZfDU6Y/KY6o5M0sxvduQP20RXALaw+ivb
         iSfs8djqxdXppSY3CBpvpHPKwuV6B1LR7JFYVdqiGBoGr2aG9O/yeNf1MPwVw48Wiukx
         TnLMrwH14YQB7gq3GEP1YQIU8avOVmFqeNKvt2LY6DwpXTs2t19R+2WJmeIQsHJmzUut
         skwssZI6NSOKfh27Pi22WvMrDja1rafsQxYsO5sJHngN+MNyTrQSBRYLkksuSO7fxmPK
         8fNOwDrtDtwJDhBzfjrjhnFuyMBNvvUEtcS/xW9J1q9rvLJ7U/mVxkEY5zu3qdsIRzRR
         Yp8A==
X-Gm-Message-State: AC+VfDypxd7wCTKfwseo+A2qAmJadIzujVJz5hKuXOrMCsaKRidk8Y0s
        gKuuTKicLVs0HJp2Itzf961+rg==
X-Google-Smtp-Source: ACHHUZ6zZG4XYts3nFyl+YKl6u2WHu6VtaTXJhnXpmffnMh5TgYQQnjC33hmQ/0tnJnIs+fQ5or/pw==
X-Received: by 2002:a17:903:2341:b0:1ac:3ebc:af0c with SMTP id c1-20020a170903234100b001ac3ebcaf0cmr1214611plh.1.1684461050562;
        Thu, 18 May 2023 18:50:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902a51300b001a1d41d1b8asm2096025plq.194.2023.05.18.18.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:50:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
Subject: Re: [PATCH v6 00/11] mq-deadline: Improve support for zoned block
 devices
Message-Id: <168446104954.145266.18321764098747563048.b4-ty@kernel.dk>
Date:   Thu, 18 May 2023 19:50:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 17 May 2023 10:42:18 -0700, Bart Van Assche wrote:
> This patch series improves support for zoned block devices in the mq-deadline
> scheduler by preserving the order of requeued writes (REQ_OP_WRITE and
> REQ_OP_WRITE_ZEROES).
> 
> Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[01/11] block: mq-deadline: Add a word in a source code comment
        commit: 45b46b6f157169b452772430566772506e25687a
[02/11] block: Simplify blk_req_needs_zone_write_lock()
        commit: 4f51644ccff1e4bf159e86da3d9695a1a33ca231
[03/11] block: Fix the type of the second bdev_op_is_zoned_write() argument
        commit: 3ddbe2a7e0d4a155a805f69c906c9beed30d4cc4
[04/11] block: Introduce op_needs_zoned_write_locking()
        commit: a370798201b537f78288e4ef5e0f7fc70889e7ee
[05/11] block: Introduce blk_rq_is_seq_zoned_write()
        commit: 19821fee3ed42e5b294e95814892d0ad6a9890c9
[06/11] block: mq-deadline: Clean up deadline_check_fifo()
        commit: e0d85cde95bba7d40caa3bf9bc41ee810f0e96df
[07/11] block: mq-deadline: Simplify deadline_skip_seq_writes()
        commit: 3b463cbea908a9c8d4b9eda09765070506864cbe
[08/11] block: mq-deadline: Reduce lock contention
        commit: b2097bd24b438d49d82a5c317be4dc74b626236a
[09/11] block: mq-deadline: Track the dispatch position
        commit: 83c46ed675579fe84354bd07b0d81b525a2b1ebb
[10/11] block: mq-deadline: Handle requeued requests correctly
        commit: 0effb390c4bac1a484f0ca6ad3f1d183fcde882b
[11/11] block: mq-deadline: Fix handling of at-head zoned writes
        commit: a036e698c231ba884daa37196be3ac6c6dce1d75

Best regards,
-- 
Jens Axboe



