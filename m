Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53191 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdJBIXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 04:23:24 -0400
Received: by mail-wm0-f43.google.com with SMTP id k4so6766000wmc.1
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 01:23:24 -0700 (PDT)
Subject: Re: [PATCH 4/6] lightnvm: remove stable extern and unused exported
 symbols
To: Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171001132516.GA5743@hercules.tuxera.com>
 <20171001135452.GA6351@hercules.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <23f66935-eb6a-7e72-48c5-a07f7d9d0572@bjorling.me>
Date: Mon, 2 Oct 2017 10:23:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171001135452.GA6351@hercules.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 10/01/2017 03:54 PM, Rakesh Pandit wrote:
> On Sun, Oct 01, 2017 at 04:25:18PM +0300, Rakesh Pandit wrote:
>> Not all exported symbols are being used outside core and there were
>> some stable entries in lightnvm.h
>>
> 
> If you can replace 'stable' with 'stale' both in subject or body while
> picking up that would be great.
> 
> Regards,
> 

Will do. Thanks!
