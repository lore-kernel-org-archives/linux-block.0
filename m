Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F5BC43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7EF20815
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mG9oC65M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfCIRAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:00:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37909 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIRAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Mar 2019 12:00:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so603405edb.5
        for <linux-block@vger.kernel.org>; Sat, 09 Mar 2019 09:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JcLBMUbky8csxrEMAbWcd1BQ10ABcEgYK69N1/6cwg=;
        b=mG9oC65M/5KSdNX9BfV89n0+gXWb7jMdHv6j9CDC/PC1U4v+DAw7+92MCHqeNnGoE0
         Y8GEwKKCqgMipfkmGI3nWH+jqR+7eG0rREUuEnEIWg5QKptBRYGjIHJ9IEAryvQsoeqe
         cdvg9ZjSsPDfVq/ywsYRF0dq1m893z9VplzcBKAzSIaPHw6cXdZohrwQwdaiFbN4qO9d
         oNu1w3zHg38RILZEWZ4MyQEWOE//u6gmM1IeNGNjMaUYfPFlq1lrbmWjLCIPNPScvzPT
         fXZGq0wUnl2HUNBadoQO4Jcb1bLVlRtxzoQwh32z2ogHjdlsGvhkLuy7kUFKyTPcNQ54
         4RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JcLBMUbky8csxrEMAbWcd1BQ10ABcEgYK69N1/6cwg=;
        b=tcvjSm1WzC19y/oNmrj4oQHsEfuhDxPUr+DLyUPHqXd6wJ2QqOXhY4G1LsV6+Bggqx
         vkK7T1Z1LqqCWkOQ4SeHZi2mhJiHWsKbGOSgw4NPy0qmmG2gxQXrEmZp8HkMjskfPaDz
         kytNadv98yDegVi7s5Q8HdyjwxhaVxhVd49WbjmlTIjlEa/3VrsWyLbWFemWub4PuGvL
         kpHIjUExe2n5FZB9SU/K+p8T9noTpEdSk3ujXnmSQHDLMtTVMZcNWPKmrCOsNIV50ix/
         4Ww1rlPn2p0SANxLac1sx/0c297vX3KDw3+cNsOei0oy+TafIrp0IPu8la7JeddlD0HE
         dexQ==
X-Gm-Message-State: APjAAAUp8+dvGi24Xpw5vKOhRY0mS8f+xWb4rwTqqobK1/fI15QOupBC
        sGUY8Hzd2JGt7qlUn9qDQnajQwCy7YI=
X-Google-Smtp-Source: APXvYqx/DD9N6IBbu4Pwrk/pBEwXLmwyRoKNYa2jHvrTSI9kLecMCCYMQ/nsgN9+e+WMno6Y+TyB3A==
X-Received: by 2002:a50:9125:: with SMTP id e34mr36658694eda.183.1552150807973;
        Sat, 09 Mar 2019 09:00:07 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id k15sm3213526eda.22.2019.03.09.09.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 09:00:07 -0800 (PST)
Subject: Re: [PATCH v2] lightnvm: pblk: fix bio leak on large sized io
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        chansol.kim@samsung.com
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <CGME20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
 <20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
 <CB2701F7-17BA-4057-B1A7-6E2E0B9DEBEB@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a89ce2ca-40a3-faae-97c2-12e2609241a3@lightnvm.io>
Date:   Sat, 9 Mar 2019 18:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CB2701F7-17BA-4057-B1A7-6E2E0B9DEBEB@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/19 1:20 PM, Javier González wrote:
>> On 7 Mar 2019, at 08.23, Chansol Kim <chansol.kim@samsung.com> wrote:
>>
>> For large size io where blk_queue_split needs to be called inside
>> pblk_rw_io, results in bio leak as bio_endio is not called on the
>> newly allocated. One way to observe this is to mounting ext4
>> filesystem on the target and issuing 1MB io with dd, e.g., dd bs=1MB
>> if=/dev/null of=/mount/myvolume. kmemleak reports:
>>
>> unreferenced object 0xffff88803d7d0100 (size 256):
>>   comm "kworker/u16:1", pid 68, jiffies 4294899333 (age 284.120s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 60 e8 31 81 88 ff ff  .........`.1....
>>     01 40 00 00 06 06 00 00 00 00 00 00 05 00 00 00  .@..............
>>   backtrace:
>>     [<000000001f5aa04f>] kmem_cache_alloc+0x204/0x3c0
>>     [<0000000040945aab>] mempool_alloc_slab+0x1d/0x30
>>     [<00000000b4959ab4>] mempool_alloc+0x83/0x220
>>     [<00000000646bad9b>] bio_alloc_bioset+0x229/0x320
>>     [<000000009264b251>] bio_clone_fast+0x26/0xc0
>>     [<0000000008250252>] bio_split+0x41/0x110
>>     [<00000000e365cad0>] blk_queue_split+0x349/0x930
>>     [<00000000eb5426bc>] pblk_make_rq+0x1b5/0x1f0
>>     [<00000000eea09cec>] generic_make_request+0x2f9/0x690
>>     [<00000000ae6acede>] submit_bio+0x12e/0x1f0
>>     [<00000000f9b8b82a>] ext4_io_submit+0x64/0x80
>>     [<000000009e4f817d>] ext4_bio_write_page+0x32e/0x890
>>     [<00000000cbd0d106>] mpage_submit_page+0x65/0xc0
>>     [<000000000eec7359>] mpage_map_and_submit_buffers+0x171/0x330
>>     [<000000009a7afcb6>] ext4_writepages+0xd5e/0x1650
>>     [<000000004476b096>] do_writepages+0x39/0xc0
>>
>> In case there is a need for a split, blk_queue_split returns the newly
>> allocated bio to the caller by changing the value of pointer passed as
>> a reference, while the original is passed to generic_make_requests.
>>
>> Although pblk_rw_io's local variable bio* has changed and passed to
>> pblk_submit_read and pblk_write_to_cache, work is done on this new
>> bio*, and pblk_rw_io returns NVM_IO_DONE, pblk_make_rq calls bio_endio
>> on the old bio* because it passed bio pointer by value to pblk_rw_io.
>>
>> pblk_rw_io is unfolded into pblk_make_rq so that there is no copying
>> of bio* and bio_endio is called on the correct bio*.
>>
>> Signed-off-by: Chansol Kim <chansol.kim@samsung.com>
>> ---
>> v2:
>> - Instead of changing pblk_rw_io's parameter, unfolded it into pblk_make_rq
>>
>> drivers/lightnvm/pblk-init.c | 47 ++++++++++++++++++--------------------------
>> 1 file changed, 19 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 8b643d0..0c98305 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -47,36 +47,10 @@ static struct pblk_global_caches pblk_caches = {
>>
>> struct bio_set pblk_bio_set;
>>
>> -static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>> -			  struct bio *bio)
>> -{
>> -	int ret;
>> -
>> -	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
>> -	 * constraint. Writes can be of arbitrary size.
>> -	 */
>> -	if (bio_data_dir(bio) == READ) {
>> -		blk_queue_split(q, &bio);
>> -		ret = pblk_submit_read(pblk, bio);
>> -		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
>> -			bio_put(bio);
>> -
>> -		return ret;
>> -	}
>> -
>> -	/* Prevent deadlock in the case of a modest LUN configuration and large
>> -	 * user I/Os. Unless stalled, the rate limiter leaves at least 256KB
>> -	 * available for user I/O.
>> -	 */
>> -	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
>> -		blk_queue_split(q, &bio);
>> -
>> -	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
>> -}
>> -
>> static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
>> {
>> 	struct pblk *pblk = q->queuedata;
>> +	int ret;
>>
>> 	if (bio_op(bio) == REQ_OP_DISCARD) {
>> 		pblk_discard(pblk, bio);
>> @@ -86,7 +60,24 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
>> 		}
>> 	}
>>
>> -	switch (pblk_rw_io(q, pblk, bio)) {
>> +	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
>> +	 * constraint. Writes can be of arbitrary size.
>> +	 */
>> +	if (bio_data_dir(bio) == READ) {
>> +		blk_queue_split(q, &bio);
>> +		ret = pblk_submit_read(pblk, bio);
>> +	} else {
>> +		/* Prevent deadlock in the case of a modest LUN configuration
>> +		 * and large user I/Os. Unless stalled, the rate limiter
>> +		 * leaves at least 256KB available for user I/O.
>> +		 */
>> +		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
>> +			blk_queue_split(q, &bio);
>> +
>> +		ret = pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
>> +	}
>> +
>> +	switch (ret) {
>> 	case NVM_IO_ERR:
>> 		bio_io_error(bio);
>> 		break;
>> --
>> 2.7.4
> 
> Looks good to me.
> 
> Reviewed-by: Javier González <javier@javigon.com>
> 

Thanks. Applied to 5.2.
