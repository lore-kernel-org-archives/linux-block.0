Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34397 "EHLO
	esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbcGAFfX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2016 01:35:23 -0400
From: Damien Le Moal <Damien.LeMoal@hgst.com>
To: Christoph Hellwig <hch@lst.de>
CC: Amir Goldstein <amir73il@gmail.com>,
	Ming Lei <ming.lei@canonical.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>
Subject: Re: Question about loop device DIO/AIO and FLUSH
Date: Fri, 1 Jul 2016 05:35:19 +0000
Message-ID: <70FF06D7-7048-46DF-BB62-35C8BC4358AC@hgst.com>
References: <CAOQ4uxhEzr=yaFPO4ZVzndct84VC6c57W5DNEtqUHUcBjdTjQg@mail.gmail.com>
 <20160701042510.GA381@lst.de> <E8DEFE4F-67B6-4A9A-83F0-3AA554AEFFB1@hgst.com>
 <20160701050455.GA828@lst.de> <3D8F3502-8EA7-4568-882B-90E48C8F6BCF@hgst.com>
 <20160701053227.GA917@lst.de>
In-Reply-To: <20160701053227.GA917@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph,

> On Jul 1, 2016, at 14:32, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Fri, Jul 01, 2016 at 05:17:28AM +0000, Damien Le Moal wrote:
>> Thank you for the clarification. Makes sense.
>> Just to be picky though, I think that "completed I/Os" applies only
>> to flush in this case (flush of the volatile device cache to media).
>> fsync of the host cache (page cache most of the time) to the device
>> will issue new BIOs, and those will be waited for until completed.
>> Right ?
> 
> For fsync the completed I/O at the syscall / VFS level.  Fsync only
> needs to cover read/write calls that have return to the user, be that
> through a synchronous call or aio completion.

Got it. Thanks.

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

