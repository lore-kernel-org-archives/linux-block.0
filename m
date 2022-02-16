Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8F4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 10:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiBPKT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:19:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiBPKT5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 05:19:57 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A742B8ADB
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 02:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645006785; x=1676542785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bj2fJtTAmjXyUvzXDofvXJqmO4YLh/oKQ7ujmO7XbcQ=;
  b=iOqd51vf/IlynifCbMa3RMgfi2GC94SECGEHTO6R/oaPVtajyosUfluZ
   PdZP+pDsmpnZeIlaOnBaFnJLa9Pr2LiUb2QnIDSRzAq/cs/a1b6DOMnfA
   qh/EufYKDDQirEjh0kiIQzeyveQx0a2rSW0xqBvop0qfCHHPyFw5nbGcz
   rM8p3bzDH9QcTW+G6QmaLLuhL9ILP//wdLJ41/pINUmud5C/5pg0azYE+
   2fS8E9FgJt73s9DstYQZcB0J4qSKbdXaOH1H8+aYEOhNgLP6CSDvqX3UT
   PTtIBWTi0Jk4mvQBilBGXJEnJyhL9b/LY9JO4jXhW7BJM2POrxpp3+Zku
   A==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="194062571"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 18:19:44 +0800
IronPort-SDR: tYkjUPYsL4ab1IwkzI7rcWSg5YJyffryahvtQMMM/voOIXPNlcWJmQmmy298xSQpWx1dUst0XP
 XhxdJgdPK9kIHR/W539LsGa1OKT5W229rJW7Ow7VJ7dDwlw2GyygF/k4p3GphzOFNzsazdoroQ
 XlBqky4cUNEQfTR8zQKPmyB5mJkVrqaP3KVepxtKtwFAeJNqXixLP8mMx+vAokH4N07t/Dyrhg
 JVjTWO+ES64R0rcZr9lLfNUTO3QNO6azIrXasXSX9TgZ148ArYMeyQ3XCURsSpzVms5JZwyXKu
 wccBvUqo3go2i5+Vn1WDXL2B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:51:23 -0800
IronPort-SDR: dtetHGGujyjohQJS0QZepkJG+gblhLFhFQkBcuv6h1NCAssHeeI8Cu4037QgPuC7VG/1qMDmc1
 m5r8MMr1geG3wQf4Vc/L40xJUSFx3ewW8hHVpGs3hoN7TmKqjYkEyXitemYzMz2PCi7QATPUYQ
 tu2UlM/vZY6KY/2LZEqdXmpj58hB25DgK4TEuIs1b2ySHEae6D71q3HPExalakRZ9ni278SyeK
 s0AakqpHZ+6JronBIJ5sfaoSbNiaZJpRNEGUIMLgaqrMwG63dKrnVjGy4aH19CJOClespv93ZL
 cmM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 02:19:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzDTq2Lkjz1SVp0
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 02:19:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645006782; x=1647598783; bh=bj2fJtTAmjXyUvzXDofvXJqmO4YLh/oKQ7u
        jmO7XbcQ=; b=j5YWbhMCCX1hxCBRI+ZdSYL+P+/jBewcgViBOrwv6Kuz3cGwudG
        buCewtDXwHH/OAJLhqAXO7ttvFlMYa9GRcJhBx7ci7TON/Q6Im5M3lLKxqUlm6Tq
        9gbVV5NFbd+gakoemImCkSPEBoIukKbQQ+qjnl0aOxmUnbEiP2QE5V/u+IMwmzXc
        /lPU6M46Vn7mY44gbp7FVvQo8GlaS5paPfGNrq+nKeLvHt72P0PCpJTT8ZaiIgVc
        6ktnMaRnK7z1MHBxQ5euSVw+bvxAat6MVOocRd7tof04SEeqLL06W/Nf8gvEeD/T
        EyvjlnskXfwQMVsVXMK1ON72JvFlfOBTu8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CD-O-Ip5QIgZ for <linux-block@vger.kernel.org>;
        Wed, 16 Feb 2022 02:19:42 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzDTp0HnYz1Rwrw;
        Wed, 16 Feb 2022 02:19:41 -0800 (PST)
Message-ID: <286d8d10-14ea-705b-585a-e12c73fe0423@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 19:19:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] null_blk: remove hardcoded alloc_cmd() parameter
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ming.lei@redhat.com, shinichiro.kawasaki@wdc.com
References: <20220216093020.175351-1-kch@nvidia.com>
 <20220216093020.175351-2-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220216093020.175351-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/22 18:30, Chaitanya Kulkarni wrote:
> Only caller of alloc_cmd() is null_submit_bio() unconditionally sets
> second parameter to true & that is statically hard-coded in null_blk.

Nit: s/&/and (let's write in proper English :))

> There is no point in having statically hardcoded function parameter.
> 
> Remove the unnecessary parameter can_wait and adjust the code so it
> can retain existing behavior of waiting when we don't get valid
> nullb_cmd from __alloc_cmd() in alloc_cmd().
> 
> The restructured code avoids multiple return statements, multiple
> calls to __alloc_cmd() and resulting a fast path call to
> prepare_to_wait() due to removal of first alloc_cmd() call.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 13004beb48ca..d78fc3edb22e 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -719,26 +719,23 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  	return NULL;
>  }
>  
> -static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, int can_wait)
> +static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq)
>  {
>  	struct nullb_cmd *cmd;
>  	DEFINE_WAIT(wait);
>  
> -	cmd = __alloc_cmd(nq);
> -	if (cmd || !can_wait)
> -		return cmd;
> -
>  	do {
> -		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * This avoids multiple return statements, multiple calls to
> +		 * __alloc_cmd() and a fast path call to prepare_to_wait().
> +		 */
>  		cmd = __alloc_cmd(nq);
>  		if (cmd)
> -			break;
> -
> +			return cmd;
> +		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
>  		io_schedule();
> +		finish_wait(&nq->wait, &wait);
>  	} while (1);
> -
> -	finish_wait(&nq->wait, &wait);
> -	return cmd;
>  }

Personally, I would simplify further like this:


	while (!(cmd = __alloc_cmd(nq)) {
		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
		io_schedule();
		finish_wait(&nq->wait, &wait);
  	}

	return cmd;

But that is a matter of taste I guess.

>  
>  static void end_cmd(struct nullb_cmd *cmd)
> @@ -1478,7 +1475,7 @@ static void null_submit_bio(struct bio *bio)
>  	struct nullb_queue *nq = nullb_to_queue(nullb);
>  	struct nullb_cmd *cmd;
>  
> -	cmd = alloc_cmd(nq, 1);
> +	cmd = alloc_cmd(nq);
>  	cmd->bio = bio;
>  
>  	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));


-- 
Damien Le Moal
Western Digital Research
