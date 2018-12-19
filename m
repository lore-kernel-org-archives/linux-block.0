Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ADEC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE7D2086C
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeLSXHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:07:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43574 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbeLSXHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 18:07:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so10520321pfk.10;
        Wed, 19 Dec 2018 15:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lq6DkM6xP0nzuJoE/ca3xsziMa+6JF4yIqVxAmDi100=;
        b=EZrURaIOIjPCCLitGGiZzy++yRHqtpFzOdz8j4pzjoAOcPQUwV+3hGDmjjMm0BKrMd
         /xd6I4OVnqxZJpzU396ZMhbW/oUjNiseiCrjBZKTAHnZqjJpyx/XrpxC5+Prn4WVHzAN
         flOfRm1j8DWfm7ZgKSNsYEfXjoAvptj1c8bz/fTArZ1hFwRSuzISK4L24Wlkk+et/sbQ
         Cjpg22DnAvI5xTXZfb/6BiWJNbVIw5uEYyO7eeTtWgf8UDT1jxWX+O8bUiyy9gDJXCi6
         AaQIkNqrgq15l1L0QlSNvhfvTJP3/he5U7MlFvGuHcRohHM1tnqlST9ma7uLqIE98eaK
         9iUg==
X-Gm-Message-State: AA+aEWYoeI+i+OmBRonAYVkvLM9TCbiSKe2uT96G7FaFAGGcAfDRr+xA
        Cv6OiVSVqfuQRME+ZntFBDNttFtHjqw=
X-Google-Smtp-Source: AFSGD/VSrCHtV6NoIzWbIQXM1ia2+Uq3kg1i7pAQ8285JhCvLT0Cm93ZCdUu5KNK1fB+wnHdSJJ5XA==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr22447157pfb.160.1545260834051;
        Wed, 19 Dec 2018 15:07:14 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id y6sm38499757pfd.104.2018.12.19.15.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 15:07:13 -0800 (PST)
Message-ID: <1545260831.185366.484.camel@acm.org>
Subject: Re: [PATCH] bsg: deprecate BIDI support in bsg
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Wed, 19 Dec 2018 15:07:11 -0800
In-Reply-To: <20181219143934.3910-1-hch@lst.de>
References: <20181219143934.3910-1-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-19 at 15:39 +-0100, Christoph Hellwig wrote:
+AD4 Besides the OSD command set that never got traction, the only SCSI
+AD4 command using bidirectional buffers is XDWRITEREAD in the 10 and 32
+AD4 byte variants, which is extremely esoteric.  It probably doesn't make
+AD4 sense to keep the support code around just for that, so start
+AD4 deprecating the support.

You may want to add to the patch description that the XDWRITEREAD command
has been removed from the latest version of SBC-4 (SBC4r15).

Bart.
