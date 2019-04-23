Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C2C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FDE206BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfDWHDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:03:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDWHDm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C86EAE78;
        Tue, 23 Apr 2019 07:03:41 +0000 (UTC)
Subject: Re: [RFC PATCH v2 07/16] bcache: add comments for kobj release
 callback routine
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-8-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fd617000-dc8f-216c-a8fc-c7b06e0be4ac@suse.de>
Date:   Tue, 23 Apr 2019 09:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419160509.66298-8-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 6:05 PM, Coly Li wrote:
> Bcache has several routines to release resources in implicit way, they
> are called when the associated kobj released. This patch adds code
> comments to notice when and which release callback will be called,
> - When dc->disk.kobj released:
>    void bch_cached_dev_release(struct kobject *kobj)
> - When d->kobj released:
>    void bch_flash_dev_release(struct kobject *kobj)
> - When c->kobj released:
>    void bch_cache_set_release(struct kobject *kobj)
> - When ca->kobj released
>    void bch_cache_release(struct kobject *kobj)
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 036bffad0bfe..400af446c372 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1174,6 +1174,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>   	return 0;
>   }
>   
> +/* when dc->disk.kobj released */
>   void bch_cached_dev_release(struct kobject *kobj)
>   {
>   	struct cached_dev *dc = container_of(kobj, struct cached_dev,
> @@ -1326,6 +1327,7 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
>   
>   /* Flash only volumes */
>   
> +/* When d->kobj released */
>   void bch_flash_dev_release(struct kobject *kobj)
>   {
>   	struct bcache_device *d = container_of(kobj, struct bcache_device,
> @@ -1496,6 +1498,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
>   	return true;
>   }
>   
> +/* When c->kobj released */
>   void bch_cache_set_release(struct kobject *kobj)
>   {
>   	struct cache_set *c = container_of(kobj, struct cache_set, kobj);
> @@ -2023,6 +2026,7 @@ static const char *register_cache_set(struct cache *ca)
>   
>   /* Cache device */
>   
> +/* When ca->kobj released */
>   void bch_cache_release(struct kobject *kobj)
>   {
>   	struct cache *ca = container_of(kobj, struct cache, kobj);
> 
This could be inferred from the 'container_of' statement for each relase 
function, but if you want ...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
