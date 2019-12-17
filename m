Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF56C2D0D1
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14421835
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfLQQPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:15:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:49216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbfLQQPP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:15:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 230D6AF43;
        Tue, 17 Dec 2019 16:15:14 +0000 (UTC)
Subject: Re: [PATCH v11 4/6] xen/blkback: Protect 'reclaim_memory()' with
 'reclaim_lock'
To:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sj38.park@gmail.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191217160748.693-1-sjpark@amazon.com>
 <20191217160748.693-5-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <027a402d-029a-e6c4-9f07-98728a161f22@suse.com>
Date:   Tue, 17 Dec 2019 17:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217160748.693-5-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.12.19 17:07, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> The 'reclaim_memory()' callback of blkback could race with
> 'xen_blkbk_probe()' and 'xen_blkbk_remove()'.  In the case, incompletely
> linked 'backend_info' and 'blkif' might be exposed to the callback, thus
> result in bad results including NULL dereference.  This commit fixes the
> problem by applying the 'reclaim_lock' protection to those.
> 
> Note that this commit is separated for review purpose only.  As the
> previous commit might result in race condition and might make bisect
> confuse, please squash this commit into previous commit if possible.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Please merge this patch into patch 2.


Juergen
