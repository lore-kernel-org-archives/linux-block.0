Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35229 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042239AbdDUSiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 14:38:22 -0400
Received: by mail-lf0-f47.google.com with SMTP id 75so49088127lfs.2
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 11:38:21 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: propagate pblk_init return to userspace
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
References: <20170420182356.GA7866@hercules.tuxera.com>
 <F1FB4E37-23D4-4E6B-9310-78FA4699556C@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c12bf1b4-3629-7c71-31fd-55468bcee3da@lightnvm.io>
Date: Fri, 21 Apr 2017 20:11:31 +0200
MIME-Version: 1.0
In-Reply-To: <F1FB4E37-23D4-4E6B-9310-78FA4699556C@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/21/2017 05:07 PM, Javier González wrote:
>> On 20 Apr 2017, at 20.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> From userspace calling ioctl(NVM_DEV_CREATE) was returning ENOMEM for
>> invalid arguments even though pblk (pblk_init) was returning correctly
>> -EINVAL to nvm_create_tgt inside core.  This patch propagates the
>> correct return value to userspace.
>>
>> Because pblk was introduced recently this only needs to go in 4.12.
>>
>> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>
>
> Looks good.
>
> Reviewed-by: Javier González <javier@cnexlabs.com>
>
> Javier
>


Jens, would you pick this up as well? :)
