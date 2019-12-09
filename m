Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B2C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1300B20692
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLIJjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:39:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:43186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbfLIJjG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Dec 2019 04:39:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F59BB1A3;
        Mon,  9 Dec 2019 09:39:04 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
 pressure
To:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org
References: <20191209085839.21215-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <954f7beb-9d40-253e-260b-4750809bf808@suse.com>
Date:   Mon, 9 Dec 2019 10:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209085839.21215-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 09:58, SeongJae Park wrote:
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and be increased on demand while processing
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> 
> Therefore, `blkfront` running guests can cause a memory pressure in the
> `blkback` running guest by attaching a large number of block devices and
> inducing I/O.

I'm having problems to understand how a guest can attach a large number
of block devices without those having been configured by the host admin
before.

If those devices have been configured, dom0 should be ready for that
number of devices, e.g. by having enough spare memory area for ballooned
pages.

So either I'm missing something here or your reasoning for the need of
the patch is wrong.


Juergen
