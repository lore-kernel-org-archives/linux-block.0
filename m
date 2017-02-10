Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17759 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdBJBYO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2017 20:24:14 -0500
Subject: Re: [PATCH 1/1] dm-zoned: Zoned block device target
To: Christoph Hellwig <hch@lst.de>
References: <20170209041849.30964-1-damien.lemoal@wdc.com>
 <20170209093606.GA8189@lst.de>
Cc: dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <a35368f9-ac5d-3144-7701-11f0fb7f10e3@wdc.com>
Date: Fri, 10 Feb 2017 09:51:58 +0900
MIME-Version: 1.0
In-Reply-To: <20170209093606.GA8189@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph,

On 2/9/17 18:36, Christoph Hellwig wrote:
> On Thu, Feb 09, 2017 at 01:18:49PM +0900, Damien Le Moal wrote:
>> +
>> +/*
>> + * Target BIO completion.
>> + */
>> +static inline void dmz_bio_end(struct bio *bio, int err)
>> +{
>> +	struct dm_zone_bioctx *bioctx =
>> +		dm_per_bio_data(bio, sizeof(struct dm_zone_bioctx));
>> +
>> +	if (atomic_dec_and_test(&bioctx->ref)) {
> 
> It seems like this could be simplified a bit by using bio_chain
> to chain the clones to the original bio.

Thank you for the hint. I will look into this.

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
