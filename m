Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C46C43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 11:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE7E24683
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 11:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLTLmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:42:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:45494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfLTLmS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 06:42:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3F17ACA3;
        Fri, 20 Dec 2019 11:42:16 +0000 (UTC)
Subject: Re: [PATCH v13 2/5] xenbus/backend: Protect xenbus callback with lock
To:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sj38.park@gmail.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191218183718.31719-1-sjpark@amazon.com>
 <20191218183718.31719-3-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <08256095-3b19-8041-9ceb-e9caa77ed4c5@suse.com>
Date:   Fri, 20 Dec 2019 12:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191218183718.31719-3-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.12.19 19:37, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> A driver's 'reclaim_memory' callback can race with 'probe' or 'remove'
> because it will be called whenever memory pressure is detected.  To
> avoid such race, this commit embeds a spinlock in each 'xenbus_device'
> and make 'xenbus' to hold the lock while the corresponded callbacks are
> running.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
