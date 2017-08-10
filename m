Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:43962 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbdHJPqs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2017 11:46:48 -0400
Subject: Re: [PATCH] loop: fix to a race condition due to the early
 registration of device
To: Omar Sandoval <osandov@osandov.com>
Cc: tom.leiming@gmail.com, axboe@fb.com, osandov@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ldv-project@linuxtesting.org, khoroshilov@ispras.ru
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
 <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
 <20170808220047.GA4072@vader.DHCP.thefacebook.com>
From: Anton Volkov <avolkov@ispras.ru>
Message-ID: <acf56d41-a135-4758-ef0b-ca2dc345d5f2@ispras.ru>
Date: Thu, 10 Aug 2017 18:46:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170808220047.GA4072@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Omar.

It was a purely theoretical race that had been considered to be possible 
in real-life.

Regards,
Anton

On 09.08.2017 01:00, Omar Sandoval wrote:
> On Mon, Aug 07, 2017 at 03:37:50PM +0300, Anton Volkov wrote:
>> The early device registration made possible a race leading to allocations
>> of disks with wrong minors.
>>
>> This patch moves the device registration further down the loop_init
>> function to make the race infeasible.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Anton Volkov <avolkov@ispras.ru>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Hi, Anton,
> 
> Were you able to reproduce this issue or was it purely theoretical? If
> the former, it'd be nice if you could add a test case to blktests [1].
> 
> 1: https://github.com/osandov/blktests
> 
> Thanks!
> Omar
> 

-- Anton Volkov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: avolkov@ispras.ru
