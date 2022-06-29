Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30189C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiF2GwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiF2GwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:52:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BEF2E680
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656485538; x=1688021538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SGXV/8mELmWsizaiqpcUOae3gjuWAfJD9tqz0bw+54g=;
  b=aRexdnpjUH3TGOTX0+0f9CRDtk2n2sVVvbBWJEjk/TFa4aE15pdD4dyu
   NJad8x3mzeHYI5cEwy/oTM239NSOyEDA0ikqRVFGFvTY/W9ptNENcamKA
   KVQoa/jxFrtTwHP2RXGMJwFWeUKChvbXhBXF5FmVBjqGzTLq+gW4cAOa8
   wjhPMVcEjqXQKtsCef04EPqQCT+oBtMTksHAomVphgKuv1X6Bl3NH8wLY
   MGA0YY5YUUNoGnLo9BQW5osy7HKd/BpbmfsYccD0pFaRIojDp1YsOs1tD
   rBX8hRZjSZfGme+4vmPtKBbsoMgegXxduk+snbRGhnaa4/rB2PTPbl1qX
   A==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="204361155"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 14:52:18 +0800
IronPort-SDR: pEJbjgP3S0Ru24Re3jFoDIE+T8d+YkDZtNvoMSXwFvVmNKJAzTC87x4aPl9pW8nvG+TxcNSzei
 ISFnPlTAKjpS4qixy5PvOn0QvcZdMaXcLvlImm3rP3Mi5UfGvs/M0Lv2OIFxg8pyaSubLUpExE
 7wXKTI9Or/UsFFvI9wkwtgQv0T1pAlM/YVdfQooiRt3p0Ddwt8T8RnWWan3s7VjJ84XwB7JePM
 almubHKmotoLMOTnhXlF/8wNncSxjXLu54F5FF3Or5lcauBNXlca4250Ol1X2a8uzXcvg9uLWA
 f0bXzKhtUsmcZGOtfmiR3Pd8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 23:14:39 -0700
IronPort-SDR: JY44oMriqGp+0TWbHYE7MyNikrpdeAcaW6STHPGq/S2c8ooQGijCSjoc8JHGqQXWp6M13JKqU5
 r30IzFaFbmMCwMDKrmRc8m9y7abIH/PLoU+kQrLYvlA9WXUUpu/WdAq3ANe3WNTWu1w51bs3ku
 RWnjFhO3mqYGw09uMdoPHjScJ98Gt8yRczAKf77qqBCK3pTcqm3zHeWRVtYd2JeXs2ZFcSJ3XT
 eO4qCvBQQhfg5oNgMO0GuHw3tegVDpGuvlwHA4mslOllodVKiZHGHk4sqFOpYI3/uwegaIOf0f
 vyM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 23:52:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXsb61Bh5z1Rwnm
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:52:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656485537; x=1659077538; bh=SGXV/8mELmWsizaiqpcUOae3gjuWAfJD9tq
        z0bw+54g=; b=UUDdMpU1XmkebMGcRR00p4WAebaKyxBefWka3lUCgoEu8rqbZN0
        Ujc92/8pola2lAZ4nsn7Qqc6Qhc7eCoTKeTeczCBY9Ia3DuTSEmXdo8QBq+psDUB
        8PO41b6gYG6vtPRwNfGRWEvMCfg0yED6EwTINtpGuJ84vR45GFdcmyfZA/3vZ8y6
        cG+4u/xwhoZQw9fv4pIdEf3FlV+u8xJNERWjYlG3NRAdUSCPxx65tkuH+Ddfd0tT
        wuR2kWiJpxlUYwc6SdEzN4yhy3xUHAhVqgRwkBlHpdHz4E+ifsduyKmJH4QF3xpx
        l2WAZvVry8iefy5FiE15K0wxQ08z7YOogtg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lfbpr6-bdVDa for <linux-block@vger.kernel.org>;
        Tue, 28 Jun 2022 23:52:17 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXsb516V1z1RtVk;
        Tue, 28 Jun 2022 23:52:17 -0700 (PDT)
Message-ID: <e401c233-9be0-41f7-a3f0-e9288c9c9973@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 15:52:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: clean up the blk-ia-ranges.c code a bit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org
References: <20220629062013.1331068-1-hch@lst.de>
 <7cc69dfd-0078-dd2a-794c-a5c5a9073f0d@opensource.wdc.com>
 <20220629064433.GA17552@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629064433.GA17552@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 15:44, Christoph Hellwig wrote:
> On Wed, Jun 29, 2022 at 03:32:36PM +0900, Damien Le Moal wrote:
>> On 6/29/22 15:20, Christoph Hellwig wrote:
>>> Hi Jens, hi Damien,
>>>
>>> this is a little drive by cleanup for the ia-ranges code, including
>>> moving the data structure to the gendisk as it is only used for
>>> non-passthrough access.
>>>
>>> I don't have hardware to test this on, so it would be good to make this
>>> go through Damien's rig.
>>
>> What branch is this based on ?
> 
> for-5.20/block

OK. Testing.

-- 
Damien Le Moal
Western Digital Research
