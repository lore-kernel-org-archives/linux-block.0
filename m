Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57822 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdBJB2M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2017 20:28:12 -0500
Subject: Re: [PATCH 1/1] dm-zoned: Zoned block device target
To: Hannes Reinecke <hare@suse.de>, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <20170209041849.30964-1-damien.lemoal@wdc.com>
 <d2353e66-183c-1f71-7a64-52e4b862bc17@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <e6e86f98-c9d4-c797-8dc1-f7dccd30fafe@wdc.com>
Date: Fri, 10 Feb 2017 10:24:59 +0900
MIME-Version: 1.0
In-Reply-To: <d2353e66-183c-1f71-7a64-52e4b862bc17@suse.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hannes,

On 2/10/17 01:07, Hannes Reinecke wrote:
>> +/*
>> + * CRC32
>> + */
>> +static u32 dmz_sb_crc32(u32 crc, const void *buf, size_t length)
>> +{
>> +	unsigned char *p = (unsigned char *)buf;
>> +	int i;
>> +
>> +#define CRCPOLY_LE 0xedb88320
>> +
>> +	while (length--) {
>> +		crc ^= *p++;
>> +		for (i = 0; i < 8; i++)
>> +			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
>> +	}
>> +
>> +	return crc;
>> +}
>> +
> Why do you insist on your own CRC32 implementations?
> Don't we have enough already?

Indeed. I will change this to use existing kernel API.

> Have you looked at using dm-kcopyd for doing the reclaim?
> What's inhibiting you from using it?

I did look at it, and I did like it very much. It would be much more
simple to use than open coding everything like I did. But the problem is
that while the read part is fine, the write part is not. The reason is
that most of the time, the zone being reclaimed is badly fragmented
(valid blocks all over the place in the zone). Reading those valid
blocks with kcopyd is fine, but when moving them to the target zone, the
overall write sequence MUST be sequential, which means that
blkdev_issue_zeroout calls must be inserted between non sequential
regions (the indirection system is per zone, not per block, so the
relative offsets of the blocks read in the zone being reclaimed must be
preserved in the destination zone).

I could modify kcopyd_copy to do this zeroout insertion of course. In
fact, I think that would be the better approach. But I think that can be
done later, once/if Mike accepts dm-zoned. Or I could re-submit dm-zoned
together with a patch for kcopyd_copy.

Mike,
Any advice on which approach is best/more acceptable for you ?

Thanks !

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
