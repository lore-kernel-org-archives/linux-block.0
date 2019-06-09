Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FAC28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516E22070B
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 10:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfFIKqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:46:47 -0400
Received: from smtp1.tech.numericable.fr ([82.216.111.37]:39678 "EHLO
        smtp1.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfFIKqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 06:46:47 -0400
Received: from pierre.juhen (89-156-43-137.rev.numericable.fr [89.156.43.137])
        by smtp1.tech.numericable.fr (Postfix) with ESMTPS id 54186142313;
        Sun,  9 Jun 2019 12:46:43 +0200 (CEST)
Subject: Re: [RFC PATCH] bcache: fix stack corruption by PRECEDING_KEY()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     Rolf Fokkens <rolf@rolffokkens.nl>, Nix <nix@esperi.org.uk>,
        linux-block@vger.kernel.org
References: <20190608102204.60126-1-colyli@suse.de>
 <3e18ec39-5357-9239-ac06-d81558bd0fd1@suse.de>
From:   Pierre JUHEN <pierre.juhen@orange.fr>
Message-ID: <f031dac3-08d3-1632-8dbe-6495f501489b@orange.fr>
Date:   Sun, 9 Jun 2019 12:46:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3e18ec39-5357-9239-ac06-d81558bd0fd1@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr-FR
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehtddgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecupfgfoffgtffkveetuefngfdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheprfhivghrrhgvucflfgfjgffpuceophhivghrrhgvrdhjuhhhvghnsehorhgrnhhgvgdrfhhrqeenucfrrghrrghmpehmohguvgepshhmthhpohhuthenucevlhhushhtvghrufhiiigvpedt
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Coly,

As Rolf and I said, the value of preceding_key_p in the stack cannot be set to NULL by your code.

The modified patch hereafter does what you expect (I think).

Regards,

  

drivers/md/bcache/bset.c | 16 +++++++++++++---
drivers/md/bcache/bset.h | 34 ++++++++++++++++++++--------------
2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 8f07fa6e1739..9422f3f1c682 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -887,12 +887,22 @@ unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
  	struct bset *i = bset_tree_last(b)->data;
  	struct bkey *m, *prev = NULL;
  	struct btree_iter iter;
+	struct bkey preceding_key_on_stack = ZERO_KEY;
+	struct bkey *preceding_key_p = &preceding_key_on_stack;
  
  	BUG_ON(b->ops->is_extents && !KEY_SIZE(k));
  
-	m = bch_btree_iter_init(b, &iter, b->ops->is_extents
-				? PRECEDING_KEY(&START_KEY(k))
-				: PRECEDING_KEY(k));
+	/*
+	 * If k has preceding key, preceding_key_p will be set to address
+	 *  of k's preceding key; otherwise preceding_key_p will be set
+	 * to NULL inside preceding_key().
+	 */
+	if (b->ops->is_extents)
+		preceding_key_p = preceding_key(&START_KEY(k), preceding_key_p);
+	else
+		preceding_key_p = preceding_key(k, preceding_key_p);
+
+	m = bch_btree_iter_init(b, &iter, preceding_key_p);
  
  	if (b->ops->insert_fixup(b, k, &iter, replace_key))
  		return status;
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index bac76aabca6d..6ab165dcb717 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -434,20 +434,26 @@ static inline bool bch_cut_back(const struct bkey *where, struct bkey *k)
  	return __bch_cut_back(where, k);
  }
  
-#define PRECEDING_KEY(_k)					\
-({								\
-	struct bkey *_ret = NULL;				\
-								\
-	if (KEY_INODE(_k) || KEY_OFFSET(_k)) {			\
-		_ret = &KEY(KEY_INODE(_k), KEY_OFFSET(_k), 0);	\
-								\
-		if (!_ret->low)					\
-			_ret->high--;				\
-		_ret->low--;					\
-	}							\
-								\
-	_ret;							\
-})
+/*
+ * Pointer preceding_key_p points to a memory object to store preceding
+ * key of k. If the preceding key does not exist, set preceding_key_p to
+ * NULL. So the caller of preceding_key() needs to take care of memory
+ * which preceding_key_p pointed to before calling preceding_key().
+ * Currently the only caller of preceding_key() is bch_btree_insert_key(),
+ * and preceding_key_p points to an on-stack variable, so the memory
+ * release is handled by stackframe itself.
+ */
+static inline  struct bkey *preceding_key(struct bkey *k, struct bkey *preceding_key_p)
+{
+	if (KEY_INODE(k) || KEY_OFFSET(k)) {
+		*preceding_key_p = KEY(KEY_INODE(k), KEY_OFFSET(k), 0);
+		if (!preceding_key_p->low)
+			preceding_key_p->high--;
+		preceding_key_p->low--;
+		return (preceding_key_p);
+	} else {
+		return(NULL);
+	}
+}
  
  static inline bool bch_ptr_invalid(struct btree_keys *b, const struct bkey *k)
  {


