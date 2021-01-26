Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCAC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA45230FE
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbhAZRO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:14:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:35800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390989AbhAZJZB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 04:25:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E458AC4F;
        Tue, 26 Jan 2021 09:24:19 +0000 (UTC)
Date:   Tue, 26 Jan 2021 10:24:16 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     tyhicks@linux.microsoft.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, jmorris@namei.org, lukas.bulwahn@gmail.com,
        hch@lst.de, ming.lei@redhat.com, mzxreary@0pointer.de,
        mcgrof@kernel.org, zhengbin13@huawei.com, maco@android.com,
        colin.king@canonical.com, evgreen@chromium.org
Subject: Re: [PATCH v3 1/1] loop: scale loop device by introducing per device
 lock
Message-ID: <YA/fwFU+Wg6+jr85@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
 <20210125201156.1330164-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125201156.1330164-2-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

> Currently, loop device has only one global lock:
> loop_ctl_mutex.

> This becomes hot in scenarios where many loop devices are used.

> Scale it by introducing per-device lock: lo_mutex that protects the
> fields in struct loop_device. Keep loop_ctl_mutex to protect global
> data such as loop_index_idr, loop_lookup, loop_add.

> Lock ordering: loop_ctl_mutex > lo_mutex.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
