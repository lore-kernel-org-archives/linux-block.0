Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC62C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B254021582
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 12:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfLRM1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:27:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:58036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfLRM1k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 07:27:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3EA8B164;
        Wed, 18 Dec 2019 12:27:38 +0000 (UTC)
Subject: Re: [PATCH v12 2/5] xenbus/backend: Protect xenbus callback with lock
To:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sj38.park@gmail.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191218104232.9606-1-sjpark@amazon.com>
 <20191218104232.9606-3-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <af02058a-fa76-5eb5-5c2b-60555273bac2@suse.com>
Date:   Wed, 18 Dec 2019 13:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191218104232.9606-3-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.12.19 11:42, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> 'reclaim_memory' callback can race with a driver code as this callback
> will be called from any memory pressure detected context.  To deal with
> the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> 'reclaim_memory' callback is called, the lock of the device which passed
> to the callback as its argument is locked.  Thus, drivers registering
> their 'reclaim_memory' callback should protect the data that might race
> with the callback with the lock by themselves.

Any reason you don't take the lock around the .probe() and .remove()
calls of the backend (xenbus_dev_probe() and xenbus_dev_remove())? This
would eliminate the need to do that in each backend instead.


Juergen
