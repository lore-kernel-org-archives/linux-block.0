Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E016C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8673206B6
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ViSeo3v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8673206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeK2DdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:33:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34579 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeK2DdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:33:23 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so5062470itd.1
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgfVxIP+VmBP4nI08Mvdi3rlUWrHYvBlihd7QjTl5sI=;
        b=ViSeo3v8g3ymY7AHz9u+uEzTNFM7BIyHpDABLxyiSDkMxKG9URuT6pAG4EUlIh5zab
         XxKrXNALM0n09us7oU7ICudc0rTScUGpsjCZyTydzyHAd6xNPaqKkK4XQPQESWdeOzzi
         6qZExmv4hW45ee9/FAOGj0PN7ObW0Tmq4nPh/+Ma5Jx1/o4KkT2vCbaNusWozGM0qplJ
         hKaNhZQ59WY4+9DEpMOn7/iovPsg2vgi+vpbd12jHeVtnIiHL/vBmactqJUybOTh2GL7
         Jmu+0t7gKBpGhJZ2xK+PfRZXHYioFuDR/sELdt8X6gFcyYLkrzTZvr2xZIbvulruSyyR
         wmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgfVxIP+VmBP4nI08Mvdi3rlUWrHYvBlihd7QjTl5sI=;
        b=W8nMlUgiGTMHifYFUyOeD9oF2tX2jsg7wPOZi3TRP06SWdEjU38ch3WpUr41+m+NjG
         15EuAEPcTzlH0L69mSkSnnQ6DXdIJen0+xIgS2ViDVBSBC2n5F1wO7LcSCGTAFaveoYL
         zVmm34JCTYVhbGfcFLcZ7sRSIydSMSrXI0X4h0Yw1L/kzX2sqczFDPy79fTacVbypRoQ
         6ouQVvjm4Y89YClN/3ObGG612zRMi2S3jmWCfzWStWyr4xNk8ey86dLKXI+m2T9tGec2
         ObwnpyvS2tHNAH887kxccdSRF3fqNfYzfHUIxsNkpr0/2r8m0tWhl3plOoPyYtXHcws/
         m+Lw==
X-Gm-Message-State: AA+aEWbhsaMDDXJa9xknZc6C1AjB7kkaokd+obwZ6mK6+rUXYalmZ4N7
        ZixgvWLW4j9KMAim5uLIiWs4ug==
X-Google-Smtp-Source: AFSGD/VI6PQcsJpqTMphhBjzE+UVVOj9o328ZXBykBf1o6EX6WAik3K/0GfBUHV4s9ShKlaDbOTUtg==
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr3654563itl.146.1543422669489;
        Wed, 28 Nov 2018 08:31:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q14sm1361111itb.36.2018.11.28.08.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:31:08 -0800 (PST)
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p> <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p> <20181128100848.GA23567@lst.de>
 <20181128154927.GE6401@localhost.localdomain>
 <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
 <20181128162655.GF6401@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4071afee-5a4e-63bf-e834-44ccdb7026ae@kernel.dk>
Date:   Wed, 28 Nov 2018 09:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128162655.GF6401@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 9:26 AM, Keith Busch wrote:
> On Wed, Nov 28, 2018 at 08:58:00AM -0700, Jens Axboe wrote:
>> On 11/28/18 8:49 AM, Keith Busch wrote:
>>> On Wed, Nov 28, 2018 at 11:08:48AM +0100, Christoph Hellwig wrote:
>>>> On Wed, Nov 28, 2018 at 06:07:01PM +0800, Ming Lei wrote:
>>>>>> Is this the nvme target on top of null_blk?
>>>>>
>>>>> Yes.
>>>>
>>>> And it goes away if you revert just the last patch?
>>>
>>> It looks like a problem existed before that last patch. Reverting it
>>> helps only if the request happened to have not been reallocated. If it
>>> had been reallocated, the NULL_IRQ_TIMER would have completed the wrong
>>> request out-of-order. If this were a real device, that'd probably result
>>> in data corruption.
>>
>> null_blk just needs updating for this.
> 
> Isn't this the nvme target's problem? It shouldn't complete requests
> dispatched to its backing device, so I'm thinking something like the
> following is what should happen. Untested at the moment, but will try
> it out shortly.

I looked at null_blk after the fact, and my recollection of how
that timeout stuff worked was wrong. I think you are right.

-- 
Jens Axboe

