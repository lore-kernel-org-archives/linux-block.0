Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784BC00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 12:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiHLMmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiHLMmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 08:42:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781CACA07
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 05:42:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p18so656033plr.8
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=gREmAxN8l8RxNVEKTsm8QkZuwPXI/lgjrFZm1KwVciI=;
        b=bjpA1ThKzQJ4OcV1ZdfRYLTWMBxY63BD6LTsegwran4BATMStJ9qkdhLiwfXeTVLv7
         lvJbD80YD1xrpeMeyhsEXMA9Wk95PWMyq/lPaHobw2gO8m4SRtZ0UEzzSz0IjQ+IQpRd
         3+m3uwHNpzuIDTJaPTWnbkYFmCMtinOXZbkeWbykaF067OeAUg+giocGTTQhVD2Y5JzQ
         7KaysSI+i8zQwtzOw9JzHeiZYEn1lFouhsyEztAbFG68zg0uhylP3xgEZM1qHYDtR72n
         0rX39lkRQ9ANuL8hO1ol8fXQGKbrMISMzhjUlrCJ//yciPHDh6oyiPFhmmzgEwyTYDn4
         Ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gREmAxN8l8RxNVEKTsm8QkZuwPXI/lgjrFZm1KwVciI=;
        b=IMvDGKr1gMAD3mwji0ghl8Ii/xll55XPqCoB56c6EWXTVA6rSqb+jerAhshk204d7E
         /eeLkBhv0GHOwbRNsP8UrX3K9Fe9ZX/pp6dFu+BjIGhM3dfSL+WWu75ByerilbeZ8gAc
         QnSsinvDW6I0B/1s7XvIc32nU2lZdFQHmBSiCZYmi4/uWPEJeky1s/gjATkyLyx2s4Dd
         CvUd87tQMkCJEaZqTVS8qBMByV4MsVIaleuwtjmG129rYqdGRQvejl8rXRnE//XJTUJR
         DQ9A09jznL8ChX4QVQBlwHFhlLeRIutNb4mNz74Qg790gDHw6c9zO2SAutsO4zjl1pZM
         bQig==
X-Gm-Message-State: ACgBeo12zPw0zTwM+/efKfEyQLdUlUjdve+5acUpzHJ9sHJr79dDU7c9
        R6B0DzkOzCgaTOH1i8eF62ha8/QhBpJ/ng==
X-Google-Smtp-Source: AA6agR6DorRRxtWFW9ndhm9eJlKetkO2UVcyM8ashb/2RipaEBOE4pKOtR24EoyB/rA2kGchKIfjJg==
X-Received: by 2002:a17:902:9005:b0:16d:1ffd:cf56 with SMTP id a5-20020a170902900500b0016d1ffdcf56mr3737918plp.119.1660308132956;
        Fri, 12 Aug 2022 05:42:12 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001708b189c4asm1623980plg.137.2022.08.12.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 05:42:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     rafaelmendsr@gmail.com, hare@suse.de
Cc:     linux-block@vger.kernel.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org,
        syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com
In-Reply-To: <20220811232338.254673-1-rafaelmendsr@gmail.com>
References: <20220811232338.254673-1-rafaelmendsr@gmail.com>
Subject: Re: [PATCH] block: Do not call blk_put_queue() if gendisk allocation fails
Message-Id: <166030813180.891934.12259200339444300073.b4-ty@kernel.dk>
Date:   Fri, 12 Aug 2022 06:42:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 11 Aug 2022 20:23:37 -0300, Rafael Mendonca wrote:
> Commit 6f8191fdf41d ("block: simplify disk shutdown") removed the call
> to blk_get_queue() during gendisk allocation but missed to remove the
> corresponding cleanup code blk_put_queue() for it. Thus, if the gendisk
> allocation fails, the request_queue refcount gets decremented and
> reaches 0, causing blk_mq_release() to be called with a hctx still
> alive. That triggers a WARNING report, as found by syzkaller:
> 
> [...]

Applied, thanks!

[1/1] block: Do not call blk_put_queue() if gendisk allocation fails
      commit: aa0c680c3aa96a5f9f160d90dd95402ad578e2b0

Best regards,
-- 
Jens Axboe


