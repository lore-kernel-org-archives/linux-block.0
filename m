Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7DC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 22:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKBW2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiKBW2q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 18:28:46 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227AD2BD0
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667428124; x=1698964124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G8q/ILOINQVNLVtPO6GQaLxWAMKNUbJmUtyF+4NTrlg=;
  b=B7lkwAEhAtSwwwcUbaZGOX3tBzLJGabCup1byRS/1ZpAJh/SQS/6J0lb
   OOFJ4VNp/3LM0M6ISitpFPvkHn5zCHXP2w+YOLfC66tgDazhNYUkRIu2L
   gAmDny/7D3TyMhMUXliXI0oA1XOxrR/Alsaty97bavIR3ovn9v+OADDKl
   7DyqNW07fvK8AbILoi+URspzlS+/oIFU+OhL/DzUA3MvlD8bbng+Scbz+
   Yyycz4aoNWG9492F+AVuNT4yJPWh6dFW/ikvFrmRbtJJvWXGzjHRrznns
   tZfPkTq8h5sPKgzKoTEZIMgOsiN8bR9tOPgvKafm6sSYa/z8vTYJHGkeR
   g==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661788800"; 
   d="scan'208";a="215692087"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2022 06:28:43 +0800
IronPort-SDR: 9IBsYeQk3Gas28hkVdN95b/pzxnpPG54uOKNb6kto3OiCj0EPP/hEw1hP0jIMT6zM8jX1BCqH0
 ocxxSuNIJY+afAaDaP0JVP8pLd1dcG2Vee0LffsZY/RmrpmfkqZmEKv5Q33l2yO59ObHOI18mN
 wAJ5DHGOD2mky/psPfopJJwB2COPeA+CQDSc2DQ2LR3XOtzMpRovvHlfX479dsXRBmYJTkZ9yg
 neYe7bL3L4C8eHEzFbk4Xk+PZAgEQfNhklpfoiHLo3+lsergei4MB13PLmoHBrdMSE/naAgXLu
 BEI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 14:47:56 -0700
IronPort-SDR: MGjliuzygdgDFeB1IRiAbq5P4duXSO9Qu84rspSYePvMFwMAu402q2iShQVuETSRIxkPdCjkJd
 Gvo9WVFEkrBqZFEu+zYlCNIyUCS7tVEGku5Ws4QF2bIX7Js3oVVhlBefoOfRcIiG8bWilTsalm
 51JpF5/rhV/1aMhbxY//svN9dOY3Hh10eQtBswTIWIG6jX7mgUove+FreGKd9m8fCNCQYigruo
 JFR3X9ddSEF0KBoAXS+ByTujiX9DtBbArorvVoSwb6I+mSnGnou2nXw26keSBz5d37wumkpsib
 WMo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 15:28:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2hPR04B5z1Rwt8
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 15:28:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667428122; x=1670020123; bh=G8q/ILOINQVNLVtPO6GQaLxWAMKNUbJmUty
        F+4NTrlg=; b=WrBEoQPHqDxzm7UBcv6RMPWZnTIX9re4IwxL7gSMCjDR/pggrQY
        clczG6odKCgS6foUrAWJGrycApZdlKHS3sbVwf4BJTT6KJFWlHaIfcLUVRjriAq4
        srnR2ANLEjVht7zzpqF3mEchPCL6j0gzzdc+T4kk5bhQfySDZtyDtZgeMCBay7ki
        ekTxRxOzHOzPZQqPnwl0m2AIQkR/PO9fBl3zJASIPG49Brv4aGfbc980mHJyEajp
        2e9FRHoiTSRJHRuFnG7JXxE2O5u6NQUlBQkpBgq7Cx40pTzRfaZNN4594nseHwDp
        b3dwi6tADA1Sx0+wQvqh3wh8ZH5NCV/Xlsw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LTyoIMK-2VeS for <linux-block@vger.kernel.org>;
        Wed,  2 Nov 2022 15:28:42 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2hPP3VHWz1RvLy;
        Wed,  2 Nov 2022 15:28:41 -0700 (PDT)
Message-ID: <d49f000c-156f-e313-1960-4baae49187cc@opensource.wdc.com>
Date:   Thu, 3 Nov 2022 07:28:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
 <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
 <Y2IXjzWL5eHA3Co9@infradead.org>
 <8125e422-7bc8-46a1-792a-f31cee7a91a3@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8125e422-7bc8-46a1-792a-f31cee7a91a3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/22 00:17, Jens Axboe wrote:
> On 11/2/22 1:09 AM, Christoph Hellwig wrote:
>> On Wed, Nov 02, 2022 at 07:05:35AM +0900, Damien Le Moal wrote:
>>>>> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
>>>>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
>>>>
>>>> How could this even happen?  If we want a debug check,  I think it
>>>> should be in submit_bio and a WARN_ON_ONCE.
>>>
>>> I have not found any code that issues a FUA read. So I do not think this
>>> can happen at all currently. The check is about making sure that it
>>> *never* happens.
>>>
>>> I thought of having the check higher up in the submit path but I wanted to
>>> avoid adding yet another check in the very hot path. But if you are OK
>>> with that, I will move it.
>>
>> I'd do something like this:
> 
> This looks fine, but if we're never expecting this to happen, I do think
> it should just go into libata instead as that's the only user that
> cares about it. Yes, that'll lose the backtrace for who submitted it
> potentially, but you can debug it pretty easily at that point if you
> run into it.

I had the check in libata initially but Hannes suggested moving it to the
block layer to have the check valid for all block device types. SCSI does
support FUA reads and we would not be catching these with SAS devices.

Will move this back to libata then.

-- 
Damien Le Moal
Western Digital Research

