Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 10:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiESKwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiESKwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 06:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68C6C0DF
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 03:52:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5500C1F86A;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=76k9iwtB764AkBR/gy2UDaYc9U3MSwSK6w0czfIl2Rc=;
        b=nB9q5ey4Uti0xC9hsDRP1Q4LGIDLndtlvIEvPaqFUd81QfszqRAzFX9dIL1GRwhPY06Pq7
        w1yuykz84bYgjSL/HwImoDZFZQg7mJXjH0KJYksZO1mpcw2LeuMV8BKpMHsH5o3cQdPMl7
        p+GzMk05h4CjFcT37VREbXeFkavBRHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=76k9iwtB764AkBR/gy2UDaYc9U3MSwSK6w0czfIl2Rc=;
        b=TCkj1+NqHhWTJKF+zoUYf7hfoZlTys4H+ipsAnmtS4Lf78HeoirznnuDhveZUnZED6Mrhy
        W86hhGxXc/h0tLBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 44BCC2C141;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 704E6A062F; Thu, 19 May 2022 12:52:35 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] bfq: Improve waker detection
Date:   Thu, 19 May 2022 12:52:28 +0200
Message-Id: <20220519104621.15456-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; h=from:subject:message-id; bh=dgid7zJjnf7k5rGKo9h8dIAbPk1Iz4zwPoMAY/VKEmg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBihiFahICwwaM+wdhYIkprN/VQHRVeNixXxpNHD1az QUktbtGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYoYhWgAKCRCcnaoHP2RA2XeIB/ oCw+YEX/s63DtkTsrQhu27L5p7dqLYIA7G2z5zw//rVM27ojgDH8q47W0EgmTmEeAIwuu9wEJSyacC VBFLhdmTPgiVB0otdLXdmgTRUgVXtBZ7SYObc6q5lR9q3uejIv/8Xo4JhDkhjWjPYtzfnqNPnmyoxX BarVXQB3end5QFTdlcvx8bVTrIX7aRmTGPF9vhqmBwqgyxBtuaSgixl6MP/ZBxVo6A4kPw+Vp6Aa8/ AeZh6hdIg1DEzvPu72Jd2mchI6OMiktauMZ1zda5ORCCPInrrj68Fqgil12pDq/ZkL3SDmibdbNhYQ 5RoRgbBZDNSwVhEaKUguBwEMsJF2JE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

this patch series restores regression in dbench for large number of processes
that was introduced by c65e6fd460b4 ("bfq: Do not let waker requests skip
proper accounting"). The detailed explanation is in the first patch but the
culprit in the end was that with large number of dbench clients it often
happened that flush worker bfqq replaced jbd2 bfqq as a waker of the bfqq
shared by dbench clients and that resulted in lot of idling and reduced
throughput.

The first two patches in this series improve the waker detection, the other
two are just cleanups I've spotted when working on the code.

I've tested the patches and they don't seem to cause regression for other
workloads.

								Honza
