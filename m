Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF0C43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8AE20803
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 12:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a3RVxmLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLDMJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:09:33 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46507 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 07:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575461372; x=1606997372;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0XU4I7wfx1XBSj0BFbZC9Xa7eD2pt9HXv+vFrvgGosk=;
  b=a3RVxmLZJ+QxCLCZlYVTFQDTFxjReRRcSMKyx2VCUIJP2OhJvugZfhZm
   kOABMbEsKxc5DpJOe+AH5T1rw7v835nZn3dgwAWUnPcmgmAEoC4orkNLV
   DdV4xQ6WXJR8EGjzJr5StI93RhxJM31E21b+DvQyYGNW38qxzDRptK2y0
   A=;
IronPort-SDR: pPAh3VyOKYzmvWOsJiLjzYBAm32158CHQmvaLASrfxIVhw/Vd2V9GFkK4QdemQZ6v2teZ/0XXt
 hOgcUUWlP9RQ==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="11545631"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Dec 2019 12:09:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 86FCCA26C9;
        Wed,  4 Dec 2019 12:09:17 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 12:09:16 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 12:09:15 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.28.85.76) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 4 Dec 2019 12:09:13 +0000
Subject: Re: [Xen-devel] [PATCH 0/2] xen/blkback: Aggressively shrink page
 pools if a memory pressure is detected
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191204113419.2298-1-sjpark@amazon.com>
 <62c68f53cc0145ad9d0dfb167b50eac4@EX13D32EUC003.ant.amazon.com>
From:   <sjpark@amazon.com>
Message-ID: <fcf414ab-4ee4-bafc-6683-5527df7a9731@amazon.com>
Date:   Wed, 4 Dec 2019 13:09:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <62c68f53cc0145ad9d0dfb167b50eac4@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04.12.19 12:52, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Xen-devel <xen-devel-bounces@lists.xenproject.org> On Behalf Of
>> SeongJae Park
>> Sent: 04 December 2019 11:34
>> To: konrad.wilk@oracle.com; roger.pau@citrix.com; axboe@kernel.dk
>> Cc: sj38.park@gmail.com; xen-devel@lists.xenproject.org; linux-
>> block@vger.kernel.org; linux-kernel@vger.kernel.org; Park, Seongjae
>> <sjpark@amazon.com>
>> Subject: [Xen-devel] [PATCH 0/2] xen/blkback: Aggressively shrink page
>> pools if a memory pressure is detected
>>
>> Each `blkif` has a free pages pool for the grant mapping.  The size of
>> the pool starts from zero and be increased on demand while processing
>> the I/O requests.  If current I/O requests handling is finished or 100
>> milliseconds has passed since last I/O requests handling, it checks and
>> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>>
>> Therefore, `blkfront` running guests can cause a memory pressure in the
>> `blkback` running guest by attaching arbitrarily large number of block
>> devices and inducing I/O.
> OOI... How do guests unilaterally cause the attachment of arbitrary numbers of PV devices?
Good point.  Many systems have their limit for the maximum number of the
devices.  Thus, 'arbitrarily' large number of devices cannot be attached.  So,
there is the upperbound.  System administrators might be able to avoid the
memory pressure problem by setting the limit low enough or giving more memory
to the 'blkback' running guest.

However, many systems also tempt to set the limit high enough so that guests
can satisfy and to give minimal memory to the 'blkback' running guest for cost
efficiency.

I believe this patchset can be helpful for such situations.

Anyway, using the term 'arbitrarily' is obvisously my fault.  I will update the
description in the next version of patchset.


Thanks,
SeongJae Park

>
>   Paul
>

