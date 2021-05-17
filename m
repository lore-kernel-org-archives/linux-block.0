Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E5C433B4
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D136660FF1
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbhEQPPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 11:15:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243323AbhEQPNb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 11:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621264333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACzB0DWbQGMuhP7p+vCM4+g4XN+9TxlE9DnI7LNXZBs=;
        b=vDfEffzs87TIlyJUBoxJiFeoxiofBZyZFCKTYenvgXrKex0QVkTui63PUD/mFZrrvqzWov
        +AYG2+nff9AsadGKL2MUFXg09LY7mghXZS9EigOW0wWNu9PYsOIXbDPqKOVJ9fab+FOGoK
        NAJ/O7l2p8W6IrmSmmMzF+HEbCj8zcE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 105D8AF75;
        Mon, 17 May 2021 15:12:13 +0000 (UTC)
Subject: Re: [PATCH 4/8] xen/blkfront: don't trust the backend response data
 blindly
To:     Juergen Gross <jgross@suse.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-5-jgross@suse.com>
 <315ad8b9-8a98-8d3e-f66c-ab32af2731a8@suse.com>
 <6095c4b9-a9bb-8a38-fb6c-a5483105b802@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <a19a13ba-a386-2808-ad85-338d47085fa6@suse.com>
Date:   Mon, 17 May 2021 17:12:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6095c4b9-a9bb-8a38-fb6c-a5483105b802@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.05.2021 16:23, Juergen Gross wrote:
> On 17.05.21 16:11, Jan Beulich wrote:
>> On 13.05.2021 12:02, Juergen Gross wrote:
>>> @@ -1574,10 +1580,16 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
>>>   	spin_lock_irqsave(&rinfo->ring_lock, flags);
>>>    again:
>>>   	rp = rinfo->ring.sring->rsp_prod;
>>> +	if (RING_RESPONSE_PROD_OVERFLOW(&rinfo->ring, rp)) {
>>> +		pr_alert("%s: illegal number of responses %u\n",
>>> +			 info->gd->disk_name, rp - rinfo->ring.rsp_cons);
>>> +		goto err;
>>> +	}
>>>   	rmb(); /* Ensure we see queued responses up to 'rp'. */
>>
>> I think you want to insert after the barrier.
> 
> Why? The relevant variable which is checked is "rp". The result of the
> check is in no way depending on the responses themselves. And any change
> of rsp_cons is protected by ring_lock, so there is no possibility of
> reading an old value here.

But this is a standard double read situation: You might check a value
and then (via a separate read) use a different one past the barrier.

Jan
