Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5BEB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjFTNTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjFTNSz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:55 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAEE1BEB
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:18:27 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1a9fe53e225so725699fac.1
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267103; x=1689859103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dINbX+nct4bRAIdqF8UsZ1EWAtvyrgtNpE239fRJIb0=;
        b=mOFAYbdHOZ53ew0pEEuMFL6nMjhI0STXUf46y3HKgnSz2uYJALwgALZA/BTx4i/YGm
         PZkB0pcB+N7MBP58zYpX6KHYxKj/Vx1cB3h0MF6xGdcPCZFF4oiLD7BLyn5tXsCFDBJm
         GJKSQT9hMnr6P8yqjsWTAv3OxB4QfKYxyDft4HsH9njWcGLThND3hZqaIaUBGPh6/zdJ
         /Lt1y3sXrWdTm0diIBmenpuHTNFxmV92LI4eXBz7kweh8NefKEwhiNUCngL5Vzu5NQ4D
         XU4ZgRxaBxpym/wcpyLTPIWkXyiNW5rcYqv+cCDnuf5P6YrBHcu6KG/ogU0XIqXJCMGh
         HA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267103; x=1689859103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dINbX+nct4bRAIdqF8UsZ1EWAtvyrgtNpE239fRJIb0=;
        b=Uk8QMiuLzjRxyEq+vaYhEZFQ5xuMIh7Q1kxBJuVylu/7pM6RrnfA0d0NYSP6XjDtDb
         D0AjiO/4nOVrjJEGz7gKeL8kPd+mwBpl93XvISpsSh7+3xzuDTat933mYqQoj6wCocIe
         mgHoYoGPTybQPDLNV3t5xF+tLt9qb5kWuDSpd3+0ybocPTn1OokV+nkmbMTqBOwjWWwN
         nOUeDHIdpNFvW2hUc5lqy6dlG6KWHJMcxK64Dx52g8q2G6ZclqRkzYio4N7ZOT+5Ze+r
         dGFa4RElbdHyLvMXmIn+aMec8qkQplf91lwvlbGhsscEA7/HsjnfcVxDTGx+lgLOKfZD
         G/dw==
X-Gm-Message-State: AC+VfDzTZmhKdDb0dfynWNCdVyY3oEx/a8NTv34EpyWnIzUh/Zf5WNLS
        nOKidsvCk6U9pfUawxvKOrSDWkwTsnuh2rtv2S8=
X-Google-Smtp-Source: ACHHUZ5HfHw1X0rhd5eNr37aF+Wj5i6f+oB7fLTJxwwiiTSAzhukoIn+Ckh9uudP6rg91m43Og1iag==
X-Received: by 2002:a05:6870:6107:b0:199:cae6:3147 with SMTP id s7-20020a056870610700b00199cae63147mr10505407oae.4.1687267102922;
        Tue, 20 Jun 2023 06:18:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r23-20020a634417000000b005143448896csm1399994pga.58.2023.06.20.06.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20230620043536.707249-1-hch@lst.de>
References: <20230620043536.707249-1-hch@lst.de>
Subject: Re: [PATCH] block: document the holder argument to
 blkdev_get_by_path
Message-Id: <168726710159.3595534.12075619248775419305.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 07:18:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 20 Jun 2023 06:35:36 +0200, Christoph Hellwig wrote:
> 


Applied, thanks!

[1/1] block: document the holder argument to blkdev_get_by_path
      commit: e89e001f24bf7bc558d9ebccb97fd559443021da

Best regards,
-- 
Jens Axboe



