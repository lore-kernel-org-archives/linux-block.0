Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF0C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA7323356
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbhATOj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:39:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390605AbhATOjN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 09:39:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXsF0fqiIHWmqnkg3pyZ7W7l886Xfshgy0aqkUvrN9M=;
        b=SgfScqFzkVPkpatFXvNoftOGSRhmibBo8EDmuDZxaczYnZ7D0Ylds7dguNNbCR8TPATyiq
        VpVS+KWnaFc5ZsQv06Cy+kn8t3GVs9mg6/pH6JjqiA0bpknHAIlateNp6pCJDOW1P5Qb8B
        H6PZ26zGtiucZYmRssmXd/2U0L4p5mA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E31EADCD;
        Wed, 20 Jan 2021 14:37:58 +0000 (UTC)
Subject: Re: [PATCH v2] xen-blkfront: allow discard-* nodes to be optional
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org,
        Arthur Borsboom <arthurborsboom@gmail.com>
References: <20210119105727.95173-1-roger.pau@citrix.com>
 <CALUcmUkd9Eeau6tC9ZWHbLdvHTYfY34LvK6KKpOOxreYF67Myg@mail.gmail.com>
 <20210120143515.v2vgyhcxrhnnng6r@Air-de-Roger>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <83d1aca5-2637-f1f2-3006-69fc6ba76bb4@suse.com>
Date:   Wed, 20 Jan 2021 15:37:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120143515.v2vgyhcxrhnnng6r@Air-de-Roger>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20.01.2021 15:35, Roger Pau Monné wrote:
> On Wed, Jan 20, 2021 at 03:23:30PM +0100, Arthur Borsboom wrote:
>> Hi Roger,
>>
>> I have set up a test environment based on Linux 5.11.0-rc4.
>> The patch did not apply clean, so I copied/pasted the patch manually.
>>
>> Without the patch the call trace (as reported) is visible in dmesg.
>> With the patch the call trace in dmesg is gone, but ... (there is always a
>> but) ...
>>
>> Now the discard action returns the following.
>>
>> [arthur@test-arch ~]$ sudo fstrim -v /
>> fstrim: /: the discard operation is not supported
>>
>> It might be correct, but of course I was hoping the Xen VM guest would pass
>> on the discard request to the block device in the Xen VM host, which is a
>> disk partition.
>> Any suggestions?
> 
> Hm, that's not what I did see on my testing, the operation worked OK,
> and that's what I would expect to happen in your case also, since I
> know the xenstore keys.

Does discard work on partitions (and not just on entire disks)?
It's been a while since I last had anything to do with this code,
so I may well misremember.

Jan
