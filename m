Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1814BC61DA4
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 00:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBGACg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGACf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 19:02:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3717140
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 16:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675728154; x=1707264154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yIILzYCcjLp2tVEtzbfoT4seV8GM2Y4g3HEmolE1Uuc=;
  b=QnbpvhBQO0WqpL++3xStXhRLU37yR3GNxkp14FHqlkTpoNw5Lyi3KpwY
   3pNIiIfvpGeeGKD9Y6JE1gEslDAVjIj9GJGE0v/9rB22bKhJCuEk+FkmF
   m99lwwyuJ0fnPeEzSuqqUg8GLp2ns73bbbxzGy9jzhGNdH/DJZ8Tbr5B8
   HNITba7J8BqUMf2QiBKYtYMzoJUutcn3KZtcNAh1lHO4eagSC2NYQucnh
   GXSvU4g64hcqPKgatsmKoaiJ/nPQOr3BMhbDYvwJ9NzctE2wxhr63yLj6
   2ZsjKzdaMGAsSL/lVsNj9EysDcScDTks5wzoW5e+gVAP5WnTzWmXh03Rt
   g==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="220974926"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2023 08:02:34 +0800
IronPort-SDR: p7iqPBpVbIeaYqqZPNgtnPS33hrpRkjfJEPna0U+48qagdktXEHIDOK609QMECIYwCkEHp+ZyZ
 VZ1Azsl45B9c9MNxXTEvjiB3jnYxWx7Ofjg9xKnmgboU08mWGKKw/WbzvjhHA9judQu/uH2vQN
 y2fqUsNj3fKg/UH+KJwqJU5RuHYkJkqrzsfyqQJm76GAyuXLNT58fuT69n/s/zOGgaI7G5Jykl
 xaYQ8kNoYGEcXv/ww36Fp4tbxSn1+uN5ZtU8Oecv4axvLc6CK70Ipm+vwWZGYWdehgr82jra2y
 eLQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2023 15:19:51 -0800
IronPort-SDR: jkhqeB0NcHTKntT2Xu/6LxSLMu0wm69k8fv8nnPcFSE/1j8Un1VCPSy7HUCBzOdiY6SF4I2gZl
 WviTlcUDTHRWLMQ+fy4BAMJzMZnXVxw8FUUeiTXzui1/L1VCmvpmtn0o5diGHKFEIlzMo7IOn3
 huXQLYMOK2Tkhrkj024ZS7/0HVXY1xX34V5gtFetycpwVdZPvDee1nh72EMC95atsaB1PhlO7U
 PTZD1DwdpmONmuV8eI8lHDGCg+fEmVoytcgjWBhRluSdgHAZXrF+biOBV6YDBMWtBfgziz2lMx
 pYU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2023 16:02:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P9jxP5nF3z1RvTp
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 16:02:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675728153; x=1678320154; bh=yIILzYCcjLp2tVEtzbfoT4seV8GM2Y4g3HE
        molE1Uuc=; b=HqIYs8r/GoSN6NzdbYUtYnRT7iAsoYp1CdgEooJ9d2YCrVFLfzb
        rjEttICX1G/oxDPb6AwDU7V2TQJB+HfJaf1M88xEH1vsUFzhMYbRnHaptWM7l3y+
        0N/93UZf3/zIpKVs1GgeYskEr8olM7rJ3MTh1mJzLj57GqlNjpfQF0p5wYlWq0S2
        Na4PZ8u2htHUX8QXv1HmrZ8E3zqd2Gmq/NnVSby3EuLZr2E6J1MHcfVAe7i4gJW1
        70gb/GfBIdcQvJCl82dQ2P89ZcTAUaYyEBY7mSFZSS0GMZKDQADgu59DkEkmqfXS
        7WQ6T4EXJatWSwa5lc9VZYa5cr6xtn4mFmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mCp1rlRChxtk for <linux-block@vger.kernel.org>;
        Mon,  6 Feb 2023 16:02:33 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P9jxM5t2Mz1RvLy;
        Mon,  6 Feb 2023 16:02:31 -0800 (PST)
Message-ID: <605df8c8-ee93-9411-f90b-5b80102b8f79@opensource.wdc.com>
Date:   Tue, 7 Feb 2023 09:02:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] pata_parport: Fix ida_alloc return value error check
To:     Ondrej Zary <linux@zary.sk>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9uwqRothHhaOeDO@kili> <20230204205527.16716-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230204205527.16716-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/23 05:55, Ondrej Zary wrote:
> pi->dev.id is unsigned so error checking of ida_alloc return value does
> not work. Fix it.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied. Thanks !

-- 
Damien Le Moal
Western Digital Research

