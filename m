Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA1C76188
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322812173B
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfGSNhQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:37:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbfGSNhQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jul 2019 09:37:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29919AD05;
        Fri, 19 Jul 2019 13:37:15 +0000 (UTC)
Subject: Re: [PATCH 3/4] Documenation: switching-sched: Remove notes about
 elevator argument
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Andreas Herrmann <aherrmann@suse.com>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
 <20190714053453.1655-4-marcos.souza.org@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a6262651-2461-feca-0a85-1208fe89a32e@suse.de>
Date:   Fri, 19 Jul 2019 15:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714053453.1655-4-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 7:34 AM, Marcos Paulo de Souza wrote:
> This argument was ignored since blk-mq was set as default, so remove it
> from documentation.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>   Documentation/block/switching-sched.txt | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/block/switching-sched.txt b/Documentation/block/switching-sched.txt
> index 7977f6fb8b20..431d56471227 100644
> --- a/Documentation/block/switching-sched.txt
> +++ b/Documentation/block/switching-sched.txt
> @@ -1,7 +1,3 @@
> -To choose IO schedulers at boot time, use the argument 'elevator=deadline'.
> -'noop' and 'cfq' (the default) are also available. IO schedulers are assigned
> -globally at boot time only presently.
> -
>   Each io queue has a set of io scheduler tunables associated with it. These
>   tunables control how the io scheduler works. You can find these entries
>   in:
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
