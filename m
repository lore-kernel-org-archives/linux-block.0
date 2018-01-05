Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeAEEEh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 23:04:37 -0500
Subject: Re: [PATCH v1 00/10] cache device failure handling improvement
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, tang.junhui@zte.com.cn
References: <20180103140325.63175-1-colyli@suse.de>
 <e53e363e-740d-5974-d989-6bf2c3a37dac@lyle.org>
 <d0c930bf-ea36-9fe5-3cce-b8f56e1b163e@suse.de>
 <59499361-3823-1cfb-1306-c0ef16125e8d@lyle.org>
From: Coly Li <colyli@suse.de>
Message-ID: <5738e67e-9eed-34a7-c71b-29aa1265555f@suse.de>
Date: Fri, 5 Jan 2018 12:04:26 +0800
MIME-Version: 1.0
In-Reply-To: <59499361-3823-1cfb-1306-c0ef16125e8d@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/01/2018 1:46 AM, Michael Lyle wrote:
> Coly--
> 
> On 01/03/2018 06:20 PM, Coly Li wrote:
>> Thanks for doing this. When you test the patch set, please apply them
>> together, because the bugs that the first 8 patches try to fix won't be
>> triggered without applying the last 2 patches, especially the io_disable
>> patch.
> 
> Eventually I will test & review the whole set, but I need to concentrate
> on testing something for a first submission to 4.16.  So I've taken
> 1,2,3 and 8 because they're easiest and have some benefit on their own
> without 9 & 10.
> 
> This means that next pass through the review we'll at least have a few
> fewer patches to look at, too.

Hi Mike,

Sure, I agree with you. Thanks :-)

Coly Li
