Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE4C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F120726
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 10:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfLIKP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:15:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfLIKP1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Dec 2019 05:15:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67BABB3E2;
        Mon,  9 Dec 2019 10:15:24 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
 pressure
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        "Park, Seongjae" <sjpark@amazon.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20191209085839.21215-1-sjpark@amazon.com>
 <954f7beb-9d40-253e-260b-4750809bf808@suse.com>
 <026ba79524da43648371e5bca437a5e4@EX13D32EUC003.ant.amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e913c44e-c898-9504-1e2a-927563563208@suse.com>
Date:   Mon, 9 Dec 2019 11:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <026ba79524da43648371e5bca437a5e4@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 10:46, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Jürgen Groß <jgross@suse.com>
>> Sent: 09 December 2019 09:39
>> To: Park, Seongjae <sjpark@amazon.com>; axboe@kernel.dk;
>> konrad.wilk@oracle.com; roger.pau@citrix.com
>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Durrant,
>> Paul <pdurrant@amazon.com>; sj38.park@gmail.com; xen-
>> devel@lists.xenproject.org
>> Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
>> pressure
>>
>> On 09.12.19 09:58, SeongJae Park wrote:
>>> Each `blkif` has a free pages pool for the grant mapping.  The size of
>>> the pool starts from zero and be increased on demand while processing
>>> the I/O requests.  If current I/O requests handling is finished or 100
>>> milliseconds has passed since last I/O requests handling, it checks and
>>> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>>>
>>> Therefore, `blkfront` running guests can cause a memory pressure in the
>>> `blkback` running guest by attaching a large number of block devices and
>>> inducing I/O.
>>
>> I'm having problems to understand how a guest can attach a large number
>> of block devices without those having been configured by the host admin
>> before.
>>
>> If those devices have been configured, dom0 should be ready for that
>> number of devices, e.g. by having enough spare memory area for ballooned
>> pages.
>>
>> So either I'm missing something here or your reasoning for the need of
>> the patch is wrong.
>>
> 
> I think the underlying issue is that persistent grant support is hogging memory in the backends, thereby compromising scalability. IIUC this patch is essentially a band-aid to get back to the scalability that was possible before persistent grant support was added. Ultimately the right answer should be to get rid of persistent grants support and use grant copy, but such a change is clearly more invasive and would need far more testing.

Persistent grants are hogging ballooned pages, which is equivalent to
memory only in case of the backend's domain memory being equal or
rather near to its max memory size.

So configuring the backend domain with enough spare area for ballooned
pages should make this problem much less serious.

Another problem in this area is the amount of maptrack frames configured
for a driver domain, which will limit the number of concurrent foreign
mappings of that domain.

So instead of having a blkback specific solution I'd rather have a
common callback for backends to release foreign mappings in order to
enable a global resource management.


Juergen
