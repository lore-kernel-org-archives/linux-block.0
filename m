Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F77CCA481
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 13:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349829AbiFUNBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348753AbiFUNBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 09:01:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BC15A0A
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655816491; x=1687352491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3HVeRZgvLcPMBQO1wB/GmSYT/lVNY6xC4X5G8epD2I=;
  b=qzm7Z8ckciSoDYnT+E2sjbIZfD5/5iy8lO8YQ7HPq0wH+GcGhagZzkuF
   vwUo/ZJ0jFDLaHSHXApY9kyVPHCv7OBbm7VZwhYMJyiVwz2luBhKgiR5R
   s2/0gu7yRHAcYRs2Ac6tE+yyM4XttTSH4e6cCBlXyJXehGivSF27zkf2V
   OQGqWC0xFK6XbkyYyiOv/o0DoEt01dQHt1tGKM+Y0atgjRxKPyij5rBIm
   dxBwq8zbQACnGG2Tg0jBO1kH2Aj7U+kHQxIhiRbQVE/lG3rXwGpbqDefY
   /h+xvY8CISMnNMSfNzSkHmCe+i5jeyQ0UV2b/sBtVGK8rtMtSo6yp4VYW
   g==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="202416278"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 21:01:29 +0800
IronPort-SDR: KoM4hYGRBHopiYLFBXt1NLr13jthAstGbIWqIsDs838+dLeGU51+K53l7DwLEyRsByALmNsSLY
 aJUefzHzL7s29LCPsc939rooV597t/B1cInKzpnDtSWqzLc4XwL1eT3pEgrmxIBH1xe48NDP7h
 SaY/hkABDMScSEZbIweV/o1+3XSZviZwZfAGLVdu+1tzp5sY8EOYmBc/NpWnVZRJCkYIKB0bfG
 J8HqDLaEJSNyCZf6u3wRZz3mXqN4wbIalxHANgO20JUxHJle51J5SYs6C1vaIP7D57kTkeuiIM
 Ln26XyCKVmYG/F1gtXkVXdUP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 05:24:00 -0700
IronPort-SDR: Zq8cPg6qCbTgnxsaaK3c1+O6qY9YDCevWRaywZoq78orscQop9BgpN4ybzOjLoHbHyYiAwHP7S
 EXMEBofcWBRq3r+Z7ZTHfBejbQ+dE67XiEqtcnhYvEHnzfxd7bfF2xfl1RbDO7eS0W5XH1VKwZ
 Kky9KJDedO5u4GlL3tVEp3eqnN97FD/QMBH75EmoJkljetfnXqTEP1ldb4L50V1lC3xgkm3siO
 Vfdd63mxdlkuCkc+xsxeKHtQbYF4IT2Mo+axcyEIJ1UU7YXIRZO8gusYxnh7Udchj1nWmZZG0c
 tlM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 06:01:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LS68n2FKYz1Rwnm
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:01:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655816488; x=1658408489; bh=x3HVeRZgvLcPMBQO1wB/GmSYT/lVNY6xC4X
        5G8epD2I=; b=KzCaJEhwrOZDTvtVJivJ24MVV3IC7joSMR7zMcDCODgPRbbZ0Mw
        eqbKSABeKviYWF7O9bLyjKhHf0yfoXe1gs3sCh5k7Bx7xDCSOTcD0PFT/RNPABLQ
        Ouo3T7KlrxZj6hqtnKD4BRzLUA3CnoZmDND7m0rVFx1Y3YuuGxPJSkN/mM6JSj0i
        RbfNt9nyce43K2ziy3vAPdQu/14vxLOM2mD6eMu1SQ8GHwe4wvkcSUF1Xrqwe9/h
        1B/KptbXG++H5Yir5BSn1QgXIq47uCMiQo8uG3rwtOrJUFx1hIaozaPh67PGsOdN
        oKa7W9cBX/sG9B8Uub5GG+ifzLxMnRDa3qQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Augz5hy8LVCK for <linux-block@vger.kernel.org>;
        Tue, 21 Jun 2022 06:01:28 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LS68l4HW2z1RtVk;
        Tue, 21 Jun 2022 06:01:27 -0700 (PDT)
Message-ID: <b1a26c4c-5b52-573f-ce9d-96e21814379e@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 22:01:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220621102201.26337-1-jack@suse.cz>
 <20220621102455.13183-3-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220621102455.13183-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 19:24, Jan Kara wrote:
> get_current_ioprio() operates only on current task. We will need the
> same functionality for other tasks as well. Generalize
> get_current_ioprio() for that and also move the bulk out of the header
> file because it is large enough.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/ioprio.c         | 26 ++++++++++++++++++++++++++
>  include/linux/ioprio.h | 26 ++++++++++----------------
>  2 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 2a34cbca18ae..c4e3476155a1 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -138,6 +138,32 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
>  	return ret;
>  }
>  
> +/*
> + * If the task has set an I/O priority, use that. Otherwise, return
> + * the default I/O priority.
> + *
> + * Expected to be called for current task or with task_lock() held to keep
> + * io_context stable.
> + */
> +int __get_task_ioprio(struct task_struct *p)
> +{
> +	struct io_context *ioc = p->io_context;
> +	int prio;
> +
> +	if (p != current)
> +		lockdep_assert_held(&p->alloc_lock);
> +	if (ioc)
> +		prio = ioc->ioprio;
> +	else
> +		prio = IOPRIO_DEFAULT;
> +
> +	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> +		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
> +					 task_nice_ioprio(p));
> +	return prio;
> +}
> +EXPORT_SYMBOL_GPL(__get_task_ioprio);
> +
>  static int get_task_ioprio(struct task_struct *p)
>  {
>  	int ret;
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 61ed6bb4998e..788a8ff57068 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -46,24 +46,18 @@ static inline int task_nice_ioclass(struct task_struct *task)
>  		return IOPRIO_CLASS_BE;
>  }
>  
> -/*
> - * If the calling process has set an I/O priority, use that. Otherwise, return
> - * the default I/O priority.
> - */
> -static inline int get_current_ioprio(void)
> +#ifdef CONFIG_BLOCK
> +int __get_task_ioprio(struct task_struct *p);
> +#else
> +static inline int __get_task_ioprio(int ioprio)
>  {
> -	struct io_context *ioc = current->io_context;
> -	int prio;
> -
> -	if (ioc)
> -		prio = ioc->ioprio;
> -	else
> -		prio = IOPRIO_DEFAULT;
> +	return IOPRIO_DEFAULT;
> +}
> +#endif /* CONFIG_BLOCK */
>  
> -	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
> -		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
> -					 task_nice_ioprio(current));
> -	return prio;
> +static inline int get_current_ioprio(void)
> +{
> +	return __get_task_ioprio(current);
>  }
>  
>  /*


-- 
Damien Le Moal
Western Digital Research
