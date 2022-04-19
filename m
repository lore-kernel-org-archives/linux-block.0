Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBCEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 20:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiDSVBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357403AbiDSVBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 17:01:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D94132B
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650401934; x=1681937934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NVCnEbMEdF3Sz5Vu8PKTq1rfbQ51OELQrlrlcHtwR2E=;
  b=no8+TgIkFtPia7NypJyEUe/dwOwH3RcioENd1ljgJunUh8AdiPsc0+Yg
   VE40xOP9qMfkg0S+2Nw6Z1jPA1kwE4759a3942dQw4SmklFnqsENLNnCp
   I4iog+oll+irwLlOPypy1mcp1cVvkVbJwnn04jHAMijLUKIFTWvley8Vs
   dGci4cOpXW75HM3foq2ZzCVMegrXUO9vE+c+qRZXbIPBD6uZQECHZE4dT
   rY2dnxh+cNI4Yu1Tf/qqleu8sEcDHOK7nL1uqIVZpW8sdTjJAN0lI/s4j
   AwywLoI6RQbZY2LgLU0K40tUqcJTXHveBwMh9PEo22n5+13f50bmmBrDu
   w==;
X-IronPort-AV: E=Sophos;i="5.90,273,1643644800"; 
   d="scan'208";a="302492726"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 04:58:53 +0800
IronPort-SDR: eEzyTOM7Jv933kiLLQypkmIotcerayh8NSQX6AVPTYXJxneBKVq8WZ9vKYnMsHRuRcihRg44IM
 ysy9tgq1+tqXhk5XDRqH12U12Ui2yCT03T9ut4UAxlxl79iq2eSgh+9vlk1tF3hG9OuP5gu7UT
 Ji3sXINZfWEANfXUSBWPMFpISLFHVwZhyLPSJuVphKkOGL2Uj72QlmWtXbJ2NessvATPg+Guk3
 HBxlQE44FcwjeV8OfQmMXtxSiM7m6hMlKi6hcCPREHFYjhvv8+gA6wZ66UwYY/5Fwh0AFywANy
 zeIPNhaG0ik9jzUuiYI4mriF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 13:29:58 -0700
IronPort-SDR: vCX0tigeSt+9msnA7gJ/28Ns3WPtaF+Ij8+mBjsfyZMGl5JrrldajDQ9NWbrrJahb+ER5VE/XD
 Ry4JnZ0Mxg2b7V3IWZqhZ5MjaIXuNUfuhIexyaWRBFiYsAVpKGpVqbQcrCjq8bKOFT+el8/Hc7
 aZ1W6iRSsQRpzKU3uHqXtZ8lek1EL9rzoYD4Mx3akSNr41kO6+B3GGh9MPW7WRLblF8PcxRqdE
 XMDeXxYgNx9HkIRR1l3sojrSE7CB1Q92WTx8FT78lQr7n3KrL+RvSzF6i3lah4Asrosf3+3zxu
 X70=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 13:58:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjbkj4sTWz1Rwrw
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 13:58:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650401933; x=1652993934; bh=NVCnEbMEdF3Sz5Vu8PKTq1rfbQ51OELQrlr
        lcHtwR2E=; b=lfOtWs+uCyzVph7CMj22FVf4jt2PRxcpoT7mRiFTGg9wec7SgAx
        jOzUqmcqTVQlpuQf6UUpkr9odpIZHAlqd9Wth5SsauEDbyJHjs16EJcm5hIpqxPw
        Q8FP/y9AeMOwfJezwbdObpgMaZTzGu+VqG0UOxQSvh0is7cHOCMyVWIMZT0HmcWJ
        u1K4uikkZpuwgVkDR05X4gXliDfRaOW+Rs53ZpOUmBmE00SBSuz4145T5rdoTLGj
        mAmzsONaVePUkt7X0R63+s/vCRawO8pT2zucKwH518CnIvXMIpxO0nHFk0hA+CwS
        1hRw5Y0QxwTh8+yJR1yA3O3sgHSe7CnNY6Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HaIWx4Sgz5rx for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 13:58:53 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjbkh50wJz1Rvlx;
        Tue, 19 Apr 2022 13:58:52 -0700 (PDT)
Message-ID: <c64c530a-cea2-cb01-c227-b8ed0bfffa3f@opensource.wdc.com>
Date:   Wed, 20 Apr 2022 05:58:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/4] block: null_blk: Cleanup messages
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
 <20220419110038.3728406-4-damien.lemoal@opensource.wdc.com>
 <PH0PR04MB741614BBD55F620C78FC47C29BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <PH0PR04MB741614BBD55F620C78FC47C29BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/22 23:00, Johannes Thumshirn wrote:
> Shouldn't that be done using
> 
> #define pr_fmt(fmt) "null_blk: " fmt

Yep, thought of that after sending :)

-- 
Damien Le Moal
Western Digital Research
