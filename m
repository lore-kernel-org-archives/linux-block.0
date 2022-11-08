Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E0C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 05:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKHFxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiKHFxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 00:53:09 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67DA2E684
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 21:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886788; x=1699422788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0SLg1VFQohMjJK06BFmKuoVTF7H5KacPSNHB+ge6PhE=;
  b=pBWDerNx10viQFh+SYUELKdNu5IRjoyJnYJHL200ZGISWn/5leeUHki4
   y+44yRA5D67PB/l+BBXXVLgJwbhayuaogJBq6rtT66oCzGk84WIQkkD3T
   5IOkFph4p0BBUsLcV0oXSlbkBdF4d763ooj9B8p3Ebxm5z5svlp2wyDry
   FhqXNvrbgGEFqYgN3ROjisHf6CDzldDX5X/nVAlDlQRj7NiYjDqqUMyye
   U0343jDRBrBUUIFRVEG39zDjcLVrIYzTfwfq63FUCQ1vskYGFFkeYuhkh
   d/Vf2Lt4GZj+QtfmKA07WfpdoEbu5mofiij7ZwUkx9HokOY1h8ztjWf8U
   A==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="214013834"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:53:07 +0800
IronPort-SDR: IZVNgQ3VcbEP9f6r76YmtAQaM0UkSp8l+yMnzmSZAyijiRMeTS/bpH3wa7HfoY7KtQ+r0MWQDV
 jMSBCRrSaNEGd1Z3tAEdIqXh8buIBK/C+Mm+ndY20XM0TdGCZ6KVDdXe21SAZtV9whBPgPpgJe
 AeHcqU6ZcJihLaIXpCdWE4f3zxFxrT1WBbZmOxdFU/rRho1MSfhfLIUWWF54T9obl9n3r9Y2YK
 xikcvrEt5EnoOQVyMpIsufU7beaCdmjd/+5PSL0+hPLjVqLPRU0kVATi2YWMDMXcmfKJyoAzaO
 JTU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:12:13 -0800
IronPort-SDR: 50UQ3HATAZOSXGj9Px9SZsx7LZnEj/ju0pZTRKB2aaMiKvsO5xuhrxW7N0ofeEQZ7a1Gg/Mcvz
 Plb5mTWt9UYHiIYo+2t8qUmTjSZAQu4mLben2HPyiGSQs38ou7ixI9OjGlaC6RXXkdUWvF6d4N
 MLN7wYnHayX1hhNBq5F8852pD7EuupfvfCwh85NwnTSf0QxdGyW/XKE6N9z2kmHUAICSlDbfaw
 clSZA20Hyv53NteBR7robj9Oflj1Xw/n7Vxs6sEMu5f6tHynEVYCT0XmzOBBpL2Vgs6YabjyTK
 Zvg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:53:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y1t31kBz1RwtC
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 21:53:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667886785; x=1670478786; bh=0SLg1VFQohMjJK06BFmKuoVTF7H5KacPSNH
        B+ge6PhE=; b=r3o03iYm3kyXOCwu/6vHXzzySYl0N7GSb2rEiMjW+O1XU1n3evZ
        2OQisY6jeGerxqpxbXnnyQ0Bn5ZRTfgncoq0PLVFLuW8zBiGbcm4wL3KYtsT0Rwh
        ZsUaB3fbYGw849+qrTtJRMpLOkQSUq6KVztaIRhg4Hjb7IZd8ldd/hf+YuVVYYIv
        hZ5Lz3wL2RFEOiklt/c5ISM3H18oq8r2M4zXwzw6scxaAlV7wG1rdYm7zg1sNaMK
        y57pjmoFmU7HrfKGfUX+TlXxEXLtdPPJem+cP+a3hfEm58fiBpEVvJonmGgknQTs
        T1pFKM84CDMZ1TZqsK3vWbimz3da64aP2cQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nDInEHzEc1Za for <linux-block@vger.kernel.org>;
        Mon,  7 Nov 2022 21:53:05 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y1r6LPSz1RvLy;
        Mon,  7 Nov 2022 21:53:04 -0800 (PST)
Message-ID: <a9d3d1e5-c3eb-b919-ba37-ef57efa3c6c9@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 14:53:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
 <20221107055000.GD28873@lst.de>
 <ca10f501-0d3e-fcae-2b98-d39ca1822a67@opensource.wdc.com>
 <20221107121627.GA17441@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107121627.GA17441@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/7/22 21:16, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 09:12:57PM +0900, Damien Le Moal wrote:
>> On 11/7/22 14:50, Christoph Hellwig wrote:
>>> On Mon, Nov 07, 2022 at 09:50:19AM +0900, Damien Le Moal wrote:
>>>> Finally, since the block layer should never issue a FUA read
>>>> request, warn in ata_build_rw_tf() if we see such request.
>>>
>>> Couldn't this be triggered using SG_IO passthrough with a SCSI 
>>> WRITE* command that has the FUA bit set?
>>
>> Yes indeed. Should I drop the warn ?
> 
> I think the warn needs to go.  But don't we also need to handle the
> non-NCQ fua case if we don't want to break pure passthrough appliations?
> Or do we simply not care?  In the latter case we'll at least need a
> comment documenting that tradeoff.

Actually, this was already handled: for an FUA read without ncq enabed,
ata_set_rwcmd_protocol() will return false, leading to ata_build_rw_tf()
to return EINVAL, which is then translated to ILLEGAL REQUEST/INVALID
FIELD IN CDB in libata-scsi. So passthrough applications attempting FUA
reads without NCQ will see an error, as they already did before (modulo
the bug with lba28, that is, the error was only for reads to higher LBAs
or larger commands).

So no additional checks needed I think.


-- 
Damien Le Moal
Western Digital Research

