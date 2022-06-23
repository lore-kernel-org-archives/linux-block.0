Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E9AC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiFWHs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiFWHso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DA2983A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0400F21D34;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5i9Z32duoelG/wbN9pv07VHvWXlD2mTcOg9tUIarTho=;
        b=2a/LT3itC5cSSXifcSHZtUV4Zf9JyFZ1S+G1EEgSdu2a23LUbyj7h7bYNSqaZPi2Z/rhUL
        vu2G/RV1pdDGWE4T+a4AVp8AlVSA9uvyjDmafnOGs//wTIm/UbZY2WQjLupB9divy03/RN
        Y+5iB6EqN4KuCekYooljHZskpk1EXUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5i9Z32duoelG/wbN9pv07VHvWXlD2mTcOg9tUIarTho=;
        b=cPdVM60MtUGTlAIPbTIcunqJpMD040HnlpgbizP8qp+E7tlS/7HUMnYCqdvW5kWLceSZP+
        6AX8MeQo/J7uesBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5ABDE2C145;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8D16A062B; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/9 v5] block: Fix IO priority mess
Date:   Thu, 23 Jun 2022 09:48:25 +0200
Message-Id: <20220623074450.30550-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; h=from:subject:message-id; bh=nog9PvcsNRTxgT1QQidhv9FJ0lhKw9XGHX5kGq0eF5g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrEd5tdcaOruJmaHGWYJDuMXF4Sx4SF6YsyPlqu /q2g4N2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQaxAAKCRCcnaoHP2RA2UDSB/ 4/8DTLjdhhtXne1wDenD55/J+vLZSwGLCXnrGlm79hHu9cYHumsEsCwNG5cDTFYtvZw/Wz2ynSV0nu BVZ5JLg1VfgMDbEelXorz0XK0/8g2iRmpo+SERDB3buUqO0psxD1pHr6T5Xvuyasbzx068EPEoXoc8 9x2SsVfLcB+W3c9rXpXFiNO0EDMZ5KqbszleC3mA67eGxMdvasdSi3IlnC7ODBDWotiqCd2OcVzQPS W22aMIqJqp8IsxpR/1PHR+p7UN6Mpy4C+tLAVqDtGXj7yC/Hx904vxm7UaP5PiLMSZlWD81yDP+Lzu zn3RD+eaLjOZP9Keqm5WEzHa4pASRh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This is the fifth revision of my patches fixing IO priority handling in the
block layer. Damien has reviewed all the patches and tested them as well so
I think patches are ready to be merged.

Changes since v4:
* Added Reviewed-by and Tested-by tags
* Fixed prototype of stub function for !CONFIG_BLOCK

Changes since v3:
* Added Reviewed-by tags from Damien
* Fixed build failure without CONFIG_BLOCK
* Separated refactoring of get_current_ioprio() into a separate patch

Changes since v2:
* added some comments to better explain things
* changed handling of ioprio_get(2)
* a few small tweaks based on Damien's feedback

Original cover letter:
Recently, I've been looking into 10% regression reported by our performance
measurement infrastructure in reaim benchmark that was bisected down to
5a9d041ba2f6 ("block: move io_context creation into where it's needed"). This
didn't really make much sense and it took me a while to understand this but the
culprit is actually in even older commit e70344c05995 ("block: fix default IO
priority handling") and 5a9d041ba2f6 just made the breakage visible.
Essentially the problem was that after these commits some IO was queued with IO
priority class IOPRIO_CLASS_BE while other IO was queued with IOPRIO_CLASS_NONE
and as a result they could not be merged together resulting in performance
regression. I think what commit e70344c05995 ("block: fix default IO priority
handling") did is actually broken not only because of this performance
regression but because of other reasons as well (see changelog of patch 3/8 for
details). Besides this problem, there are multiple other inconsistencies in the
IO priority handling throughout the block stack we have identified when
discussing this with Damien Le Moal. So this patch set aims at fixing all these
various issues.

Note that there are a few choices I've made I'm not 100% sold on. In particular
the conversion of blk-ioprio from rqos is somewhat disputable since it now
incurs a cost similar to blk-throttle in the bio submission fast path (need to
load bio->bi_blkg->pd[ioprio_policy.plid]).  If people think the removed
boilerplate code is not worth the cost, I can certainly go via the "additional
rqos hook" path.

								Honza
Previous versions:
Link: http://lore.kernel.org/r/20220601132347.13543-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20220615160437.5478-1-jack@suse.cz # v2
Link: http://lore.kernel.org/r/20220620160726.19798-1-jack@suse.cz # v3
Link: http://lore.kernel.org/r/20220621102201.26337-1-jack@suse.cz # v4
