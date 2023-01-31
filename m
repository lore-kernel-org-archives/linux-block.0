Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F702C61DA4
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 03:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjAaDDe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 22:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaDDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 22:03:33 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBE279A3
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 19:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675134211; x=1706670211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P7BHgUkZw+jVhhTt3f/OAAE8mvrWUSi6Vx/Cs2piN78=;
  b=EmHgHNqY3jAHAM0McopXnq8fAczYvtku/uqrc0PLBRLc6p5CWFMN1hrs
   zSB38PrTyXa+YhBhOObHPkLQwDV+6jYIOOkwOVeXGNwn11Z7VEYbmItI6
   7KUfz+3JnsY+RkdaWkK7HejbsD9SgX4+j1IRQiooODbgJWvvehvbWrwuJ
   dfOdypF+hvFgCN1lZqvcOTQrKbmpQPaKzNL6p19PxwEXDDbkyhk8vhirS
   C2+oADPsSDXgjluQ/bi2pHUGv8wMQVrRcWlatM/wgyiai89vFGxNq08iC
   mY8TsHgmK1ByyPOEpkG9UOLWZ8kqU3dEvNqBPjXNcn4k+QZM1qJeIAsue
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="222189362"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 11:03:31 +0800
IronPort-SDR: yYD5ju3khHB/BgCMtSFVWDUFmKdtj/4x2f0TbAcu8G7mFV1xFcJmi/tYa2YTNqfoYf6edBskb1
 S2/FE2+USHX9h+f1E016P8CFyiHvS0hBQhP6J2aKVvXTv9kg6YIdvCUjyzo4bA0RR9Xp6qewzL
 GytCW7cI11IYQBwx63F10SZ2mIsz2NydICQZryFgdr588AKOd1PGLVHCt4Ct1gzlem8Le7J7S4
 p4L88e54FwhPaQbhjyOwHZsl3bA0zf1szfc8k/1BQu3A3CH7AA6A69Pm7tzFYUXXLuZBAjQ3ux
 CZ0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 18:15:11 -0800
IronPort-SDR: gMtMF6S3swrkwxwsnTUDBZZoQ6X6w3c1pAagQqlrqb2Id0qDzrmJg96TfkQjmUWiOBaFIUXcVf
 fZiTLPLCGS7Fjuk5FQg2ATZTvQtqUjq0daYX5Z1IaTrcWkqZJ0jLSIo37OixSJGw27QSBezAoe
 6/Dl0vEwRSEwZ8zlXYpY2hIeBpAXovC6D1/dY3nBZJBrkSPZeKeCxsA3WTv1YDjeM/VpcbmL48
 5QYx0+9acymdgXFjuWWsuGMMh5nNQ1unsiJHKAtNKDCYvAncd4uQCPhYTai1KVuErMP71GiZCZ
 sgU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 19:03:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5VHQ6QmHz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 19:03:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675134210; x=1677726211; bh=P7BHgUkZw+jVhhTt3f/OAAE8mvrWUSi6Vx/
        Cs2piN78=; b=myE75nv+ltDR2wShpOZeAS6m8OCCckCsUxSUwzaQyLhwmxnNwMV
        YQl/+OSB5N0RDJvamtmZMmu6q4pBH821KCLpBX1/lkMJ/5Y+ZPGTTE5C6gMmn0Vl
        FZaCIBNoFKGf9MQpNb8uD3/EeC7z9G91nzHOf1FG3G++WDAxmteAqswI0ZJRCotv
        j1u+4XnR7yZHvVIcJ+eTBdj+Y+akM8vwE0AWl4+ToAPb8copNgM8ngyz6f2QDvz1
        FYPZpTK6zzKWrR8LntVmm9uBezce81MA5v4EQcpPxOqqoE8/CivHF/qA3ISbgPGS
        OEhj2bIPHzRcr+AuRxPel63lePSe0c31UoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tvIeuXI3pamO for <linux-block@vger.kernel.org>;
        Mon, 30 Jan 2023 19:03:30 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5VHN5Hgpz1RvLy;
        Mon, 30 Jan 2023 19:03:28 -0800 (PST)
Message-ID: <4d0e360a-32ce-7204-1d86-7ec636bb3feb@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 12:03:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230124190308.127318-2-niklas.cassel@wdc.com>
 <731aeacc-74c0-396b-efa0-f9ae950566d8@opensource.wdc.com>
 <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
 <4c345d8b-7efa-85c9-fe1c-1124ea5d9de6@opensource.wdc.com>
 <5066441f-e265-ed64-fa39-f77a931ab998@acm.org>
 <275993f1-f9e8-e7a8-e901-2f7d3a6bb501@opensource.wdc.com>
 <e8324901-7c18-153f-b47f-112a394832bd@acm.org> <Y9Gd0eI1t8V61yzO@x1-carbon>
 <86de1e78-0ff2-be70-f592-673bce76e5ac@opensource.wdc.com>
 <Y9KF5z/v0Qp5E4sI@x1-carbon> <7f0a2464-673a-f64a-4ebb-e599c3123a24@acm.org>
 <29b50dbd-76e9-cdce-4227-a22223850c9a@opensource.wdc.com>
 <c8ef76be-c285-c797-5bdb-3a960821048b@opensource.wdc.com>
 <ddc88fa1-5aaa-4123-e43b-18dc37f477e9@acm.org>
 <049a7e88-89d1-804f-a0b5-9e5d93d505f7@opensource.wdc.com>
 <b77d5e44-bc1e-7524-7e09-a609ba471dbc@acm.org>
 <4e803108-9526-6a75-f209-789a06ef52f9@opensource.wdc.com>
 <yq1r0veh2fa.fsf@ca-mkp.ca.oracle.com>
 <9547f182-4ec2-021c-5860-5cc2e3dc515a@acm.org>
 <yq15ycne7rg.fsf@ca-mkp.ca.oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yq15ycne7rg.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 11:58, Martin K. Petersen wrote:
> 
> Hi Bart!
> 
>> My understanding is that ionice uses the ioprio_set() system call and
>> hence only affects foreground I/O but not page cache writeback. This
>> is why I introduced the ioprio rq-qos policy (block/blk-ioprio.c). How
>> about not adding CDL support in ioprio_set() and only supporting
>> configuration of CDL via the v2 cgroup mechanism?
> 
> I suspect applications that care about CDL would probably not go through
> the page cache. But I don't have a problem supporting cgroups at all.
> 
> Longer term, for the applications that I'm aware of that care about
> this, we'd probably want to be able to specify things on a per-I/O basis
> via io_uring, though.

Absolutely agree here. Similarly to the legacy ioprio, we need to be able to
specify per-io (iouring or libaio) and per context (ioprio_set() or cgroups). I
see the per-io and cgroups APIs as complementary.

Many of the use cases we are seeing for CDL are transitions from ATA NCQ prio,
which relies on the RT class for per IO aio_iorpio field with libaio/iouring. I
would like to have continuity with this to facilitate application development.
Having only cgroups as the API would disallow per-io async io application engines.

-- 
Damien Le Moal
Western Digital Research

