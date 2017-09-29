Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:55610 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdI2Azm (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 28 Sep 2017 20:55:42 -0400
Subject: Re: [PATCH] badblocks: fix wrong return value in badblocks_set if
 badblocks are disabled
To: bo.li.liu@oracle.com, Guoqing Jiang <gqjiang@suse.com>
References: <20170927221317.31237-1-bo.li.liu@oracle.com>
 <86e97dbb-5d8d-66c7-5bc6-39e0d16f7724@suse.com>
 <20170928184506.GB27771@lim.localdomain>
Cc: linux-block@vger.kernel.org, NeilBrown <neilb@suse.com>
From: Guoqing Jiang <gqjiang@suse.com>
Message-ID: <b63ec97f-0f2d-0953-a3cd-7f9ae3cd8d1d@suse.com>
Date: Fri, 29 Sep 2017 09:04:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170928184506.GB27771@lim.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 09/29/2017 02:45 AM, Liu Bo wrote:
> On Thu, Sep 28, 2017 at 09:57:41AM +0800, Guoqing Jiang wrote:
>>
>> On 09/28/2017 06:13 AM, Liu Bo wrote:
>>> MD's rdev_set_badblocks() expects that badblocks_set() returns 1 if
>>> badblocks are disabled, otherwise, rdev_set_badblocks() will record
>>> superblock changes and return success in that case and md will fail to
>>> report an IO error which it should.
>>>
>>> This bug has existed since badblocks were introduced in commit
>>> 9e0e252a048b ("badblocks: Add core badblock management code").
>> I don't think we need to change it since it originally was return 0 in
>> original
>> commit.
> The difference is that the original md_set_badblocks() returns 0 for
> both "being disabled" and "no room", while now badblocks_set() returns
> 1 for "no room" as a failure but 0 for "being disabled".

Thanks for point it out, you are right, and the below comments said:

  * Return:
  *  0: success
  *  1: failed to set badblocks (out of space)

Maybe it is better to add "badblocks are disabled" to above comment.

Anyway, Acked-by: Guoqing Jiang <gqjiang@suse.com>

Regards,
Guoqing
