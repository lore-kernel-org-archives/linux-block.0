Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F562C6379F
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 08:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjAQIP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjAQIPG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:15:06 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288D29E3F
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673943305; x=1705479305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/A9f5uVbu/7B67PEgsZ+dQ2Yu9WMa+tclhDOagcGEy4=;
  b=mwcHEe8jw1MnRbO1rNVeK4/nyF688ZLS4zhrAQ5OZV5YaLN3BSHLR0pL
   Gb8q95QeYV5vdy9Yl51/tIbcrLKwzkN4axipMWJEBJ28cYsa1XSjP0ibJ
   PDo06oBzcaVrKp1upgjXq+KZcfLLqs2c2415CHjr8YDsF7gIGAMMubIlm
   EGR5MUcxdtgWlhIghJes9Xt34fRT7Jpw0es8XLwF9lRgiEmdmBjP1Cubd
   cs1h/z5TWnEOODnLu3B7xu6GjEeDBHvxTq1EA4sWHikb1WaPisWnh2dc0
   Jslbms06QLeZdhS3EC0onicdMceJYYn1VBxZGpXQuv3Avz0aeyR5h3mSo
   w==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="332983669"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 16:15:03 +0800
IronPort-SDR: vRiRhaKJkHZd3kiOmTGpQz2HQPDDNdtfx900L5lYyVm1vcYvtWiNdgItERXqGaOAvR/7p6vaGg
 FoPIyPe4YEGs245oFgAN45BeoBP2a8A4U8LLuIje7d/N8UueMayBBkPPqCGW42c8T7Y+JaXY6l
 MdJTaNYcdp6p8NAr0WTAQxZLh1+19O+xv5OQd0AXOTLthxI0YSCMFw4qEhUO72zpiEau+1ItUr
 gavgsWZAeUAust1xZzp6A+XZZ7udCs6lUvJYK37TdxGNT6f0xhoqfGF+2Jg1TbExqYLZRnLtl3
 sno=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 23:32:44 -0800
IronPort-SDR: 879x0vz6BjTZNOAx5cVApYEKJOc62bsOWHU7+rRmDenGEbrnBqjA4n4dtqtSfqPG8BtvOPp+BA
 OEJetvInZcMTvnP9LqJTyQM6evKarPyUWzoQpqUsDkfeTtNhwwR1Oer5qiGKeHvmkxpmJITPZ4
 DDAklOeW8KGtPDVtTc5/2CeuCvybP0E1YJl2a7cxrvDpMKtI7ooWUAAtln4JHsDLH937j9ToRt
 ehVNyMujgIowjKOzbR8D5cEZShNSpvDZQAOd380Px9rv/p+PafW7W/kvOIAjKEkt8xeJ8BA8JJ
 Ez8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 00:15:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nx1sK6Xnrz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:15:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673943301; x=1676535302; bh=/A9f5uVbu/7B67PEgsZ+dQ2Yu9WMa+tclhD
        OagcGEy4=; b=ZgLmQKi7bp6pKRV5biECgmnlsNOFc2Z2FF0uq8CUMOCC2A+ypL9
        vi8A896UhXGGVKtSPgiWuHVvzyHQCohG0Ql6Plm1exrnr0RMapRGw7VPrZUN1XvW
        GQ+Ix5bmow2Lw7eWMkXblLJ0rk1Aho2+77bWUqPW5+BbGoGXw7d9qIGfIJrk1Euo
        xXGyxjmj4e6ZZzoZunl7s3LbVB3TJOmhmvroKUTB5FctXIZlnhtkH7sXFTekOM2h
        Iu2n38HPign66pXqfitKXmXTW8vz+74KtmAQtA9u/Boh2z952NwM7QFJLEOftpkN
        zVExjt8/PIxTs81h/hREJn20w02xnY/GoGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jnwDvM86MHjF for <linux-block@vger.kernel.org>;
        Tue, 17 Jan 2023 00:15:01 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nx1sJ0V7Bz1RvLy;
        Tue, 17 Jan 2023 00:14:59 -0800 (PST)
Message-ID: <f5d2f1d1-94a7-1b14-fc0d-d2497155893a@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 17:14:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 07/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-8-niklas.cassel@wdc.com>
 <Y8ZNftvsEIuPqMFP@infradead.org>
 <2bd49412-de68-91d3-e710-0b24fed625d2@opensource.wdc.com>
 <Y8ZYuIlxC3Ui0LMP@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8ZYuIlxC3Ui0LMP@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 17:13, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 05:06:52PM +0900, Damien Le Moal wrote:
>> They can, by using a large limit for "low priority" IOs. But then, these
>> would still have a limit while any IO issued simultaneously without a CDL
>> index specified would have no limit at all. So strictly speaking, the no
>> limit IOs should be considered as even lower priority that CDL IOs with
>> large limits.
>>
>> The other aspect here is that on ATA drives, CDL and NCQ priority cannot
>> be used together. A mix of CDL and high priority commands cannot be sent
>> to a device. Combining this with the above thinking, it made sense to me
>> to have the CDL priority class handled the same as the RT class (as that
>> is the one that maps to ATA NCQ high prio commands).
> 
> Ok.  Maybe document this a bit better in the commit log.

OK. Will do.

-- 
Damien Le Moal
Western Digital Research

