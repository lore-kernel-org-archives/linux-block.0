Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6BC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B7B20830
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 11:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="NyaZyS6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfIML5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 07:57:40 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:45602 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729614AbfIML5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 07:57:40 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id 4DA535E2D0;
        Fri, 13 Sep 2019 13:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1568375854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Z9xg7xgKMrrqkn/e7HBj143ShGOLGVGxp4yGuiyNvE=;
        b=NyaZyS6BRIR158K3vkGQqeLPP4bt62Pw2eCNu3X4J3ZnEpAheVgmemd073gxF0j/3K5dtu
        njJdWNlmYj79b81C719SCxq1zZj05wtyg9QixyOHYs8DZKkiSmRbWlMFkzz3WYzqW+gzpy
        KyppMWXgFaRFZOWQzUwu+Q26yIw/ypwf7zcAOf7ZJwgoUu/a2O3K2YQPEVj81+FzAj5UlC
        pJtbu6+LeTnPvlZw+6h753H9TB8s+OeywNeLYnXGQ5JXxs4VLUqUMa5xFeJm6bwuIQ9oDk
        OjjW4iKf1dp/36AHg3ThQNhbYoDY7rOWjHV6E2ctTUU4UkUD+L4liSbHyujPoA==
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file
 format driver
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190823225619.15530-1-development@manuel-bentele.de>
 <20190912022359.GD2731@ming.t460p>
From:   Manuel Bentele <development@manuel-bentele.de>
Message-ID: <dc9e1697-ee11-622a-0f48-ebd65ff2a4e7@manuel-bentele.de>
Date:   Fri, 13 Sep 2019 13:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912022359.GD2731@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1568375854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Z9xg7xgKMrrqkn/e7HBj143ShGOLGVGxp4yGuiyNvE=;
        b=S7hqJ361nOmqAHcG7EssBpGQfVaFbJ2xAt6dvWX5ZyNEdhaozNG4TbqQk9tm5ODgFRPPsh
        KnNorfSOhJE46aQKBZQk5Gqs/jv/A5LqSEtzWy8kP8B9b/0aVMOj2BBUcUpbuR6d/skpFg
        qZpv6Qv3Zv7b9/rXkigtg14DvCkhcSRoxaT56blnasansRBc9BI4D3aOxy2j1ZUGjwLTc7
        ZyVV/SrjaIGCq1ISW7t+XuJ9kgpRH+PyIXCD1ggjr5WSrusfPS+biTpFEiSgaD2sRthYNv
        UA4cy/OyFT35ipjAUHctqvU9LntSCJMZV57zXaIT0kGqeTihP5MaKJ+v3UxdrQ==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1568375854; a=rsa-sha256;
        cv=none;
        b=W29FVaStSGoxCgg2vd+6GTHl1coDQgZtNMvS1YWOsqoH74f61CxypNNtzLmhy2Bk1VITpw
        QSD1azVRaeXqGR4cm+2Z4DIHAdYUcmoIE+Rz2T0nwdYaaW4qglUoFacqL7Eb+YHIqeAO6t
        XI0bXsnAsMwatMfjF0y6hRYNnuMXIoc9FgbE/GwurxYVlg5PR7W87ad2D33O6tbA1kYZYI
        Hac/uifVcZs/xug5rzabQzLT3n0UMwKQsDqa4FM9fOQWyk7jpbjviKrAIhoRJJ+9CdOCDY
        jvZLRkq7C3zJ6+whJ4TVYQ5Mq0m9q4tnnI1gcELQm9mAUucyzbe2pif36hzeoQ==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 9/12/19 4:24 AM, Ming Lei wrote:
> On Sat, Aug 24, 2019 at 12:56:14AM +0200, development@manuel-bentele.de wrote:
>> From: Manuel Bentele <development@manuel-bentele.de>
>>
>> Hi
>>
>> Regarding to the following discussion [1] on the mailing list I show you 
>> the result of my work as announced at the end of the discussion [2].
>>
>> The discussion was about the project topic of how to implement the 
>> reading/writing of QCOW2 in the kernel. The project focuses on an read-only 
>> in-kernel QCOW2 implementation to increase the read/write performance 
>> and tries to avoid nbd. Furthermore, the project is part of a project 
>> series to develop a in-kernel network boot infrastructure that has no need 
> I'd suggest you to share more details about this use case first:
>
> 1) what is the in-kernel network boot infrastructure? which functions
> does it provide for user?

Some time ago, I started to describe the setup a little bit in [1]. Now
I want to extend the description:

The boot infrastructure is used in the university environment and
quarrels with network-related limitations. Step-by-step, the network
hardware is renewed and improved, but there are still many university
branches which are spread all over the city and connected by poor uplink
connections. Sometimes there exist cases where 15 until 20 desktop
computers have to share only 1 gigabit uplink. To accelerate the network
boot, the idea came up to use the QCOW2 file format and its compression
feature for the image content. Tests have shown, that the usage of
compression is already measurable at gigabit uplinks and clearly
noticeable at 100 megabit uplinks.

The network boot infrastructure is based on a classical PXE network boot
to load the Linux kernel and the initramfs. In the initramfs, the
compressed QCOW2 image is fetched via nfs or cifs or something else. The
fetched QCOW2 image is now decompressed and read in the kernel. Compared
to a decompression and read in the user space, like qemu-nbd does, this
approach does not need any user space process, is faster and avoids
switchroot problems.

> 2) how does the in kernel QCOW2 interacts with in-kernel network boot
> infrastructure?

The in-kernel QCOW2 implementation uses the fetched QCOW2 image and
exposes it as block device.

Therefore, my implementation extends the loop device module by a general
file format subsystem to implement various file format drivers including
a driver for the QCOW2 and RAW file format. The configuration utility
losetup is used to set up a loop device and specify the file format
driver to use.

> 3) most important thing, what are the exact steps for one user to use
> the in-kernel network boot infrastructure and in-kernel QCOW2?

To achieve a running system one have to complete the following items:

  * Set up a PXE boot server and configure client computers to boot from
    the network
  * Build a Linux kernel for the network boot with built-in QCOW2
    implementation
  * Prepare the initramfs for the network boot. Use a network file
    system or copy tool to fetch the compressed QCOW2 image.
  * Create a compressed QCOW2 image that contains a complete environment
    for the user to work with after a successful network boot
  * Set up the reading of the fetched QCOW2 image using the in-kernel
    QCOW2 implementation and mount the file systems located in the QCOW2
    image.
  * Perform a switchroot to change into the mounted environment of the
    QCOW2 image.


Thanks for your help.

Regards,
Manuel

[1] https://www.spinics.net/lists/linux-block/msg39565.html

