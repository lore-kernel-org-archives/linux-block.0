Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80EAC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A80218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i4FKNZf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbeLTVeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:34:21 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:50269 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTVeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:34:21 -0500
Received: by mail-it1-f173.google.com with SMTP id z7so4177078iti.0
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lPG02Pgi0wJhhxBjzO0ocOPwCKZRyE1okfEjf0Bs9B4=;
        b=i4FKNZf5z7eBdtZBMtj5hgDBGRQh+VMXFnp8wTqASeppkdIIxv7fZ00fzQdTV24VXi
         k5R78MezQJj6WqIn1j+/RRSWQoBJDOtopz9dHUx/8/64dV00fslH2D4btbGUpZ3D54eC
         XaDQ3piakYzZZm1RsVOnqdZwdUlDKFVQYWHrM415koA/IpTd3oVw+CDcpk7h6OM3Fys0
         p83qGCvbumVBaEU0u0XtTvaJKNgzgMyTaUbLgOfyS+cBJRI/OTWh7Jaf8R+CHcA2hSo+
         D5bGOwZjZFWSDk3ig3zQeOtD4PaN/Nk2U91oeiHGGYf7g4gI7fUQ9mMirl1M9q6oymwW
         gAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lPG02Pgi0wJhhxBjzO0ocOPwCKZRyE1okfEjf0Bs9B4=;
        b=GhzgqGqxkHYXhRYWqxfoyw+6T3lMrzgVh+f1uRGrbnaIZLpSjf2GQi0CGoxdXYPb3p
         Eo17gXEV36HhNBeYaIHYcIVPm8CpeVjKCjO7shZ8lbx37f7pxtfCv+v0+pnSgn8mh7L0
         p+4jbzDwHI7Aep5jQhh2FVv9gE5HBbzS0rYi+P+IOLs8ZRg5/Rw3LOpCIaMgrGFXm7L1
         W+EW+EhRV32oxbHcUYxv7ReVSGHudMqvI/5xaalA2qbTcAPfaFd1br92o4reDlLPTAc1
         /nRCGUPyWVPOoxZQOjtayxKtNd0G2WmEC6rrlxBIC+i17diombgkKbUqMSn2aXZ+4OuS
         7yag==
X-Gm-Message-State: AA+aEWbGS6sKKfGS13RvVKUW3cdvfcO0SjWH23KkbDFDL9yYrkuNSbsM
        OfnhvNGwlhFTKRTOJWlLKvCBNVgY+BH1+w==
X-Google-Smtp-Source: AFSGD/U+csbVbRTg0VwA6dl8GcHkwCm5ONlBj8adwC+YJRukXPlL9TiZthxad5oN1s/PMzmLV5k8XQ==
X-Received: by 2002:a02:b529:: with SMTP id l38mr22550551jaj.25.1545341659730;
        Thu, 20 Dec 2018 13:34:19 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t10sm10090955ioi.4.2018.12.20.13.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:34:18 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
 <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org>
 <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org>
 <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
 <1545341470.185366.519.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
Date:   Thu, 20 Dec 2018 14:34:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545341470.185366.519.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 2:31 PM, Bart Van Assche wrote:
> On Thu, 2018-12-20 at 14:26 -0700, Jens Axboe wrote:
>> On 12/20/18 2:23 PM, Bart Van Assche wrote:
>>> On Thu, 2018-12-20 at 14:00 -0700, Jens Axboe wrote:
>>>> On 12/20/18 1:56 PM, Bart Van Assche wrote:
>>>>> @@ -96,6 +97,9 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>>>>  {
>>>>>  	struct mq_inflight *mi = priv;
>>>>>  
>>>>> +	if (rq->q != mi->q)
>>>>> +		return;
>>>>
>>>> Aren't you back to square one with this one, if the tags are shared? You
>>>> can't dereference it before you know it matches.
>>>
>>> My patch can only work if the new rq->q = NULL assignment in __blk_mq_free_request()
>>> is executed before the request tag is freed and if freeing a tag does not happen
>>> concurrently with any bt_iter() call. Would you accept that I add a seqlock to avoid
>>> this scenario?
>>
>> Ugh no, let's not go that far. Why not just use my approach that avoids
>> any need to dereference rq, unless we know it belongs to the queue in
>> question? I think that's cheaper than resetting ->queue as well when the
>> rq completes, I'm always wary of adding new stores in the completion
>> path.
> 
> I think there is a race condition in bt_iter() in your approach:
> tags->rqs[bitnr].queue can change after it has been read and that can
> cause a request that is not associated with hctx->queue to be passed
> to iter_data->fn(). Since 'fn' will access '*rq' I think that with
> your patch a use-after-free can occur similar to the one reported at
> the start of this e-mail thread. Your patch may make it harder to
> trigger that issue though.

Yeah, I don't think it's bullet proof either, it just closes the gap.
I'm fine with fiddling with the tag iteration. On top of what I sent, we
could have tag iteration hold the RCU read lock, and then we just need
to ensure that the tags are freed with RCU.

-- 
Jens Axboe

