Return-Path: <SRS0=tY2F=7N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB8C433DF
	for <linux-block@archiver.kernel.org>; Sun, 31 May 2020 16:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCEB207BB
	for <linux-block@archiver.kernel.org>; Sun, 31 May 2020 16:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Oc6sUMwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEaQjo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 May 2020 12:39:44 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:39780 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728322AbgEaQjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 May 2020 12:39:43 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 20C632E1478;
        Sun, 31 May 2020 19:39:38 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 0aHlEyV4lD-dbx0ACCx;
        Sun, 31 May 2020 19:39:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590943178; bh=2mtCU2U0KE0xx8atMhzxY/9rjdmX95+6IA+naCASAYw=;
        h=In-Reply-To:References:Date:Message-ID:To:From:Subject;
        b=Oc6sUMwEwwNe84QZd0++bNQB5xjfiOTB63EsWwgcbByWiVRHSyFN7s9YnOzv18X30
         QWJLUFxLrWhRoFKDGG0P//67FHR5CKEK4S+FMsGXRv+EsDpUigcH36P1Me6hSH5kY8
         1GS8uF9sTF2g1cg8aDcjK99zYvSeJesAWfRQlGtw=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:111::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id W4zK4d67ix-daWGj9q3;
        Sun, 31 May 2020 19:39:36 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] block: really remove REQ_NOWAIT_INLINE
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <159094279217.155550.11478547618029899022.stgit@buzz>
Message-ID: <7274c2c7-5348-babb-4bbf-6a0e7b95559b@yandex-team.ru>
Date:   Sun, 31 May 2020 19:39:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159094279217.155550.11478547618029899022.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 31/05/2020 19.33, Konstantin Khlebnikov wrote:
> Commit 7b6620d7db56 ("block: remove REQ_NOWAIT_INLINE") removed it,
> but some pieces left. Probably something went wrong with git merge.

Nevermind. As I see in block/for-next, Christoph have removed REQ_NOWAIT_INLINE.

But BLK_QC_T_EAGAIN is still here though.

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   include/linux/blk_types.h |    7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 31eb92876be7..59b2e9bd9bd8 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -322,8 +322,7 @@ enum req_flag_bits {
>   	__REQ_PREFLUSH,		/* request for cache flush */
>   	__REQ_RAHEAD,		/* read ahead, can fail anytime */
>   	__REQ_BACKGROUND,	/* background IO */
> -	__REQ_NOWAIT,           /* Don't wait if request will block */
> -	__REQ_NOWAIT_INLINE,	/* Return would-block error inline */
> +	__REQ_NOWAIT,		/* Don't wait if request will block */
>   	/*
>   	 * When a shared kthread needs to issue a bio for a cgroup, doing
>   	 * so synchronously can lead to priority inversions as the kthread
> @@ -358,7 +357,6 @@ enum req_flag_bits {
>   #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
>   #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
>   #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
> -#define REQ_NOWAIT_INLINE	(1ULL << __REQ_NOWAIT_INLINE)
>   #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>   
>   #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
> @@ -452,13 +450,12 @@ static inline int op_stat_group(unsigned int op)
>   
>   typedef unsigned int blk_qc_t;
>   #define BLK_QC_T_NONE		-1U
> -#define BLK_QC_T_EAGAIN		-2U
>   #define BLK_QC_T_SHIFT		16
>   #define BLK_QC_T_INTERNAL	(1U << 31)
>   
>   static inline bool blk_qc_t_valid(blk_qc_t cookie)
>   {
> -	return cookie != BLK_QC_T_NONE && cookie != BLK_QC_T_EAGAIN;
> +	return cookie != BLK_QC_T_NONE;
>   }
>   
>   static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
> 
