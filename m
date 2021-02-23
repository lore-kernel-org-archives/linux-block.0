Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C6C433E6
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB52B64E32
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBWHXj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:23:39 -0500
Received: from verein.lst.de ([213.95.11.211]:32997 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231822AbhBWHXg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:23:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7D5268D0D; Tue, 23 Feb 2021 08:22:52 +0100 (CET)
Date:   Tue, 23 Feb 2021 08:22:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Message-ID: <20210223072252.GA18035@lst.de>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com> <20210223070408.GA16980@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223070408.GA16980@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 08:04:08AM +0100, Christoph Hellwig wrote:
> The problem is that the blk-crypto fallback code calls bio_split
> with a NULL bioset.  That was aready broken before, as the mempool
> needed to guarantee forward progress was missing, but is not fatal.
> 
> Satya, can you look into adding a mempool that can guarantees forward
> progress here?

Something like this would be the minimum viable fix:

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e8327c50d7c9f4..c176b7af56a7a5 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -80,6 +80,7 @@ static struct blk_crypto_keyslot {
 static struct blk_keyslot_manager blk_crypto_ksm;
 static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
+static struct bio_set crypto_bio_split;
 
 /*
  * This is the key we set when evicting a keyslot. This *should* be the all 0's
@@ -224,7 +225,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
-		split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
+		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
+				      &crypto_bio_split);
 		if (!split_bio) {
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
@@ -538,9 +540,13 @@ static int blk_crypto_fallback_init(void)
 
 	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
 
-	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
+	err = bioset_init(&crypto_bio_split, 64, 0, 0);
 	if (err)
 		goto out;
+
+	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
+	if (err)
+		goto fail_free_bioset;
 	err = -ENOMEM;
 
 	blk_crypto_ksm.ksm_ll_ops = blk_crypto_ksm_ll_ops;
@@ -591,6 +597,8 @@ static int blk_crypto_fallback_init(void)
 	destroy_workqueue(blk_crypto_wq);
 fail_free_ksm:
 	blk_ksm_destroy(&blk_crypto_ksm);
+fail_free_bioset:
+	bioset_exit(&crypto_bio_split);
 out:
 	return err;
 }
