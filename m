Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F94C43217
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 23:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiK1Xzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiK1Xzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 18:55:47 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C272182B
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669679746; x=1701215746;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=jgHhBEN0Ah+NoCbq3trOiIbRFhVWUplmAyARsGMC2AM=;
  b=qv2Cs1Gi3DALAZ7mvAGEX6qNeq2cMbLyLM56P6hCj1IfN8rnvVCrrkPH
   Pzzq4ou2JkdeQVd4emNilDxHgA7l1Zk1y4HKYObblMEaYcB/9NrdHp4OP
   uZGeo80LgCZe/T6RmN4wWPmqcA74v8FTTBLEsba+N79eCH3RRD9ARFXz7
   hHBouTEs4OxpIXFs+KZxJXuJDfoABWqpUUA6039uOdqJdfMqxLSSkJ1Gd
   aWwify01EZnJeipzlXaD1oDB85f//ouqUfIk7VGUtOp7BRi6EeuCEH31q
   aOO8SuIV3Wl8gi2KZTaO28Q/0D706pw+r1fDd4CpB1McEK+7pYkxaCnX1
   g==;
X-IronPort-AV: E=Sophos;i="5.96,201,1665417600"; 
   d="scan'208";a="329497980"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2022 07:55:46 +0800
IronPort-SDR: w1AWVZciH1V0pbSV98FhKO3PAinKtnbZ/DUdFxZfbXvggC0Z2XxuWSdnY0hQwOoa57LRtt9NkR
 Aw2XdZAPJYUJMlakwW9yTlZZyAYUstvVAIJGJSqv6wNiOXhjZEHwxcHYkndE1IRk6lv0r8BcN9
 RuNDRw+VbVu5ni9kzQBRYyNVygHOOEUqxdUYkDlzPggFg8CWZ5kU0Q5f3ZiiaJwRANBlu56/Ku
 /t4NErdCVO+ylhQpl6EN+nuW7PMsrfzjkcbxeB61yKm9+qgcyhLMDAMJEngYs0laA+KO4GvgCF
 2/U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 15:14:28 -0800
IronPort-SDR: Ema9iBKkHX3mscXE8vmiQ+PzdKnf4XWQeZMGBsXP1ueCXBM2R2Yw9jbvLw9lN35Ps8hM0w79eB
 NZ90JncVJuu5aAbhCA9cObdatjT1EOG/P5GAPEZTwfRJtvZFQmT3pGfNw4hQGF41ZVpXQXNtt5
 +V/PPJZB5WpcV22WTJbu6t73nDnhaMvAwgBAzJ/NDLDGjwHhGCTced2VdM3IBNbCap+TUv4130
 7xCqnZS510k9r+MsDbTu2sm+70Lben10CdMiqT0XgCkmLCb/kcc1EKuEWv9yEMmuHgSAz/Imop
 ack=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 15:55:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NLj5t4W3Bz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 15:55:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669679746; x=1672271747; bh=jgHhBEN0Ah+NoCbq3trOiIbRFhVWUplmAyA
        RsGMC2AM=; b=LySXv4uGy4/hNe8o26EWB2Ek1LvT7PhXI9CMv8smaf93DCZzLQH
        tcD7gouLmbUN6f3F3l74TroRmV8FwdAOg9Mim4TqngiYITM14viGu7leo+k7irPe
        H5M2HsiM5/6VSvIEF1SDS/qO58r0hTDxAd0PfDeeG3Xyuv/9FfWNYQI+a5uvBqhG
        RbgubZ+IGq19nkeU8TWnhBHqFwSuBReIU1roHNl/vXAFOrdF1FStrtIeU3oYeh1B
        pvwTUCYltlRDiLPiojZOYpQfvzEzYXSqT7Yl6GAgWZ7UJedF514FuG8K9y9GIinI
        0TBd7LbTm0vOrHS8TLw/lvXitFcMMbKaklA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4huHab-Hca_r for <linux-block@vger.kernel.org>;
        Mon, 28 Nov 2022 15:55:46 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NLj5s55nvz1RvLy;
        Mon, 28 Nov 2022 15:55:45 -0800 (PST)
Message-ID: <05cfde30-415f-d856-1a9d-c58b3d70add3@opensource.wdc.com>
Date:   Tue, 29 Nov 2022 08:55:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] block: fops: Do not set REQ_SYNC for async IOs
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
 <20221126025550.967914-3-damien.lemoal@opensource.wdc.com>
 <Y4TS7BDDQEn+uusB@infradead.org>
 <8dcb9649-c0d0-40e3-319b-1e1c177b688b@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8dcb9649-c0d0-40e3-319b-1e1c177b688b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 08:35, Damien Le Moal wrote:
> On 11/29/22 00:25, Christoph Hellwig wrote:
>> On Sat, Nov 26, 2022 at 11:55:50AM +0900, Damien Le Moal wrote:
>>> Taking a blktrace of a simple fio run on a block device file using
>>> libaio and iodepth > 1 reveals that asynchronous writes are executed as
>>> sync writes, that is, REQ_SYNC is set for the write BIOs.
>>>
>>> Fix this by modifying dio_bio_write_op() to set REQ_SYNC only for IOs
>>> that are indeed synchronous ones and set REQ_IDLE only for asynchronous
>>> IOs.
>>
>> Well, REQ_SYNC is used for I/O that some is actively waiting for,
>> which includs aio/io_uring I/O unlike buffered writback.
> 
> OK. But then the semantic of REQ_SYNC should really be more clearly
> defined. Always setting it for bdev direct write IOs regardless of the
> iocb type is telling me that we should not need it at all, especially
> considering that for bdev direct IO reads, it is the reverse: REQ_SYNC
> is never set.
> 
>> So I don't think this should be changed.
> 
> OK. But then what ? Looking again at the block layer use of REQ_SYNC, I
> do not see anything super relevant. wbt_should_throttle() use it to
> detect direct writes. Some other places set that flag but it does not
> seem to actually be used/tested anywhere. What am I missing ?

I missed that most of the "magic" is happening using tests done with
op_is_sync(), which assumes that all reads are sync too. Got it.

Back to the problem at hand though, bfq uses op_is_sync() to
differentiate sync and async IOs to apply them to different queues. So
always setting REQ_SYNC for direct writes seems wrong.


-- 
Damien Le Moal
Western Digital Research

