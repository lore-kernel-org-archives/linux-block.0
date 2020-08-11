Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB149C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AAB206B5
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="r3NA5Ah3";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="vfydsypI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgHKQBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:01:48 -0400
Received: from fallback22.m.smailru.net ([94.100.176.132]:49834 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgHKQBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 12:01:48 -0400
X-Greylist: delayed 3430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 12:01:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=mROCFJWe99NSLMrhTi1xOQJxQ0Y5fuzuX44YzNRePsQ=;
        b=r3NA5Ah3jbfPrypd7OlDvszdsFpl5G5Z8WWYVSH8ZrUR6TKwYnsA1Rtl8WCmuKtzZr2rYyz6sqe4NmlR1lC+dSo+Rvowy1be1f3WS0MrVl93+1n59oDnfdkA8G2yuiIq5XwS7LQocxOiHg03k3WCML7ZZHXxeQs/vPOQVtnvIm8=;
Received: from [10.161.64.45] (port=43902 helo=smtp37.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <alekseymmm@mail.ru>)
        id 1k5VpJ-0003y1-HI
        for linux-block@vger.kernel.org; Tue, 11 Aug 2020 18:04:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=mROCFJWe99NSLMrhTi1xOQJxQ0Y5fuzuX44YzNRePsQ=;
        b=vfydsypID0UUQkBEOoc/ICuevTg0iwQKnfr7C0xOXM4hdQ+jdFcPeDBLs5WSvImaKZuisv+CSocPQKB+9tvnWWAHSEvEVjy1zDHXzmJq2N56kss4Ys46mtXcIG62xi9EMlNlXpEKCLdBzOcbrsbehbMmdRLgcPU805XltGxzcJA=;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
        id 1k5VpE-00037p-Np; Tue, 11 Aug 2020 18:04:29 +0300
Message-ID: <d9c35f557772f97255e64d29172b57f7225d23ad.camel@mail.ru>
Subject: Re: [PATCH RFC V2 2/4] block: add a statistic table for io sector
From:   Aleksei Marov <alekseymmm@mail.ru>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 18:04:27 +0300
In-Reply-To: <20200713211321.21123-3-guoqing.jiang@cloud.ionos.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
         <20200713211321.21123-3-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96D681ABE1524340CEA0E96BE3B1B48D20716390BB309D05D182A05F5380850401C96E0063297CF7BB6F8E82B60C3414331B1E33751E4D2AB824711C945BE8A1B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77806F8AEFB2C8BE8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063790333AD7CC3E6A518638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCFF522B3761FC4C382C72379F0DAF2FEA7BC0EDFFFD9CB772389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3E478A468B35FE767117882F4460429728AD0CFFFB425014E09623437467D3AE276E601842F6C81A19E625A9149C048EE0AC5B80A05675ACD07FB45A5F6E725C8D8FC6C240DEA76429449624AB7ADAF37B2D370F7B14D4BC40A6AB1C7CE11FEE3F8BD4E506CFA3D889735652A29929C6CC4224003CC8364767A15B7713DBEF166A7F4EDE966BC389F9E8FC8737B5C22495D56369A3576CBA5089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7CB0EC3B1FCAE4A06943847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FDCD13837A2BCF0203C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-C8649E89: A4F946ADBF3E93B9862FE4444DA3A0C9FD726FE3E10CEEEAA6B4A2322E2E2156EB39FBB161A394709F595CEF8576C34B
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmuWqfOuyJ9x2hE9bPtNjPg==
X-Mailru-Internal-Actual: A:0.89626206690105
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EA3298642CB21088A9FC4396CFB3F0F79D3D34EEA4F3A34A11FEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4A353DFAE02CC96B25977329EBD85C2EA8CAE275DD4FF3201049FFFDB7839CE9EF1AA7688671555E3C876930985971B8B9B4527962DCE37D7AA0CE983350C618A
X-7FA49CB5: 0D63561A33F958A5C4C4BB623939175562462C8F7E8363711166D1DD80F5B0A68941B15DA834481FA18204E546F3947CB861051D4BA689FCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364760DD3EA8D24872D7CD81D268191BDAD3DC09775C1D3CA48CF3681FF7970298036BA3038C0950A5D36C8A9BA7A39EFB7668729DE7A884B61D135872C767BF85DA29E625A9149C048EE0A3850AC1BE2E735E4A630A5B664A4FF4AD6D5ED66289B524E70A05D1297E1BB35872C767BF85DA227C277FBC8AE2E8BDC0F6C5B2EEF3D0C75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmuWqfOuyJ9ykZvEgpVCFsw==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90051485E593308544756C1CBA5BF4DAA8836A2BE7F7C2814C06AE5D0ADEEBC53A88BA06D6758C6957D0C77752E0C033A69EE9C7C6BE7440F28B4CF838113C6AC4B43453F38A29522196
X-Mras: Ok
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Is it possible to collect the very same stats (distribution of sizes and
distribution of lat) without having static maps in kernel but with eBPF tracing?
Like using https://github.com/iovisor/bcc/tree/master/tools/
* biolatency for lat distribution
* bitesize for size distribution
Please, have a look at these and similar tools (biolatpcts, biosnoop). Check the
examples they have 
https://github.com/iovisor/bcc/blob/master/tools/bitesize_example.txt
https://github.com/iovisor/bcc/blob/master/tools/biolatency_example.txt
Let me know what is the difference comparing to your stats.

Best Regards
Aleksei Marov

On Mon, 2020-07-13 at 23:13 +0200, Guoqing Jiang wrote:
> With the sector table, so we can know the distribution of
> different IO size from upper layer, which means we could
> have the opportunity to tune the performance based on the
> mostly issued IOs.
> 
> Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  block/Kconfig             |  3 ++-
>  block/blk-core.c          | 16 ++++++++++++++++
>  block/genhd.c             | 21 +++++++++++++++++++++
>  include/linux/part_stat.h |  3 ++-
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 360f63111e2d..c9b9f99152d8 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -180,7 +180,8 @@ config BLK_ADDITIONAL_DISKSTAT
>  	bool "Block layer additional diskstat"
>  	default n
>  	help
> -	Enabling this option adds io latency statistics for each block device.
> +	Enabling this option adds io latency and io size statistics for each
> +	block device.
>  
>  	If unsure, say N.
>  
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 036eb04782de..b67aedfbcefc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1437,6 +1437,16 @@ static void blk_additional_latency(struct hd_struct
> *part, const int sgrp,
>  	part_stat_inc(part, latency_table[idx][sgrp]);
>  
>  }
> +
> +static void blk_additional_sector(struct hd_struct *part, const int sgrp,
> +				  unsigned int sectors)
> +{
> +	unsigned int KB = sectors / 2, idx;
> +
> +	idx = (KB > 0) ? ilog2(KB) : 0;
> +	idx = (idx > (ADD_STAT_NUM - 1)) ? (ADD_STAT_NUM - 1) : idx;
> +	part_stat_inc(part, size_table[idx][sgrp]);
> +}
>  #endif
>  
>  static void blk_account_io_completion(struct request *req, unsigned int
> bytes)
> @@ -1447,6 +1457,9 @@ static void blk_account_io_completion(struct request
> *req, unsigned int bytes)
>  
>  		part_stat_lock();
>  		part = req->part;
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +		blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
> +#endif
>  		part_stat_add(part, sectors[sgrp], bytes >> 9);
>  		part_stat_unlock();
>  	}
> @@ -1502,6 +1515,9 @@ unsigned long disk_start_io_acct(struct gendisk *disk,
> unsigned int sectors,
>  	update_io_ticks(part, now, false);
>  	part_stat_inc(part, ios[sgrp]);
>  	part_stat_add(part, sectors[sgrp], sectors);
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +	blk_additional_sector(part, sgrp, sectors);
> +#endif
>  	part_stat_local_inc(part, in_flight[op_is_write(op)]);
>  	part_stat_unlock();
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index f5d2f110fb34..cb9394521a8f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1441,6 +1441,26 @@ static ssize_t io_latency_show(struct device *dev,
> struct device_attribute *attr
>  
>  static struct device_attribute dev_attr_io_latency =
>  	__ATTR(io_latency, 0444, io_latency_show, NULL);
> +
> +static ssize_t io_size_show(struct device *dev, struct device_attribute
> *attr, char *buf)
> +{
> +	struct hd_struct *p = dev_to_part(dev);
> +	size_t count = 0;
> +	int i, sgrp;
> +
> +	for (i = 0; i < ADD_STAT_NUM; i++) {
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "%5d KB: ", 1
> << i);
> +		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
> +			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu
> ",
> +					   part_stat_read(p,
> size_table[i][sgrp]));
> +		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
> +	}
> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_io_size =
> +	__ATTR(io_size, 0444, io_size_show, NULL);
>  #endif
>  
>  static struct attribute *disk_attrs[] = {
> @@ -1464,6 +1484,7 @@ static struct attribute *disk_attrs[] = {
>  #endif
>  #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>  	&dev_attr_io_latency.attr,
> +	&dev_attr_io_size.attr,
>  #endif
>  	NULL
>  };
> diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
> index fe3def8c69d7..2b056cd70d1f 100644
> --- a/include/linux/part_stat.h
> +++ b/include/linux/part_stat.h
> @@ -11,10 +11,11 @@ struct disk_stats {
>  	unsigned long merges[NR_STAT_GROUPS];
>  #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>  /*
> - * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
> + * We measure latency (ms) and size (sector) for 1, 2, ..., 1024 and >=1024.
>   */
>  #define ADD_STAT_NUM	12
>  	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
> +	unsigned long size_table[ADD_STAT_NUM][NR_STAT_GROUPS];
>  #endif
>  	unsigned long io_ticks;
>  	local_t in_flight[2];

