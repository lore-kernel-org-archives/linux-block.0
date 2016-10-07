Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754533AbcJGUox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Oct 2016 16:44:53 -0400
Subject: Re: [PATCH][V2] nbd: add multi-connection support
To: Pavel Machek <pavel@ucw.cz>
References: <1473950634-4299-1-git-send-email-jbacik@fb.com>
 <20161007183656.GE19976@amd>
CC: <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <w@uter.be>,
        <hch@infradead.org>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <1af1b85a-6d14-b9b3-69b6-96444fccd187@fb.com>
Date: Fri, 7 Oct 2016 16:43:10 -0400
MIME-Version: 1.0
In-Reply-To: <20161007183656.GE19976@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/07/2016 02:36 PM, Pavel Machek wrote:
> On Thu 2016-09-15 10:43:54, Josef Bacik wrote:
>> NBD can become contended on its single connection.  We have to serialize all
>> writes and we can only process one read response at a time.  Fix this by
>> allowing userspace to provide multiple connections to a single nbd device.  This
>> coupled with block-mq drastically increases performance in multi-process cases.
>> Thanks,
>>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
>
> Idea is that it can now use multiple CPUs concurrently...?
>
> Do you have a diff for the nbd-server, too?
> 									Pavel
>

nbd-server doesn't need anything special, it just works.  I have a patch for 
nbd-client so you can open multiple connections to setup the NBD device.  You 
can find my patches for the userspace stuff here

https://github.com/josefbacik/nbd

Thanks,

Josef
