Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E41C35646
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 15:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210CA20679
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 15:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgBUPZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:25:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:14131 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgBUPZt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 10:25:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 07:25:48 -0800
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; 
   d="scan'208";a="225243362"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.78.27.169])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2020 07:25:47 -0800
Subject: Re: [PATCH v2 2/2] md: enable io polling
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
 <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
 <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
 <20200212214207.GA6409@redsun51.ssa.fujisawa.hgst.com>
 <f516e2b2-1988-03ca-f966-5f26771717ff@linux.intel.com>
 <20200214192526.GA10991@redsun51.ssa.fujisawa.hgst.com>
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <db131d8e-b622-ec80-411e-2ca7643997a7@linux.intel.com>
Date:   Fri, 21 Feb 2020 08:25:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200214192526.GA10991@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/20 12:25 PM, Keith Busch wrote:
> On Thu, Feb 13, 2020 at 01:19:42PM -0700, Andrzej Jakowski wrote:
>> On 2/12/20 2:42 PM, Keith Busch wrote:
>>> Okay, that's a nice subtlety. But it means the original caller gets the
>>> cookie from the last submission in the chain. If md recieves a single
>>> request that has to be split among more than one member disk, the cookie
>>> you're using to control the polling is valid only for one of the
>>> request_queue's and may break others.
>> Correct, I agree that it is an issue. I can see at least two ways how to solve it:
>>  1. Provide a mechanism in md accounting for outstanding IOs, storing cookie information 
>>     for them. md_poll() will then use valid cookie's
>>  2. Provide similar mechanism abstracted for stackable block devices and block layer could
>>     handle completions for subordinate bios in an abstracted way in blk_poll() routine.
>> How do you Guys see this going?
> Honestly, I don't see how this is can be successful without a more
> significant change than you may be anticipating. I'd be happy to hear if
> there's a better solution, but here's what I'm thinking:
> 
> You'd need each stacking layer to return a cookie that its poll function
> can turn into a list of { request_queue, blk_qc_t } tuples for each bio
> the stacking layer created so that it can chain the poll request to the
> next layers.
> 
> The problems are that the stacking layers don't get a cookie for the
> bio's it submits from within the same md_make_request() context. Even if
> you could get the cookie associated with those bios, you either allocate
> more memory to track these things, or need polling bio list link fields
> added 'struct bio', neither of which seem very appealing.
> 
> Do you have a better way in mind?

Your proposal makes sense to me, yet still it requires significant rework
in generic_make_request(). I believe that generic_make_request() would 
have to return/store cookie for each subordinate bio. I'm wondering why 
cookie is needed for polling at all? From my understanding it looks 
like cookie info is used to find HW context which to poll on. Hybrid
polling uses it to find particular IO request and set its 'RQF_MQ_POLL_SLEPT'
flag. 

Now, if we assume that cookie is not passed to polling function, poll_fn
would need to find HW context to poll on in different way. Perhaps reference
to it could be stored in request_queue itself? Polling in stackable block
drivers would be much simpler -- they would call polling for underlying MQ
device, which in turn would poll on correct HW context.

Does this approach sound reasonable? 

