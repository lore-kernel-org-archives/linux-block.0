Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C241C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 21:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiITVyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiITVyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 17:54:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C1753B6
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663710856; x=1695246856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOXFHU/NhsRuC7Tx8ZAT0JlkO96Z9uT8EG2X+KkgGiI=;
  b=NtrBQKLDzqAm4vduSio3swefKieJLNNvJpQHPSmVKnh7IhtMHnXOEUq8
   nYPClmR95iYJncu5kdlSgoJnIza+pr+D5BaigEyEtoezRzKuIPJQYB/qL
   Xn055nIUG//Jl+ZDrDyOovFT4ZNmEfEVk6DLBQKsjdZdQmvGyWGYYLm0t
   FJ2H29NyvMbRtUhJEBRr9y7YpaW+QOBEt5wCmIkO46sDAEZsoPp1MaY/Q
   oDGNk7oNNacJYF6OKBsUe+9eMl36TF6UtDJcLAXqpNAuB9qEkHs0aJcny
   j/BQ0PYTYC8WaotZq6hFfCet6csqoH9+RJ+nmJdaZdKMsin/962Tv5EwA
   A==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="212288834"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 05:54:15 +0800
IronPort-SDR: +8+a9sQTSluqOCKF11Qzj9VfgnuQVNV03+0uPSCOo6MuqPRtYzmcT1Qqd66N9aUuxzyWOOmqcS
 c+7IvKQ9anp2E/7cGtpDLA98nuDoukHALpMvwzrOB/py3zybF/18CbPLiviLbHEbVTgDjgZ6PU
 EFFvskGrKb4sbiOyKlvx1DR4ub+cTxwFPqZ5aWh40Sx7xkKv1ZCCqWvZ977tWcbdpoUHEaE5Ck
 b6j0/RE6hw4MMSP866A416q1OGfNOGsHF7h5BkyHPiQ6P59Kc27oKj7muk7+j3GV06VYCz436e
 wh1kQ7gcaaUgTT79qyRsEs5t
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:14:20 -0700
IronPort-SDR: wKXrHUL7MkiZ9xud+lWhBeJ3egLODiIqR93XYaevz7oTxc2Tkz9oZ3gNutZ/MenuijAA86BAWc
 KOeyRDPjBMd5xL9SWM04/3ey7lGcvkG6Y2+r356fgOeoahV4MrZ+7q36EPiBuPK3VkT0+pBoNr
 QPqhKlXTEcuY3tyM/2ZPHt2hzbQ0/Won0Eq9tfixCwlYzz1dxtMk59OAYrlKPhIN6bQwSVTMPk
 UI1FuGtOpkdroNZ9zhjA9IoSYXZMpdLas020Qfv+kuy8S/Q9vo9rX1RkJrg+hUt03JXs5lpqKY
 uBk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:54:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFgV4zTCz1RwtC
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 14:54:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663710854; x=1666302855; bh=WOXFHU/NhsRuC7Tx8ZAT0JlkO96Z9uT8EG2
        X+KkgGiI=; b=hsL/f5XhOgP58t67ihnM8VF4iyELypHweE6xKaecHofeB1HApcZ
        bdmJwkn8lpDh3jzde0ZuJhqLnuKmoOG5Jnb/gvkezLUwtZ/tOCPukXrrqHvmvTe2
        QO9lsWDt1uUUBhJ0Oxsmhd+ke/ChX0V7J2cG82oW90s9HR0JYGwLXGEQHfmPmNEQ
        /uOkNXNjNvRnQL2C9+l5/hpiM1nY9q8XSFH/S5bLGHyptXYoPtjOTF2rX6jpPsh5
        R9UmlxqOmZgnamIg0fQtMEIysJwSXlb9CMV8XBvkpv2tUXZecilYOFg436VugcgA
        ytBZM80GstbXBC4Yh8jZKdrnxiB5iqO5QPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g1bmQuQJ8bhz for <linux-block@vger.kernel.org>;
        Tue, 20 Sep 2022 14:54:14 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFgQ4dJxz1RvLy;
        Tue, 20 Sep 2022 14:54:10 -0700 (PDT)
Message-ID: <c8ba65f2-3b03-b9a0-49f8-6643dc32ed26@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 06:54:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] block: Fix the enum blk_eh_timer_return documentation
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>
References: <20220920200626.3422296-1-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220920200626.3422296-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/22 05:06, Bart Van Assche wrote:
> The documentation of the blk_eh_timer_return enumeration values does not
> reflect correctly how e.g. the SCSI core uses these values. Fix the
> documentation.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Fixes: 88b0cfad2888 ("block: document the blk_eh_timer_return values")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>   include/linux/blk-mq.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 92294a5fb083..1532cd07a597 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -268,9 +268,16 @@ static inline void rq_list_move(struct request **src, struct request **dst,
>   	rq_list_add(dst, rq);
>   }
>   
> +/**
> + * enum blk_eh_timer_return - How the timeout handler should proceed
> + * @BLK_EH_DONE: The block driver completed the command or will complete it at
> + *	a later time.
> + * @BLK_EH_RESET_TIMER: Reset the request timer and continue waiting for the
> + *	request to complete.
> + */
>   enum blk_eh_timer_return {
> -	BLK_EH_DONE,		/* drivers has completed the command */
> -	BLK_EH_RESET_TIMER,	/* reset timer and try again */
> +	BLK_EH_DONE,
> +	BLK_EH_RESET_TIMER,
>   };
>   
>   #define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */

-- 
Damien Le Moal
Western Digital Research

