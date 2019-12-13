Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89396C43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FA32465A
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 08:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfLMI7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:59:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:47760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfLMI7u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 03:59:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D9FCAE3F;
        Fri, 13 Dec 2019 08:59:48 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] xen/interface: re-define FRONT/BACK_RING_ATTACH()
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To:     Paul Durrant <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191211152956.5168-1-pdurrant@amazon.com>
 <20191211152956.5168-4-pdurrant@amazon.com>
 <cfd8f169-e925-dbff-64b2-d471300a6694@suse.com>
Message-ID: <1c12f2d7-ce67-41fc-f022-e39ea0c4e1df@suse.com>
Date:   Fri, 13 Dec 2019 09:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <cfd8f169-e925-dbff-64b2-d471300a6694@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.12.19 07:04, Jürgen Groß wrote:
> On 11.12.19 16:29, Paul Durrant wrote:
>> Currently these macros are defined to re-initialize a front/back ring
>> (respectively) to values read from the shared ring in such a way that any
>> requests/responses that are added to the shared ring whilst the 
>> front/back
>> is detached will be skipped over. This, in general, is not a desirable
>> semantic since most frontend implementations will eventually block 
>> waiting
>> for a response which would either never appear or never be processed.
>>
>> Since the macros are currently unused, take this opportunity to re-define
>> them to re-initialize a front/back ring using specified values. This also
>> allows FRONT/BACK_RING_INIT() to be re-defined in terms of
>> FRONT/BACK_RING_ATTACH() using a specified value of 0.
>>
>> NOTE: BACK_RING_ATTACH() will be used directly in a subsequent patch.
>>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Paul, I think you should send a patch changing ring.h in the Xen tree.

As soon as it has been accepted I'll take your series for the kernel.


Juergen
