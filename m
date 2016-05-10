Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11487 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752589AbcEJOnW (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 10:43:22 -0400
Subject: Re: [PATCH 00/28] LightNVM fixes for 4.7
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1462557801-24974-1-git-send-email-m@bjorling.me>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5731F386.9000505@fb.com>
Date: Tue, 10 May 2016 08:43:18 -0600
MIME-Version: 1.0
In-Reply-To: <1462557801-24974-1-git-send-email-m@bjorling.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/06/2016 12:02 PM, Matias Bjørling wrote:
> Hi Jens,
>
> A collection of fixes and features destined for 4.7. They contain:
>
>    Fixes all over the place from Arnd, Jeff, Sagi, Wenwei, Javier and me.
>
>    Preparation patches from Simon to enable sysfs support. The final
>    patch is delayed to 4.8. We need to integrate it correctly with
>    device drivers.
>
>    A patch from Javier to allow a target to access the metadata field.
>    Typically it maps to the flash page out of band area.
>
>    Preparation patches for pblk and persistent block management
>    information from me.
>
> Please pick up.

Added for 4.7, thanks.

-- 
Jens Axboe

