Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A90C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7245D2089E
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfEAPse (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 11:48:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33303 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfEAPse (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 11:48:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so7512938plp.0
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 08:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97aP0Etzlazb0dzzNxQLRd8FHBoDH6Ttx040iXulh3w=;
        b=cQSVFD+rVXs/x3GzGSRC0HsTwDEh2pu1ttlQcqYLTvLV1UVximPvSBfUM7l0nwXcFH
         DswB9hmIGs0hHUwfOGE8qEOJHrqUI7ELILDbuAaOnRIhWtuoUvWRNjiKEz8RvIzPgWcX
         Hqzo4REBZNNkzrRpHvkX2NOmxd1KfIPb9/t7mqg5GsFSjcZ7cvq4MfifA1BYjvMtUz68
         u4hlowlak7qm14OEcAgBf2dbNZshUZcLZGnStM1Ifiin4PJiYEYXAXAxVnXUzY7Y75o+
         1g76P/oFnns2kAH6ZzEGowc+267CMp5/vAN2eDxY2MQ/0WEkvgThpAENPaBFTitPvbRs
         j7Sg==
X-Gm-Message-State: APjAAAX3z0GBkpDW8uhwYGvoJI675A97zGTI6NsLGB6Vf05HZTNPGzgr
        hHoh+8kIWz2ydk5pkJI/spTndy5+
X-Google-Smtp-Source: APXvYqwpr1iHuL50FW7P3AF4gEUf1GqKdR/COu7XWPM287qykxrJsgaBjS22Zq3uUi9HLZdB2MagLg==
X-Received: by 2002:a17:902:b08c:: with SMTP id p12mr21013887plr.214.1556725713658;
        Wed, 01 May 2019 08:48:33 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l2sm46192420pgl.2.2019.05.01.08.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 08:48:32 -0700 (PDT)
Message-ID: <1556725711.19047.10.camel@acm.org>
Subject: Re: [RFC PATCH 01/18] blktrace: increase the size of action mask
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Date:   Wed, 01 May 2019 08:48:31 -0700
In-Reply-To: <20190501042831.5313-2-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
         <20190501042831.5313-2-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-30 at 21:28 -0700, Chaitanya Kulkarni wrote:
+AD4 -+ACM-define BLKTRACESETUP32 +AF8-IOWR(0x12, 115, struct compat+AF8-blk+AF8-user+AF8-trace+AF8-setup)
+AD4 +-
+AD4 +-/+ACo XXX: temp work around for RFC +ACo-/
+AD4 +-+ACM-define BLKTRACESETUP32 +AF8-IOWR(0x13, 115, struct compat+AF8-blk+AF8-user+AF8-trace+AF8-setup)

This change breaks user space so this change is not acceptable. I think you
want to introduce a new ioctl instead of modifying an existing ioctl.
Additionally, have you considered to split the blktrace+AF8-api.h header file
into two header files: one with kernel-internal definitions and a second one
with definitions that are shared with user space (include/uapi/...)?

Thanks,

Bart.
