Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD51C43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE14206C3
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfLMJAu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:00:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:48566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfLMJAt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 04:00:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 115DDB1FC;
        Fri, 13 Dec 2019 09:00:48 +0000 (UTC)
Subject: Re: [PATCH] xen-blkback: prevent premature module unload
To:     Paul Durrant <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20191210145305.6605-1-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <0a83ebaa-40b8-55f0-cff0-5aaf7bc14e98@suse.com>
Date:   Fri, 13 Dec 2019 10:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145305.6605-1-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.12.19 15:53, Paul Durrant wrote:
> Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
> cache. This cache is destoyed when xen-blkif is unloaded so it is
> necessary to wait for the deferred free routine used for such objects to
> complete. This necessity was missed in commit 14855954f636 "xen-blkback:
> allow module to be cleanly unloaded". This patch fixes the problem by
> taking/releasing extra module references in xen_blkif_alloc/free()
> respectively.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Pushed to xen/tip.git for-linus-5.5b


Juergen
