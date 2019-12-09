Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E02C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68DC2073D
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 11:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EgTLVB2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLILdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:33:39 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52524 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfLILdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 06:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575891218; x=1607427218;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=jCDbQSdoBdfMrVuJUQRfuw9YKJvl0RFzFJ83Wu3g8QU=;
  b=EgTLVB2BmaIqAuenrfyQg0x0+/Ir4PiIXqhWygW4GIxjQVqihXu4p0Om
   9cvbBvLp+otU8vaYo3TDg0pToW4YnyaMf/ijeNaRo/1FXJ2LjDHN747Xi
   mU4uO/O9ccABZkmV5pir2Slt9xKtN4++NWhEqxzrwaaOnLZVirF3VMIgd
   g=;
IronPort-SDR: L9FyZ/Wo8dtPzPzFif4LsTdQfHQIxKbR+hC5608Mr4rSs8W9JKV103XRU93491eIRRYTYnZCnB
 BKNPXn1P+gLQ==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="12413711"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 09 Dec 2019 11:33:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id B356AA1C95;
        Mon,  9 Dec 2019 11:33:23 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 11:33:22 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 11:33:19 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory pressure
Date:   Mon, 9 Dec 2019 12:32:40 +0100
Message-ID: <20191209113240.847-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <17131297-6d09-7302-d632-246f62487652@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D37UWA003.ant.amazon.com (10.43.160.25) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 9 Dec 2019 12:08:10 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

>On 09.12.19 11:52, SeongJae Park wrote:
>> On Mon, 9 Dec 2019 11:15:22 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
>>
>>> On 09.12.19 10:46, Durrant, Paul wrote:
>>>>> -----Original Message-----
>>>>> From: Jürgen Groß <jgross@suse.com>
>>>>> Sent: 09 December 2019 09:39
>>>>> To: Park, Seongjae <sjpark@amazon.com>; axboe@kernel.dk;
>>>>> konrad.wilk@oracle.com; roger.pau@citrix.com
>>>>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Durrant,
>>>>> Paul <pdurrant@amazon.com>; sj38.park@gmail.com; xen-
>>>>> devel@lists.xenproject.org
>>>>> Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
>>>>> pressure
>>>>>
>>>>> On 09.12.19 09:58, SeongJae Park wrote:
>>>>>> Each `blkif` has a free pages pool for the grant mapping.  The size of
>>>>>> the pool starts from zero and be increased on demand while processing
>>>>>> the I/O requests.  If current I/O requests handling is finished or 100
>>>>>> milliseconds has passed since last I/O requests handling, it checks and
>>>>>> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>>>>>>
>>>>>> Therefore, `blkfront` running guests can cause a memory pressure in the
>>>>>> `blkback` running guest by attaching a large number of block devices and
>>>>>> inducing I/O.
>>>>>
>>>>> I'm having problems to understand how a guest can attach a large number
>>>>> of block devices without those having been configured by the host admin
>>>>> before.
>>>>>
>>>>> If those devices have been configured, dom0 should be ready for that
>>>>> number of devices, e.g. by having enough spare memory area for ballooned
>>>>> pages.
>>>>>
>>>>> So either I'm missing something here or your reasoning for the need of
>>>>> the patch is wrong.
>>>>>
>>>>
>>>> I think the underlying issue is that persistent grant support is hogging memory in the backends, thereby compromising scalability. IIUC this patch is essentially a band-aid to get back to the scalability that was possible before persistent grant support was added. Ultimately the right answer should be to get rid of persistent grants support and use grant copy, but such a change is clearly more invasive and would need far more testing.
>>>
>>> Persistent grants are hogging ballooned pages, which is equivalent to
>>> memory only in case of the backend's domain memory being equal or
>>> rather near to its max memory size.
>>>
>>> So configuring the backend domain with enough spare area for ballooned
>>> pages should make this problem much less serious.
>>>
>>> Another problem in this area is the amount of maptrack frames configured
>>> for a driver domain, which will limit the number of concurrent foreign
>>> mappings of that domain.
>>
>> Right, similar problems from other backends are possible.
>>
>>>
>>> So instead of having a blkback specific solution I'd rather have a
>>> common callback for backends to release foreign mappings in order to
>>> enable a global resource management.
>>
>> This patch is also based on a common callback, namely the shrinker callback
>> system.  As the shrinker callback is designed for the general memory pressure
>> handling, I thought this is a right one to use.  Other backends having similar
>> problems can use this in their way.
>
> But this is addressing memory shortage only and it is acting globally.
>
> What I'd like to have in some (maybe distant) future is a way to control
> resource usage per guest. Why would you want to throttle performance of
> all guests instead of only the one causing the pain by hogging lots of
> resources?

Good point.  I was also concerned about the performance fairness at first, but
settled in this ugly but simple solution mainly because my worst-case
performance test (detailed in 1st patch's commit msg) shows no visible
performance degradation, though it is a minimal test on my test environment.

Anyway, I agree with your future direction.

>
> The new backend callback should (IMO) have a domid as parameter for
> specifying which guest should be taken away resources (including the
> possibility to select "any domain").
>
> It might be reasonable to have your shrinker hook in e.g. xenbus for
> calling the backend callbacks. And you could have another agent in the
> grant driver reacting on shortage of possible grant mappings.
>
> I don't expect you to implement all of that at once, but I think having
> that idea in mind when addressing current issues would be nice. So as a
> starting point you could move the shrinker hook to xenbus, add the
> generic callback to struct xenbus_driver, populate that callback in
> blkback and call it in the shrinker hook with "any domain". This would
> enable a future extension to other backends and a dynamic resource
> management in a natural way.

Appreciate this kind and detailed advice.  I will post the second version
applying your comments, soon.


Thanks,
SeongJae Park

>
>
>Juergen
>
