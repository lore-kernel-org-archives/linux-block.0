Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13845 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeFZPYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 11:24:54 -0400
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
 <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
 <20180626013719.GA31259@ming.t460p>
 <430584e255cc8d25a748bd5d76febb3fd23f8df2.camel@wdc.com>
 <20180626072707.555hshtnr3fgnsxk@linux-x5ow.site>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <ee7ddc2e-888e-952e-db22-7ff20d72265c@wdc.com>
Date: Tue, 26 Jun 2018 08:24:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180626072707.555hshtnr3fgnsxk@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/26/18 00:27, Johannes Thumshirn wrote:
> On Tue, Jun 26, 2018 at 02:16:26AM +0000, Bart Van Assche wrote:
>> On Tue, 2018-06-26 at 09:37 +0800, Ming Lei wrote:
>>> I run SRP test on Fedora 27, and not run any LIO specific commands
>>> to load it, seems it is done automatically.
>>>
>>> So looks it might not a good idea to fail SRP test if LIO is loaded,
>>> just wondering why your SRP test can't make the two co-exist?
>>
>> The LIO configuration is system-wide. Only one configuration can be
>> loaded at any given time. I don't think that the SRP tests should wipe
>> any existing LIO configuration data if e.g. blktests is run accidentally
>> on a production server. I think that wiping LIO configuration data should
>> be a manual step.
> 
> I think this should be handled in requires(). I.e. check if LIO is
> already configured and then skip the test if it is.

As far as I know the requires() function is per test and there is no 
such function at the group level. I prefer to define this test once at 
the group level instead of copy/pasting the same test thirteen times in 
each test.

Bart.
