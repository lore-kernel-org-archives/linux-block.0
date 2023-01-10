Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A3C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 11:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjAJLyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 06:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjAJLy3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 06:54:29 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD5544FD
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673351668; x=1704887668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1kYVD/fBD3Gh03tQHnyD2tHqsWMIIRt8y20VLnKVM3o=;
  b=E1LcSWgp6lSDqYZ90kE2ATDMGz/2oVhu+lusj9f1BVq7xUKou/1e9x3u
   heSt1VEDdL/xCpALlZXivQEQldyN0QaAvtCpeP0OL5pugoqe4d7I0Dtja
   Ky/mnBEs0F8MXaTNxUhnIKFbacLNGZMB9xYaTcbQnaCZY0PPc2DkdvghL
   T08Aoa5SFicSq++uC+7lOPWqwarmuJfyvY9w28ND5J7eVOMYnmQNkbXta
   YDfSEsG7P0JEa2VEBWmKrEZJu82kZpLWAWI6o2+EDspT0I42RcLDeXG5L
   8W45eNmwPUJ67hCa8fRh8zcqtNjreqO+BVYQcwLleb+KXHDKhi3V2WGx5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225488505"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 19:54:28 +0800
IronPort-SDR: 7yzHDZxeMGKDyieX7kDS9Uf4Z0eKEccy7FJDoY7k1GyPWG3eej7VT9NlR+NXmEfB/JG2ehyC/3
 BNpYTE/miWdTVI2NYRHIKKVTkmiC/fR8+I6+h3PwLWkpCm59lEkWUJWwbZuvUMFee5h75Ei5gD
 y1cV71kPf8NnyXVJcFddvRtI2Yzohx/S3f2u/6iCjj9joLdWjmoPHyDfAdI9ZmgJwTbiqBiZNv
 StC6dy7vt7WO8eO+Y8p0T9hLI7lDzFeE/2cHTDWxp3nE/hMj2ZBqNqbGXFsXhIrnlIAg78kkni
 L0o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 03:12:18 -0800
IronPort-SDR: kr8C1lw8ycS/Fzqr97rVchvgHBg0Bmsn5HQXi9fUJCR/XkQwNWynryayRACGIU46ftB9HKVv5/
 liNDbVBYi9QOAC1pCMDE1ZmEvE7tLARcNXjiRK+3s9dqw5td1IRKzxFuI92XbSmMpe7XmcUeuj
 zrWiC0pUCbcf1unFEvFrgC8uHaIQKiPItto5q2+aS6DLyrhgBxuHm1g9PZn7vUXBhOosW4GEI5
 HsDtVQNu7cOCN3kyPu7RWr99nu1c5APr/0Mf3N/rQuWif6g2y2Ui0djOKwmxHrBey2mxq/YqCp
 6hw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 03:54:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrq3l5t6fz1RwtC
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 03:54:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673351667; x=1675943668; bh=1kYVD/fBD3Gh03tQHnyD2tHqsWMIIRt8y20
        VLnKVM3o=; b=YOCe5wvFi1zweMgucqbj3VPbcAOHFO7aimbDbn0RHrU6VU1elYo
        Y51DCY8oVKjTXPl/BtXwg8U6bl9qLMWu9bh12UWrBGkfRyhaNSGMtVbSh30vWj9K
        lu4cc4XtsHyvxNLQH3qRIa+HdCWFi8WW1TAyo6hXXiXoPIa7YibxduqDkUDS3DPw
        FR+9ukwoXqGXIUIE1fWU7ofkgUmzdDIM/L2GsaiZjlI8RIQLwzYZV+4BISDWxXJd
        PV0C+iTQKX9YzC/nzh3Z3d+Me3jP0nY9M4baoiVGPPTNQCxBuxQzFjyt/mFf7+/p
        dyiUR31vaFbo4hj14x938vOGSqu5M95nlZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Q4HSC0ecDfi for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 03:54:27 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrq3k2bBJz1RvLy;
        Tue, 10 Jan 2023 03:54:26 -0800 (PST)
Message-ID: <278a9c42-bfa3-1602-622d-bdbbf72649a6@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 20:54:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-3-bvanassche@acm.org>
 <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
 <22912d92-dd0f-8fc9-8dc5-10a81866e4ee@acm.org> <Y701TJtNyj86G1QV@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y701TJtNyj86G1QV@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 18:52, Niklas Cassel wrote:
> On Mon, Jan 09, 2023 at 03:52:23PM -0800, Bart Van Assche wrote:
>> On 1/9/23 15:38, Damien Le Moal wrote:
>>> On 1/10/23 08:27, Bart Van Assche wrote:
>>>> +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
>>>> +{
>>>> +	switch (req_op(rq)) {
>>>> +	case REQ_OP_WRITE:
>>>> +	case REQ_OP_WRITE_ZEROES:
>>>
>>> REQ_OP_ZONE_APPEND ?
>>
>> I will add REQ_OP_ZONE_APPEND.
>>
> 
> Hello Bart, Damien,
> 
> +       if (blk_queue_pipeline_zoned_writes(rq->q) &&
> +           blk_rq_is_seq_zone_write(rq))
> +               cmd->allowed += rq->q->nr_requests;
> 
> Considering that this function, blk_rq_is_seq_zone_write(), only seems to
> be used to determine if a request should be allowed to be retried, I think
> that it is incorrect to add REQ_OP_ZONE_APPEND, since a zone append
> operation will never result in a ILLEGAL REQUEST/UNALIGNED WRITE COMMAND.
> 
> (If this instead was a function that said which operations that needed to
> be held back, then you would probably need to include REQ_OP_ZONE_APPEND,
> as otherwise the reordered+retried write would never be able to succeed.)

Unless UFS defines a zone append operation, REQ_OP_ZONE_APPEND will be
processed using regular writes in the sd driver.

I suggested adding it given the name of the function. REQ_OP_ZONE_APPEND
is a zone write operation for sequential zones...


> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

