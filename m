Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFBAC76188
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CDB21852
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGSNga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:36:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727888AbfGSNg3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jul 2019 09:36:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86973AD05;
        Fri, 19 Jul 2019 13:36:28 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: elevator.c: Remove now unused elevator=
 argument
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
 <20190714053453.1655-2-marcos.souza.org@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <081e9968-0ca5-6c3e-fac7-4eb701c415fa@suse.de>
Date:   Fri, 19 Jul 2019 15:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714053453.1655-2-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 7:34 AM, Marcos Paulo de Souza wrote:
> Since the inclusion of blk-mq, elevator argument was not being
> considered anymore, and it's utility died long with the legacy IO path,
> now removed too.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>   block/elevator.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 2f17d66d0e61..f56d9c7d5cbc 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -135,20 +135,6 @@ static struct elevator_type *elevator_get(struct request_queue *q,
>   	return e;
>   }
>   
> -static char chosen_elevator[ELV_NAME_MAX];
> -
> -static int __init elevator_setup(char *str)
> -{
> -	/*
> -	 * Be backwards-compatible with previous kernels, so users
> -	 * won't get the wrong elevator.
> -	 */
> -	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
> -	return 1;
> -}
> -
> -__setup("elevator=", elevator_setup);
> -
>   static struct kobj_type elv_ktype;
>   
>   struct elevator_queue *elevator_alloc(struct request_queue *q,
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
