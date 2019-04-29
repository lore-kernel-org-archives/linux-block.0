Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A2C43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BE92087B
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfD2SEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:04:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35446 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 14:04:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so5454478plp.2
        for <linux-block@vger.kernel.org>; Mon, 29 Apr 2019 11:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFE02sFeAUQCKTOBLpVSCOCSjZU6ktmDtPm6wqRAMtY=;
        b=bfDieX7A0j3k24VZWe/I+hkqpwcPJYa/2qFDQdF1d/cLGblZj0STB2xtkhrZORA6Ob
         H5t+rRJnbBpe+TqTUT3ldPGetEfIzPvle4OAfyxneEjX1jLQBqZL5zQO3AxPj6ixIYPa
         RKbUc+rpmHcczIH3rU5OZfnl/LUHii4juV0c45SP2gm2B5sCdHyPByiPSQmS37KVKWjM
         7TW4sfacBb8uH3h2kDP+13xq6v43SSqRCxb/oHd45uCER5McD+nLAV3DGpVqkGYgj5x7
         MFm1FE0m6FgaVcW31M/Jja5+4DJ1e4822ZWxN92BIWY4ei5gMLfD1SdtA7NzjunGVhEK
         bsCQ==
X-Gm-Message-State: APjAAAVqQEAB7bjSt/Im0ns8gQkHmUnDFY/pWsbz66gvLen9YuT8Vhhs
        6Hgn4gRnj8XoIOI+AHRzANI=
X-Google-Smtp-Source: APXvYqwqQf2tV3/q7xu4rTuT0bB+6DXN5KJVlewuQCS5hRteEUHCZw3+ujva9234bmERfw+9rS+dyw==
X-Received: by 2002:a17:902:e785:: with SMTP id cp5mr3273795plb.43.1556561074247;
        Mon, 29 Apr 2019 11:04:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id w189sm66275827pfw.147.2019.04.29.11.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:04:33 -0700 (PDT)
Message-ID: <1556561072.161891.159.camel@acm.org>
Subject: Re: [PATCH v4] blk-mq: fix hang caused by freeze/unfreeze sequence
From:   Bart Van Assche <bvanassche@acm.org>
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hare@suse.com, ming.lei@redhat.com,
        hch@lst.de, martin.petersen@oracle.com, jinpuwang@gmail.com,
        rpenyaev@suse.de
Date:   Mon, 29 Apr 2019 11:04:32 -0700
In-Reply-To: <20190425102846.28911-1-bob.liu@oracle.com>
References: <20190425102846.28911-1-bob.liu@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-25 at 03:28 -0700, Bob Liu wrote:
+AD4 The following is a description of a hang in blk+AF8-mq+AF8-freeze+AF8-queue+AF8-wait().
+AD4 The hang happens on attempting to freeze a queue while another task does
+AD4 queue unfreeze.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


