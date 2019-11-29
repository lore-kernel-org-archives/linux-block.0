Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4480C432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FB82075C
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfK2Ppu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:45:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:43418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfK2Ppt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 10:45:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12679B266;
        Fri, 29 Nov 2019 15:45:48 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
 unloaded
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        "Durrant, Paul" <pdurrant@amazon.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, boris.ostrovsky@oracle.com
References: <20191129134306.2738-1-pdurrant@amazon.com>
 <20191129134306.2738-3-pdurrant@amazon.com>
 <20191129150006.GZ980@Air-de-Roger>
 <f06bf1967bdf43ca9b218f9b5c5202a6@EX13D32EUC003.ant.amazon.com>
 <20191129150757.GA980@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <625a2843-ec65-90a5-8312-82131cc281c5@suse.com>
Date:   Fri, 29 Nov 2019 16:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191129150757.GA980@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29.11.19 16:07, Roger Pau Monné wrote:
> On Fri, Nov 29, 2019 at 03:02:37PM +0000, Durrant, Paul wrote:
>>> -----Original Message-----
>>> From: Roger Pau Monné <roger.pau@citrix.com>
>>> Sent: 29 November 2019 15:00
>>> To: Durrant, Paul <pdurrant@amazon.com>
>>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; xen-
>>> devel@lists.xenproject.org; Konrad Rzeszutek Wilk
>>> <konrad.wilk@oracle.com>; Jens Axboe <axboe@kernel.dk>
>>> Subject: Re: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
>>> unloaded
>>>
>>> On Fri, Nov 29, 2019 at 01:43:06PM +0000, Paul Durrant wrote:
>>>> Add a module_exit() to perform the necessary clean-up.
>>>>
>>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>>
>>> LGTM:
>>>
>>> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
>>>
>>
>> Thanks.
>>
>>> AFAICT we should make sure this is not committed before patch 1, or
>>> else you could unload a blkback module that's still in use?
>>>
>>
>> Yes, that's correct.
> 
> Given this is a very small change, and not really block related I
> think it would be better for both patches to be committed from the Xen
> tree, if Jens, Juergen and Boris agree.

I'm fine with that.

And:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

