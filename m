Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D1C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0072611C1
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 08:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhDWIFb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:05:31 -0400
Received: from mail.synology.com ([211.23.38.101]:56580 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229917AbhDWIFa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 04:05:30 -0400
Subject: Re: [PATCH v2] block: fix trace completion for chained bio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1619165093; bh=KD2DEUbUs/MuymN+RMyXMiyFHNjxQu60kGtFI97ART0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=myaTybs+xgX1giHiS+cTjzfjEz+aAyKT//zpKLYKHK8WBEXU3wfJ6QpxnF4ImCwsS
         0VTsRaLsIC09/z1Z53E0/01JWyWRJsLw5fgSeTdCiot3ykjmYZL+eoIP+dXMMNkBha
         bRNywAebMqWK9sHW1HLn8p0jbu9VQkXAX1wlMyy0=
To:     NeilBrown <neilb@suse.de>, axboe@kernel.dk, neilb@suse.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com
References: <1614741726-28074-1-git-send-email-edwardh@synology.com>
 <87zgyudgss.fsf@notabene.neil.brown.name>
From:   Edward Hsieh <edwardh@synology.com>
Message-ID: <fb8620bf-f4e9-5787-ab79-6e0a5d79d26d@synology.com>
Date:   Fri, 23 Apr 2021 16:04:49 +0800
MIME-Version: 1.0
In-Reply-To: <87zgyudgss.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/2021 5:22 AM, NeilBrown wrote:
> On Wed, Mar 03 2021, edwardh wrote:
> 
>> From: Edward Hsieh <edwardh@synology.com>
>>
>> For chained bio, trace_block_bio_complete in bio_endio is currently called
>> only by the parent bio once upon all chained bio completed.
>> However, the sector and size for the parent bio are modified in bio_split.
>> Therefore, the size and sector of the complete events might not match the
>> queue events in blktrace.
>>
>> The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
>> completion of all bios.") wants multiple complete events to correspond
>> to one queue event but missed this.
>>
>> md/raid5 read with bio cross chunks can reproduce this issue.
>>
>> To fix, move trace completion into the loop for every chained bio to call.
> 
> Thanks.  I think this is correct as far as tracing goes.
> However the code still looks a bit odd.
> 
> The comment for the handling of bio_chain_endio suggests that the *only*
> purpose for that is to avoid deep recursion.  That suggests it should be
> at the end of the function.
> As it is blk_throtl_bio_endio() and bio_unint() are only called on the
> last bio in a chain.
> That seems wrong.
> 
> I'd be more comfortable if the patch moved the bio_chain_endio()
> handling to the end, after all of that.
> So the function would end.
> 
> if (bio->bi_end_io == bio_chain_endio) {
>     bio = __bio_chain_endio(bio);
>     goto again;
> } else if (bio->bi_end_io)
>     bio->bi_end_io(bio);
> 
> Jens:  can you see any reason why that functions must only be called on
> the last bio in the chain?
> 
> Thanks,
> NeilBrown
> 

Hi Neil and Jens,

 From the commit message, bio_uninit is put here for bio allocated in 
special ways (e.g., on stack), that will not be release by bio_free. For 
chained bio, __bio_chain_endio invokes bio_put and release the 
resources, so it seems that we don't need to call bio_uninit for chained 
bio.

The blk_throtl_bio_endio is used to update the latency for the throttle 
group. I think the latency should only be updated after the whole bio is 
finished?

To make sense for the "tail call optimization" in the comment, I'll 
suggest to wrap the whole statement with an else. What do you think?

if (bio->bi_end_io == bio_chain_endio) {
	bio = __bio_chain_endio(bio);
	goto again;
} else {
	blk_throtl_bio_endio(bio);
	/* release cgroup info */
	bio_uninit(bio);
	if (bio->bi_end_io)
		bio->bi_end_io(bio);
}

Thanks,
Edward Hsieh
