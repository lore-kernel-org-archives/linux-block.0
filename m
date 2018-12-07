Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32110C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4B420882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wzv1pop4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4B420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGBeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:34:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40671 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeLGBeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 20:34:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so1024382plq.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 17:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XT1aFWROWThFLQd4oidIPdL/eUrdrfxHG9i3ZZGvcCw=;
        b=Wzv1pop4kqBVd+pao+EJCN3Sq5PmedAAvRfvGpjlKNdRn/AKXX9dkZOaQ5dk2y59yE
         bxv9VOTmGP51KZ02OSHxlaBHYRuFzXbzzeNwAqk6PnbpVymbhORSbfh1z24xY7S+8lxw
         3b8tdvwr9uW0dplVmYmT9ctNfPm1O6B3vTx0FBk79UgXS+T8d6OLVP7ga4W2bPX3rB1t
         61e7CG7gng4ZbcbGNKoyb7WguzAglg6/qQb+UVw6VymUxP3TxfZ3Z25ntYv/7J3z2JPS
         xKnCQtQWbZdMnyr5S+XZIMGd2t7go3WRynw82RyfAAI0wVpDG8FprPcqsL9eKCebfpjK
         GMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XT1aFWROWThFLQd4oidIPdL/eUrdrfxHG9i3ZZGvcCw=;
        b=KmqulcoL9mOMNlzBnEKn+fwsqvlmEVnMwaHNmaQV3Qrge7zo6vcZ+v79Q3WtJf1TYM
         LuQEBsb+9zhNqDGvmU5eTWOt6tXINDsC8Q36VIW4ofe4H9nuZLekrm+dkbMnAZhPZ/We
         D9/aI0ZH+TkJ/ipFz56dXwrvUiBllCBYvamm+GrcFFU9/TeohO/ELhr0M6oAEVP8NMoy
         /bIykbnUIPuiqR2rG3D2YSNow5Vdp9OrEqmb5EmN29kFVvNWqOPAyOzc8UrOK7o0xghN
         6lpjUZ04pVPTGBdtuzbj3Wd0/fNAebGEN3llMgeQmNg2mhf9dNZX2ohvfEMq7fYCqHnF
         bzxg==
X-Gm-Message-State: AA+aEWb/r28g84Duagvv5YYjQDQI3J2jMErkUsErsRUlUF3rIA5kEFqV
        zcBNa9KZKEX2x9kQwQ13inOzZw==
X-Google-Smtp-Source: AFSGD/UdGY6JNIRH/jtBFBZvpR7O6U0urvMmlI7lDYQgn41KS4/mSn08La1HpnInZe/VTSPUfMx6rw==
X-Received: by 2002:a17:902:2f03:: with SMTP id s3mr249205plb.277.1544146476042;
        Thu, 06 Dec 2018 17:34:36 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p67sm2834192pfg.44.2018.12.06.17.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 17:34:35 -0800 (PST)
Subject: Re: [PATCH] block: fix direct dispatch issue failure for clones
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
 <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36822da2-ecde-ad71-7b49-f98e845b4fc2@kernel.dk>
Date:   Thu, 6 Dec 2018 18:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 6:22 PM, jianchao.wang wrote:
> 
> 
> On 12/7/18 9:13 AM, Jens Axboe wrote:
>> On 12/6/18 6:04 PM, jianchao.wang wrote:
>>>
>>>
>>> On 12/7/18 6:20 AM, Jens Axboe wrote:
>>>> After the direct dispatch corruption fix, we permanently disallow direct
>>>> dispatch of non read/write requests. This works fine off the normal IO
>>>> path, as they will be retried like any other failed direct dispatch
>>>> request. But for the blk_insert_cloned_request() that only DM uses to
>>>> bypass the bottom level scheduler, we always first attempt direct
>>>> dispatch. For some types of requests, that's now a permanent failure,
>>>> and no amount of retrying will make that succeed.
>>>>
>>>> Don't use direct dispatch off the cloned insert path, always just use
>>>> bypass inserts. This still bypasses the bottom level scheduler, which is
>>>> what DM wants.
>>>>
>>>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index deb56932f8c4..4c44e6fa0d08 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>>>>  		 * bypass a potential scheduler on the bottom device for
>>>>  		 * insert.
>>>>  		 */
>>>> -		return blk_mq_request_issue_directly(rq);
>>>> +		blk_mq_request_bypass_insert(rq, true);
>>>> +		return BLK_STS_OK;
>>>>  	}
>>>>  
>>>>  	spin_lock_irqsave(q->queue_lock, flags);
>>>>
>>> Not sure about this because it will break the merging promotion for request based DM
>>> from Ming.
>>> 396eaf21ee17c476e8f66249fb1f4a39003d0ab4
>>> (blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback)
>>>
>>> We could use some other way to fix this.
>>
>> That really shouldn't matter as this is the cloned insert, merging should
>> have been done on the original request.
>>
>>
> Just quote some comments from the patch.
> 
> "
>                        But dm-rq currently can't get the underlying queue's
>     dispatch feedback at all.  Without knowing whether a request was issued
>     or not (e.g. due to underlying queue being busy) the dm-rq elevator will
>     not be able to provide effective IO merging (as a side-effect of dm-rq
>     currently blindly destaging a request from its elevator only to requeue
>     it after a delay, which kills any opportunity for merging).  This
>     obviously causes very bad sequential IO performance.
>     ...
>     With this, request-based DM's blk-mq sequential IO performance is vastly
>     improved (as much as 3X in mpath/virtio-scsi testing)
> "
> 
> Using blk_mq_request_bypass_insert to replace the blk_mq_request_issue_directly
> could be a fast method to fix the current issue. Maybe we could get the merging
> promotion back after some time.

This really sucks, mostly because DM wants to have it both ways - not use
the bottom level IO scheduler, but still actually use it if it makes sense.

There is another way to fix this - still do the direct dispatch, but have
dm track if it failed and do bypass insert in that case. I didn't want do
to that since it's more involved, but it's doable.

Let me cook that up and test it... Don't like it, though.

-- 
Jens Axboe

