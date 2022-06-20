Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 23:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiFTXrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244665AbiFTXrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 19:47:35 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD71B7AA
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655768853; x=1687304853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QXd+jzuXpU68ZdOqx3lh511W84za7p5iWGWpJZTFvc0=;
  b=XG+E8qdluNH8rfkILiCQhQlhdTwfLW8GZsm3SqEEvKf+59WvY76ObVKN
   yIYnCf/oI/ZovvhPjTmVu68QXwQW8iZA4JEQ8SgJMPYGUVUJuMXIrwZxv
   kfaFc86BGxtcufngr4MeeDtLLT7/gqlT4czi58OrVHs8HzsoH1AeRfGMr
   bfai5GrkyHhzGXlVvzMd6nmgC8yIVGsEh0TAdiTJuU+FELH/Mhe6DCuZv
   82k2xd4dMN6F+yzxaw1PqX/TrX880sXQzyTJAukhnIfEeHll+OzVN4fAS
   Y8sI59UldAUbSHxmavDoXuvBokIME8GFovhiJRAJ8jf6JAhA6OEFfnDpH
   g==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="204422791"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:47:33 +0800
IronPort-SDR: tvM1fM9Ch3KhJuaKxybjHpofjJ/8gAnXOWXD/fazayI3PAOkoVqooJf+/Nq7zV2Tr0x5l6OHdm
 FxCVCVYEJ4ZcHYDmV8btbRO2YB53gd9883cUto+3fftTM5ODsGgYj9ZSO3d1nRGNf95TGml3Nl
 qW+aK+hNTNBDdWpwAceWwWeTqNtqakTzTk5O4KRzwOwPleWWkADjphYPF1fZ/YzzNbWmQO3Eru
 WJKKyqn7p062pncy/8QE650limjDDXHFvYFmYKDijm+C+vB7vWyXFlHx0mp4F4KL2Smqf0rb1a
 ONqGCAH8zzG1LWM1eqlpvX+K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:05:39 -0700
IronPort-SDR: 2tHKnfZqg9YFvQvjjXHf/jTSPVmMgvTYl+qW/Ax79lCH399LJO3uoza6zvibrbW9V6AJYDvN96
 OUiVwhnFggBz2EXNfiUavM96vQcyBnyDnd8atYNhclMuaAyHXzHxxpSFqC1hmFffWPBf839eQF
 tO3VEqJMQQFT5Oyi6vnJ2PMiQRC3J4ux3cIImNUNwl4HN2JXLY6O3qZ1vT+PCrIiEsI39o7TId
 OzywohJhW3majRGkRw574qx3nERITYkB1+4qwbPWvl+CrR9BQEtIoAHx4/3E6VuPLyWd5TGzLv
 NGs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:47:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmXg4zXJz1Rwrw
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:47:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655768851; x=1658360852; bh=QXd+jzuXpU68ZdOqx3lh511W84za7p5iWGW
        pJZTFvc0=; b=rcwzeKT+TOC5CQmxry2QUnDMNSBIz+OAmjYWnIDDlKzX6MEp7Xq
        ZeTMYQSTkuClzLG8UAaOO71aF+CKzO4rpZ/N5zKucbry44n9Hm8fP+i2Xy8CXI9X
        kcrWvod5OamvXO+Vkt7CwDdAVuoRjzgo24P8pAyxI45+Y5mQawXTvPBUuomCdl62
        2D89yoM9rcq4eVLREyk8Zhla3grBRy9iUBsp+r4RwklM4i8XwdFd7/Irxq6rz8gY
        ChtoYomS47eYBhRTAqog94HuklFNgj7jCXbNwtAl0ITu/93Bdz+d/Dl3LJQhFK+c
        8yczndjette3NQ5EFLlfJEWSJupYrgskH7w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nxDbBGdMhF7b for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 16:47:31 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmXf3M8Wz1Rvlc;
        Mon, 20 Jun 2022 16:47:30 -0700 (PDT)
Message-ID: <c060f9ac-90b6-3aac-e09f-9e7c99f364aa@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:47:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/8] block: Make ioprio_best() static
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-3-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> Nobody outside of block/ioprio.c uses it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioprio.c         | 2 +-
>  include/linux/ioprio.h | 5 -----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 2a34cbca18ae..b5cf7339709b 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -154,7 +154,7 @@ static int get_task_ioprio(struct task_struct *p)
>  	return ret;
>  }
>  
> -int ioprio_best(unsigned short aprio, unsigned short bprio)
> +static int ioprio_best(unsigned short aprio, unsigned short bprio)
>  {
>  	if (!ioprio_valid(aprio))
>  		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 61ed6bb4998e..519d51fc8902 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -66,11 +66,6 @@ static inline int get_current_ioprio(void)
>  	return prio;
>  }
>  
> -/*
> - * For inheritance, return the highest of the two given priorities
> - */

Nit: you could move this comment over the static function. But the name
makes it fairly obvious what it does :)

> -extern int ioprio_best(unsigned short aprio, unsigned short bprio);
> -
>  extern int set_task_ioprio(struct task_struct *task, int ioprio);
>  
>  #ifdef CONFIG_BLOCK
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
