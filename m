Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68408C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiI0XfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiI0XfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 19:35:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4791CD119
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664321721; x=1695857721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JBZghDlF0R4sVxXiNKzSIsPdxYI4CWnTTz5qvcxgYXQ=;
  b=Kaai6uvl/aVbyCPDaNLkKTes4foxS6NzzDlDDQkYVSZnoUuBWECAPdZi
   TxBg4jjvbRCvwweTcjJynHPbtaSzqAv1A0aqMqv2usYEiFs36lIzNua7Q
   s9QH0FfJ97aPMUtDahuRcNrDDskAcrhJWkUlLeXmPF9uOBmXgYvtnqvFG
   2KC0yj/hCYzijTqOzfIKkIlf4pVNwqnV+MCeVGAl4vG9kew8uJTZwZU1t
   QGKZH3NeB+pQzfr1yKzp2IuC3DVv83A8CXQm+gB0Yu2BquQaSdPxzhA+1
   FXqlKK9aO/ixxAapgye4qMCM0TTdrQF08xvFq6znVR9188pnG8iD75lnE
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,350,1654531200"; 
   d="scan'208";a="212840083"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 07:35:21 +0800
IronPort-SDR: X9f0bkGcWvANql5w2Oj8RHMaGxkODAdmJdEeAGd1gCNTnKh1QIAktU/DHwtZtX0WGvcDYlQVpR
 Puq/0vFnzal8rFxfhcVtZqUvRvmTTUcx+8fGYiuoRF5nsH2kkvjvMWhj2+2k0P7G359FUfujPo
 cZnSkY+LM/0tN3CAkUG2tJFQb9QRQYElUB3IzWheQ4elT4ajGhmf/acRzG9C602PheD4eLgT3F
 Ip53ey8VOHpHFE5dpUZBrQkdRAwVUwok80ctKe6fYpxax6QiA1JpfWtPBa03V1pHL6YHd1vdha
 os1uQaTDFQUBqLzCiYTxEgUh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 15:55:17 -0700
IronPort-SDR: hUsqvoxecQRNHijNgAfHmaeROGobMPPxf5GrvQz18CbQgDXnncd+Dtc22Gs4RiLOYVJZKPUmDy
 A4J9x3QSRqkFmBE8V7ek4QwW0Yc7aKDbKHLmal/ygEIjTKrpKCGWC5mHZKtsC/61sZv1NZCneR
 2iPRfXdmXhvlf59o3Hi/XaYGdQFAHRFB2JHbi782JRi9fj3Ap0Esp7GEhC+RrPFck4zbby69hi
 OvgOW8+TS5No6fqlOhXuyKfDKiZMr9QkuGxeiGBmmHlwTvbQ9mBUfLW4Eqpv0qGlyMAlmDm++c
 wLY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 16:35:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4McbZx2Vb7z1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:35:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664321720; x=1666913721; bh=JBZghDlF0R4sVxXiNKzSIsPdxYI4CWnTTz5
        qvcxgYXQ=; b=aWLjYow6bHgkVv2BpHR5uylFsqTDm7kJvbWLNjCsCnzpX0l4MVK
        BzmszBHZv1TzJESXC9541wo4xr5e1HhwU9d7Q/RT4gaDHeHXtuFkmoiM7Mg0DcgR
        InT+LX1v8upqHWKnDkLuJvJqxpV8/t8zzw1nksN2AkJ+B19WPii8FJJC0U0Ze3i8
        GjF3/5JKwTsSHVZNvh3lZlruMnGVcZlOxDu+AcRuYuf9w1KeBHN1FrFWsTkJQPdX
        nTutY1gi+Cx1V3XR+1mVSTrz8GbhgED3Vj3cOoCP+ljN3Xi3SGWPIUbY6xQof+tI
        Naqi1xvzExJYeCVBh0YsCZ3CoyyBlXVpXlw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 20Ub0EkSHZvo for <linux-block@vger.kernel.org>;
        Tue, 27 Sep 2022 16:35:20 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4McbZv6hScz1RvLy;
        Tue, 27 Sep 2022 16:35:19 -0700 (PDT)
Message-ID: <814b8ccd-7047-f7f7-25a9-0f7c1c293ce6@opensource.wdc.com>
Date:   Wed, 28 Sep 2022 08:35:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        gost.dev@samsung.com
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
 <YzMp+SIsv6Aw4bFW@infradead.org>
 <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
 <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
 <038d0238-19e0-70ff-49b6-b9c8f4429ac1@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <038d0238-19e0-70ff-49b6-b9c8f4429ac1@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/22 08:12, Jens Axboe wrote:
> On 9/27/22 5:07 PM, Damien Le Moal wrote:
>> On 9/28/22 01:52, Jens Axboe wrote:
>>> On 9/27/22 10:51 AM, Christoph Hellwig wrote:
>>>> On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
>>>>> Ah yes, good point. We used to have this notion of 'fs' request, don't
>>>>> think we do anymore. Because it really should just be:
>>>>
>>>> A fs request is a !passthrough request.
>>>
>>> Right, that's the condition I made below too.
>>>
>>>>> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>>>>>          return NULL;
>>>>>
>>>>> for that condition imho. I guess we could make it:
>>>>>
>>>>> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>>>>>          return NULL;
>>>>
>>>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>>>> REQ_OP_WRITE_ZEROES.  So this should be:
>>>>
>>>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>>>> 		return NULL;
>>>
>>> I'd rather just make it explicit and use that. Pankaj, do you want
>>> to spin a v2 with that?
>>
>> It would be nice to reuse the bio equivalent of
>> blk_req_needs_zone_write_lock().
>>
>> The test would be:
>>
>> 	if (bio_needs_zone_write_locking())
>> 		return NULL;
>>
>> With something like:
>>
>> static inline bool bio_needs_zone_write_locking()
>> {
>> 	 if (!bdev_is_zoned(bio->bi_bdev))
>> 		return false;
>>
>> 	switch (bio_op(bio)) {
>>         case REQ_OP_WRITE_ZEROES:
>>
>>         case REQ_OP_WRITE:
>>
>>                 return true;
>>         default:
>>
>>                 return false;
>>
>>         }
>> }
> 
> I'd be fine with that (using a shared helper), but let's please just
> make it:
> 
> static inline bool op_is_zoned_write(bdev, op)
> {
> 	 if (!bdev_is_zoned(bio->bi_bdev))
> 		return false;
> 
> 	return op == REQ_OP_WRITE_ZEROES || op == REQ_OP_WRITE;

Works for me. Nit: should have REQ_OP_WRITE first as that is the most
common case.

> }
> 
> and avoid a switch for this basic case and name it a bit more logically
> too. Not married to the above name, but the helper should not imply
> anything about zone locking. That's for the caller.

blk_req_needs_zone_write_lock() would become:

bool blk_req_needs_zone_write_lock(struct request *rq)

{

	if (blk_rq_is_passthrough(rq))
		return false;

	if (!rq->q->disk->seq_zones_wlock)
		return false;

        return op_is_zoned_write(rq->q->disk->part0, req_op(rq));


}

-- 
Damien Le Moal
Western Digital Research

