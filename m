Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA0C04AA5
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 23:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiHXXeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 19:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHXXeC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 19:34:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A030895C9
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 16:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661384001; x=1692920001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zZwYmlJjNoiCHzJlJTR3ZW06qY57fAtVbsDbcIfaOQ0=;
  b=dey8IUTSBl6LBbGLXhzFgN+Il1psGVEDJyyH2TiGajrsnacdPpGHqJgb
   EX3+Lnd6x2+5/yvMcmWFDCO3z6Pf3DSVsz1jlpslP0nRxWOFDJbJrWf1b
   dUa8PXR4cd6nzZTJe6V+WdSV8/AMmhDclYxX6Vm+hP6KQJ3xXv9fJNTMr
   8JIb0x09hpsWFzbpJtcdUg4++x5ql2mVyF/i1QfT5Cd9o0mOvvaGIJdZp
   XrDS/6QZKcuCC0f+Ma7FW1V6YjctbFhwLTRCbYE/GaWKv3TohA+gw5Rml
   AhpxNiPLJMQydAFAmWgEzVeimZZiX25UfAaY/gf+3lClkSAaB8MFGQncO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,261,1654531200"; 
   d="scan'208";a="210091136"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 07:33:21 +0800
IronPort-SDR: uGph7D7YsvmyRpD3+WoRPlWDMovCKdHQ2CX9rQ+RJmLnrSr89W7EqSiwwdZfqm/n+k3KWjUpLW
 a4CallA8PV+0Z0hUSBD++0/SheAnacxzbjPJJmfsu5mbcJ6NGhlIdgb+4kLetktF74Y8pOVS7S
 OY9FrI3PTJ9YvQ4Sp2UJhyBR9ZTFmeW/eUgJFhjiOAmoDAbKUtYvRa1/b2R7okxJyaq6FyUUv8
 xKUDLmFwqdEFNik4JRY2VXEkoPGITShvy0paLO0p/DH4gmJRZrFT1fMpPKZF/ktGT2qKBNW8vY
 ehXwB+F2xlh4k9bouko+E6BL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 15:48:36 -0700
IronPort-SDR: DMlsJ6x226KkY4FI3CreoSIMaIfLw+yT1DF5LkwwstWvWSuKIMbyXHPxiOPHEkEt1u9T4PCET7
 fvI+5/VUDw5z7PYWBBNn8665pbpBXl95LXZ6UH3D9RoCIpiaH2Io0Jngq+luzrcmRQpHHau2qm
 eNf0Heono/ppYw+OJQXVd+MZpb6pAUZuOKeLzaMlZY8gN1I0AOZy2PBOSnHKEPZ1p4mJV0xKpb
 bmG2dDPZAfTlqkvnaZRcWh+6cbRy5/ySkSx1DxB+3ELKHzAitpfbHhilz62LkBap127hD/XN10
 HOw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2022 16:33:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MCj8J6R2cz1Rwnm
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 16:33:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661384000; x=1663976001; bh=zZwYmlJjNoiCHzJlJTR3ZW06qY57fAtVbsD
        bcIfaOQ0=; b=Iipj82sD5Y7alqghy0eoPxrR2cEkwCNXbHl1EW/f44shjC5GyzD
        7kPgR3x1T163RacsamCFgyokZ6UJBCFKAab3sR6RSwc/3Lu3+PkH1hGbZ424LOZS
        FXdjAp+DSiwNJeJOxMlM551vXtxmezYedJdum9ohnQTyPcFOKB9aV7OV6gYmt6Fy
        WU89HzI48NythNffQH1WhUnzZYM0cTBWCx8mrWYr2xbcjhHXL3NCWHQbGSijdr+T
        WRwIqYyD1OOGbvxzKiWz+Wu7La1PkTKuoqSNkeTR8jB3gj7mbB5GhZ17H4NsX6z8
        CZef/akFjmUjXAqqhsp7C1D9VrwPLmn6yZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HcuD64QBFBcF for <linux-block@vger.kernel.org>;
        Wed, 24 Aug 2022 16:33:20 -0700 (PDT)
Received: from [10.89.82.240] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.240])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MCj8H6rv7z1RtVk;
        Wed, 24 Aug 2022 16:33:19 -0700 (PDT)
Message-ID: <85dc9b51-c2fc-89e4-1790-c7fc156d9771@opensource.wdc.com>
Date:   Wed, 24 Aug 2022 16:33:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     Gu Mi <gumi@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <1661341010-80107-1-git-send-email-gumi@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1661341010-80107-1-git-send-email-gumi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/24 4:36, Gu Mi wrote:
> The problem occurs in two async processes, One is when a new IO
> calls the blk_mq_start_request() interface to start sending,The other
> is that the block layer timer process calls the blk_mq_req_expired
> interface to check whether there is an IO timeout.
> 
> When an instruction out of sequence occurs between blk_add_timer
> and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface
> blk_mq_start_request,at this time, the block timer is checking the
> new IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT
> and req->deadline is 0 at this time, the new IO will be misjudged as
> a timeout.
> 
> Our repair plan is for the deadline to be 0, and we do not think
> that a timeout occurs. At the same time, because the jiffies of the
> 32-bit system will be reversed shortly after the system is turned on,
> we will add 1 jiffies to the deadline at this time.
> 
> Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
> ---
>  block/blk-mq.c      | 2 ++
>  block/blk-timeout.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4b90d2d..6defaa1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
>  		return false;
>  
>  	deadline = READ_ONCE(rq->deadline);
> +	if (unlikely(deadline == 0))
> +		return false;
>  	if (time_after_eq(jiffies, deadline))

Use time_after() instead of time_after_eq() ? Then the above change would not be
needed.

>  		return true;
>  
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index 1b8de041..6fc5088 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -140,6 +140,10 @@ void blk_add_timer(struct request *req)
>  	req->rq_flags &= ~RQF_TIMED_OUT;
>  
>  	expiry = jiffies + req->timeout;
> +#ifndef CONFIG_64BIT
> +/* In case INITIAL_JIFFIES wraps on 32-bit */
> +	expiry |= 1UL;
> +#endif

time_after() and friends should handle the overflow. Why is this change needed ?

>  	WRITE_ONCE(req->deadline, expiry);
>  
>  	/*


-- 
Damien Le Moal
Western Digital Research
