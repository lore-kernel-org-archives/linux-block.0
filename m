Return-Path: <SRS0=z7Fj=3Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB573C35254
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1A217BA
	for <linux-block@archiver.kernel.org>; Wed,  5 Feb 2020 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580912622;
	bh=LfCexNE6Gd761qKllNrk3XSUaDduX219PoECEnfSNCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ipm1lO6DbCDdbS9yGDJw81TrI9oS7MtZF4UR6OLS1TDu4OQSwZ0DSerQ8Fs23ocX+
	 yuC4eO2XBoXTEt4PnjUheQoWyZxkt9qsoxEZGofrVoVsm3HELMUXYfnAcF3CFlZaMv
	 HbKw/Dwjl3DchakzlRJXOvSXlfenaM72Ok+n4l5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEOXm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgBEOXl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Feb 2020 09:23:41 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E103220702;
        Wed,  5 Feb 2020 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580912621;
        bh=LfCexNE6Gd761qKllNrk3XSUaDduX219PoECEnfSNCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xqco1M8lAPH2BYadhEP9/w851pfYbF70Mnmu1vxHG6VWrdQLJJKWLvTBO517Mdwsy
         PFh00d5SY2PtA3ZWsTU/6Icm4f4QcoEb+kWxxWpJOexZX49C9R/bm9aPtlgY5dPUjI
         TdO1AuVkbiMCgi5uARS3gGdx86GSltW/CIxpjBUU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1izLac-00392Y-RU; Wed, 05 Feb 2020 14:23:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 14:23:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Keith Busch <kbusch@kernel.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
In-Reply-To: <c8a31bf9-7e25-aff1-e0df-7d9106324b9f@huawei.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
 <14cb0d17-f9e6-ffa8-7a98-bd602c72273f@huawei.com>
 <56502aa9-d4ad-5ede-5184-13f1817c77d7@huawei.com>
 <CACVXFVNiBOBdtwuW=q4aSmUMAnn6Gfpg6BGhcQu44s58NZ08Ww@mail.gmail.com>
 <20200201110539.03db5434@why> <87sgjutufz.fsf@nanos.tec.linutronix.de>
 <3db522f4-c0c3-ce0f-b0e3-57ee1176bbf8@huawei.com>
 <797432ab-1ef5-92e3-b512-bdcee57d1053@huawei.com>
 <CACVXFVOijCDjFa339Dyxnp9_0W5UjDyF-a42Dmo-6pogu+rp5Q@mail.gmail.com>
 <b0f35177-70f3-541d-996b-ebb364634225@huawei.com>
 <f759c5bca7de4b2af2e1cabd2f476e3c@kernel.org>
 <7ae71bf1-fd1f-d97e-1e72-646e2e6c8b3c@huawei.com>
 <c8a31bf9-7e25-aff1-e0df-7d9106324b9f@huawei.com>
Message-ID: <19e798801684f952e7237240ca3b43f0@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, tom.leiming@gmail.com, tglx@linutronix.de, ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org, bvanassche@acm.org, hare@suse.com, hch@lst.de, chenxiang66@hisilicon.com, kbusch@kernel.org, liudongdong3@huawei.com, wanghuiqiang@huawei.com, wangzhou1@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-05 14:08, John Garry wrote:
> On 03/02/2020 18:16, John Garry wrote:
>> On 03/02/2020 15:43, Marc Zyngier wrote:
>>> On 2020-02-03 12:56, John Garry wrote:
>>> 
>>> [...]
>>> 
>>>>> Can you trigger it after disabling irqbalance?
>>>> 
>>>> No, so tested by killing the irqbalance process and it ran for 25
>>>> minutes without issue.
>>> 
>>> OK, that's interesting.
>>> 
>>> Can you find you whether irqbalance tries to move an interrupt to an 
>>> offlined CPU?
>>> Just putting a trace into git_set_affinity() should be enough.
>>> 
>> 
> 
> Just an update here: I have tried this same test on a new model dev
> board and I don't experience the same issue. It's quite stable.

Is it the exact same SoC? Or a revised version?

> I'd like to get to the bottom of the issue reported, but I feel that
> the root cause may be a BIOS issue and I will get next to no BIOS
> support for that particular board. Hmmm.

I'd very much like to understand it too. Your latest log is even more 
puzzling,
as the backtrace shows a switch_to() even earlier... The fact that this 
only
happens on hotplug off tends to tell me that the firmware gets confused 
with
PSCI OFF. You'd see something like that if a CPU was taken into the 
firmware
(or powered-off) without the rest of the kernel knowing...

Could it be that PSCI powers off more than a single CPU at once?

         M.
-- 
Jazz is not dead. It just smells funny...
