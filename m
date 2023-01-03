Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B41C3DA7D
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 12:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbjACMqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 07:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbjACMqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 07:46:34 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B92E8
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 04:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672749990; x=1704285990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mwfbvVLMDjUETdhI9q31YaVL6c0OLJ5sSWu74g9LlwY=;
  b=A0tW/16bVBR+svhWBRewMWWP5xuhx9jk1OL2snpp5jHf3c+KgwsIao6r
   m/ULdQo80MXj7uaIyXvIAzIs5+JAVQ5oEHmYnVg45zgwNZ7Y4vOP5Rukl
   2sIpzVXiHMxt02XKZRYpOKRMuBRFTTVtjzskS4Rb4OzrwdMZRHbdNkUGi
   DWiVNdYBPPs25ay3Za7MrkD/KoaCBE+JhD7auminzrHVRpdvR2YvAZjRT
   G3d18U5T/1XbDNdYe2NASK0Tykr5tVN8AQUve0i642emtRQN78B8h6y5/
   JfW9A6yzhrlaiccP0Ra6X6xRbbRSodpePnFABNHRRPdiLC77NqQCPKVlc
   A==;
X-IronPort-AV: E=Sophos;i="5.96,297,1665417600"; 
   d="scan'208";a="219815160"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 20:46:29 +0800
IronPort-SDR: jHL99713vhdYfYMRWgOtvfNyKAQWUDFuLanboAnHKjJNlxa15H4dBp4dChokZTFDKmWF+FajCy
 1/0FkqzImPK58V6rLFhJKfAnon6WBpMbphvkRzLrueO27NSmNUjUKQnrwI22CzsfLQuYxXb28X
 AWpoU0qPZy/N8Bq0DJCAFhP4k8L1NhjEHyKzcb+Wi5ujZ8bupfEP0FvCtfOMYKb3ItOWu7EsoY
 IaKMsxj4elKStc3Qp/5Z6ra6ZmL57wdLb5I7hsvLOdvveBosy+SMP7Yj2UZnav9UtHJYBe3g0k
 vT0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2023 03:58:43 -0800
IronPort-SDR: Mk8gh6R7PZ7G7LAINgIkr2QxsBZGSfNe3zUqrAfSMd/WfGuxhzF1IYgApl7f0saDL4j/K7CuXX
 pgUtC0klYlSFKA2bCb0Cuty+v+BqPxYzRMEHonhkCgtJpLjVJYNBaZWspP3gH+11rXPlKrEujG
 GZkKiHJq08o2YB+tJxEi4euvBbRW0UC3VpVlJtp1YhvB1AovSepHe7gvOtA+1wwhgNdHPKVeDB
 SVIFSffqf3oq0uS9ZXvaTG+SkNQzBstiSM0vp2GBGXgFC1M9OmKbgfsMOqBcBEqjZSC6BGE8ZQ
 u9o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2023 04:46:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmXY14Zybz1RvTr
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 04:46:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672749988; x=1675341989; bh=mwfbvVLMDjUETdhI9q31YaVL6c0OLJ5sSWu
        74g9LlwY=; b=Yz0eF1DRluAJkfh9MqMcqQHnbMnxKbgg9g5jVA2GdixO0mGvML9
        J2IOTY2STfC099LX24MyDXOCelfQj61c4CDmx2gBVL04yp7V7zD+TM0OEjchaOsD
        INZNII9nWLSrUghC4f1eXmypqGDgsZzyySW6cWARAIy7wTqrVDnMMNQeHxbCvEbF
        JKplS5/ADAvgqWMdi3jXL2VHkdecr3HkWFGYIUQz4tLkm7yun2tURl4po6I3zz1H
        4KDXjLD1oiwZrYEwnKNlGdajZ0WOzwKeUyMv6cDg9Kwn3RXcTstFg8VcWh7yfREZ
        SgrXBGZbOQw7oQ+tKI17+dfHwdwIkRomdvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BRZAkb80BXwP for <linux-block@vger.kernel.org>;
        Tue,  3 Jan 2023 04:46:28 -0800 (PST)
Received: from [10.225.163.3] (unknown [10.225.163.3])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmXXz3b55z1RvLy;
        Tue,  3 Jan 2023 04:46:27 -0800 (PST)
Message-ID: <89b9c647-3c77-a599-5932-dbfc51d4d1a9@opensource.wdc.com>
Date:   Tue, 3 Jan 2023 21:46:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
 <Y7PhyHWFL/tz6bn0@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y7PhyHWFL/tz6bn0@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/3/23 17:05, Niklas Cassel wrote:
> On Tue, Jan 03, 2023 at 02:19:18PM +0900, Damien Le Moal wrote:
>> From: Christoph Hellwig <hch@infradead.org>
>>
>> Check that the PREFUSH and FUA flags are only set on write bios,
>> given that the flush state machine expects that.
>>
>> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
>> these are data write operations used by btrfs and zonefs and may also
>> have the REQ_FUA bit set.
>>
>> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  block/blk-core.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 9321767470dc..c644aac498ef 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
>> 	 * Filter flush bio's early so that bio based drivers without flush
>> 	 * support don't have to worry about them.
>> 	 */
>> -	if (op_is_flush(bio->bi_opf) &&
>> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
>> -		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
>> -		if (!bio_sectors(bio)) {
>> -			status = BLK_STS_OK;
>> +	if (op_is_flush(bio->bi_opf)) {
>> +		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE &&
>> +				 bio_op(bio) != REQ_OP_ZONE_APPEND))
>> 			goto end_io;
>> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
>> +			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
>> +			if (!bio_sectors(bio)) {
>> +				status = BLK_STS_OK;
>> +				goto end_io;
>> +			}
>> 		}
>> 	}
> 
> Hello Damien,
> 
> In a previous email I wrote:
> 
>> It seems that you can have flag WC set, without having flag FUA set.
>>
>> So should perhaps the line:
>>
>>> +             if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
>>
>> instead be:
>>
>> if (!test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
> 
> You replied with:
> "Need both. If there is no write cache or write cache is off, FUA is
> implied and is useless.">
> Did you change your mind since then?

I checked the flush machinery code again to be sure and we do not need to
check "if (!test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {" because this is
exactly what blk-flush.c code will handle: if the device support FUA, the
write is sent as is and if it does not, then the flush machinery sent a
regular write followed by a cache flush command. See the chain:

submit_bio_noacct() -> submit_bio_noacct_nocheck() ->
__submit_bio_noacct[_mq]() -> __submit_bio() -> blk_mq_submit_bio() ->
blk_insert_flush().

Then see blk_insert_flush() handling of the various cases based off the
device features and request.

So that QUEUE_FLAG_FUA test here does not make any sense.

Checking for the no write cache case does make sense though, as in that
case, all writes are FUA. So clearing the FUA & PREFLUSH flags for devices
that do not have write caching is the right thing to do.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

