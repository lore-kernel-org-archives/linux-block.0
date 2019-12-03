Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88553C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654C12146E
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLCOPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:15:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:48616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfLCOPD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 09:15:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7063B43C;
        Tue,  3 Dec 2019 14:15:01 +0000 (UTC)
Subject: Re: [PATCH] bcache: print written and keys in
 trace_bcache_btree_write
To:     Guoju Fang <fangguoju@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1575344921-20254-1-git-send-email-fangguoju@gmail.com>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <08d0226d-8734-d5c0-678b-c8ebfbdf5831@suse.de>
Date:   Tue, 3 Dec 2019 22:14:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575344921-20254-1-git-send-email-fangguoju@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/12/3 11:48 上午, Guoju Fang wrote:
> It's useful to dump written block and keys on btree write, this patch
> add them into trace_bcache_btree_write.
> 
> Signed-off-by: Guoju Fang <fangguoju@gmail.com>

It is OK to me, added it in my for-test directory. This patch will run
with other development patches for Linux v5.6 merge window.

Thanks.

> ---
>  include/trace/events/bcache.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
> index e4526f8..0bddea6 100644
> --- a/include/trace/events/bcache.h
> +++ b/include/trace/events/bcache.h
> @@ -275,7 +275,8 @@
>  		__entry->keys	= b->keys.set[b->keys.nsets].data->keys;
>  	),
>  
> -	TP_printk("bucket %zu", __entry->bucket)
> +	TP_printk("bucket %zu written block %u + %u",
> +		__entry->bucket, __entry->block, __entry->keys)
>  );
>  
>  DEFINE_EVENT(btree_node, bcache_btree_node_alloc,
> 


-- 

Coly Li
