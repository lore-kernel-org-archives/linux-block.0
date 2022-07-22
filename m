Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28615C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 05:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiGVF7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVF7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:59:34 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CEB51A36
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658469572; x=1690005572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0+gXXi87vYbr+W7C5OMh8zlhjHsaRXP+wu+uEbGEwik=;
  b=UwOCDb0L7zE2DrsnTcou22hedg3IMc/sXWrlU+zCirXIBpZXRV0Apx07
   Q10FUJQNCBxUQ8SXAZkgM47WcAq0vjUwk1XBYNwgWUuPEDpZ236rz6+MT
   2jf3uztyakdQCybLKsCD0mXxYctRoGQxFifQYmSfsP6/cFQkJkItt6sph
   kb+LCJ1tLAvFtblfqkcRIUHwcKsVYf7aVrFfFPE7o4AMUoOt47GXbDbhm
   X++J1pteojyibp9gKhzrZxQ3zQCdYUDuY1bi0mtaTNZkyu5rsHpk9j1wq
   tKaLw02nRv8eRpumHWS2jHZl5sTI99DLtAEX1cLTBDNUUjRaUdQEYXO4t
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="318708263"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 13:59:32 +0800
IronPort-SDR: BJzTpOQ7+tCCjLrolFyuTJTO0tV2c1wEyc/8Xl2NwjRkmE9TZ8W4lqKj8nuq57xZ8uXiCtWsy4
 G2/B9xs4MaqQqgoRK7si0zuzoK6tSydGeL++mK/eq4W4uoCWJlhZphPHi2CJ9tl69l27/J2PHf
 CCbj+ULdjfuoimRiHs3ygw3y7hxKieQXLqSce9zb5Zxn55tlaEcW569x57c76e1ATSxdl0/c1J
 kaRqkZw6mT3Md1fcclQBJbUr+4gdBCVMmXvZzd1KVnNBEGbK4r1jQBz47qYBNLSub0aWHTvrof
 o/IKbAYDyPgKYb4YTHSf/Ebz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:20:50 -0700
IronPort-SDR: oYDRbxiMEHxt3QvT7tTXJ2yckoHF7ZkrCt27JnlgeJ03HbkNNAdszrwdXwzXIcGbvcxoZmGKb9
 QQDaxQFwdrjAOfdmdssxoAiPOjfLQHMuzKfAf3hYOF42TZmSLDmVx1aTga+7D7OJGGVVAIO+mE
 LYyr+sE00x4ov9L9Yl7tL5bvfj9uCwxfA+tlz2LoTvcK3jA2mQAkJlpkaH74tqKDGBbD00PQlu
 gW30V9tQqwpyD2fj6davRGv6bBsrJx3OLG/AJGcrDSQMIQNdYkwt0Oa9m+iKHhV7kwc1mui7jU
 a98=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:59:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LpzKc02MNz1Rw4L
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:59:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658469571; x=1661061572; bh=0+gXXi87vYbr+W7C5OMh8zlhjHsaRXP+wu+
        uEbGEwik=; b=A90tFfnHPlJEqxLK16x/YVY5iaoBEk3oXbrXk7wAZU6q2LzK7wj
        XZqkEzH5USGWATTTVkhKZiLD/AaJRhCUGXmW0NsO3RJeUAnINE7hrYRoNbHq5Gkl
        hlX+47oAVg8Vje0aKQA1ORhN7CG7+2ti8TDenx4m574XtnNlenkehNyWRVmVrXrN
        WWx8GEhreBLLsc0etDlcOjlZctv3J0npySMfrZ9gnHqa3F1qhWeuP+z43Cxk4Ili
        ryUqqj1vfx5B+MoOt4UFnJ2ZW9MHxUz5iCmmaYkXfWYCO9pTiU+rwCkncrRWRe0z
        Cw8v000m8c8PaLm2uFEvVsF5qjVwKwolJ6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mpV4N6wF4wqg for <linux-block@vger.kernel.org>;
        Thu, 21 Jul 2022 22:59:31 -0700 (PDT)
Received: from [10.225.163.125] (unknown [10.225.163.125])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LpzKb105Zz1RtVk;
        Thu, 21 Jul 2022 22:59:31 -0700 (PDT)
Message-ID: <e4bb0162-4280-a8e3-ebbc-9daf428085a4@opensource.wdc.com>
Date:   Fri, 22 Jul 2022 14:59:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] block: fix max_zone_append_sectors inheritance in
 blk_stack_limits
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-3-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220720142456.1414262-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/22 23:24, Christoph Hellwig wrote:
> As we start out with a default of 0, this needs a min_not_zero to
> actually work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8bb9eef5310eb..9f6e271ca67f4 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -554,7 +554,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>  					b->max_write_zeroes_sectors);
> -	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
> +	t->max_zone_append_sectors = min_not_zero(t->max_zone_append_sectors,
>  					b->max_zone_append_sectors);

Hmmm... Given that max_zone_append_sectors should never be zero for any
zoned block device, that is OK. However, DM targets combining zoned and
non-zoned devices to create a non zoned logical drive, e.g. dm-zoned with
a regular ssd for metadata, should not have a non-zero
max_zone_append_sectors. So I am not confident this change leads to
correct limits in all cases.

>  	t->bounce = max(t->bounce, b->bounce);
>  


-- 
Damien Le Moal
Western Digital Research
