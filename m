Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46226C4338F
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F066023E
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhHHGaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 02:30:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25236 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHGaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 02:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628404183; x=1659940183;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=UJc/Hvuwn3lsRk9fHecnmjRpT7KEQJhsFR+AONwK1es=;
  b=lbYYMmyVo7mX66F7b0Yeaq2kgLl7QPtu+kqVKTDSN9jqTWWxGi8voDAo
   a3OH9fINo/1KVhBLcpJjwYNVrV5fQOWGOldl+GKmhw7mkIg5OWpkQzERH
   N/LWjDUx+8NoOwQNoEugxIEioYssanCrxjloBJ7D7Xkge0lMzlwHHtmt/
   0+HIms6sGU0Me5hekax+QHbuEyTsQZloxooJ+VNmkAlrGK5mJA3zXJQKC
   +qRDPJeB6rbxaGQ+RSxcwnIsTGWmzoYpJ99E/KnZ8js0jLi/IwzlfIa45
   yx6UQFrI1Y7PvQnG46j1r3CE7AErfhs1aAiINLVdt0qkcIqDtUicLw0HE
   g==;
X-IronPort-AV: E=Sophos;i="5.84,304,1620662400"; 
   d="scan'208";a="176601739"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2021 14:29:42 +0800
IronPort-SDR: pJSwn0SBfVYNmdSh0BKancHr4Js5B26tZpTJGGKWrcHGOSXks+u//DTLSk9qVi8uJ2YZ3/KFwZ
 GmsXCVrkvZ/hTzI/asc9vOrg23cczddE9AcYZQOoZiNozVUhD+gVrTdieIpHfT9+cNgvmmguzP
 86HYEdyY74ck+DWuD76qcnH4ahNXQib+0JBsJMgG4T47v8qEH9M4SniCC7K+euh9qVdDlXLdH7
 D+kHUrSunBxxLNRYsuus7R4oPg1F5aNxpcMg+MxWbkX4yf6csj9oUW3rmmO6utICYXFdA5Xa7g
 LRGwxbxEiOP+3f3dST8ZNFh0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 23:05:19 -0700
IronPort-SDR: pPMOxFvDaqjuBkYq5QZToKanSK2Y+S6/20YYXgJvDoVJTJh9567xvrUInQYa9EsUtRuvTrPEZI
 d84V2lQgQG2/X+tk2PWnotXAZ6p4k5n2VWuKCv86EJogWv+UKEt5LtysrKyMGZ0HkZ5qXc5Zm/
 AHnMNP3GlnEYHORSRAy2hiEbKqOyv0Uj3/lyZ5j/Y5vBMGX8jCb8kQp2jZueWr3KEm8IZTFhad
 UM4BuymJcpVjYJ/96j4YUWIlnJyDW1wb1YvHLhO8VEHj9pzWvt6cvUjNxqJI++MlmDGKQJBmeh
 KDQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 23:29:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Gj8T4288yz1RvlR
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 23:29:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1628404183; x=1630996184; bh=UJc/Hvuwn3lsRk9fHecnmjRpT7KEQJhsFR+
        AONwK1es=; b=Y5YfW8nIddnMzU+ouRnx840tMtKW/nOcMoaJRtItG0ajKAP9qxF
        PG758L9aw3q3S1NCXP2qWKXvAly/Gh7BC/dVS7zqDMu48nydiQ/ENdFdpYLOtz/O
        0yWjP0wGawZnWHC5lBTLukZ8/NiKWt/URaA61InU9IlLVl0S4b8Jheh0JxaL3JCg
        pzUnJmu2c7HgoUSKZgF02m6JSrL85yiXHgl8I9P3qmXet1Sh0NRi+ayUmV/nU7K3
        kLnd3z94F4PUAH7sI+R7T1Kkbdjm5BKautGRE5YLbAgzwl1f5Bl5LFr9tisU0WbN
        j7kcw3oBDDE/8eZ80kYj0vFH57kHUMPbwQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 84SrNmvgT3C3 for <linux-block@vger.kernel.org>;
        Sat,  7 Aug 2021 23:29:43 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Gj8T25ShMz1RvlC;
        Sat,  7 Aug 2021 23:29:42 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] block: fix ioprio interface
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-3-damien.lemoal@wdc.com>
 <0141fb21-c0dc-d743-6af9-c2b26d34c4ba@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <ab7925cb-c6a3-0c32-093b-9ac8f17f0c3f@opensource.wdc.com>
Date:   Sun, 8 Aug 2021 15:29:41 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0141fb21-c0dc-d743-6af9-c2b26d34c4ba@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/08 1:18, Jens Axboe wrote:
> On 8/6/21 5:18 AM, Damien Le Moal wrote:
>> An iocb aio_reqprio field is 16-bits (u16) but often handled as an int
>> in the block layer. E.g. ioprio_check_cap() takes an int as argument.
> 
> I'd just reference kiocb->ki_ioprio, that's transport agnostic.
> 
> Apart from that, this one looks fine to me. A better commit title
> would do wonders too, though, it's very non-descript.

OK. Will cleanup commit title and message.


-- 
Damien Le Moal
Western Digital Research
