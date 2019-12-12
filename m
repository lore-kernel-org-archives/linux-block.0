Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F12C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 06:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ADF2465A
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 06:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLLGCV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:02:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:59902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfLLGCV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 01:02:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FC70AD20;
        Thu, 12 Dec 2019 06:02:19 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] xenbus: limit when state is forced to closed
To:     Paul Durrant <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191211152956.5168-1-pdurrant@amazon.com>
 <20191211152956.5168-3-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <61622e02-9cdc-03bc-b107-f3d1e6ff0fb9@suse.com>
Date:   Thu, 12 Dec 2019 07:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211152956.5168-3-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.12.19 16:29, Paul Durrant wrote:
> If a driver probe() fails then leave the xenstore state alone. There is no
> reason to modify it as the failure may be due to transient resource
> allocation issues and hence a subsequent probe() may succeed.
> 
> If the driver supports re-binding then only force state to closed during
> remove() only in the case when the toolstack may need to clean up. This can
> be detected by checking whether the state in xenstore has been set to
> closing prior to device removal.
> 
> NOTE: Re-bind support is indicated by new boolean in struct xenbus_driver,
>        which defaults to false. Subsequent patches will add support to
>        some backend drivers.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
