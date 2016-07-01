Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16778 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752510AbcGAO0m (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 1 Jul 2016 10:26:42 -0400
Subject: Re: [PATCH] nbd: convert to blkmq
To: Josef Bacik <jbacik@fb.com>, <mpa@pengutronix.de>,
	<linux-kernel@vger.kernel.org>,
	<nbd-general@lists.sourceforge.net>, <kernel-team@fb.com>,
	<linux-block@vger.kernel.org>
References: <1467382507-523615-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <57767D8E.40808@fb.com>
Date: Fri, 1 Jul 2016 08:26:22 -0600
MIME-Version: 1.0
In-Reply-To: <1467382507-523615-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/01/2016 08:15 AM, Josef Bacik wrote:
> This moves NBD over to using blkmq, which allows us to get rid of the NBD
> wide queue lock and the async submit kthread.  We will start with 1 hw
> queue for now, but I plan to add multiple tcp connection support in the
> future and we'll fix how we set the hwqueue's.

Looks pretty clean. I'd get rid of that horrible nbd_find_request() as 
well, though. Store the request tag in the reply.handle, and then just 
lookup the request from the tag, if the tag is valid. The resulting 
request can then be checked for proper state (started).

nbd->active_cmd needs to die as well.

-- 
Jens Axboe

