Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8BCC43219
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 22:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKAWGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKAWFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 18:05:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCBEE00D
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667340340; x=1698876340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bvijd/XNf7+b6GpJzbGNsMETf26UX8win/XwhAEB7pc=;
  b=qJJHVhq+N604msrd0vz2gSTPhp7yuQGYrjGsKCdpZ5LVSDBsb2yI98Fu
   2SRUl9jJXZOg+P5IS6XOacBroFVz10JevKHc8JTSboqji8I0YQd/Aj1OC
   N6ACcGoSLqiae4p0lJRqCg8CnvHCUO5fWizsHk9r5zfsJN91OmufiDeg3
   npNGkLCfQfi/n5W/84rEBBZY1WYdnO6IIpFUYiawFZc6H4AMNz8rco4xX
   PykN6tYMbvfKXNhhi3ufmpsRjYf5go9M795IVBW9t305qvq8aTnua7A58
   TGFrWluGAgCitt2p3FCUkmOCsqeW1bWxX58+8+X/p2DVjWY8G/rAxV625
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="215600113"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 06:05:40 +0800
IronPort-SDR: n9T1WTOtsAZg/0z/3Io+4WFB+RQ1kDD0q7UWCyRXADggWOC8saFG/Q7Sl7BFgkHfw7QEca+Abi
 TowyH0HX6rLSnGafDkeWTSL0FHUOp5f8mw5ZlndeGRSlWmtpz/bnUvin7qkmHFHlkSj92oPdom
 2UGSQXrh9Jf/m7lQ0K47fqzLvxm3K7QtT/lYtktROzeuUlRPJQqsGEM3BOBzQX4QDtz1wz6U6R
 hZnfsO9QlYuw6YQl2jNxQDJ/mOlrHzndfjk5YjtJA69Ero1wDOXUKnMfiwUwJpV2/gov83CTbk
 9zg555d+nkqekt1jY7DqWHpm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 14:24:55 -0700
IronPort-SDR: JoxIxjSK3IRRgwc5LDWaEO/jEe7V6ToCyMxGnoeRGI4SSgQt02V2NnE8uNv5pFTEvZe2baT6yt
 oY9rkiKlBdzHXkEwnDX4A9soXHRWfe0rfjxH80MWzdWtUORWbtpTkehk6b3kDAiJt2ca8pWKAc
 2+avsr4z5fU4mKy1vFJrZFYNt7uyVUNe4GxTn+fHZhOdXZAOij3YN8hdaNlFtqa0Kicu+LIucD
 JDEuQc9GmPlR9feHmofPsEvoRxh5lGM4hMpTRYscuV0QS3XooBKMZvKFhF0erdPHlqAyOmHsmX
 +bc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 15:05:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N23xG31ZPz1RvLy
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 15:05:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667340337; x=1669932338; bh=bvijd/XNf7+b6GpJzbGNsMETf26UX8win/X
        whAEB7pc=; b=tILjcmno2zZ4IiAhoflTprCsA+xy0oRCNOz641Etq1sIkByi+cM
        STw4Rea6fnI20GyHKcEdZQ9Kn43vcH8i93dysWcay/8vbQ/VflWYQvOvdiSc2M3g
        IK5zMX+mcbqr9EWbwm9YHkpYN/MZ3G60NUg+ZkLiNPmHC8tdodLTM7bKllWy60Mv
        2LHzXg33O/fAbIVPt995HeKyXS1kYarCaxhxSUpeBpg9N9mO3+WIbfVMiEMkbAqc
        Fz67n0kKKvVS2oHBPRDjVHbqwOV1ML3vCrIylKQw/9hyLqpupppsqaK8LExGyJRJ
        B0l1Bl16DkffGngkxgH8D3Q5kih1ZWMdhCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p_OEvXrMbKU5 for <linux-block@vger.kernel.org>;
        Tue,  1 Nov 2022 15:05:37 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N23xD5n7Fz1RvTp;
        Tue,  1 Nov 2022 15:05:36 -0700 (PDT)
Message-ID: <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 07:05:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y2E2wFnbeUzAPjo0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/22 00:09, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 11:26:36AM +0900, Damien Le Moal wrote:
>> +	/*
>> +	 * REQ_FUA does not apply to read requests because:
>> +	 * - There is no way to reliably force media access for read operations
>> +	 *   with a block device that does not support FUA.
>> +	 * - Not all block devices support FUA for read operations (e.g. ATA
>> +	 *   devices with NCQ support turned off).
>> +	 */
>> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
> 
> How could this even happen?  If we want a debug check,  I think it
> should be in submit_bio and a WARN_ON_ONCE.

I have not found any code that issues a FUA read. So I do not think this
can happen at all currently. The check is about making sure that it
*never* happens.

I thought of having the check higher up in the submit path but I wanted to
avoid adding yet another check in the very hot path. But if you are OK
with that, I will move it.

-- 
Damien Le Moal
Western Digital Research

