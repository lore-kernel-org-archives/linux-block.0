Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2510C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjAJMl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbjAJMlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 07:41:23 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACD0373BE
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 04:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673354482; x=1704890482;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aw2S4rmP8A/gp1vT9siYMrdwhAZnnd8+vWSGGUuuLeo=;
  b=bbO6UpQVotAMXGsne/aMuLyDCZQLtdw/EPgjsYaQjUli3EHNAWFLs+XE
   3dkoHWbHSDSWr4BXN22ZgH2oPkzu8q9MILGM9C6Lb2pIn5BSoSfYIOfUT
   A/saXP/J0UrYy+iBZyzruLBbMZty8vbAILMyF83f4lDLrX+GghH3hfIMA
   rw8HlRu9vc8Go3z5rBRfIGuCANNd66HCKaU6OSpxJi+aWwK2vNRpM7lxy
   2WsKM2FTex7f4yy8uu54pvDH+LNMBAe6qSWktotsE7Gtw6Zmf/bxAuivH
   f23V36OSM/BaDXNoLUwuFtCtt18Qe2C8IOB/QQf6vXIEq9n1UhyTAAZNe
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220318042"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 20:41:21 +0800
IronPort-SDR: RJLL1aWyIDNSQLENJo1+rh+CnA0+QU5p5IJeFGnnCCpdusK9mYUfGRI0Od0P6jd0zPR/N3VRH9
 CjWGIL32J865eQcTJqrqsaWM7pYYgfjYpuG8z+2eUOGZ2CK7yy2PKGbuNP8gzNXmt3aQW+YGc2
 X9ly3yL7Xi1gPbO9QmC2X/Xq5h1jQH4j2D/4m1r45IatCXAHySAJJd8knqrdRzB3ZQ17DeBoGr
 5c83bvQddRTG4kOzm4YOiCA43ozvMX7iDejY5X5SQ+O92ntaYrIONWM2XD+GQ/FMr1UJFsVUmr
 jyk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 03:59:11 -0800
IronPort-SDR: LxV1MwejFqg1vZpouvH6lvO+XChoGNzZpjU+4RzLwrLxaseYrIARVzSmctdwtjGMg/Z6y/GaiW
 JEoyYaU2/DlM/xoUteOTbnOWB6K9V6c/VTk/X7gjRKfqeFFkKH0+iujuw+zJMXcbR8xYOYXIrY
 vDjBRCZj1KejHtGt1ujbmiPIaEa86GOn07lY4eOuVFpr6a3XTg3pHGeOVcE0KZw/VUgdpV1vBQ
 MgTHnNmvizjWT/NbKL+fth9A4JktZjO5rGnUx7B3tilHc1f2HDggCHSgc5CFlNfRxbiFS28Mfb
 A9Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:41:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrr5s0M1Nz1Rwt8
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 04:41:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673354480; x=1675946481; bh=aw2S4rmP8A/gp1vT9siYMrdwhAZnnd8+vWS
        GGUuuLeo=; b=O7VC3gRMOO6jiX8IVrsLD4U+we8Bj+vMLuyjIh5yHxK8y84ANgE
        +TScg87R/HlQDk2MjmgO8yXf5ewTphu6ZP0SARKhMGSA1U5MQE3wPeMX9OBFX8Mm
        +x+GzEi/YIl+JiEXZYFH/dV6d0YWQ9We7EWBCTwux4H4GqeVlLbArukFd68iEtXw
        8S8znhL+4c0UAobZd1Mas+wDRdqd+LjefHWvckYv46uab3t6Hm09w9NgO+e0bGIk
        qiMsfj585MUCxyuJ/WngER77y8y9kJABwHz70Zx+PsZ4pGIUTUmRx4cDpkwnSjbg
        lasUN3O8CdUNlnlp0uhWCBCvISGfncpj4uA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NT8FQwDy3gj4 for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 04:41:20 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrr5q3mQVz1RvLy;
        Tue, 10 Jan 2023 04:41:19 -0800 (PST)
Message-ID: <685dc05a-0b8a-7c2a-c6ca-8d8f394219ef@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 21:41:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-3-bvanassche@acm.org>
 <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
 <22912d92-dd0f-8fc9-8dc5-10a81866e4ee@acm.org> <Y701TJtNyj86G1QV@x1-carbon>
 <278a9c42-bfa3-1602-622d-bdbbf72649a6@opensource.wdc.com>
 <Y71WVAAVzYEyKedM@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y71WVAAVzYEyKedM@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 21:13, Niklas Cassel wrote:
> On Tue, Jan 10, 2023 at 08:54:24PM +0900, Damien Le Moal wrote:
>> On 1/10/23 18:52, Niklas Cassel wrote:
>>> On Mon, Jan 09, 2023 at 03:52:23PM -0800, Bart Van Assche wrote:
>>>> On 1/9/23 15:38, Damien Le Moal wrote:
>>>>> On 1/10/23 08:27, Bart Van Assche wrote:
>>>>>> +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
>>>>>> +{
>>>>>> +	switch (req_op(rq)) {
>>>>>> +	case REQ_OP_WRITE:
>>>>>> +	case REQ_OP_WRITE_ZEROES:
>>>>>
>>>>> REQ_OP_ZONE_APPEND ?
>>>>
>>>> I will add REQ_OP_ZONE_APPEND.
>>>>
>>>
>>> Hello Bart, Damien,
>>>
>>> +       if (blk_queue_pipeline_zoned_writes(rq->q) &&
>>> +           blk_rq_is_seq_zone_write(rq))
>>> +               cmd->allowed += rq->q->nr_requests;
>>>
>>> Considering that this function, blk_rq_is_seq_zone_write(), only seems to
>>> be used to determine if a request should be allowed to be retried, I think
>>> that it is incorrect to add REQ_OP_ZONE_APPEND, since a zone append
>>> operation will never result in a ILLEGAL REQUEST/UNALIGNED WRITE COMMAND.
>>>
>>> (If this instead was a function that said which operations that needed to
>>> be held back, then you would probably need to include REQ_OP_ZONE_APPEND,
>>> as otherwise the reordered+retried write would never be able to succeed.)
>>
>> Unless UFS defines a zone append operation, REQ_OP_ZONE_APPEND will be
>> processed using regular writes in the sd driver.
> 
> Sure, but I still think that my point is valid.
> 
> A REQ_OP_ZONE_APPEND should never be able to result in a
> "UNALIGNED WRITE COMMAND".

Yes, but that semantic should not be associated with a function named
blk_rq_is_seq_zone_write() :)

> 
> If the SCSI REQ_OP_ZONE_APPEND emulation can result in a
> "UNALIGNED WRITE COMMAND", I would argue that the SCSI zone append
> emulation is faulty.

or a passthrough command was used and screwed up the zone write pointer
tracking....

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

