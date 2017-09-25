Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:48834 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933440AbdIYKPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 06:15:14 -0400
Received: by mail-wm0-f53.google.com with SMTP id m127so17892561wmm.3
        for <linux-block@vger.kernel.org>; Mon, 25 Sep 2017 03:15:13 -0700 (PDT)
Subject: Re: [PATCH 4/6] lightnvm: pblk: improve error message if down_timeout
 fails
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170921112729.GA28553@dhcp-216.srv.tuxera.com>
 <F526444E-C13D-439A-BC00-34D7A3F6C8FF@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <55dfff8b-6e74-89bb-7c3f-1286cb4ea914@lightnvm.io>
Date: Mon, 25 Sep 2017 12:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <F526444E-C13D-439A-BC00-34D7A3F6C8FF@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/22/2017 10:55 AM, Javier González wrote:
>> On 21 Sep 2017, at 13.27, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> The two pr_err messages are useless as they don't even differentiate
>> error code.
>>
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 12 ++----------
>> 1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index b92eabc..74ddb30 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1734,16 +1734,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
>> #endif
>>
>> 	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>> -	if (ret) {
>> -		switch (ret) {
>> -		case -ETIME:
>> -			pr_err("pblk: lun semaphore timed out\n");
>> -			break;
>> -		case -EINTR:
>> -			pr_err("pblk: lun semaphore timed out\n");
>> -			break;
>> -		}
>> -	}
>> +	if (ret == -ETIME || ret == -EINTR)
>> +		pr_err("pblk: taking lun semaphore timed out: err %d\n", -ret);
>> }
>>
>> void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
>> --
>> 2.5.0
> 
> Looks good.
> 
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 
Thanks, I picked it up.
