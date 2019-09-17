Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4103AC4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C602067B
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfIQToK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfIQToK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 15:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F89610CC1E1;
        Tue, 17 Sep 2019 19:44:10 +0000 (UTC)
Received: from [10.10.125.113] (ovpn-125-113.rdu2.redhat.com [10.10.125.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6B465D9D5;
        Tue, 17 Sep 2019 19:44:09 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] nbd: fix possible page fault for nbd disk
To:     Josef Bacik <josef@toxicpanda.com>
References: <20190917115606.13992-1-xiubli@redhat.com>
 <20190917115606.13992-3-xiubli@redhat.com> <5D812669.9050901@redhat.com>
 <20190917184011.74ityetkw7n3sqbs@MacBook-Pro-91.local>
Cc:     xiubli@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D813789.1050400@redhat.com>
Date:   Tue, 17 Sep 2019 14:44:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190917184011.74ityetkw7n3sqbs@MacBook-Pro-91.local>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 17 Sep 2019 19:44:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/17/2019 01:40 PM, Josef Bacik wrote:
>>> +		nbd->destroy_complete = &destroy_complete;
>>
>> Also, without the mutex part of the v3 patch, we could race and
>> nbd_dev_remove could have passed the destroy_complete check already, so
>> below we will wait forever.
>>
> 
> Oh hmm you're right,

I think I am actually wrong about that part too now :) I had forgot
about the idr removal under the mutex when making my original comment.

If nbd_put grabs the mutex first then it will do idr_remove under the
mutex. If nbd_genl_connect then runs, idr_find/idr_for_each will fail
and we will allocate a new nbd device and NBD_DISCONNECT_REQUESTED will
not be set.

If nbd_genl_connect grabs the mutex first, then idr_find/idr_for_each
will succeed and we will set the completion. nbd_put will then grab the
mutex and call nbd_remove_dev and see the completion.
