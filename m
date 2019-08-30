Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE43C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 05:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9E206BB
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 05:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfH3FWh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:22:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfH3FWg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 01:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1F0F8980E2;
        Fri, 30 Aug 2019 05:22:36 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A478519C58;
        Fri, 30 Aug 2019 05:22:34 +0000 (UTC)
Subject: Re: [PATCH 2/2 v3] nbd: fix possible page fault for nbd disk
From:   Xiubo Li <xiubli@redhat.com>
To:     Mike Christie <mchristi@redhat.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20190822075923.11996-1-xiubli@redhat.com>
 <20190822075923.11996-3-xiubli@redhat.com> <5D686498.5090602@redhat.com>
 <78d16d10-1d06-6ce1-7c51-64c42e51f549@redhat.com>
Message-ID: <fe964fbe-64fe-5bf3-25e9-9e76175d7eba@redhat.com>
Date:   Fri, 30 Aug 2019 13:22:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <78d16d10-1d06-6ce1-7c51-64c42e51f549@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 30 Aug 2019 05:22:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/8/30 8:58, Xiubo Li wrote:
> On 2019/8/30 7:49, Mike Christie wrote:
>> On 08/22/2019 02:59 AM, xiubli@redhat.com wrote:
[...]
>>
>>> + test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
>>> +        mutex_unlock(&nbd_index_mutex);
>>> +
>>> +        /* Wait untill the recv_work exit */
>> If that is all you need we could do a flush_workqueue(nbd->recv_workq)
>> (you would need Jens's for next branch which has some work queue changes
>> in nbd).
>
> Yeah, this makes sense.

This has already been done in nbd_disconnect_and_put() in the Jen's for 
next branch code. So here it will make no sense.

I will rebase this patch set to that branch.

Thanks.
BRs
Xiubo
