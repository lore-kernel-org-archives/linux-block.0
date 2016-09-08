Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50727 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751672AbcIHUOL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 16:14:11 -0400
Subject: Re: [PATCH 0/5] nbd improvements
To: Josef Bacik <jbacik@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <mpa@pengutronix.de>, <nbd-general@lists.sourceforge.net>
References: <1473363221-142264-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <aee66977-c8f2-dab7-0649-f4e71fdc31f8@fb.com>
Date: Thu, 8 Sep 2016 14:13:46 -0600
MIME-Version: 1.0
In-Reply-To: <1473363221-142264-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/08/2016 01:33 PM, Josef Bacik wrote:
> This is a patch series aimed at bringing NBD into 2016.  The two big
> components of this series is converting nbd over to using blkmq and
> then allowing us to provide more than one connection for a nbd device.
> The NBD user space server doesn't care about how many connections it
> has to a particular device, so we can easily open multiple
> connections to the server and allow blkmq to handle multi-plexing over
> the different connections.  This drastically improves performance
> with multi-threaded workloads over NBD.  The multi-connection support
> requires some changes to the NBD userspace client code, and you can
> find that code here
>
> https://github.com/josefbacik/nbd
>
> I have been testing this for a few months and it is pretty solid and gives
> excellent performance improvements.  Thanks,

Not only are these nice performance improvements, it also cleans up the
code a lot and kills crufty old driver code in favor of using the proper
APIs instead. I have applied the series for 4.9.

-- 
Jens Axboe

