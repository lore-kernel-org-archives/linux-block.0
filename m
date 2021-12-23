Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D51AC4332F
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbhLWRcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:32:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54104 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhLWRcL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 12:32:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6209121128;
        Thu, 23 Dec 2021 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640280730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L8kagnBOo/gOySUuvYmjg4HfRSNqdxnk/fAqew7vElI=;
        b=HPx55yZzqw9bHDQOAN0yrdvTrh6z78aIpnRe3wiIM6O7OL8qrLTZYy/ExmiNFg+03a8syN
        eCH0jxbN9tGFXu83Tz4M3MFNIVnJ0AMfOS1qiFGGRi/79CJBCgXt987zKg4mAJpPO0jxCH
        7GmCDWfp5IO7ujgTvoI159pTnnx0YCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640280730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L8kagnBOo/gOySUuvYmjg4HfRSNqdxnk/fAqew7vElI=;
        b=y6LM5oL9zK87MpqAGbAYEDPSKhFepGTP7cDJDS/MqOm32Sr7MtKlkOqcY2mNDgtBxYoj0W
        KCS9l4zlLBLUtmBQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 4AD74A3B85;
        Thu, 23 Dec 2021 17:32:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1AB921E1328; Thu, 23 Dec 2021 18:32:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] bfq: Avoid use-after-free when moving processes between cgroups
Date:   Thu, 23 Dec 2021 18:31:56 +0100
Message-Id: <20211223171425.3551-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=332; h=from:subject:message-id; bh=vs1Yyl+jjo2YoeXrke5B9pRz4cZBGIlt/W4J35idkrI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhxLJvAkrJljfG3ckpfTB+EUPJhWIRi1BHBbwIssao mLv8Ws2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYcSybwAKCRCcnaoHP2RA2aL/B/ 0Qwl0hLeiS4L71MKuAdPgButRR1AiTv22v/77les8FoM1wjsuFRtrMZOBnTalLE4YJ7TaJu45IdU7n ufYzrBgUED38Ms8grJw+U4S/6IesMGs57yGCu9Whj8VhE1fd0QAGU1ot3k0uDjPnouLBuvp9IQHleb 4yew1aZc+dAjnuAUxWELIMprdML5yuqAE4V59/GA+pIFAb5ShNltVl6Z2lDWf0gCqwkXevg4yftd+J ow0pT9/eX43TjnvR7bdtJt+LBOIWzla06ybRMaZtsoW2uh1RYyTO2Xm0SFXv6alEsqmek1Chk/DD4M Qlc6XrHRgeQmiy4javcXXwRwzss3kz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

these three patches fix use-after-free issues in BFQ when processes with merged
queues get moved to different cgroups. The patches have survived some beating
in my test VM but so far I fail to reproduce the original KASAN reports so
testing from people who can reproduce them is most welcome. Thanks!

								Honza
