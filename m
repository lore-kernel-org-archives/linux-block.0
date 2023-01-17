Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4DCC63797
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 08:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjAQIAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjAQIAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:00:08 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EB25E0F
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673942407; x=1705478407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g9jZ4NXxoTsdj4fcvmZe+9a9/ft8JBcGnJUfqd1G/YM=;
  b=iI7dYovdadgv3yXtwp7eXJ/QIse7V0ffyDxdNGZ4h9OMBqcvtR3SOn5F
   8Ex36tzX6dgoGPl3rBSERPG1aWFrijfnDk53nXl+RWW/B66vg4qQh+FUF
   qB4s5pUaPkI/hKRIWc8rIejBSqWfoLMAvEF31yiOFELZHFHM+unx3P32w
   XQW3ZEsOp/Fl+QQN2j4PUfOO5pDgU6vGqO4leLePQfwELPlAjyAF33KWe
   nbiZ/o2SKXJU31FVsrNV0ydtX8oQmQUOGYrw1cVhTiYu0ByBbY2c9izo8
   9wCg8E/toQiEhYbOmSBT2AfV/swY46lnNyCyx1cyHQURH4VUJ77jatucO
   w==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="220819956"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 16:00:07 +0800
IronPort-SDR: 2aqmXHVjmLecwJXvOQfKfXaM1Ue77knciWRnYlNkikyQPMcg9BaSqpIRxWakKIcf5cNoR1sG86
 CrxO1/dhubwIPZxQsbPihwfihBjjTyyuCHrjghlQCe/D1SXkSYugh48/z2ePZOouhrzreD7FD/
 sz815SQYt4U20Wee9P7pxzkV15shHyUREZ3Cg7du+5qdOC0dzBLo+d/AQ8C8JdHSl46Sqp11fb
 E01T5ypQJCUMomDSX7Bad1M+CvrPx/43zy0NP2yBC+MTfr/6beQxRPwjBpDQyM7V7enC8GqGzr
 1II=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 23:17:49 -0800
IronPort-SDR: S3iuipaacmUyKcOIlTy4hRTCyldAWjOwPqU8A++LXOcEA8xXfsLGdevd4IqLwXb/Ih1W89wdph
 ocac/7kKhhcJgnkkmaRObjR7KLVEYVSGblc0r5w924cGvxU+WJtkG0PLUrVw0+B2VudYLX0ePy
 SFoSW8Js80vMSErDSf5Dkx/FT4e0cPdKZSaurtNZAEPH1UURA9nqMzuSBscE3iGwfqX9Z3UG/l
 R0W/257PAbI44BOx30TQWjcWb8iOnUhg/KUcSqEXHo+iDafsvNSrWzY5G6Mtlgk1Wkm65WO1IB
 RsQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 00:00:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nx1X70bDXz1RvTr
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:00:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673942406; x=1676534407; bh=g9jZ4NXxoTsdj4fcvmZe+9a9/ft8JBcGnJU
        fqd1G/YM=; b=gh+HNdU5lPDHjtYtR8YwkLMsGJcCWv0G5fvflwB4/e79NO4dc95
        CATSrXcZ3Hq0ngy8y5zaWrZl1c/tM0v+J/VEtzb5EqDCRTqg+7dM9f8LWFNswk34
        batIoLERiycRRwPhxp3tvG0vhfu/Mf7Qbhst/wFKoTRscOcO9vtBCeKLqQj3ee1D
        pyA1yP4KDRjvVZ39vpyO6/dphfv8oZAF05HlR95Bx6mQDflzukwuc5JgYILNasq4
        m7HPVA+71cQRWFjOU4zK/hNTbfA3gxAeUK8EZ6uzVEEObnSuWcuH/IgypkD7RiJF
        TDs3dvl4udySqNBAt8aQdh7F8Os5b310S2w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EPcG4_f1vioa for <linux-block@vger.kernel.org>;
        Tue, 17 Jan 2023 00:00:06 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nx1X5302dz1RvLy;
        Tue, 17 Jan 2023 00:00:05 -0800 (PST)
Message-ID: <16676885-5e71-4a5d-1b75-db2ddeb8e16f@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 17:00:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 14/18] scsi: sd: detect support for command duration
 limits
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-15-niklas.cassel@wdc.com>
 <Y8ZQQRO/O/3JjHtV@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8ZQQRO/O/3JjHtV@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 16:37, Christoph Hellwig wrote:
> Is sysfs really the right interface here?  I would have expected an
> ioctl (and for kernel use method) on the block device to more
> useful.  Especially all the dynamic sysfs manipulation from a driver
> is a little scary to me.

I found it convenient to have everything in sysfs as everything is visible
from the shell without needing any extra tooling. And I did that because I
thought ioctls should not be added... We could add one though, but then I
do not see much value since cdl-tools (cdladm utility) and sg3utils/sdparm
can give that information already.

-- 
Damien Le Moal
Western Digital Research

