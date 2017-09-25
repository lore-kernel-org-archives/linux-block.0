Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:47542 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdIYKOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 06:14:53 -0400
Received: by mail-wm0-f48.google.com with SMTP id r136so17885116wmf.2
        for <linux-block@vger.kernel.org>; Mon, 25 Sep 2017 03:14:53 -0700 (PDT)
Subject: Re: [PATCH 2/6] lightnvm: pblk: protect line bitmap while submitting
 meta io
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170921112620.GA28524@dhcp-216.srv.tuxera.com>
 <A1244F27-AE62-433A-AFC2-5F40E8B96B53@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <579b8e72-9251-521a-dc18-ce294e52e4b8@lightnvm.io>
Date: Mon, 25 Sep 2017 12:14:51 +0200
MIME-Version: 1.0
In-Reply-To: <A1244F27-AE62-433A-AFC2-5F40E8B96B53@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/22/2017 10:49 AM, Javier González wrote:
>> On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> It seems pblk_dealloc_page would race against pblk_alloc_pages for
>> line bitmap for sector allocation.  The chances are very low but might
>> as well protect the bitmap properly.  It's not even in fast path.
>>
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index a230125..b92eabc 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -502,12 +502,14 @@ void pblk_dealloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
>> 	u64 addr;
>> 	int i;
>>
>> +	spin_lock(&line->lock);
>> 	addr = find_next_zero_bit(line->map_bitmap,
>> 					pblk->lm.sec_per_line, line->cur_sec);
>> 	line->cur_sec = addr - nr_secs;
>>
>> 	for (i = 0; i < nr_secs; i++, line->cur_sec--)
>> 		WARN_ON(!test_and_clear_bit(line->cur_sec, line->map_bitmap));
>> +	spin_lock(&line->lock);
>> }
>>
>> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int nr_secs)
>> --
>> 2.5.0
> 
> Looks good. The reason not to have locks here was that the caller is
> always on the write thread - who did the allocation -, since it is error
> handling. So there is no protection needed. In any case, it is better to
> have it since it is implemented as a helper function.
> 
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks, I picked it up.
