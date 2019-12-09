Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C822C04E30
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 10:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B40207FD
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 10:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mtdUm4X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLIKxB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:53:01 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:64636 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfLIKxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 05:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575888780; x=1607424780;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7b19Ik5i6iJTWRb6DDwOlywn9r/llQCNAsaaQHiunpg=;
  b=mtdUm4X+6yB6Lhc2OD5aqnnSjBXSWd1drGT5Lbn3bMiQuEXwSSM8jYuq
   I5WRdjOa5tGDk3q/mLvUqTie1/wzuz3fMSgHEDUb5Cw7jJ+we+TUuu3Za
   ck7JHNDaIBd7ZmNVWxUQega8b/Xs+h5jYf99uGszPw9Q37MsdElzCD0FL
   o=;
IronPort-SDR: PBZ1GWKcDaJl8Ndj1bxsK2qfu0qgHzc1XCXN2WJix89t2R0mDpGffy+b9M3Y3oH/5/2DLWV/N3
 tizEtAqisDxA==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="6790975"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 09 Dec 2019 10:52:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 7F399225828;
        Mon,  9 Dec 2019 10:52:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 10:52:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 10:52:53 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory pressure
Date:   Mon, 9 Dec 2019 11:52:18 +0100
Message-ID: <20191209105218.23583-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <e913c44e-c898-9504-1e2a-927563563208@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.192]
X-ClientProxiedBy: EX13D17UWB002.ant.amazon.com (10.43.161.141) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 9 Dec 2019 11:15:22 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

>On 09.12.19 10:46, Durrant, Paul wrote:
>>> -----Original Message-----
>>> From: Jürgen Groß <jgross@suse.com>
>>> Sent: 09 December 2019 09:39
>>> To: Park, Seongjae <sjpark@amazon.com>; axboe@kernel.dk;
>>> konrad.wilk@oracle.com; roger.pau@citrix.com
>>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Durrant,
>>> Paul <pdurrant@amazon.com>; sj38.park@gmail.com; xen-
>>> devel@lists.xenproject.org
>>> Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
>>> pressure
>>>
>>> On 09.12.19 09:58, SeongJae Park wrote:
>>>> Each `blkif` has a free pages pool for the grant mapping.  The size of
>>>> the pool starts from zero and be increased on demand while processing
>>>> the I/O requests.  If current I/O requests handling is finished or 100
>>>> milliseconds has passed since last I/O requests handling, it checks and
>>>> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>>>>
>>>> Therefore, `blkfront` running guests can cause a memory pressure in the
>>>> `blkback` running guest by attaching a large number of block devices and
>>>> inducing I/O.
>>>
>>> I'm having problems to understand how a guest can attach a large number
>>> of block devices without those having been configured by the host admin
>>> before.
>>>
>>> If those devices have been configured, dom0 should be ready for that
>>> number of devices, e.g. by having enough spare memory area for ballooned
>>> pages.
>>>
>>> So either I'm missing something here or your reasoning for the need of
>>> the patch is wrong.
>>>
>>
>> I think the underlying issue is that persistent grant support is hogging memory in the backends, thereby compromising scalability. IIUC this patch is essentially a band-aid to get back to the scalability that was possible before persistent grant support was added. Ultimately the right answer should be to get rid of persistent grants support and use grant copy, but such a change is clearly more invasive and would need far more testing.
>
>Persistent grants are hogging ballooned pages, which is equivalent to
>memory only in case of the backend's domain memory being equal or
>rather near to its max memory size.
>
>So configuring the backend domain with enough spare area for ballooned
>pages should make this problem much less serious.
>
>Another problem in this area is the amount of maptrack frames configured
>for a driver domain, which will limit the number of concurrent foreign
>mappings of that domain.

Right, similar problems from other backends are possible.

>
>So instead of having a blkback specific solution I'd rather have a
>common callback for backends to release foreign mappings in order to
>enable a global resource management.

This patch is also based on a common callback, namely the shrinker callback
system.  As the shrinker callback is designed for the general memory pressure
handling, I thought this is a right one to use.  Other backends having similar
problems can use this in their way.


Thanks,
SeongJae Park


>
>
>Juergen
>
