Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BAC3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 11:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjAFLCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjAFLCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 06:02:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8C6DBB5
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002927; x=1704538927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qOPZjLWb85oTosl4Zg0QMHphA/mZ2a9oPbXY3mUvq2I=;
  b=PiMXZIr9EavD6kB5y5YxXaNKZXt9F+vhuSoJfUJAn+l5rkKPg5DraaVs
   65LMtzxp5bZxvnh4HQ80wQLvDaTr7Nobdd8h5SgvkXGncqHBXJyqCjuy1
   toytIdYclin6rUUZabWfQEQ+cxGMdyVOz2hDz1d0y3JhujukhC5Af+kJV
   mbGMTWMdc6hJno2uuFjf3YaWubic2L6kysY6xQd+ph2TRRueBGtTyDTtg
   8Zn/NEFkZ7UN/L0ZM1Fc89itn0BTcXkGWJx3VEZyXUogcYGIsgyzcl9lF
   ZoZpCirdnBiAV6Kc130MJg/9ELX+oz0XsZjwcanlbAod8Sa/Uewx31T/H
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="220280658"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:02:07 +0800
IronPort-SDR: T7/WstsM0bNWTyU2UejxAI/J0AbWOdBXvWQQ8vRDRhu+aZfCqatV7Z6nF5GCLfYbHXy7cC+9kp
 GO0i/OzZeTDZcoaY3cvmzCBFupJCU82+Od/XzDljUubMekG5CRBsm33lyemrfo0hapUGa0IE/n
 D58M2zM2PLMTwvrBOMkexDoqMRzf2GRVOXVKQrNZSwe+3iLIk8xoDFMwByVLIM9/RbjAy/gaSd
 T+3K0QXpkGKhdg92EkNVCX+TZxLIgVhWwQmYrmX9eIQdf3mO0gXkwiCBBXxpkoq+4NqbY4DzrW
 Reo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:20:02 -0800
IronPort-SDR: 5QXA74cQVIBC953ZFUO4DiSCzbN/12lZUoWXyDpePqpwSmR32m+g2exYl5WrtN/u3s2UaujZQp
 kijZBuR5Wfqv63ozwPsWa8+8KTB6FMk0w9u1mmpQIEjT+eKc0ykJi/+G9dA1gEtCU2nV/Yzs8Y
 PUeb/71ruS2FxvbZH/3ON9ViE0QA1iI9ogQaOLog1r4MLxZoFGRmccrG3QdagpjMqIK7V3zapl
 mXGe3qTNE23+hO2SP4NOLtzuqmP+1S6pzL4GBmp0fIcbvUx76uwnr+ERh9lheOq3iCLCEBZQjP
 360=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:02:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL5B5vMBz1RwvL
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:02:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673002926; x=1675594927; bh=qOPZjLWb85oTosl4Zg0QMHphA/mZ2a9oPbX
        Y3mUvq2I=; b=emYsWRsPcpEOiygtnbX+ay8RXWSrr1fcQ4j8rreH6rJjU2nAPaS
        VzO8gx9YDdVHkW9GQBjUF6hjKzBRitRNzQ4eoiLQWjUYn2L+Q/ar7jC4fruwf8JK
        Ugy/6fnb5aO9NTjCvBqDGvL/lezCh5xnJTUniSO7/kiiSlNeEODpep5QyWihFrWV
        mKhv/s3F01NwuKnyWchz1FtyC5XtXhd2rDJIbHuCVdpJmXycoX+tfJsnxIAU5A2o
        Ah6exVQViCJ0efyk3f8XU25Z7dEYHGu1yCQWGtb0lFcKts5ykU5VRTlsIFa+bDcg
        cDnycyHYt4hoXnjVLrZ/JjkgfjVeA3wru2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TTMNZk0bKFla for <linux-block@vger.kernel.org>;
        Fri,  6 Jan 2023 03:02:06 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL583jLFz1RvLy;
        Fri,  6 Jan 2023 03:02:04 -0800 (PST)
Message-ID: <e6216fe9-f77a-adb5-6ab4-2f86d6a86ef5@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:02:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
 <20230106083317.93938-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/23 17:33, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

