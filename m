Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29590C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D47208C3
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCENkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:40:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:58914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgCENkE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 08:40:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DDADAFF0;
        Thu,  5 Mar 2020 13:40:02 +0000 (UTC)
Subject: Re: [PATCH v2] xen/blkfront: fix ring info addressing
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200305114044.20235-1-jgross@suse.com>
 <20200305124255.GW24458@Air-de-Roger.citrite.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c2c1573a-8c98-4a99-64fb-1346ee724d08@suse.com>
Date:   Thu, 5 Mar 2020 14:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305124255.GW24458@Air-de-Roger.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05.03.20 13:42, Roger Pau Monné wrote:
> On Thu, Mar 05, 2020 at 12:40:44PM +0100, Juergen Gross wrote:
>> Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
>> actual use case") made struct blkfront_ring_info size dynamic. This is
>> fine when running with only one queue, but with multiple queues the
>> addressing of the single queues has to be adapted as the structs are
>> allocated in an array.
>>
>> Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
>> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V2:
>> - get rid of rinfo_ptr() helper
>> - use proper parenthesis in for_each_rinfo()
>> - rename rinfo parameter of for_each_rinfo()
>> ---
>>   drivers/block/xen-blkfront.c | 79 +++++++++++++++++++++++---------------------
>>   1 file changed, 42 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index e2ad6bba2281..8e844da826db 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -213,6 +213,7 @@ struct blkfront_info
>>   	struct blk_mq_tag_set tag_set;
>>   	struct blkfront_ring_info *rinfo;
>>   	unsigned int nr_rings;
>> +	unsigned int rinfo_size;
>>   	/* Save uncomplete reqs and bios for migration. */
>>   	struct list_head requests;
>>   	struct bio_list bio_list;
>> @@ -259,6 +260,18 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
>>   static void blkfront_gather_backend_features(struct blkfront_info *info);
>>   static int negotiate_mq(struct blkfront_info *info);
>>   
>> +#define for_each_rinfo(info, ptr, idx)				\
>> +	for ((ptr) = (info)->rinfo, (idx) = 0;			\
>> +	     (idx) < (info)->nr_rings;				\
>> +	     (idx)++, (ptr) = (void *)(ptr) + (info)->rinfo_size)
>> +
>> +static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,
> 
> I still think inline should be added here, but I don't have such a
> strong opinion to block the patch on it.

I can add it if you like that better. Won't make much difference in the
end.

> Also, info should be constified AFAICT.

Yes.

> 
> With at least info constified:
> 
> Acked-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Can you queue this through the Xen tree?

Sure.


Juergen
