Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C3C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 23:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLFXXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 18:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 18:23:00 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0B286ED
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 15:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670368975; x=1701904975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7dTgJZvXn/0rjzJG4KrL4TNwGEAxt2FG5yydkETyABg=;
  b=M+ZQii9oDBNwYaGjSvOor6os3htDR/SEvJ08bCdHlzlaKcPJknts9hQj
   MiOQPMLiWCsaRylcHNBTfJwwVRfGw8naVUf0I1EjGUfKMMx8dPMbb/FHW
   RxqvsB2TPDFAyVZp19iGzv423ICj+6Y4K0jeQukVWR3aP1681tfkqHMGj
   WYj+Pam+74Fn9mIxx3fIopoSbKPRwCQubDY04EYjr8b9iXywidA2JyeK9
   Axh85bGXfoDVnp+PsVqyFFY/EqhxXlbUx0ASjiPvbP4GK7B5f0UT/+yRx
   yCNrSaUDpy+DugCODAhh/nhJv1GW0Rv8V6XqYHnjTiWriOiMnXleRKPTh
   g==;
X-IronPort-AV: E=Sophos;i="5.96,223,1665417600"; 
   d="scan'208";a="330140993"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 07:22:54 +0800
IronPort-SDR: eXsg6p2CF/vktuipC0BCPnehRVT1PloSREMi0/OHa842eHyfcYubPUnVS5BzFsUM1zlFHrH6XV
 rgJpG46XWSIxe34mIPDHGuVEK+746iNsAilouzxRGqpDDc8QNtxUc5Itd1ryE7kpLfzhOoerYn
 mQBga3cGhFnMTAzi+IeURno+S9PJv5jLgEAVr3y+NXlflw8PitoH67n1GLm6x3nZfQST7QWmRY
 v+F54MqF1JUs2DPLgASunl5el8RSg1PE6i7laWZEl+x/0qWlyTzX7KQyAVYUvHwZVPJJkmrECq
 s4I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 14:41:25 -0800
IronPort-SDR: mRc6u2WploYX59H+LmTkCWkG9eG1bMmsInytm9YP1l6QPHuCptYQBT9TNel6MxlpYFpDw2CTyx
 TReXfeh5fvx4mGSt0e8gzsfs6iUlqJufKTPWxthuOKU03xOSewPtchYSNYBzQ3QehndD5Iheh3
 0+XW0zg3BEhjtqODQj1fVzkQVduWtuDbbeGbbODHr6XKz9fyWWto8G7JuvSdfpPhAMmrQWzKwD
 OaHh0NZjm/10jMWb2YH4zDPA/ISMUz6QldmXy6yWC1MyedVpxV4+8M5cgnKrR8icRA2bDSl/yF
 Tzg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 15:22:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRc0G0Wp6z1Rwtl
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 15:22:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670368973; x=1672960974; bh=7dTgJZvXn/0rjzJG4KrL4TNwGEAxt2FG5yy
        dkETyABg=; b=X1aW3GN1utk0UgPHuHVZA2oTdTMeXctOUd+rsdoX8RAorOW2zdu
        afiI0sEz8xelO16qCfd05xOj/naPGG9KLUZFZZUsBV2ACtoCNtTNLZ+U2gA2rucx
        NZq77IpJaxnPhBzbvDlsx7V+7DThQJ4058ldWNt8C1IajrKEN7cAcsC/73fXPXJm
        7BtbId2rGWTt20WsBg2p9qFp1XASo7eGAz897IaXqXhJYvEcd0bRN30rH14gEuJM
        6e7wVfvze8dvTy4/M1nbyBf+HgsnetFvCrvDv0zg3JOgTiiV8YHfJ0iq0J3oCuYQ
        BcUQwoGVNxwJ1kSv/ZyBgkVW2BZzrgcqO/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yJcd2P8WlZ-F for <linux-block@vger.kernel.org>;
        Tue,  6 Dec 2022 15:22:53 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRc0C5NZhz1RvLy;
        Tue,  6 Dec 2022 15:22:51 -0800 (PST)
Message-ID: <52576133-b94e-e667-8410-33e44f3f37f1@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 08:22:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V8 3/8] block, bfq: move io_cq-persistent bfqq data into a
 dedicated struct
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221206163203.30071-1-paolo.valente@linaro.org>
 <20221206163203.30071-4-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221206163203.30071-4-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/22 01:31, Paolo Valente wrote:
> With a multi-actuator drive, a process may get associated with multiple
> bfq_queues: one queue for each of the N actuators. So, the bfq_io_cq
> data structure must be able to accommodate its per-queue persistent
> information for N queues. Currently it stores this information for
> just one queue, in several scalar fields.
> 
> This is a preparatory commit for moving to accommodating persistent
> information for N queues. In particular, this commit packs all the
> above scalar fields into a single data structure. Then there is now
> only one field, in bfq_io_cq, that stores all the above information. This
> scalar field will then be turned into an array by a following commit.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
> Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

