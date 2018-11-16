Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33621C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C0121019
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C0121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeKPKrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:47:04 -0500
Received: from 109-183-129-149.customers.tmcz.cz ([109.183.129.149]:46228 "EHLO
        leontynka.twibright.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 05:47:04 -0500
Received: from debian.vm ([192.168.192.2])
        by leontynka.twibright.com with smtp (Exim 4.89)
        (envelope-from <mpatocka@redhat.com>)
        id 1gNRdB-0001CS-Vp; Fri, 16 Nov 2018 01:05:06 +0100
Received: by debian.vm (sSMTP sendmail emulation); Fri, 16 Nov 2018 01:05:05 +0100
Message-Id: <20181116000416.992905103@debian.vm>
User-Agent: quilt/0.65
Date:   Fri, 16 Nov 2018 01:04:16 +0100
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Mike Snitzer <msnitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/3] device mapper percpu counter patches
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

These are the device mapper percpu counter patches.
They are on the top of
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-4.21

Mikulas

