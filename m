Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:50256 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdHGNJO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 09:09:14 -0400
Subject: Re: [PATCH] loop: fix to a race condition due to the early
 registration of device
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: tom.leiming@gmail.com, axboe@fb.com, osandov@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ldv-project@linuxtesting.org, khoroshilov@ispras.ru
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
 <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
 <20170807125413.GZ3978@linux-x5ow.site>
From: Anton Volkov <avolkov@ispras.ru>
Message-ID: <e99d4f73-5d73-8141-558f-c918245abc42@ispras.ru>
Date: Mon, 7 Aug 2017 16:09:12 +0300
MIME-Version: 1.0
In-Reply-To: <20170807125413.GZ3978@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is more of a style-oriented suggestion. This kind of template is 
commonly used in other modules.

Regards,
Anton

On 07.08.2017 15:54, Johannes Thumshirn wrote:
> On Mon, Aug 07, 2017 at 03:37:50PM +0300, Anton Volkov wrote:
>> +err_out:
>>   	return err;
> 
> Any reason you can't just use return err; at the respective callsites?
> 
> Thanks,
> 	Johannes
> 

-- Anton Volkov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: avolkov@ispras.ru
