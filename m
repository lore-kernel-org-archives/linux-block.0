Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6117C4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8894F604AC
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 12:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhGZLvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:51:24 -0400
Received: from smtp99.ord1c.emailsrvr.com ([108.166.43.99]:46334 "EHLO
        smtp99.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234161AbhGZLvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 07:51:15 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 07:51:13 EDT
X-Auth-ID: markh@compro.net
Received: by smtp13.relay.ord1c.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id C6730A0115;
        Mon, 26 Jul 2021 08:23:48 -0400 (EDT)
Reply-To: markh@compro.net
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
To:     Denis Efremov <efremov@linux.com>, dmarkh@cfl.rr.com,
        linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
 <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
 <f5501a7c-4387-259d-66d2-f10db0cf36ff@cfl.rr.com>
 <f1277dcb-6bf8-b149-ad4e-68a4109d4e67@linux.com>
From:   Mark Hounschell <markh@compro.net>
Organization: Compro Computer Svcs.
Message-ID: <1cf8e751-db77-441e-53b4-d6e979bbe046@compro.net>
Date:   Mon, 26 Jul 2021 08:23:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f1277dcb-6bf8-b149-ad4e-68a4109d4e67@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Classification-ID: 0104ae61-b9b1-446d-a266-59dbbb31ebfc-1-1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/21 7:37 AM, Denis Efremov wrote:
> 
> 
> On 7/26/21 2:17 PM, Mark Hounschell wrote:
>> On 7/26/21 3:57 AM, Denis Efremov wrote:
>>> Hi,
>>>
>>> On 7/23/21 9:47 PM, Mark Hounschell wrote:
>>>>
>>>> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.
>>>
>>> Thank you for the report, I'm looking into this.
>>>
>>>> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.
>>>
>>> If it's a project with open sources could you please give a link?
>>>
>>> Regards,
>>> Denis
>>>
>> This is immaterial but fdutils and libdsk both use rely on this flag. Who can know who else does. The point is it should NOT have been changed.
> 
> Yes, I asked this only to add utils and this behavior to the tests.
> And be more specific about why we should preserve this behavior in
> next commit messages.
> 

Well, first thing is now you can't open a floppy with a write protected 
floppy installed. I don't think that was intended but that is now how it is.

Next there are commands that can be sent to the floppy via "ioctl(fd, 
FDRAWCMD,  &raw_cmd);" that do NOT require a floppy diskette to be 
installed.

All commands issued to the device that require a floppy diskette without 
a diskette installed fail with the proper status letting you know the 
device is not ready / no diskette installed. That goes for write 
protected floppies too.

There is no reason to force a user to only be able to operate on Linux 
fdformat formatted floppies.

Regards
Mark

