Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0BDFA373D
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJaCTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaCTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:19:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D47B1C8
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667182784; x=1698718784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9GrKDuUAtVqQ1Y+gCXur21qQSPYDQz0G+Me6GoJ2gpg=;
  b=izhwovBdbD3PI/ucPZdN3gbaWjO4levKRbggQ5xTHGSHPXq0aPZ2j72z
   2xdJwc7KcB0X3SpUPWgQI4dRG5VMgwjVPdODDkwc2cihhVi+Vt+ihckgS
   0vYVdBAoJmo5gjj18fs5ZZh+QlpVfekvvTfTWiynBIz8G+WlNoXkDv/fn
   NfgfoMIzG45bd8a/brGy5Id5+6iIQs28+ol/LgZhx/l35FhK55HdEFtm/
   o5TblkwW+znwtRhE9v4vpft+72iko3ocm3Rd++DEKglgkdayLVf7iqswh
   xU+GKT1uyzcrKJFq/MQw4h6WG9qMEhDkeAUfxxtu3G+6q1ec5Ovk0elDC
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="327200020"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:19:44 +0800
IronPort-SDR: XulMKxCDdTKBA3OdaJ/S+hUBE/8Kg+lwvb+7OdvXxDqVo+PpwWua/J6YTqFpnwIQ6P3HjnUB8j
 wgphTN4Y0ozpoTmpgw0M6ksHzpjdj96oGRZczVmlSxtbWSCQ4iIPWEXEbiJbCvzSwwmPGbpQby
 9QO+lQ4BFr778hXFklLJWofi/UKrnRQi4gkbkM47eWLWhRt4HimMQf7wpICHwmdtYbYVv8GdGb
 zPnYklnuTSnrxEQJvKwJZ9WPA1okfPUdoeGK9GHDnCl8MHvXNDgHkVZaHs0RNGFO0VCcvgfgam
 8O7a87dpX7ZNpICDJdeFPgTX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:39:00 -0700
IronPort-SDR: QRp76nRe35B6rShJ0RBlby5BaIz1blbgeTRE80jhKyHKrrS6TcarHdNOYluSgwmI/qUMagW+2z
 Xqs99Q3L5YjjKfARqf5REy22mg9+cDYDxzNYvek4t89WOnZ7x4V3xWJi5xZ5GccLQiSwxpcWQR
 AZDib0w/B8P9ZIR1eljyK/5nzovqNeYRM8KF/p6o4OQF0IkV/ff/kHS6Ds6mXhdHlKD7sAnkUl
 /ruWzC+Aaraub8du3gvkkYOZRo1cwV3UWBSdZpJmKiNyc8TGFhxrldk6VHppUP4udH4xQvpfKG
 2xg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:19:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xgM4QgFz1RwqL
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:19:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667182783; x=1669774784; bh=9GrKDuUAtVqQ1Y+gCXur21qQSPYDQz0G+Me
        6GoJ2gpg=; b=nidAhk+jaloV/QGA/hak/N+I79sIdRArm4QByz+canbNe4fhTGG
        eGOFQuSSmaoAIXRs1kY/YJ7IkMHQDxT6NwbuGM4HObxoM4IUQvwoGszKkCxdjoXi
        Rl1uvS9oEUuPZgXeecPky0GQ2DIqz4VUzGHX3t1JeqdzPsWr18JRB8Emks9RH8YA
        qTBLby8zL/6kpzgDnQsXWK7+4oecXkg+SjdsrUsOo1dZMl+E5772Ji1txJDNvr/P
        JdK/udDzp1k5ibBS2cae/RNxxEOfWlCIbLT12fem7iZcZv4P4rjF80AioeUsPUjP
        vyJ8RmiyhoJFwBQWTzvFOZscF5uNXmWaxCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dQMU2_Fh2mmb for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:19:43 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xgL2XmNz1RvLy;
        Sun, 30 Oct 2022 19:19:42 -0700 (PDT)
Message-ID: <dd25b6a1-478c-3c9f-9853-43917c115d66@opensource.wdc.com>
Date:   Mon, 31 Oct 2022 11:19:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 0/7]
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
 <dd214de3-2501-e0d0-824e-a3b893dd012c@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <dd214de3-2501-e0d0-824e-a3b893dd012c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/22 10:59, Chaitanya Kulkarni wrote:
> On 10/30/2022 6:53 PM, Damien Le Moal wrote:
>> These patches cleanup and improve libata support for the FUA device
>> feature. Patch 6 enables FUA support by default for any drive that
>> reports supporting the feature as well as NCQ.
>>
>>
> 
> subject line would be really useful to check the previous
> discussions ...

Arg. Sorry. It is: "Improve libata support for FUA".
Forgot to copy that when changing the cover letter from v3.

> 
> -ck
> 
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

