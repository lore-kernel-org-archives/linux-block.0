Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A0C54EBD
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 02:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjAJCYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 21:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjAJCYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 21:24:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3081838E
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 18:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673317459; x=1704853459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G/y3cYQSjb7PPy25WMftIhldeHLkTnt1kSX50ZUTwDk=;
  b=Kh5FOZooRoZYZ0CZHzdIkL73UmoC47OZ+TOZ2RFDdXyEGT+gc0hFY4SM
   qZamjF0B8a653RrxkbPC2yCPn3cb7n3Of65GXdiTL5QoQWSt3ivbKHbRZ
   5cXMAZaGe31IfllHc1IxhhFdmptG2X9FB7wC2IiWdf2UcFDkjTZEQvifF
   B1fRdqSuZRKW4m4KGY+5FrN3kEYDN2fKNr1RyEWCvLkUfXbWlZApz0nB2
   7DDOvtCkfI1W8MJC9B2be9n+rcWS+5HdzGFPBG7oc5+iPhE7W6m40fguJ
   Igx+qg8v+1OID8wl+OXe5uXDOVFBnOQ2vKks1lBIvh9L6q05bI25kJWG0
   g==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="324700210"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 10:24:18 +0800
IronPort-SDR: cB3R1G8yiq+xx5JH3ngkeLcGA03cSMibJ8Bsi0AStPJwjha1o0q7Dae61/6CwxvJzgScYa/IXT
 2G5cDidKVk1S46L9a6wI9CINRAJnSKrXg4PIa/R3r1lPvOY4MkVMsY08zX3T78Equmrq/R4FH+
 BJubPGINujuOcIGmOhnyMGtich1GogJzWhJLOEby0QD+26obXv2XeXAV/jFLDxCHrwe66/pJiH
 aYcKW+/a7mKx/fRZaVyZGlNhweHbgL52/NUl5BAhMsX/xNB8K5kLDT+S7p/NCuWxPGFySeQB7m
 1BI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 17:36:25 -0800
IronPort-SDR: M1TP2h5ZJ1ZRq7EcacyuhCtSAKuhXcxdpnbRxB6vooiC2qAOg0Io3mBcq/dh12K5j4e11suet0
 HgK9Bosx4CKKuPgdbO+Dc/AWv12ksbi68ff50OV8QB2ksAJDm4qLxgZylxL5c67jqNapJ/754w
 GnYNXTmfyvxZm6tjNF7PpUnhB8g4lfcfgCn8GFr+CP4K7vQ7mdQpX2ORpJGH8xI1Ytkm4QSXms
 1f/a15qt4ztDIzgGHLuL+64Vazuy5g0tBPs/fb/kBy9lZDGu+wgYhfJmdm8yj2rp1Gq3Ir3zaH
 TNw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 18:24:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrZPt5hL8z1RwtC
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 18:24:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673317458; x=1675909459; bh=G/y3cYQSjb7PPy25WMftIhldeHLkTnt1kSX
        50ZUTwDk=; b=X5+2VuG/SpBVinma3vRr6+bG5MzwSEx+E5tAzZH164KXEaNZ2NS
        ZhcHMbpGR5DwtOXfpu8z8QBPl2JRTRx5bMfk4q8MpITbZWrZE03Cyu9C86+GdRdp
        5121gOMUXRcctUggvThNDPA2b2XtCX5pUnRaSLx2KGje67XbS7Wx0aYnYg2Moj+P
        Pn0I8IcqRPpjhQmO6zPC1mRXEQ88vj1TNB7GB9WRgJ19BMVIw6tpl3k90wva6d0r
        F020wm1igtW/zehHhCN9snwRmuBYeE1R6dph8VYeU7EaXQnzOBOMOws7rFqB42zT
        iOcM7PizIYb3kgJQCEbqI741KPA1Kfh/dJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iZl_9G8oLgey for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 18:24:18 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrZPs1BcHz1RvLy;
        Mon,  9 Jan 2023 18:24:16 -0800 (PST)
Message-ID: <873cbbef-e01f-3142-af2d-053dc040d17e@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 11:24:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
 <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 09:48, Jens Axboe wrote:
> On 1/9/23 5:44?PM, Bart Van Assche wrote:
>> On 1/9/23 16:41, Jens Axboe wrote:
>>> Or, probably better, a stacked scheduler where the bottom one can be zone
>>> away. Then we can get rid of littering the entire stack and IO schedulers
>>> with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.
>>
>> Hi Jens,
>>
>> Isn't one of Damien's viewpoints that an I/O scheduler should not do
>> the reordering of write requests since reordering of write requests
>> may involve waiting for write requests, write request that will never
>> be received if all tags have been allocated?
> 
> It should be work conservering, it should not wait for anything. If
> there are holes or gaps, then there's nothing the scheduler can do.
> 
> My point is that the strict ordering was pretty hacky when it went in,
> and rather than get better, it's proliferating. That's not a good
> direction.

Yes, and hard to maintain/avoid breaking something.

Given that only writes need special handling, I am thinking that having a
dedicated write queue for submission/scheduling/requeue could
significantly clean things up. Essentially, we would have a different code
path for zoned device write from submit_bio(). Something like:

if (queue_is_zoned() && op_is_write())
	return blk_zoned_write_submit();

at the top of submit_bio(). That zone write code can be isolated in
block/blk-zoned.c and avoid spreading "if (zoned)" all over the place.
E.g. the flush machinery reorders writes right now... That needs fixing,
more "if (zoned)" coming...

That special zone write queue could also do its own dispatch scheduling,
so no need to hack existing schedulers.

Need to try coding something to see how it goes.

-- 
Damien Le Moal
Western Digital Research

