Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43532 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeAaIfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jan 2018 03:35:50 -0500
Received: by mail-lf0-f68.google.com with SMTP id o89so19392669lfg.10
        for <linux-block@vger.kernel.org>; Wed, 31 Jan 2018 00:35:49 -0800 (PST)
Subject: Re: [PATCH 1/2] lightnvm: remove mlc pairs structure
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180130132605.28635-1-m@bjorling.me>
 <E2E51BC8-63D4-40EC-9912-398BB73C9F16@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e807b046-7d83-9cea-377c-03eb6fd1f662@lightnvm.io>
Date: Wed, 31 Jan 2018 09:35:47 +0100
MIME-Version: 1.0
In-Reply-To: <E2E51BC8-63D4-40EC-9912-398BB73C9F16@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/31/2018 03:00 AM, Javier González wrote:
>> On 30 Jan 2018, at 21.26, Matias Bjørling <m@bjorling.me> wrote:
>>
>> The known implementations of the 1.2 specification, and upcoming 2.0
>> implementation all expose a sequential list of pages to write.
>> Remove the data structure, as it is no longer needed.
>>
>> Signed-off-by: Matias Bjørling <m@bjorling.me>
>> ---
>> drivers/nvme/host/lightnvm.c | 14 +-------------
>> 1 file changed, 1 insertion(+), 13 deletions(-)
> 
> Even though the current implementations does not use the MLC pairing
> information, this is part of the on the 1.2 identification. Until we
> eventually remove 1.2 support (if we do), the identify structure should
> reflect the specification as is.
> 
> Javier
> 

I already started on removing the MLC bits in previous patches. These 
two patches continue that trend. I don't know of any implementing either 
multiple groups or MLC, and since it has not been implemented before, no 
one is going to use it. No reason to have dead code hanging around. This 
is similar to the NVMe device driver not having definitions for all that 
is in the specification until it is used in the implementation.
