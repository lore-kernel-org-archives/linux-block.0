Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2582C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 11:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350386AbiFVLPJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355191AbiFVLPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 07:15:08 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209E3A729
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 04:15:07 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] reduce the size of rnbd_clt_dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655896506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9p4o07SpwC0pqZSANwk7TD6REIEv7ioPtByn+upVpA=;
        b=vsUqOKkhcPo+2CB8jbcXADsgrEpYF1Ct+3jOo0yF3leCA97LvStA9yNONTtw2Bg9S8IL3/
        qgxiX/4Wyc/2yy03gTAPamTP/QkKqma5npEj/0tI7N0yqD9n2z3tSlo020FjP9xx8xxtxO
        LFH2/pzCKVPXBrOIXCsP6aG6d+lIayw=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
 <CAMGffEmXohRXYg0twM5yxb1pdHhwRy9AkN8myj-mh6KnRgG1Vg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <b0ab5515-cbb5-fe57-19f2-9afb92713bfd@linux.dev>
Date:   Wed, 22 Jun 2022 19:15:03 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEmXohRXYg0twM5yxb1pdHhwRy9AkN8myj-mh6KnRgG1Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jinpu,

On 6/21/22 8:16 PM, Jinpu Wang wrote:
> On Mon, Jun 20, 2022 at 5:49 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Hi,
>>
>> The struct rnbd_clt_dev added some members (wc, fua and max_hw_sectors
>> etc) which are used to set up gendisk and request_queue, but seems only
>> map scenario need to setup them since rnbd_client_setup_device is not
>> called from remap path.
>>
>> Previously, pahole reports.
>>
>>          /* size: 272, cachelines: 5, members: 29 */
>>          /* sum members: 259, holes: 4, sum holes: 13 */
>>          /* last cacheline: 16 bytes */
>>
>> After the series, it changes to
>> t
>>          /* last cacheline: 32 bytes */
>>
>> Please review.
>>
>> Thanks,
>> Guoqing
> Hi Guoqing,
>
> Thanks for the patchset, I had a brief look, in general I like the
> idea, will run a regression test. and sort out the details.
>

Thanks for the review!

Thanks,
Guoqing
