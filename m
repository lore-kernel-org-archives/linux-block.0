Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B4EC54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiI0XIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiI0XH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 19:07:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45BC10C7AA
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664320078; x=1695856078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a9khNiGMEQPyRUjFz+OS9NI8Q39aqT312fibOWJd+BM=;
  b=oJIv5rMIMxszkBeYN7/fTZ/diq9g8xH1S3E3Tan1lYfPJQTto1reSE21
   Ll+U10aBJSRcTe2j4ooJ05ttjK9kLx1dW50WXEnBc2Ts2PyKcpCeCJkb6
   WXdZbbJwla+ZlS5clt6RLo+KZxf0Z+Ih0S7eboPIDw6ux47wmUQEqmQE9
   7xTcC+2+WqMg1e/4QCnY5xlR8W1R89EPHgl0aQ0O+m6QNJYBNIzwcDxLX
   YZ7zVsAI0EFSjF0Ny8cNclvw56uwqOKjHAUAXPFvrhFvkt9ihEPbAfP3v
   VgsLHzAs9CNg+YWb6ZmfL/c+TYxg03De3XexFclEmund3qXpJ0pXO8j4o
   A==;
X-IronPort-AV: E=Sophos;i="5.93,350,1654531200"; 
   d="scan'208";a="324524590"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 07:07:58 +0800
IronPort-SDR: uxKq7M5foFtmRo748MCAJnz7addkeoa+aaFP3uo6Dm7Z9c9u6Kz08gNukF+KD37JIKkaC2q+w9
 nss1ShVqQ86tsk6tJA9Cu1r2Wbh6gp0iNCEsM2JGzfW84yoBxhNMkDJ+4AuMNVIs2YjGPUhjUA
 hRismdBVPAqL+1i1sbxe7c+XHrQGSOQzdV3w25iFtf6B2m9s+yRD9t04xnOZaS1lSP4hRlP5lL
 hQQTa+Rmz3XjxnZTiwYf1HtrbRtUfhQ8ja4r+YEDD3wQ3MtIQxGzd+Cg+z4F1Pz2qDn1TYQYcU
 Shkj2NAToDguDCZLZpmG5ZbL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 15:27:55 -0700
IronPort-SDR: 1ozCEwmo35mSnffbz1vy0y3gJkLMsYI5mBfCefGTnSysZ/hcKw/OGpZak7Y+kzGkF1HW4g3WVX
 Hll0MqeARymN91hGGkip3Z1yPjPNcO0J/OJjitm6HgBuVgQ7XPAD27as+lu2w/JjcnhuZquZtT
 Sfk2pBuE5wQXomnAe6mxlHFPbY2m1d2jG4JqB2uOFGfbgcjl0eWn4U2aFX4SA0DQYBGge+UE7o
 7HiAbwYh6eNRuEzFdkrkT86gpNo0EW4b/L6lwwGqvg7goJTemv0b4RjKWEDDBWCEPWKR503fBR
 R8Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 16:07:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4McZzK3L1rz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:07:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664320077; x=1666912078; bh=a9khNiGMEQPyRUjFz+OS9NI8Q39aqT312fi
        bOWJd+BM=; b=N9UFxDfRWecn26Pm4EYbL/oNikpkPBiXgssGRsqdpGn0NJjYckt
        PFbYm0nJWpMRiD8QCVbWAL26lbjdrjKZ+ZHo3ubrjCcCpBltyXbrPIpmyrdXKojq
        fDQiucuhHZuKOwcb5dZbWADiJ1vghf+uveL2RTmFDrJ6ISPwNnG+Y9xUqPlGO9PO
        eHPN54qM7maMJVB4i2rjJBLGo8gIzzUPeq5YexYNav6mk8SpO5JdQPa6MbqMdOBY
        FyXWJ7Llsxhpc8U32JC3JcgRAsDgAu5fFpazYpXwQ0fi4aVqM9gZ3qDI4PS1wcBx
        b10pVBu0oum9IjpV9O7gr94Enj9f141jxIw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aHeILri5F5z7 for <linux-block@vger.kernel.org>;
        Tue, 27 Sep 2022 16:07:57 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4McZzJ1GZlz1RvLy;
        Tue, 27 Sep 2022 16:07:55 -0700 (PDT)
Message-ID: <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
Date:   Wed, 28 Sep 2022 08:07:54 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/22 01:52, Jens Axboe wrote:
> On 9/27/22 10:51 AM, Christoph Hellwig wrote:
>> On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
>>> Ah yes, good point. We used to have this notion of 'fs' request, don't
>>> think we do anymore. Because it really should just be:
>>
>> A fs request is a !passthrough request.
> 
> Right, that's the condition I made below too.
> 
>>> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>>>          return NULL;
>>>
>>> for that condition imho. I guess we could make it:
>>>
>>> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>>>          return NULL;
>>
>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>> REQ_OP_WRITE_ZEROES.  So this should be:
>>
>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>> 		return NULL;
> 
> I'd rather just make it explicit and use that. Pankaj, do you want
> to spin a v2 with that?

It would be nice to reuse the bio equivalent of
blk_req_needs_zone_write_lock().

The test would be:

	if (bio_needs_zone_write_locking())
		return NULL;

With something like:

static inline bool bio_needs_zone_write_locking()
{
	 if (!bdev_is_zoned(bio->bi_bdev))
		return false;

	switch (bio_op(bio)) {
        case REQ_OP_WRITE_ZEROES:

        case REQ_OP_WRITE:

                return true;
        default:

                return false;

        }
}

Which also has the advantage that going forward, we could refine this to
plug writes to conventional zones (as these can be plugged).

-- 
Damien Le Moal
Western Digital Research

