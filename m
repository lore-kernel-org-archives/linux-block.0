Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE8C433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 06:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJDGMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 02:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDGMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 02:12:17 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7FC2FC3A
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664863935; x=1696399935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SnXda7uZ6Dr6mMWhz2D5//J4crYsD30pa1x2rJ8re9A=;
  b=mICnLKXlagHVyvwCD4S/iZ67HUnEjQXD0YPnCcrjzTHokykTGdTx8X3Z
   HmXxCjqZrwPB1q5sXYZQ/JYhCMLlnL9gej8Ffq8oH30qcOAYJnne/5fVP
   26oILBhrdeEP3qxZydHkoqRBAmkOec1Bj1lMtFCtSxBebMAkk33uFyKRH
   Ww1jE4PvBxJDUDsvbXz6SIyqqFkTEypmKjfiLPpkWRIyTey308SEgxAxh
   pZw+uSNyMNlWbjOuZNLUwk6n7w5el1rNc89+R+d6BpN1VxWU/rHdR801B
   yRQib6GY/MbrZNrLAR2GVVBuE0jxpg2nAWSKPpXooMF5HOhCbTRL/yrA8
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654531200"; 
   d="scan'208";a="211271772"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 14:12:14 +0800
IronPort-SDR: 0dGGgpHNY+4MRe40ODU2YPhj9KQ0GSEPtaGJ4ynTBNAu83l68DAQQLqZnRM4E8mmXGnnqb9mua
 UY7aQClx5+ry0DruCEYWsCuv50U3kZC9YUXFlXVuKyDY0MbwhshmEOW7e/cP9/OyfnzY2Gq1Zi
 peHW5JeZJ8gpcNkqEtbAmDeNnRh/LVHrogvgvqi7zkHw/DVAG7KT3MjS60UBz/UAVHHmJsJbO6
 qd53z+u16yajv3mWrR/XwbzJPBeX5y8yJNhQ8p6c+YgMqCeFzfAkkfYjS6UsW8ouKXCU1TpSJg
 hZ+qRr9E2ziO+T+0VbN5cuGO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2022 22:32:03 -0700
IronPort-SDR: p52IAd00yttvWCr7Cc9zZuDjFIZiDK7JTXVkOIGxgS4Yy7CcpWOH7dHxdwkKYdRbi0Cm8BUmiP
 pPbGuZwzD/AFH2iYOXCuoYOIVZyMIL6UylsRsWST9N59jetu6tUbpqLX8W+LFN7PmsaPHmjbAX
 Di57cF+b1YZMTba825Ek7LijRBKq9q8PsfGBkWr5HLbc0X8jKYX04FKASeCxdg3VZ3tOnqM15H
 nVI5Tt6FwcH5zkRX+GQ/rrC7Wa2Qnl4oSktFghxIH9DOHVlgqD/rbqjDUHoaxU49FY7+eoHx4N
 oAY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2022 23:12:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MhS656dx2z1RwqL
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 23:12:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664863933; x=1667455934; bh=SnXda7uZ6Dr6mMWhz2D5//J4crYsD30pa1x
        2rJ8re9A=; b=fChd1qlINI7FyffvMbP4JaIkGi+ewczRJQR4anEbEvJvfbhHoBp
        JOu28HeM4GEA/GPr4rUqPFU+98kfaS4Qb5Mn+tlZz38hg7im34yzwEp9oCXjyJ0K
        horZPfPpbv2p0znNFaBYGgrkeMexrH4diydfXHkd9PIGKNFUmlcb7FR67ijIS1qd
        MCG58NDVo1IQwDpca8JEl2utIdx9G1uSrkxn2EFcuiZzLduiECwkWhLY4wMEZv1B
        QFpqhcwGhkX5X5Ah8wVWQICTEHgMxwqgDG9YEJGTMlfdcKOs5jAAKd4vkCY1feBV
        /If9vSKuXB1EZDSZbr2aJZRy9a9t8kUbKLg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kJhq_kycfuHk for <linux-block@vger.kernel.org>;
        Mon,  3 Oct 2022 23:12:13 -0700 (PDT)
Received: from [10.89.80.132] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.132])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MhS633NPDz1RvLy;
        Mon,  3 Oct 2022 23:12:11 -0700 (PDT)
Message-ID: <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
Date:   Tue, 4 Oct 2022 15:12:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH] block: allow specifying default iosched in config
Content-Language: en-US
To:     Khazhismel Kumykov <khazhy@chromium.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
References: <20220926220134.2633692-1-khazhy@google.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220926220134.2633692-1-khazhy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/09/27 7:01, Khazhismel Kumykov wrote:
> Setting IO scheduler at device init time in kernel is useful, and moving
> this option into kernel config makes it possible to build different
> kernels with different default schedulers from the same tree.
> 
> Order deadline->none->rest to retain current behavior of using "none" by
> default if mq-deadline is not enabled.
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
> checkpatch suggested more verbose help descriptions, but I felt it'd be
> too much repeated from the main config options, so opted to leave them
> out.
> 
>  block/Kconfig.iosched | 28 ++++++++++++++++++++++++++++
>  block/elevator.c      |  2 +-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
> index 615516146086..38a83282802a 100644
> --- a/block/Kconfig.iosched
> +++ b/block/Kconfig.iosched
> @@ -43,4 +43,32 @@ config BFQ_CGROUP_DEBUG
>  	Enable some debugging help. Currently it exports additional stat
>  	files in a cgroup which can be useful for debugging.
>  
> +choice
> +	prompt "Default I/O scheduler"
> +	default DEFAULT_MQ_DEADLINE
> +	help
> +	  Select the I/O scheduler which will be used by default for block devices
> +	  with a single hardware queue.
> +
> +config DEFAULT_MQ_DEADLINE
> +	bool "MQ Deadline" if MQ_IOSCHED_DEADLINE=y
> +
> +config DEFAULT_NONE
> +	bool "none"
> +
> +config DEFAULT_MQ_KYBER
> +	bool "Kyber" if MQ_IOSCHED_KYBER=y
> +
> +config DEFAULT_BFQ
> +	bool "BFQ" if IOSCHED_BFQ=y
> +
> +endchoice
> +
> +config MQ_DEFAULT_IOSCHED
> +	string
> +	default "mq-deadline" if DEFAULT_MQ_DEADLINE
> +	default "none" if DEFAULT_NONE
> +	default "kyber" if DEFAULT_MQ_KYBER
> +	default "bfq" if DEFAULT_BFQ
> +
>  endmenu
> diff --git a/block/elevator.c b/block/elevator.c
> index c319765892bb..4137933dfd16 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -642,7 +642,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
>  	    !blk_mq_is_shared_tags(q->tag_set->flags))
>  		return NULL;
>  
> -	return elevator_get(q, "mq-deadline", false);
> +	return elevator_get(q, CONFIG_MQ_DEFAULT_IOSCHED, false);

This will allow a configuration to specify bfq or kyber for all single queue
devices, which include SMR HDDs. Since these can only use mq-deadline (or none
if the user like living dangerously), this default config-based solution is not
OK in my opinion.

What is wrong with using a udev rule to set the default disk scheduler ? Most
distros do that already anyway, so this config may not even be that useful in
practice. What is the use case here ?

>  }
>  
>  /*

-- 
Damien Le Moal
Western Digital Research

