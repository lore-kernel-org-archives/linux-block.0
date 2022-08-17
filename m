Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB55C25B08
	for <linux-block@archiver.kernel.org>; Wed, 17 Aug 2022 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiHQRMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiHQRMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 13:12:16 -0400
X-Greylist: delayed 26357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 10:12:14 PDT
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B89642F3
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 10:12:14 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd78be.dip0.t-ipconnect.de [93.221.120.190])
        by mail.itouring.de (Postfix) with ESMTPSA id 9ABF0103762
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 19:12:12 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 5372CF01600
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 19:12:12 +0200 (CEST)
To:     linux-block <linux-block@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: wbt_lat_usec still set despite wbt disabled by BFQ
Organization: Applied Asynchrony, Inc.
Message-ID: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
Date:   Wed, 17 Aug 2022 19:12:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


I just noticed that my device configured with BFQ still shows wbt_lat_usec
as configured, despite the fact that BFQ disables WBT in bfq_init_queue [1]:

$cat /sys/block/sdc/queue/scheduler
mq-deadline [bfq] none
$cat /sys/block/sdc/queue/wbt_lat_usec
75000

Is this supposed to be 0 (since it's disabled) or is sysfs confused?

Thanks,
Holger

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/bfq-iosched.c#n7195

