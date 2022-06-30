Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB11C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiF3XjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiF3XjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 19:39:17 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6844A3E
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656632353; x=1688168353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p/aH+kbjF4J+5Mz1F7nu/6L6Nurgb2SuW006w1zPehE=;
  b=kyP5dTd+IpKxJmdX89qV3FwbhHfuS+sr/cHjMgW6inHbmAReKxUU00mZ
   5iPKN+1KebDVwOCGGyqhIeEAyNwNJeyP4cPC5fb+nSQOnEUg4hbYvlatE
   HZSBh65Y7rfuypBEehz+0bkhp5P45s/Qiosr5MsrQdlPVMRzIUstRVvtp
   mnJOVrJ/+CZ1DJfgQViQZ+wfLJ1fi/CuY5lySc99Elty6V8Antl8s5xEg
   GKot8Rlgktn2PXow6RjokXcz8iVt2zdrcmGCsnoR6pfmw5HZaKlOHx2GY
   aqBmVQSszvSqyof+IVzmvaQcWpAj/u/0SU3HhdNM6rmKdn91JalkxA4hn
   g==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="205257346"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:39:12 +0800
IronPort-SDR: UpstTfS0pESD3/QmoMvkHFhmsevJlk6/VyM3hCFr26e9wTE5FaXsJDklRBCquOa2jTxs6g+5rQ
 z7G8rtI37STb6aBo17np+CODSk46YqWRNQUfZmu7kTwPE6Mi1YoR20FN3Qe7nhFrmag0jxHUO2
 8nq7/PE8Y2UQHTh2K/QHeoxrRLEVF2MxeXq9RxK9Wew+hatEtfwOtZDuT7KmmXtBqxL+8SN5Jj
 5Xq/bz+G4GomFeexJkYj0+ofkwJokUfQf+YtdEdI6RizUwn32bl7MBCwpw30raa5KqkiT8K3zk
 ZTXiWEMqJxLJfWmXhYFyu9jo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 15:56:46 -0700
IronPort-SDR: zLFqhexRVpHaEEriKXRsbFSntv/xDGjFiBgrg/RwzV2aSb9xzPFNHJpOkESb+BMoD2rna0DHY3
 r+AzCBc/g5OlGnoS0i4qlD3218L3cyIeSzq3kYC3tot2KBzVk73WxmqAQCgJ8W2UNZO7FqzWCT
 BfYxvjKGTmO185bYfJcbYu7klp7dm+M5OBScBxYJOR3XqdvRyenBs5V66nIzBXOk2h0DMLK8CE
 86JQnyOIwLQdixEldbLerAyrJdKOIu1pxHPi4zMlfXouGdWuhghbXcXL2yZI/nayfJVR7e6DDq
 t9M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 16:39:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYvtS4PyYz1Rwqy
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:39:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656632352; x=1659224353; bh=p/aH+kbjF4J+5Mz1F7nu/6L6Nurgb2SuW00
        6w1zPehE=; b=cpf4PZe6lwjhyYT9zimbFJm4ydv7K/JhfYfQTOtkYnhPZ4P2jIG
        oatj+k4OfFxF0HqhMAgXy+NUwAm0CsaZ5VVP6Q9XR1Go9A/yDglnZSiNEOnPI7yH
        xU1fAMLl9PguQ8g6TmtbVDQX46rdYDm6NO483Ox15jXa4RShtEDwkGrgDKNHf/J5
        M4kkMQ2FRdN2mt3RfHaMHB4JDzty3lTZg8wVWonEl8n+MPMLT2CbSH2d9hlGWLbu
        P1Dsa2LiyFsGzJcf76TeaQZWWKBn2EIzfac4BW0AC0gHjYItL9LVH+/OjPL2/Nvq
        WLZK1obrFKJJnK2xpM/ooxdmenWgRIA94sA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ynpqG2O7wjIq for <linux-block@vger.kernel.org>;
        Thu, 30 Jun 2022 16:39:12 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYvtR1DmHz1RtVk;
        Thu, 30 Jun 2022 16:39:10 -0700 (PDT)
Message-ID: <f42c76ef-ae9a-71ee-e1e0-1aa3cbbad154@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 08:39:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 63/63] fs/zonefs: Use the enum req_op type for request
 operations
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-64-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629233145.2779494-64-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 08:31, Bart Van Assche wrote:
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/zonefs/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
> index 21501da764bd..42edcfd393ed 100644
> --- a/fs/zonefs/trace.h
> +++ b/fs/zonefs/trace.h
> @@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
>  	    TP_STRUCT__entry(
>  			     __field(dev_t, dev)
>  			     __field(ino_t, ino)
> -			     __field(int, op)
> +			     __field(enum req_op, op)
>  			     __field(sector_t, sector)
>  			     __field(sector_t, nr_sectors)
>  	    ),

Nit: the patch title could be more to the point, E.g.

fs/zonefs: Use the enum req_op type for zone operation trace events

Otherwise, looks good.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
