Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90BC2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 11:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE8E20719
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NTjrurU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIVLfd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 07:35:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIVLfd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 07:35:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600774530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xKyn37igCwVdW/X/CBmTomDtKCHpuashkMdG2jkb4c=;
        b=NTjrurU/+zwFRQtn4hfGYg2GOko6dC0SeUB1QZtnNa696pUrSKZKZgYVa5HxMkhxO4U8oL
        oOvogVfpTUYSvHszpbI59Xoup8VEs6dfyakD7OOTWNwduP1XAeRLB+kZMPVVcUxxN3ckj9
        zGzn/HVDMrBuie6uMe1/nvylnsgDZLk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D52CAE1C;
        Tue, 22 Sep 2020 11:36:07 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] xen-blkback: add a parameter for disabling of
 persistent grants
To:     SeongJae Park <sjpark@amazon.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     konrad.wilk@oracle.com, SeongJae Park <sjpark@amazon.de>,
        axboe@kernel.dk, aliguori@amazon.com, amit@kernel.org,
        mheyne@amazon.de, pdurrant@amazon.co.uk,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20200922112638.14238-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <33a8d880-d8ce-0cf7-d115-ca6938889f27@suse.com>
Date:   Tue, 22 Sep 2020 13:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922112638.14238-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.09.20 13:26, SeongJae Park wrote:
> On Tue, 22 Sep 2020 13:12:59 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> 
>> On Tue, Sep 22, 2020 at 12:52:07PM +0200, SeongJae Park wrote:
>>> From: SeongJae Park <sjpark@amazon.de>
>>>
>>> Persistent grants feature provides high scalability.  On some small
>>> systems, however, it could incur data copy overheads[1] and thus it is
>>> required to be disabled.  But, there is no option to disable it.  For
>>> the reason, this commit adds a module parameter for disabling of the
>>> feature.
>>>
>>> [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
>>>
>>> Signed-off-by: Anthony Liguori <aliguori@amazon.com>
>>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
>>> ---
>>>   .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++
>>>   drivers/block/xen-blkback/xenbus.c            | 28 ++++++++++++++-----
>>>   2 files changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
>>> index ecb7942ff146..ac2947b98950 100644
>>> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
>>> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
>>> @@ -35,3 +35,12 @@ Description:
>>>                   controls the duration in milliseconds that blkback will not
>>>                   cache any page not backed by a grant mapping.
>>>                   The default is 10ms.
>>> +
>>> +What:           /sys/module/xen_blkback/parameters/feature_persistent
>>> +Date:           September 2020
>>> +KernelVersion:  5.10
>>> +Contact:        SeongJae Park <sjpark@amazon.de>
>>> +Description:
>>> +                Whether to enable the persistent grants feature or not.  Note
>>> +                that this option only takes effect on newly created backends.
>>> +                The default is Y (enable).
>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
>>> index b9aa5d1ac10b..8a95ddd08b13 100644
>>> --- a/drivers/block/xen-blkback/xenbus.c
>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>> @@ -879,6 +879,12 @@ static void reclaim_memory(struct xenbus_device *dev)
>>>   
>>>   /* ** Connection ** */
>>>   
>>> +/* Enable the persistent grants feature. */
>>> +static bool feature_persistent = true;
>>> +module_param(feature_persistent, bool, 0644);
>>> +MODULE_PARM_DESC(feature_persistent,
>>> +		"Enables the persistent grants feature");
>>> +
>>>   /*
>>>    * Write the physical details regarding the block device to the store, and
>>>    * switch to Connected state.
>>> @@ -906,11 +912,15 @@ static void connect(struct backend_info *be)
>>>   
>>>   	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
>>>   
>>> -	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
>>> -	if (err) {
>>> -		xenbus_dev_fatal(dev, err, "writing %s/feature-persistent",
>>> -				 dev->nodename);
>>> -		goto abort;
>>> +	if (feature_persistent) {
>>> +		err = xenbus_printf(xbt, dev->nodename, "feature-persistent",
>>> +				"%u", feature_persistent);
>>> +		if (err) {
>>> +			xenbus_dev_fatal(dev, err,
>>> +					"writing %s/feature-persistent",
>>> +					dev->nodename);
>>> +			goto abort;
>>> +		}
>>>   	}
>>>   
>>>   	err = xenbus_printf(xbt, dev->nodename, "sectors", "%llu",
>>> @@ -1093,8 +1103,12 @@ static int connect_ring(struct backend_info *be)
>>>   		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
>>>   		return -ENOSYS;
>>>   	}
>>> -	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
>>> -					   0);
>>> +	if (feature_persistent)
>>> +		pers_grants = xenbus_read_unsigned(dev->otherend,
>>> +				"feature-persistent", 0);
>>> +	else
>>> +		pers_grants = 0;
>>> +
>>
>> Sorry for not realizing earlier, but looking at it again I think you
>> need to cache the value of feature_persistent when it's first used in
>> the blkback state data, so that it's consistent.
>>
>> What would happen for example with the following flow (assume a
>> persistent grants enabled frontend):
>>
>> feature_persistent = false
>>
>> connect(...)
>> feature-persistent is not written to xenstore
>>
>> User changes feature_persistent = true
>>
>> connect_ring(...)
>> pers_grants = true, because feature-persistent is set unconditionally
>> by the frontend and feature_persistent variable is now true.
>>
>> Then blkback will try to use persistent grants and the whole
>> connection will malfunction because the frontend won't.
> 
> Ah, you're right.  I should also catch this before but didn't, sorry.
> 
>>
>> The other option is to prevent changing the variable when there are
>> blkback instances already running.
> 
> I think storing the option value in xenstore would be simpler.  That said, if
> you prefer this way, please let me know.

No, Xenstore isn't the right place for that. This is a local
implementation detail of blkback and shouldn't be exported to Xenstore.


Juergen
